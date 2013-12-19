mission_spawn_crash = {
    private ["_vehicle","_vehicle_position","_position","_vehicle_spawn","_veh_pool","_type","_crates","_crate_position","_isNear","_chance","_mission_type","_marker_name","_marker","_group_1","_group_2","_group_3","_timeout","_timeout2"];

	_mission_id = _this select 0;	
	_position = _this select 1;
	
	_chance = floor(random 100);
	_crates = [];
	_vehicle = 0;
	_vehicle_spawn = false;


	_c130wreck = createVehicle ["C130J_wreck_EP1",_position,[], 0, "NONE"];
	
	//  Spawn Supplies -- Crates
	for "_i" from 0 to (mission_num_of_crates + 2) do
	{
		_crate_position = [_position,0,30,3,0,2000,0] call BIS_fnc_findSafePos;
		if ((count _crate_position) == 2) then {
			_type = mission_crates call BIS_fnc_selectRandom;
			_crates = _crates + [[_crate_position,_type,"Random"] call mission_spawn_crates];
		};
	};

	// SPAWN AI
	_this = createMarker ["DZAI_marker_boomc", _position];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Empty";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [200, 200];
	_this setMarkerAlpha 0;
    DZAI_marker_boomc = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_boomc",20,1,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

	
	// Player Markers
	_marker_name = (_mission_id + "_player_marker");
	[_marker_name, _position, "ColorBlack", true] call mission_add_marker;

	customMissionWarning = ["CrashCJ", mission_warning_debug, _marker_name, _position, _vehicle_spawn, _vehicle];
	publicVariable "customMissionWarning";

	// Wait till all AI Dead or Mission Times Out

	_timeout = time + mission_despawn_timer_min;
	waitUntil{
		sleep 30;
		if ((count units _group_1 == 0) && (count units _group_2 == 0) && (count units _group_3 == 0) && (count units _group_4 == 0)) exitWith {true};
		if (time > _timeout) exitWith {true};
		false
	};


	// Wait till no Players within 200 metres && Mission Timeout Check for Crates
	_isNear = true;
	_timeout = time + ((mission_despawn_timer_max - mission_despawn_timer_min)/2);
	_timeout2 = _timeout + ((mission_despawn_timer_max - mission_despawn_timer_min)/2);
	while {_isNear} do
	{
		sleep 30;
		_isNear = [_crate_position, 500] call mission_nearbyPlayers;
		if ((!_isNear) && (time > _timeout)) then {
			_isNear = false;
		};
		if (time > _timeout2) then {
			_isNear = false;
		};
	};

	[_marker_name, true] call mission_delete_marker;

	diag_log ("DEBUG: Mission Code: Removing AI + Crates");
	// Remove Crates
	{
		deleteVehicle _x;
	} forEach _crates;
};