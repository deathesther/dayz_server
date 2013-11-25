/*
	unit_resupply
	
	Credits:  Basic script concept adapted from Sarge AI.
	
	Description: Handles AI ammo reload, self-healing, zombie hostility. Called by fnc_createGroup upon AI unit creation.
	
	Last updated: 1:59 AM 11/9/2013
*/
private["_unit","_currentWeapon","_weaponMagazine","_needsReload","_nearbyZeds","_marker","_markername","_lastBandage","_bandages","_unitGroup","_health","_lowblood","_brokenbones"];
if (!isServer) exitWith {};
if (DZAI_debugLevel > 1) then {diag_log "DZAI Extended Debug: AI resupply script active.";};

_unit = _this select 0;								//Unit to monitor/reload ammo
_bandages = if ((count _this) > 1) then {_this select 1} else {1};	//Additional self-heals based on unit weapon grade. Each unit has 1 self-heal by default.

if (isNil {_unit getVariable "unithealth"}) then {_unit setVariable ["unithealth",[12000,0,0]]};
_currentWeapon = currentWeapon _unit;				//Retrieve unit's current weapon
waitUntil {sleep 0.1; !isNil "_currentWeapon"};
_weaponMagazine = getArray (configFile >> "CfgWeapons" >> _currentWeapon >> "magazines") select 0;	//Retrieve ammo used by unit's current weapon
waitUntil {sleep 0.1; !isNil "_weaponMagazine"};

_lastBandage = 0;
_unitGroup = (group _unit);

while {(alive _unit)&&(!(isNull _unit))} do {	
	if (DZAI_zombieEnemy && ((leader _unitGroup) == _unit)) then {
		_nearbyZeds = (getPosATL _unit) nearEntities ["zZombie_Base",DZAI_zDetectRange];
		{
			if(rating _x > -30000) then {
                _x addrating -30000;
				_unitGroup reveal [_x,1.5];
            };
		} forEach _nearbyZeds;
		if (DZAI_passiveAggro) then {
			if ((count _nearbyZeds) > 0) then {_nul = [_unit,75,false,(getPosATL _unit)] spawn ai_alertzombies;};
		};
	};
	if !(_unit getVariable ["unconscious",false]) then {
		_needsReload = true;
		if (_weaponMagazine in magazines _unit) then {	//If unit already has at least one magazine, assume reload is not needed
			_needsReload = false;
		}; 
		if ((_unit ammo _currentWeapon == 0) || (_needsReload))  then {		//If active weapon has no ammunition, or AI has no magazines, remove empty magazines and add a new magazine.
			_unit removeMagazines _weaponMagazine;
			_unit addMagazine _weaponMagazine;
			if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: AI ammo depleted, added magazine %1 to AI %2.",_weaponMagazine,_unit];};
		};
		if (_bandages > 0) then {
			_health = _unit getVariable "unithealth";
			_lowblood = ((_health select 0) < 7800);
			_brokenbones = (((_health select 1) >= 1) or ((_health select 2) >= 1)); 
			if ((_lowblood or _brokenbones) &&(time - _lastBandage) > 60) then {
				if ((random 1) < 0.5) then {
					_bandages = _bandages - 1;
					_unit disableAI "FSM";
					_unit playActionNow "Medic";
					if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: AI %1 is healing. Remaining bandages: %2.",_unit,_bandages];};
					sleep 4;
					_unit setDamage 0;
					_unit setVariable ["unithealth",[12000,0,0]];
					_lastBandage = time;
					_unit enableAI "FSM";
				};
			};
		};
	};
	sleep DZAI_refreshRate;										//Check again in x seconds.
};
sleep 0.5;
if (DZAI_debugLevel > 1) then {diag_log "DZAI Extended Debug: AI resupply script deactivated.";};
