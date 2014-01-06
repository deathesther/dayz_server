private ["_mission_array","_wait","_handle","_mission_counter","_mission","_index","_last_index","_mission_unique_id"];

#include "config.sqf"
mission_markers = [];

diag_log ("DEBUG: Mission Code: Waiting for Server to finish Loading.......");
waitUntil{!isNil "BIS_fnc_findSafePos"};
waitUntil{!isNil "BIS_fnc_selectRandom"};
waitUntil{!isNil "sm_done"};
waitUntil{sm_done};
diag_log ("DEBUG: Mission Code: Starting Deamon.......");

call compile preprocessFileLineNumbers "\z\addons\dayz_server\addons\Missions\mission_functions.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\addons\Missions\missions\standard.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\addons\Missions\missions\crash.sqf";

if (mission_hunter) then {
	call compile preprocessFile "Predator_fnc.sqf";	
	call compile preprocessFile "Predator_aux_fnc.sqf";
};

/*
if (isNull "mission_dzai_heli_array") then {
	diag_log ("DEBUG: Missions: No mission_dzai_heli_array defined. Heli reinforcements Disabled");
	mission_heli_array_clean = {};
	mission_heli_call = {};
	mission_heli_call_check = {};
};
*/


// Initialize Building Array
/*
mission_buildings_pos = [];
{
	_type = (_x select 0);
	mission_buildings_pos = mission_buildings_pos + [_type, [_type] call mission_find_buildings];
} forEach mission_buildings;
*/
sleep 60;

// Loop to keep heli array clean
[] spawn mission_heli_array_clean;

// Initialize mission array
_mission_array = [];
_mission_unique_id = 0;
for "_x" from 1 to mission_max_number do {
	_mission_unique_id = _mission_unique_id + 1;
	_handle = [str(_mission_unique_id)] spawn mission_spawn;
	_mission_array = _mission_array + [_handle];
	sleep 60;
};	

// Main Loop for Spawning Missions
while {true} do {
	_wait = [mission_spawn_timer_min, mission_spawn_timer_max] call mission_timer;
	
	sleep _wait;
	if (((diag_fps) > mission_fps_check) && (mission_player_check <= (count playableUnits)))  then {

		// Getting Number of Running Bandit Missions
		_mission_counter = mission_max_number;
		{
			if (scriptDone _x) then {
				_mission_counter = _mission_counter - 1;
			};
		} forEach _mission_array;

		// Spawning Bandit Missions
		_index = 0;
		_last_index = count _mission_array;
		while {(_index < _last_index)} do
		{
			_mission = (_mission_array select _index);
			if (scriptDone _mission) then {
				if (((random 10) > 6) || (_mission_counter < mission_min_number)) exitWith {

					_mission_unique_id = _mission_unique_id + 1;
					_handle = [str(_mission_unique_id)] spawn mission_spawn;

					_mission_array set [_index, _handle];
					_mission_counter = _mission_counter + 1;
					sleep 60;
				};
			};
			_index = _index + 1;
		};
	};
};