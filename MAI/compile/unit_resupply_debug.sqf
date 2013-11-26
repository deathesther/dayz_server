/*
	unit_resupply (debugging version)
	
	Credits:  Basic script concept adapted from Sarge AI.
	
	Description: Handles AI ammo reload, self-healing, zombie hostility. Called by fnc_createGroup upon AI unit creation.
	
	Last updated: 12:49 AM 11/19/2013
*/
private["_unit","_currentWeapon","_weaponMagazine","_needsReload","_nearbyZeds","_marker","_markername","_lastBandage","_bandages","_unitGroup","_health","_needsHeal"];
if (!isServer) exitWith {};
if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: AI resupply script active.";};

_unit = _this select 0;								//Unit to monitor/reload ammo
_bandages = if ((count _this) > 1) then {_this select 1} else {1};	//Additional self-heals based on unit weapon grade. Each unit has 1 self-heal by default.

//Initialize medical variables
if (isNil {_unit getVariable "unithealth"}) then {_unit setVariable ["unithealth",[12000,0,0]]};
if (isNil {_unit getVariable "unconscious"}) then {_unit setVariable ["unconscious",false]};
_lastBandage = 0;
_needsHeal = false;

_markername = format["AI_%1",_unit];
if ((getMarkerColor _markername) != "") then {deleteMarker _markername; sleep 5;};	//Delete the previous marker if it wasn't deleted for some reason.
_marker = createMarker[_markername,(getposATL _unit)];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerType "Dot";
_marker setMarkerColor "ColorRed";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerSize [5, 5];

_currentWeapon = currentWeapon _unit;									//Retrieve unit's current weapon
waitUntil {sleep 0.1; !isNil "_currentWeapon"};
_weaponMagazine = getArray (configFile >> "CfgWeapons" >> _currentWeapon >> "magazines") select 0;	//Retrieve ammo used by unit's current weapon
waitUntil {sleep 0.1; !isNil "_weaponMagazine"};

_unitGroup = (group _unit);

if (MAI_debugLevel > 0) then {
	if (isNull (unitBackpack _unit)) then {
		diag_log format ["MAI Error :: Unit backpack not found! Skin: %1. Backpack: %2. Skin classname possibly incompatible with backpacks.",(typeOf _unit),(unitBackpack _unit)];
	};		//Check if backpack is missing
	if (MAI_debugLevel > 1) then {
		0 = [_unit] spawn {
			private ["_unit"];
			_unit = _this select 0;
			sleep 5;
			diag_log format ["MAI ExtDebug (Unit Skills): %1, %2, %3, %4, %5, %6, %7, %8, %9, %10.",_unit skill "aimingAccuracy",_unit skill "aimingShake",_unit skill "aimingSpeed",_unit skill "endurance",_unit skill "spotDistance",_unit skill "spotTime",_unit skill "courage",_unit skill "reloadSpeed",_unit skill "commanding",_unit skill "general"];
			true
		};
	};
};

while {(alive _unit)&&(!(isNull _unit))} do {													//Run script for as long as unit is alive
	_marker setmarkerpos (getposATL _unit);
		if (MAI_zombieEnemy && ((leader _unitGroup) == _unit)) then {
		_nearbyZeds = (getPosATL _unit) nearEntities ["zZombie_Base",MAI_zDetectRange];
		{
			if(rating _x > -30000) then {
				_x addrating -30000;
				_unitGroup reveal [_x,1.5];
			};
		} forEach _nearbyZeds;
		if (MAI_passiveAggro) then {
			if ((count _nearbyZeds) > 0) then {_nul = [_unit,75,false,(getPosATL _unit)] spawn ai_alertzombies;};
		};
	};
	if !(_unit getVariable ["unconscious",false]) then {
		_needsReload = true;
		if (_weaponMagazine in magazines _unit) then {						//If unit already has at least one magazine, assume reload is not needed
			_needsReload = false;
		}; 
		if ((_unit ammo _currentWeapon == 0) || (_needsReload))  then {		//If active weapon has no ammunition, or AI has no magazines, remove empty magazines and add a new magazine.
			_unit removeMagazines _weaponMagazine;
			_unit addMagazine _weaponMagazine;
			if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: AI ammo depleted, added magazine %1 to AI %2.",_weaponMagazine,_unit];};
		};
		if (_bandages > 0) then {
			_health = _unit getVariable "unithealth";
			if (_needsHeal) then {
				private ["_healTimes"];
				_bandages = _bandages - 1;
				_unit disableAI "TARGET"; _unit disableAI "AUTOTARGET"; _unit disableAI "MOVE";
				_unit playActionNow "Medic";
				_healTimes = 0;
				while {(!(_unit getVariable ["unconscious",false]))&&(_healTimes < 3)&&(alive _unit)} do {
					sleep 2;
					_health set [0,(((_health select 0) + 2000) min 12000)];
					if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: AI %1 is healing. Current Blood: %2.",_unit,(_health select 0)];};
					_healTimes = _healTimes + 1;
					if ((_healTimes == 3)&&(alive _unit)) then {
						_health set [1,0];
						_health set [2,0];
						_unit setDamage 0;
						if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: AI %1 has completed full heal process.",_unit];};
					};
				};
				
				_unit enableAI "TARGET"; _unit enableAI "AUTOTARGET"; _unit enableAI "MOVE";
				_lastBandage = time;
				_needsHeal = false;
			} else {
				private ["_lowblood","_brokenbones"];
				_lowblood = ((_health select 0) < 7200);
				_brokenbones = (((_health select 1) >= 1) or ((_health select 2) >= 1)); 
				if ((_lowblood or _brokenbones) && (time - _lastBandage) > 60) then {
					_needsHeal = true;
					if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: AI %1 needs to heal! Blood low: %2, Broken bones: %3.",_unit,_lowblood,_brokenbones];};
				};
			};
		};
		//Uncomment to debug death-related scripts.
		/*if ((time - _unit) > 20) then {
			_helicopter setDamage 1;
		};*/
		//diag_log format ["Group %1 has %2 waypoints.",(group _unit),count (waypoints (group _unit))];
	};
	sleep MAI_refreshRate;												//Check again in x seconds.
};
sleep 0.5;
deleteMarker _marker;
if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: AI resupply script deactivated.";};