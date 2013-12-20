/*
	
	
	Description:
	
	Last updated:
	
*/
#define MAX_CARGO_COUNT 3
#define MAX_GUNNER_COUNT 2
private ["_objectMonitor","_amount"];

if (MAI_curLandPatrols >= MAI_maxLandPatrols) exitWith {};

_amount = _this;

_objectMonitor = [] call MAI_getObjMon;

for "_i" from 1 to _amount do {
	private ["_vehType","_startPos","_vehicle","_unitGroup","_driver","_cargoSpots","_gunnerSpots","_weapongrade","_cargo","_gunner"];
	_vehType = MAI_vehTypes call BIS_fnc_selectRandom2;
	
	if !(_vehType isKindOf "land") then {_vehType = "UAZ_Unarmed_TK_EP1"};
	_startPos = [(getMarkerPos "MAI_centerMarker"),300 + random((getMarkerSize "MAI_centerMarker") select 0),random(360),false,[1,300]] call SHK_pos;
	
	//Create the patrol group
	_unitGroup = createGroup resistance;
	//diag_log format ["Created group %1",_unitGroup];
	
	//Create vehicle crew
	_weapongrade = [MAI_weaponGrades,MAI_gradeChances3] call fnc_selectRandomWeighted_M;
	_driver = _unitGroup createUnit [(MAI_militaryTypes call BIS_fnc_selectRandom2), [0,0,0], [], 1, "NONE"];
	[_driver] joinSilent _unitGroup;
		
	//Create the vehicle and set variables
	_vehicle = createVehicle [_vehType, [_startPos select 0, _startPos select 1, 0], [], 0, "NONE"];
	_vehicle setFuel 1;
	_vehicle engineOn true;

	_objectMonitor set [count _objectMonitor, _vehicle];
	_vehicle setVariable ["ObjectID",""];
	_vehicle setVariable ["unitGroup",_unitGroup];
	if (MAI_debugLevel > 0) then {diag_log format ["Spawned vehicle type %1 for group %2 at %3.",_vehType,_unitGroup,mapGridPosition _vehicle];};

	//Add vehicle pilot
	_crewCount = 1;
	_driver assignAsDriver _vehicle;
	_driver moveInDriver _vehicle;
	0 = [_driver,_weapongrade] call MAI_setSkills;
	0 = [_driver,_weapongrade] call MAI_setupLoadout;
	_driver setVariable ["unithealth",[12000,0,0,false,false]];
	_driver setVariable ["unconscious",true];	//Prevent AI heli crew from being knocked unconscious
	_driver setVariable ["MAI_deathTime",time];
	if (!(_driver hasWeapon "NVGoggles")) then {
		_driver addWeapon "NVGoggles";
		_driver setVariable ["removeNVG",1];
	};
	_driver addEventHandler ["HandleDamage",{_this call MAI_AI_handledamage}];
	
	//Fill passenger seat(s)
	_cargoSpots = _vehicle emptyPositions "cargo";
	for "_i" from 0 to ((_cargoSpots min MAX_CARGO_COUNT) - 1) do {
		_cargo = _unitGroup createUnit [(MAI_militaryTypes call BIS_fnc_selectRandom2), [0,0,0], [], 1, "NONE"];
		[_cargo] joinSilent _unitGroup;
		0 = [_cargo,_weapongrade] call MAI_setSkills;
		0 = [_cargo,_weapongrade] call MAI_setupLoadout;
		_cargo setVariable ["unithealth",[12000,0,0,false,false]];
		_cargo setVariable ["unconscious",true];	//Prevent AI heli crew from being knocked unconscious
		_cargo setVariable ["MAI_deathTime",time];
		if (!(_cargo hasWeapon "NVGoggles")) then {
			_cargo addWeapon "NVGoggles";
			_cargo setVariable ["removeNVG",1];
		};
		_cargo addEventHandler ["HandleDamage",{_this call MAI_AI_handledamage}];
		_cargo assignAsCargo _vehicle;
		_cargo moveInCargo [_vehicle,_i];
		_crewCount = _crewCount + 1;
	};
	
	//Fill gunner spot(s)
	_gunnerSpots = _vehicle emptyPositions "gunner";
	for "_i" from 0 to ((_gunnerSpots min MAX_GUNNER_COUNT) - 1) do {
		_gunner = _unitGroup createUnit [(MAI_militaryTypes call BIS_fnc_selectRandom2), [0,0,0], [], 1, "NONE"];
		[_gunner] joinSilent _unitGroup;
		0 = [_gunner,_weapongrade] call MAI_setSkills;
		0 = [_gunner,_weapongrade] call MAI_setupLoadout;
		_gunner setVariable ["unithealth",[12000,0,0,false,false]];
		_gunner setVariable ["unconscious",true];	//Prevent AI heli crew from being knocked unconscious
		_gunner setVariable ["MAI_deathTime",time];
		if (!(_gunner hasWeapon "NVGoggles")) then {
			_gunner addWeapon "NVGoggles";
			_gunner setVariable ["removeNVG",1];
		};
		_gunner addEventHandler ["HandleDamage",{_this call MAI_AI_handledamage}];
		_gunner assignAsCargo _vehicle;
		_gunner moveInCargo [_vehicle,_i];
		_crewCount = _crewCount + 1;
	};

	//Add eventhandlers
	_vehicle addEventHandler ["Killed",{_this call MAI_vehDespawn; (_this select 0) removeAllEventHandlers "Killed";}];
	_vehicle addEventHandler ["GetOut",{_this call MAI_vehGetOut; (_this select 0) removeAllEventHandlers "GetOut";}];
	_vehicle addEventHandler ["HandleDamage",{_this call MAI_vHandleDamage}];
	_vehicle setVariable ["crewCount",_crewCount];
	[_vehicle] spawn MAI_autoRearm_veh;

	//Set group behavior and waypoint
	_unitGroup allowFleeing 0;
	_unitGroup setBehaviour "AWARE";
	_unitGroup setSpeedMode "FULL";
	_unitGroup setCombatMode "RED";
	_unitGroup setVariable ["unitType","land"];

	//diag_log format ["DEBUG :: vehicle group: %1",(units _unitGroup)];

	//Set initial waypoint and begin patrol
	[_unitGroup,0] setWaypointType "MOVE";
	[_unitGroup,0] setWaypointTimeout [5,10,15];
	[_unitGroup,0] setWaypointCompletionRadius 150;
	[_unitGroup,0] setWaypointStatements ["true","[(group this)] spawn MAI_vehPatrol;"];
	[_unitGroup] spawn MAI_vehPatrol;

	if (!isNull _vehicle) then {MAI_curLandPatrols = MAI_curLandPatrols + 1};
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Created AI vehicle crew group %1 is now active and patrolling.",_unitGroup];};
	if (_i < _amount) then {sleep 20};
};
