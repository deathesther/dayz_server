/*
	spawn_heliPatrol
	
	Description:
	
	Last updated:	1:29 AM 9/29/2013
	
*/

private ["_objectMonitor"];

if (MAI_curHeliPatrols >= MAI_maxHeliPatrols) exitWith {};

_objectMonitor = [] call MAI_getObjMon;

for "_i" from 1 to (MAI_maxHeliPatrols - MAI_curHeliPatrols) do {
	private ["_heliType","_startPos","_helicopter","_unitGroup","_pilot","_turretCount","_crewCount","_weapongrade"];
	_heliType = MAI_heliTypes call BIS_fnc_selectRandom2;
	
	//If chosen classname isn't an air-type vehicle, then use UH1H as default.
	if !(_heliType isKindOf "Air") then {_heliType = "UH1H_DZ"};
	_startPos = [(getMarkerPos "MAI_centerMarker"),(600 + random((getMarkerSize "MAI_centerMarker") select 0)),random(360),false] call SHK_pos;
	//_startPos = ["MAI_centerMarker",true] call SHK_pos;
	
	//Create the patrol group
	_unitGroup = createGroup resistance;
	//diag_log format ["Created group %1",_unitGroup];
	
	//Create helicopter crew
	_pilot = _unitGroup createUnit [(MAI_militaryTypes call BIS_fnc_selectRandom2), [0,0,0], [], 1, "NONE"];
	[_pilot] joinSilent _unitGroup;
		
	//Create the helicopter and set variables
	_helicopter = createVehicle [_heliType, [_startPos select 0, _startPos select 1, 180], [], 0, "FLY"];
	_helicopter setFuel 1;
	_helicopter engineOn true;
	if (_heliType isKindOf "Plane") then {
		private ["_heliDir","_heliSpd"];
		_heliDir = random 360;
		_heliSpd = 120;
		_helicopter setPos [_startPos select 0, _startPos select 1, 180];
		_helicopter setDir _heliDir;
		_helicopter setVelocity [(sin _heliDir * _heliSpd),(cos _heliDir * _heliSpd), 0];
	};
	_objectMonitor set [count _objectMonitor, _helicopter];
	_helicopter setVariable ["ObjectID",""];
	_helicopter setVariable ["unitGroup",_unitGroup];
	if (MAI_debugLevel > 0) then {diag_log format ["Spawned helicopter type %1 for group %2 at %3.",_heliType,_unitGroup,mapGridPosition _helicopter];};

	//Add helicopter pilot
	_crewCount = 1;
	_pilot assignAsDriver _helicopter;
	_pilot moveInDriver _helicopter;
	0 = [_pilot,"helicrew"] call MAI_setSkills;
	_pilot setVariable ["unithealth",[12000,0,0]];
	_pilot setVariable ["removeNVG",1];
	_pilot setVariable ["unconscious",true];	//Prevent AI heli crew from being knocked unconscious
	_pilot setVariable ["MAI_deathTime",time];
	_pilot addWeapon "NVGoggles";
	_pilot addEventHandler ["HandleDamage",{_this call MAI_AI_handledamage}];
	
	//Fill all available helicopter gunner seats.
	_heliTurrets = configFile >> "CfgVehicles" >> _heliType >> "turrets";
	if ((count _heliTurrets) > 0) then {
		for "_i" from 0 to ((count _heliTurrets) - 1) do {
			private["_gunner"];
			_gunner = _unitGroup createUnit [(MAI_militaryTypes call BIS_fnc_selectRandom2), [0,0,0], [], 1, "NONE"];
			_gunner assignAsGunner _helicopter;
			_gunner moveInTurret [_helicopter,[_i]];
			0 = [_x,"helicrew"] call MAI_setSkills;
			_gunner setVariable ["unithealth",[12000,0,0]];
			_gunner setVariable ["removeNVG",1];
			_gunner setVariable ["unconscious",true];	//Prevent AI heli crew from being knocked unconscious
			_gunner setVariable ["MAI_deathTime",time];
			_gunner addWeapon "NVGoggles";
			_gunner addEventHandler ["HandleDamage",{_this call MAI_AI_handledamage}];
			[_gunner] joinSilent _unitGroup;
			_crewCount = _crewCount + 1;
			//diag_log format ["DEBUG :: Assigned gunner %1 of %2 to AI %3.",(_i+1),(count _heliTurrets),_heliType];
		};
	} else {
		if (((count (weapons _helicopter)) < 1) && (_heliType in (MAI_airWeapons select 0))) then {
			private ["_index","_vehWeapon","_vehMag"];
			_index = (MAI_airWeapons select 0) find _heliType;
			if (_index > -1) then {
				_vehWeapon = (MAI_airWeapons select 1) select _index;
				_helicopter addWeapon _vehWeapon;
				_vehMag = getArray (configFile >> "CfgWeapons" >> _vehWeapon >> "magazines") select 0;
				_helicopter addMagazine _vehMag;
				if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Added weapon %1 and magazine %2 to air vehicle %3.",_vehWeapon,_vehMag,_heliType]};
			};
		};
	};
	//Add eventhandlers
	_helicopter addEventHandler ["Killed",{_this spawn fnc_heliDespawn_M;}];					//Begin despawn process when heli is destroyed.
	//_helicopter addEventHandler ["LandedTouchDown",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];			//Destroy helicopter if it is forced to land.
	_helicopter addEventHandler ["GetOut",{_this call MAI_airLanding;}];	//Converts AI crew to ground AI units.
	_helicopter setVariable ["crewCount",_crewCount];
	_helicopter setVehicleAmmo 1;
	[_helicopter] spawn MAI_autoRearm_heli;

	//Set group behavior and waypoint
	_unitGroup allowFleeing 0;
	_unitGroup setBehaviour "AWARE";
	_unitGroup setSpeedMode "FULL";
	_unitGroup setCombatMode "RED";
	_unitGroup setVariable ["unitType","air"];
	
	//AI behavior settings for testing
	/*
	_unitGroup allowFleeing 0;
	_unitGroup setBehaviour "SAFE";
	_unitGroup setSpeedMode "FULL";
	_unitGroup setCombatMode "BLUE";
	*/

	//diag_log format ["DEBUG :: Helicopter group: %1",(units _unitGroup)];

	//Set initial waypoint and begin patrol
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [5,10,15];
	[_unitGroup,0] setWaypointCompletionRadius 150;
	[_unitGroup,0] setWaypointStatements ["true","[(group this)] spawn MAI_heliRandomPatrol;"];
	[_unitGroup] spawn MAI_heliRandomPatrol;

	if (!isNull _helicopter) then {MAI_curHeliPatrols = MAI_curHeliPatrols + 1};
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Created AI helicopter crew group %1 is now active and patrolling.",_unitGroup];};

	if (_i <= (MAI_maxHeliPatrols - MAI_curHeliPatrols)) then {sleep 20};
};
