/*
	spawnmilitary_custom
	
	Usage: 
	
	Description: MAI custom spawn function (MAI_spawn).
	
	Last updated: 6:00 PM 10/24/2013
*/

private ["_patrolDist","_trigger","_grpArray","_triggerPos","_gradeChances","_weapongrade","_totalAI","_startTime","_tMarker","_spawnMarker"];
if (!isServer) exitWith {};

_startTime = diag_tickTime;

_totalAI = _this select 0;									
//_this select 1;
_patrolDist = _this select 2;								
_trigger = _this select 3;									
_weapongrade = _this select 4;
_spawnMarker = _this select 5;

_grpArray = _trigger getVariable ["GroupArray",[]];	
if (count _grpArray > 0) exitWith {if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Active groups found at %1. Exiting spawn script (spawnmilitary)",(triggerText _trigger)];};};						

_triggerPos = getPosATL _trigger;
if (_totalAI == 0) then {_totalAI = 1};

if (MAI_debugMarkers > 0) then {
	if ((getMarkerColor str(_trigger)) == "") then {
		_tMarker = createMarker [str(_trigger), (getPosATL _trigger)];
		_tMarker setMarkerText "STATIC TRIGGER (ACTIVE)";
		_tMarker setMarkerType "Defend";
		_tMarker setMarkerColor "ColorRed";
		_tMarker setMarkerBrush "Solid";
		if (MAI_debugMarkers > 1) then {_nul = [_trigger] spawn MAI_updateSpawnMarker;};
	};
};

if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: Processed static trigger spawn data in %1 seconds (spawnmilitary).",(diag_tickTime - _startTime)];};

_startTime = diag_tickTime;

private ["_unitGroup","_spawnPos","_totalAI"];

_spawnPos = [(getPosATL _trigger),random (_patrolDist),random(360),false] call SHK_pos;
_unitGroup = [_totalAI,(createGroup resistance),_spawnPos,_trigger,_weapongrade] call MAI_setup_AI;

//Set group variables
_unitGroup setVariable ["unitType","static"];
_unitGroup allowFleeing 0;

//Update AI count
MAI_numAIUnits = MAI_numAIUnits + _totalAI;
if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Group %1 has group size %2.",_unitGroup,_totalAI];};

0 = [_unitGroup,_triggerPos,_patrolDist,MAI_debugMarkers] spawn MAI_BIN_taskPatrol;

if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: Spawned a group of %1 units in %2 seconds at %3 (spawnmilitary).",_totalAI,(diag_tickTime - _startTime),(triggerText _trigger)];};

_gradeChances = switch (_weapongrade) do {
	case 0: {[MAI_gradeChances0,MAI_gradeChances1] call BIS_fnc_selectRandom2};
	case 1: {[MAI_gradeChances1,MAI_gradeChances2] call BIS_fnc_selectRandom2};
	case 2: {[MAI_gradeChances2,MAI_gradeChances3] call BIS_fnc_selectRandom2};
	case 3: {MAI_gradeChances3};
	case 4; case 5; case 6; case 7; case 8; case 9: {MAI_gradeChances3};
	case default {[MAI_gradeChances0,MAI_gradeChances1,MAI_gradeChances2,MAI_gradeChances3] call BIS_fnc_selectRandom2};
};

0 = [_trigger,[_unitGroup],_patrolDist,_gradeChances,[],[_totalAI,0]] call MAI_setTrigVars;

_unitGroup
