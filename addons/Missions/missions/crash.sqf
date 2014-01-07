mission_spawn_crash = {
    private ["_vehicle","_position","_vehicle_spawn","_type","_crates","_crate_position","_isNear","_chance","_marker_name","_group_1","_group_2","_group_3","_timeout","_timeout2","_group_4_info","_group_4","_group_3_info","_paradrop","_spawn_ammo","_mission_id","_c130wreck","_group_1_info","_group_2_info"];

	_mission_id = _this select 0;	
	_position = _this select 1;
	
	_chance = floor(random 100);
	_crates = [];
	_vehicle = 0;
	_vehicle_spawn = false;
    _paradrop = false;

    
	_c130wreck = createVehicle ["C130J_wreck_EP1",_position,[], 0, "NONE"];
	
	//  Spawn Supplies -- Crates
	for "_i" from 0 to (mission_num_of_crates + 2) do
	{
		_crate_position = [_position,0,30,3,0,2000,0] call BIS_fnc_findSafePos;
		if ((count _crate_position) == 2) then {
			_type = mission_crates call BIS_fnc_selectRandom;
			_crates set [count _crates, ([_crate_position, _type] call mission_spawn_crates)];
		};
	};

	// SPAWN AI
	// Inital Group 200 metre range, 1 sniper, 4 riflemen
	_group_1_info = [(_mission_id + "-AIGroup1"), "AI", _position, 100, 6, 1] call mission_spawn_ai;
	_group_1 = _group_1_info select 1;
	
	// Second Group 80 metre range, 1 sniper, 4 riflemen
	_group_2_info = [(_mission_id + "-AIGroup2"), "AI", _position, 50, 4, 2] call mission_spawn_ai;
	_group_2 = _group_2_info select 1;
	
	// Third Group 80 metre range, 1 sniper, 4 riflemen
	_group_3_info = [(_mission_id + "-AIGroup3"), "AI_HELI", _position, 200, 6, 0] call mission_spawn_ai;
	_group_3 = _group_3_info select 1;
	
	// Fourth Group
	_group_4_info = objNull;
	_group_4 = objNull;
	
	// Fifth Group
	_group_5_info = objNull;

	_chance = (random 10);
	switch (true) do {
        
        case (_chance <= 2):
        {
			_group_4_info = [(_mission_id + "-AIGroup4"), "AI_HELI", _position, 300, 6, 0] call mission_spawn_ai;
			_group_4 = _group_4_info select 1;
			//[_group4] call mission_kill_vehicle_group;
        };
        
        case (_chance <= 4):
        {
			_group_4_info = [(_mission_id + "-AIGroup4"), "AI_HELI", _position, 300, 3, 2] call mission_spawn_ai;
			_group_4 = _group_4_info select 1;
            //[_group4] call mission_kill_vehicle_group;
        };
        
        case (_chance <= 7):
        {
			_group_4_info = [(_mission_id + "-AIGroup4"), "AI_LAND", _position, 300, 6, 1] call mission_spawn_ai;
			_group_4 = _group_4_info select 1;
            //[_group4] call mission_kill_vehicle_group;
        };
        
        default
        {
			_group_4_info = [(_mission_id + "-AIGroup4"), "AI", _position, 300, 4, 1] call mission_spawn_ai;
			_group_4 = _group_4_info select 1;
        };
    };

	
	// Player Markers
	_marker_name = (_mission_id + "_player_marker");
	[_marker_name, _position, "ColorBlack", true] call mission_add_marker;

	customMissionWarning = ["CrashCJ", mission_warning_debug, _marker_name, _position, _vehicle_spawn, _vehicle];
	publicVariable "customMissionWarning";

	// Wait till all AI Dead or Mission Times Out

	_timeout = time + mission_despawn_timer_min;
    _spawn_ammo = true;
	_isNear = false;
	_heli_reinforcements = false;
	waitUntil{
		sleep 15;
		if ((_spawn_ammo) || (_heli_reinforcements) || (_paradrop)) then {
			_isNear = [_position, 100] call mission_nearbyPlayers;
			if (_isNear) then {
				if (_spawn_ammo) then {
					{
						[_x, "Random"] execVM "\z\addons\dayz_server\addons\missions\misc\fillBoxes.sqf";
						sleep 1;
					} forEach _crates;
					_spawn_ammo = false;
				};
				if (_paradrop) then {
					//_group_4_info = [(_mission_id + "-AIGroup4"), "AI_LAND", _position, 300, 6, -1] call mission_spawn_ai;
					_paradrop = false;
				};
				if (_heli_reinforcements) then {
					[_position] call mission_heli_call_check;
					_heli_reinforcements = false;
				};
			};
		};
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
		
		_isNear = [_position, 500] call mission_nearbyPlayers;
		if ((!_isNear) && (time > _timeout)) then {
			_isNear = false;
		};
		if (time > _timeout2) then {
			_isNear = false;
		};
		sleep 30;
	};

	[_marker_name, true] call mission_delete_marker;

	diag_log ("DEBUG: Mission Code: Removing AI + Crates");
	
	deleteVehicle _c130wreck;
	
	// Remove Crates
	//{
	//	deleteVehicle _x;
	//} forEach _crates;

	
	// Kill All AI + Triggers
	{
		[_x,_x] call DZAI_unitDeath;
	} forEach units _group_1;
	deletevehicle (_group_1_info select 0);
	
	{
		[_x,_x] call DZAI_unitDeath;
	} forEach units _group_2;
	deletevehicle (_group_2_info select 0);
	
	{
		[_x,_x] call DZAI_unitDeath;
	} forEach units _group_3;
	deletevehicle (_group_3_info select 0);
	
	{
		[_x,_x] call DZAI_unitDeath;
	} forEach units _group_4;
	deletevehicle (_group_4_info select 0);
	
	DZAI_actTrigs = (DZAI_actTrigs - 1);
};