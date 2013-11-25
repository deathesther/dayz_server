/*
	MAI Functions
	
	Last Updated: 7:49 PM 10/30/2013
*/

waituntil {!isnil "bis_fnc_init"};
diag_log "[MAI] Compiling MAI functions.";
// [] call BIS_fnc_help;
//Compile general functions.
if (isNil "SHK_pos_getPos") then {call compile preprocessFile "\z\addons\dayz_server\MAI\SHK_pos\shk_pos_init.sqf";};
BIS_fnc_selectRandom3 = { 
	#include "\z\addons\dayz_server\MAI\compile\fn_selectRandom.sqf" 
};
if (MAI_zombieEnemy && (MAI_weaponNoise > 0)) then { // Optional Zed-to-AI aggro functions
	ai_fired = { 
		#include "\z\addons\dayz_server\MAI\compile\ai_fired.sqf"
	};
};
if (MAI_passiveAggro or (MAI_zombieEnemy && (MAI_weaponNoise > 0))) then {
	ai_alertzombies = {
		#include "\z\addons\dayz_server\MAI\compile\ai_alertzombies.sqf"
	};
};
MAI_AI_killed_all = { 
	#include "\z\addons\dayz_server\MAI\compile\ai_killed_all.sqf"
};
MAI_AI_killed_static = {
	#include "\z\addons\dayz_server\MAI\compile\ai_killed_static.sqf"
};
MAI_AI_killed_dynamic = {
	#include "\z\addons\dayz_server\MAI\compile\ai_killed_dynamic.sqf"
};
fnc_selectRandomWeightedmil = {
	#include "\z\addons\dayz_server\MAI\compile\fn_selectRandomWeighted.sqf"
};
MAI_setup_AI = {
	#include "\z\addons\dayz_server\MAI\compile\fn_createGroup.sqf"
};
MAI_AI_handledamage = {
	//#include "\z\addons\dayz_server\MAI\compile\fn_damageHandlerAI.sqf"
	#include "\z\addons\dayz_server\MAI\compile\fn_damageHandlerAI2.sqf"
};
MAI_BIN_taskPatrol = {
	#include "\z\addons\dayz_server\MAI\compile\BIN_taskPatrol.sqf"
};
if (MAI_debugMarkers < 1) then {
	MAI_autoRearm_unit = {
		#include "\z\addons\dayz_server\MAI\compile\unit_resupply.sqf"
	};
} else {
	MAI_autoRearm_unit = {
		#include "\z\addons\dayz_server\MAI\compile\unit_resupply_debug.sqf"
	};
};
if (MAI_findKiller) then {
	MAI_huntKiller = {
		#include "\z\addons\dayz_server\MAI\compile\fn_findKiller.sqf"
	};
};
MAI_dyn_huntPlayer = {
	#include "\z\addons\dayz_server\MAI\compile\fn_seekPlayer.sqf"
};
MAI_randDynTriggers = {
	#include "\z\addons\dayz_server\MAI\compile\fn_randomizeTriggers.sqf"
};
	
//Compile spawn scripts
fnc_spawnmilitary = 	{
	#include "\z\addons\dayz_server\MAI\spawn_functions\spawnmilitary.sqf"
};
fnc_spawnmilitary_custom	= {
	#include "\z\addons\dayz_server\MAI\spawn_functions\spawnmilitary_custom.sqf"
};
fnc_respawnmilitary = {
	#include "\z\addons\dayz_server\MAI\spawn_functions\respawnmilitary.sqf"
};
fnc_respawnHandlermill = {
	#include "\z\addons\dayz_server\MAI\spawn_functions\respawnHandler.sqf"
};
fnc_despawnmilitary = {
	#include "\z\addons\dayz_server\MAI\spawn_functions\despawnmilitary.sqf"
};
if !(MAI_V2dynSpawns) then {
	fnc_spawnmilitary_dynamic = 	{
		#include "\z\addons\dayz_server\MAI\spawn_functions\spawnmilitary_dynamic.sqf"
	};
	fnc_despawnmilitary_dynamic = {
		#include "\z\addons\dayz_server\MAI\spawn_functions\despawnmilitary_dynamic.sqf"
	};
} else {
	fnc_spawnmilitary_dynamic = 	{
		#include "\z\addons\dayz_server\MAI\spawn_functions\spawnmilitary_dynamicV2.sqf"
	};
	fnc_despawnmilitary_dynamic = {
		#include "\z\addons\dayz_server\MAI\spawn_functions\despawnmilitary_dynamicV2.sqf"
	};
};

//Helicopter patrol scripts
fnc_heliDespawnmil ={ 
	#include "\z\addons\dayz_server\MAI\spawn_functions\heli_despawn.sqf"
};
if (MAI_debugMarkers < 1) then {
	MAI_autoRearm_heli = { 
		#include "\z\addons\dayz_server\MAI\compile\heli_resupply.sqf"
	};
} else {
	MAI_autoRearm_heli = { 
		#include "\z\addons\dayz_server\MAI\compile\heli_resupply_debug.sqf"
	};
};
fnc_spawnHeliPatrolmill	= { 
	#include "\z\addons\dayz_server\MAI\spawn_functions\spawn_heliPatrol.sqf"
};

//MAI custom spawns function.
MAI_spawn = {
	private ["_spawnMarker","_patrolRadius","_trigStatements","_trigger","_respawn","_weapongrade","_totalAI","_useUPS"];
	
	_spawnMarker = _this select 0;
	if ((typeName _spawnMarker) != "STRING") exitWith {diag_log "MAI Error: Marker string not given!"};
	_totalAI = if ((typeName (_this select 1)) == "SCALAR") then {_this select 1} else {1};
	_weapongrade = if ((typeName (_this select 2)) == "SCALAR") then {_this select 2} else {1};
	_respawn = if ((typeName (_this select 3)) == "BOOL") then {_this select 3} else {true};
	//_useUPS = if ((count _this) > 3) then {_this select 3} else {false};

	_patrolRadius = ((((getMarkerSize _spawnMarker) select 0) min ((getMarkerSize _spawnMarker) select 1)) min 300);

	_trigStatements = format ["0 = [%1,0,%2,thisTrigger,%3,%4] call fnc_spawnmilitary_custom;",_totalAI,_patrolRadius,_weapongrade,_spawnMarker];
	_trigger = createTrigger ["EmptyDetector", getMarkerPos(_spawnMarker)];
	_trigger setTriggerArea [600, 600, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerTimeout [5, 5, 5, true];
	_trigger setTriggerText _spawnMarker;
	_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;",_trigStatements,"0 = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger setVariable ["respawn",_respawn];
	_trigger setVariable ["spawnmarker",_spawnMarker];
	//diag_log format ["DEBUG :: %1",_trigStatements];
	
	if ((markerAlpha _spawnMarker) > 0) then {
		_spawnMarker setMarkerAlpha 0;
	};
	if ((markerShape _spawnMarker) == "ELLIPSE") then {
		_spawnMarker setMarkerShape "RECTANGLE";
	};
	
	diag_log format ["DEBUG :: Created custom spawn area with %1 AI units, weapongrade %2, respawn %3.",_totalAI,_weapongrade,_respawn];
	true
};

//Miscellaneous functions 
//------------------------------------------------------------------------------------------------------------------------

//MAI group side assignment function. Detects when resistance side has too many groups, then switches to resistance side.
MAI_getFreeSide = {
	private["_groupSide"];
	_groupSide = resistance;
	//diag_log format ["Assigned side %1 to AI group",_groupSide];
	
	_groupSide
};

//Selects a random dynamic trigger to use as AI helicopter's next waypoint
MAI_heliRandomPatrol = {
	private ["_unitGroup","_tooClose","_wpSelect"];
	_unitGroup = _this select 0;

	_tooClose = true;
	while {_tooClose} do {
		_wpSelect = (MAI_locations call BIS_fnc_selectRandom3) select 1;
		if (((waypointPosition [_unitGroup,0]) distance _wpSelect) > 0) then {
			_tooClose = false;
		};
	};
	_wpSelect = [_wpSelect,200+(random 100),(random 360),true] call SHK_pos;
	[_unitGroup,0] setWPPos _wpSelect; 
	if ((waypointType [_unitGroup,0]) == "MOVE") then {
		if ((random 1) < 0.30) then {
			[_unitGroup,0] setWaypointType "SAD";
			[_unitGroup,0] setWaypointTimeout [20,40,60];
		};
	} else {
		[_unitGroup,0] setWaypointType "MOVE";
		[_unitGroup,0] setWaypointTimeout [3,7,10];
	};
	[_unitGroup,0] setWaypointCompletionRadius 150;
	_unitGroup setCurrentWaypoint [_unitGroup,0];
};

//Sets skills for unit based on their weapongrade value.
MAI_setSkills = {
	private["_unit","_weapongrade","_skillArray"];
	_unit = _this select 0;
	_weapongrade = _this select 1;

	_skillArray = switch (_weapongrade) do {
		case 0: {MAI_skill0};
		case 1: {MAI_skill1};
		case 2: {MAI_skill2};
		case 3: {MAI_skill3};
		case "helicrew": {MAI_heliCrewSkills};
		case default {MAI_skill2};
	};
	{
		_unit setskill [_x select 0,((_x select 1) + random (_x select 2))];
	} foreach _skillArray;
};

//Spawns flies on AI corpse
MAI_deathFlies = {
	private ["_soundFlies"];
	_soundFlies = createSoundSource["Sound_Flies",getPosATL _this,[],0];
	_soundFlies attachTo [_this,[0,0,0]];
	_this setVariable ["sound_flies",_soundFlies];
};

//Returns probabilities of generating different grades of weapons based on equipType value
MAI_getGradeChances = {
	private ["_equipType", "_gradeChances"];
	_equipType = _this select 0;

	_gradeChances = switch (_equipType) do {
		case 0: {MAI_gradeChances0};
		case 1: {MAI_gradeChances1};
		case 2: {MAI_gradeChances2};
		case 3: {MAI_gradeChances3};
		case default {MAI_gradeChancesDyn};
	};
	
	_gradeChances
};

//Convert server uptime in seconds to formatted time (days/hours/minutes/seconds)
MAI_getUptime = {
	private ["_iS","_oS","_oM","_oH","_oD"];

	_iS = time;
	
	_oS = floor (_iS % 60);
	_oM = floor ((_iS % 3600)/60);
	_oH = floor ((_iS % 86400)/3600);
	_oD = floor ((_iS % 2592000)/86400);
	
	[_oD,_oH,_oM,_oS]
};

//Combines two arrays and returns the combined array. Does not add duplicate values. Second array is appended to first array.
MAI_append = {
	{
		if !(_x in (_this select 0)) then {
			(_this select 0) set [(count (_this select 0)),_x];
		};
	} forEach (_this select 1);
	
	(_this select 0)
};

//Knocks an AI unit unconscious for x seconds - determines the correct animation to use, and returns unit to standing state after waking.
MAI_unconscious = {
	private ["_unit","_anim","_hit","_sleep"];
	_unit = _this select 0;
	_hit = _this select 1;
	
	if ((animationState _unit) in ["amovppnemrunsnonwnondf","amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemsprslowwrfldf","aidlppnemstpsnonwnondnon0s","aidlppnemstpsnonwnondnon01"]) then {
		_anim = "adthppnemstpsraswpstdnon_2";
	} else {
		_anim = "adthpercmstpslowwrfldnon_4";
	};
	_unit switchMove _anim;
	_nul = [objNull, _unit, rSWITCHMOVE, _anim] call RE;  
	//diag_log "DEBUG :: AI unit is unconscious.";

	_sleep = if (_hit == "head_hit") then {20} else {12.5};
	//diag_log format ["DEBUG :: Knocked out AI %1 for %2 seconds.",_unit,_sleep];
	sleep _sleep;

	_nul = [objNull, _unit, rSWITCHMOVE, "amovppnemrunsnonwnondf"] call RE;
	sleep 0.1;
	_unit switchMove "amovppnemrunsnonwnondf";
	//diag_log "DEBUG :: AI unit is conscious.";
	_unit setVariable ["unconscious",false];
};

//Killed eventhandler script used by both static and dynamic AI.
MAI_unitDeath = {
	private["_victim","_killer","_unitGroup"];
	_victim = _this select 0;
	_killer = _this select 1;
	
	if (_victim getVariable ["deathhandled",false]) exitWith {};
	_victim setVariable ["deathhandled",true];
	_victim setDamage 1;
	
	_unitGroup = (group _victim);

	switch (_unitGroup getVariable "unitType") do {
		case "static":
		{
			[_victim,_unitGroup] spawn MAI_AI_killed_static;
		};
		case "dynamic":
		{
			[_victim,_unitGroup] spawn MAI_AI_killed_dynamic;
		};
		case default {
			if (MAI_debugMarkers > 0) then {
				{
					deleteMarker (str _x);
				} forEach (waypoints _unitGroup);
			};
		};
	};
	
	[_victim,_killer,_unitGroup] call MAI_AI_killed_all;
	//diag_log format ["DEBUG :: AI %1 (Group %2) killed by %3",_victim,_unitGroup,_killer];
	
	true
};

//Generic function to delete a specified object (or array of objects) after a specified time (seconds).
MAI_deleteObject = {
	private["_obj","_delay"];
	_obj = _this select 0;
	_delay = if ((count _this) > 1) then {_this select 1} else {300};
	
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Deleting object(s) %1 in %2 seconds.",_obj,_delay];};
	sleep _delay;
	
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Deleting object(s) %1 now.",_obj];};
	
	if ((typeName _obj) == "ARRAY") then {
		{deleteVehicle _x} forEach _obj;
	} else {deleteVehicle _obj};
};

//If a trigger's calculated totalAI value is zero, then add new group to respawn queue to retry spawn until a nonzero value is found.
MAI_retrySpawn = {
	private ["_trigger","_unitGroup","_dummy","_grpArray"];

	_trigger = _this select 0;

	waitUntil {sleep 0.1; (_trigger getVariable ["initialized",false])};

	//Create placeholder dummy unit.
	_unitGroup = createGroup (call MAI_getFreeSide);
	_dummy = _unitGroup createUnit ["Survivor1_DZ",[0,0,0],[],0,"FORM"];
	[_dummy] joinSilent _unitGroup;
	_dummy setVehicleInit "this hideObject true;this allowDamage false;this enableSimulation false;"; processInitCommands;
	_dummy disableAI "FSM";
	_dummy disableAI "ANIM";
	_dummy disableAI "MOVE";
	_dummy disableAI "TARGET";
	_dummy disableAI "AUTOTARGET";

	//Initialize group variables.
	_unitGroup setVariable ["dummyUnit",_dummy];
	_unitGroup setVariable ["groupSize",0];
	_unitGroup setVariable ["trigger",_trigger];
	_unitGroup setVariable ["unitType","static"];
	_unitGroup setVariable ["deadUnits",[]];
	_unitGroup allowFleeing 0;

	//Add new group to trigger's group array.
	_grpArray = _trigger getVariable "GroupArray";
	_grpArray set [(count _grpArray),_unitGroup];

	0 = [(time + MAI_respawnTime),_trigger,_unitGroup] spawn fnc_respawnHandlermill;

	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Inserted group %1 into respawn queue. (retryRespawn)",_unitGroup];};
};

//Refreshes position of debug markers of active static triggers for JIP players. Terminates once trigger is marked inactive.
MAI_updateSpawnMarker = {
	private ["_trigger","_markername","_marker"];
	_trigger = _this select 0;

	_marker = str (_trigger);

	while {(getMarkerColor _marker) != "ColorGreen"} do {
		_marker setMarkerPos (getMarkerPos _marker);
		sleep 30;
	};
};

//Finds a position that does not have a player within a certain distance.
MAI_findSpawnPos = {
	private ["_spawnPos","_attempts","_continue","_spawnpool"];
	
	_attempts = 0;
	_continue = true;
	_spawnpool = [] + _this;
	while {((_attempts <= 5)&&_continue)} do {
		_spawnPos = _spawnpool select floor (random count _spawnpool);
		_spawnpool = _spawnpool - _spawnPos;	//Prevent this position from being reused if player distance check fails.
		if ((typeName _spawnPos) == "OBJECT") then {_spawnPos = getPosATL _spawnPos}; 
		if (({isPlayer _x} count (_spawnPos nearEntities [["AllVehicles","CAManBase"],50])) == 0) then {_continue = false};
		_attempts = _attempts + 1;
		if ((MAI_debugLevel > 0)&&(_attempts > 1)) then {diag_log format ["MAI Debug: Player found within 40m of chosen spawn position. (attempt %1/5).",_attempts];};
	};
	_spawnPos
};

//Relocates a dynamic trigger
MAI_relocDynTrigger = {
	private ["_newPos","_attempts"];

	_attempts = 0;	
	while {_newPos = ["MAI_centerMarker",false,MAI_dynBlacklist] call SHK_pos; (_attempts < 4)&&(({([_newPos select 0,_newPos select 1] distance _x) < (2*(MAI_dynTriggerRadius - (MAI_dynTriggerRadius*MAI_dynOverlap)))} count MAI_dynTriggerArray) > 0)} do {
	_attempts = _attempts +1;
		if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Calculated trigger position intersects with at least 1 other trigger (attempt %1/4).",_attempts];};
	};
	if (MAI_debugMarkers > 0) then {
		private["_marker"];
		_marker = format["trigger_%1",_this];
		_marker setMarkerPos _newPos;
		_marker setMarkerColor "ColorYellow";			//Reset trigger indicator to Ready.
		_marker setMarkerAlpha 0.8;
	};
	_this setPosATL _newPos;

	_newPos
};

//Creates static spawn trigger (in development)
/*Syntax: 	[
				_spawnMarker, 		//Circular marker defining patrol radius.
				[_minAI,_addAI],	//(Optional, default [1,1]) Minimum and maximum bonus amount of AI units per group.
				_positionArray,		//(Optional, default []): Array of markers defining possible spawn points. If omitted or left empty, nearby buildings within 250m radius will be used as spawn points.
				_equipType,			//(Optional, default 1): Number between 0-3. Defines AI weapon selection and skill parameters.
				_numGroups			//(Optional, default 1): Number of AI groups to spawn using the above parameters.			
			] call MAI_static_spawn;
*/			
MAI_static_spawn = {
	private ["_spawnMarker","_minAI","_addAI","_positionArray","_equipType","_numGroups","_patrolRadius","_trigStatements","_trigger"];
	
	if ((count _this) < 1) exitWith {diag_log format ["MAI Error: MAI_static_spawn expected at least 1 argument, found %1.",(count _this)]; false};
	_spawnMarker = _this select 0;
	_spawnMarker setMarkerAlpha 0;
	
	if ((count _this) > 1) then {
		_minAI = (_this select 1) select 0;
		_addAI = (_this select 1) select 1;
	} else {
		_minAI = 1;
		_addAI = 1;
	};
	_positionArray = if ((count _this) > 2) then {_this select 2} else {[]};
	_equipType = if ((count _this) > 3) then {_this select 3} else {1};
	_numGroups = if ((count _this) > 4) then {_this select 4} else {1};
	
	_patrolRadius = (getMarkerSize _spawnMarker) select 0;
	
	_trigStatements = format ["_nul = [%1,%2,%3,thisTrigger,%4,%5,%6] call fnc_spawnmilitary;",_minAI,_addAI,_patrolRadius,_positionArray,_equipType,_numGroups];
	_trigger = createTrigger ["EmptyDetector", getMarkerPos(_spawnMarker)];
	_trigger setTriggerArea [600, 600, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerTimeout [10, 15, 20, true];
	_trigger setTriggerText _spawnMarker;
	_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;",_trigStatements,"_nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	
	true
};

MAI_findLootPile = {
	private ["_lootPiles","_lootPos","_unitGroup","_searchRange"];
	_unitGroup = _this select 0;
	_searchRange = _this select 1;
	
	_lootPiles = (getPosATL (leader _unitGroup)) nearObjects ["ReammoBox",_searchRange];
	if ((count _lootPiles) > 0) then {
		_lootPos = getPosATL (_lootPiles call BIS_fnc_selectRandom3);
		(units _unitGroup) doMove _lootPos;
		{_x moveTo _lootPos} forEach (units _unitGroup);
		//diag_log format ["DEBUG :: AI group %1 is investigating a loot pile at %2.",_unitGroup,_lootPos];
	};
};

MAI_shuffleWP = {
	private ["_unitGroup","_locationArray","_newWPPos","_wp"];
	_unitGroup = _this select 0;
	_locationArray = (_unitGroup getVariable "trigger") getVariable "locationArray";
	_newWPPos = _locationArray call BIS_fnc_selectRandom3;
	//diag_log format ["DEBUG :: Chosen position: %1.",_newWPPos];
	_wp = (currentWaypoint _unitGroup);
	if (MAI_debugMarkers > 0) then {
		private["_markername"];
		_markername = format ["[%1,%2]",_unitGroup,_wp];
		//diag_log format ["DEBUG :: Relocating marker %1.",_markername];
		_markername setMarkerPos _newWPPos;
	};
	[_unitGroup,_wp] setWPPos _newWPPos;
};

MAI_bldgPatrol = {
	private ["_unitGroup","_locationArray"];
	_unitGroup = _this select 0;
	_locationArray = _this select 1;

	//diag_log format ["DEBUG :: Counted %1 spawn positions.",count _locationArray];
	
	for "_i" from 1 to 5 do {
		private ["_loc","_wp"];
		_loc = _locationArray call BIS_fnc_selectRandom3;
		//diag_log format ["DEBUG :: Chosen position: %1.",_loc];
		_wp = _unitGroup addWaypoint [_loc,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 35;
		_wp setWaypointTimeout [0,2,15];
		_wp setWaypointStatements ["true", "if ((random 3) > 2) then {_nul = [(group this)] spawn MAI_shuffleWP;} else {_nul = [(group this),100] spawn MAI_findLootPile;};"];
		if (MAI_debugMarkers > 0) then {
			private["_markername","_marker"];
			_markername = str (_wp);
			if ((getMarkerColor _markername) != "") then {deleteMarker _markername};
			_marker = createMarker [_markername,[_loc select 0,_loc select 1]];
			//diag_log format ["DEBUG :: Creating marker %1.",_markername];
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerType "Dot";
			_marker setMarkerColor "ColorOrange";
			_marker setMarkerBrush "SolidBorder";
			_marker setMarkerSize [20, 20];
		};
		if (_i == 5) then {
			_wp = _unitGroup addWaypoint [_loc, 0];
			_wp setWaypointType "CYCLE";
			_wp setWaypointCompletionRadius 100;
		};
		sleep 0.5;
	};
};

MAI_addLoot = {
	private ["_unit","_pistol","_pistols","_weapongrade","_magazine","_currentWeapon","_toolselect","_chance","_tool","_toolsArray"];
		_unit = _this select 0;
		_weapongrade = _this select 1;

		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: AI killed by player at %1. Generating loot with weapongrade %2 (fn_militaryAIKilled).",mapGridPosition _unit,_weapongrade];};

		if (_unit getVariable ["CanGivePistol",true]) then {
			_pistols = switch (_weapongrade) do {
				case 0: {MAI_Pistols0};
				case 1: {MAI_Pistols1};
				case 2: {MAI_Pistols2};
				case 3: {MAI_Pistols3};
				case default {[MAI_Pistols0,MAI_Pistols1,MAI_Pistols2,MAI_Pistols3] call BIS_fnc_selectRandom3};
			};

			_pistol = _pistols call BIS_fnc_selectRandom3;
			_magazine = getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines") select 0;
			_unit addMagazine _magazine;	
			_unit addWeapon _pistol;
			
			if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated pistol weapon: %1 for AI.",_pistol];};
			sleep 0.001;
		};
		
		//Add consumables, medical items, and miscellaneous items
		////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//Add one guaranteed Bandage to inventory
		_unit addMagazine "ItemBandage";

		//Add edible items to inventory
		for "_i" from 1 to MAI_invedibles do {
			if ((random 1) < MAI_chanceEdibles) then{
				private["_invedible"];
				_invedible = MAI_Edibles call BIS_fnc_selectRandom3;
				_unit addMagazine _invedible;
				if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Inventory Edible Item: %1 for AI.",_invedible];};
			};
		};
		
		//Add edible items to backpack
		for "_i" from 1 to MAI_bpedibles do {
			if ((random 1) < MAI_chanceEdibles) then {
				private["_bpedible"];
				_bpedible = MAI_Edibles call BIS_fnc_selectRandom3;
				(unitBackpack _unit) addMagazineCargoGlobal [_bpedible, 1];
				if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Backpack Edible Item: %1 for AI.",_bpedible];};
			};
		};
		
		if (_weapongrade > 0) then {
			//Chance to add miscellaneous item (Small) to backpack
			for "_i" from 1 to MAI_numMiscItemS do {
				if ((random 1) < MAI_chanceMiscItemS) then {
					private ["_miscItemS"];
					_miscItemS = MAI_MiscItemS call BIS_fnc_selectRandom3;
					(unitBackpack _unit) addMagazineCargoGlobal [_miscItemS,1];
					if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Misc Item (Small): %1 for AI.",_miscItemS];};
				};
			};
			
			//Chance to add miscellaneous item (Large) to backpack
			for "_i" from 1 to MAI_numMiscItemL do {
				if ((random 1) < MAI_chanceMiscItemL) then {
					private["_miscItemL"];
					_miscItemL = MAI_MiscItemL call BIS_fnc_selectRandom3;
					(unitBackpack _unit) addMagazineCargoGlobal [_miscItemL,1];
					if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Misc Item (Large): %1 for AI.",_miscItemL];};
				};
			};

			//Add medical items to backpack
			for "_i" from 1 to MAI_bpmedicals do {
				if ((random 1) < MAI_chanceMedicals) then {
					private["_bpmedical"];
					_bpmedical = MAI_Medicals2 call BIS_fnc_selectRandom3;
					(unitBackpack _unit) addMagazineCargoGlobal [_bpmedical, 1];
					if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Backpack Medical Item: %1 for AI.",_bpmedical];};
				};
			};

			//Add medical items to inventory
			for "_i" from 1 to MAI_invmedicals do {
				if ((random 1) < MAI_chanceMedicals) then {
					private["_invmedical"];
					_invmedical = MAI_Medicals1 call BIS_fnc_selectRandom3;
					_unit addMagazine _invmedical;
					if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Inventory Medical Item: %1 for AI.",_invmedical];};
				};
			};
			
			if (MAI_modName == "epoch") then {
				private ["_itemBar","_index","_chance","_metalBarCount"];
				_metalBarCount = (count MAI_metalBars);
				//diag_log format ["DEBUG :: Counted %1 bars in MAI_metalBars.",_metalBarCount];
				for "_i" from 0 to MAI_metalBarNum do {
					_index = floor (random _metalBarCount);
					_chance = ((MAI_metalBars select _index) select 1);
					//diag_log format ["DEBUG :: %1 chance to add bar.",_chance];
					if ((random 1) < _chance) then {
						_itemBar = ((MAI_metalBars select _index) select 0);
						_unit addMagazine _itemBar;
						//diag_log format ["DEBUG :: Added bar %1 as loot to AI corpse.",_itemBar];
					};
				};
			};
		};
		
		sleep 0.001;
		
		//Add tool items
		////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		_toolsArray = if (_weapongrade < 2) then {MAI_tools0} else {MAI_tools1};

		//diag_log format ["DEBUG :: Counted %1 tools in _toolsArray.",(count _toolsArray)];
		for "_i" from 0 to ((count _toolsArray) - 1) do {
			_chance = ((_toolsArray select _i) select 1);
			//diag_log format ["DEBUG :: %1 chance to add tool.",_chance];
			if ((random 1) < _chance) then {
				_tool = ((_toolsArray select _i) select 0);
				_unit addWeapon _tool;
				//diag_log format ["DEBUG :: Added tool %1 as loot to AI corpse.",_tool];
			};
	};
};

MAI_setupLoadout = {
	private ["_unit","_weapongrade","_weapons","_weapon","_magazine","_backpacks","_gadgetsArray","_backpack","_gadget"];
	_unit = _this select 0;
	_weapongrade = _this select 1;

	if (_unit getVariable ["loadoutDone",false]) exitWith {diag_log "MAI Error :: Unit already has loadout!";};
	if ((typeName _weapongrade) == "SCALAR") then {
		if ((count (weapons _unit)) > 0) then {
			removeAllWeapons _unit;
			_unit removeWeapon "ItemMap";
			_unit removeWeapon "ItemGPS";
			_unit removeWeapon "ItemCompass";
			_unit removeWeapon "ItemRadio";  
			_unit removeWeapon "ItemWatch";
		};
		
		switch (_weapongrade) do {
			case 0: {
				if ((random 1) < 0.30) then {
					_weapons = MAI_Pistols0;
					_unit setVariable ["CanGivePistol",false];	//Prevent unit from being assigned a pistol after death.
				} else {
					_weapons = MAI_rifles0;
				};
				_backpacks = MAI_Backpacks0;
				_gadgetsArray = MAI_gadgets0;
			};
			case 1: {
				_weapons = MAI_rifles1;
				_backpacks = MAI_Backpacks1;
				_gadgetsArray = MAI_gadgets0;
			};
			case 2: {
				_weapons = MAI_rifles2;
				_backpacks = MAI_Backpacks2;
				_gadgetsArray = MAI_gadgets1;
			};
			case 3: {
				_weapons = MAI_rifles3;
				_backpacks = MAI_Backpacks3;
				_gadgetsArray = MAI_gadgets1;
			};
			case default {
				_weapons = [MAI_rifles0,MAI_rifles1,MAI_rifles2,MAI_rifles3] call BIS_fnc_selectRandom3;
				_backpacks = [MAI_Backpacks0,MAI_Backpacks1,MAI_Backpacks2,MAI_Backpacks3] call BIS_fnc_selectRandom3;
				_gadgetsArray = [MAI_gadgets0,MAI_gadgets1] call BIS_fnc_selectRandom3;
			};
		};

		//Select weapon and backpack
		_weapon = _weapons call BIS_fnc_selectRandom3;
		_backpack = _backpacks call BIS_fnc_selectRandom3;
		
		//Add weapon, ammunition, and backpack
		_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
		_unit addMagazine _magazine;
		_unit addWeapon _weapon;
		_unit selectWeapon _weapon;
		_unit addBackpack _backpack;
		if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Created weapon %1 and backpack %3 for AI with weapongrade %2. (fn_unitSelectWeapon)",_weapon,_weapongrade,_backpack];};
		
		//diag_log format ["DEBUG :: Counted %1 tools in _gadgetsArray.",(count _gadgetsArray)];
		for "_i" from 0 to ((count _gadgetsArray) - 1) do {
			private["_chance"];
			_chance = ((_gadgetsArray select _i) select 1);
			//diag_log format ["DEBUG :: %1 chance to add gadget.",_chance];
			if ((random 1) < _chance) then {
				_gadget = ((_gadgetsArray select _i) select 0);
				_unit addWeapon _gadget;
				//diag_log format ["DEBUG :: Added gadget %1 as loot to AI inventory.",_gadget];
			};
		};
		
		//If unit has weapongrade 2 or 3 and was not given NVGs, give the unit temporary NVGs which will be removed at death. Set MAI_tempNVGs to true in variables config to enable temporary NVGs.
		if (MAI_tempNVGs) then {
			if (!(_unit hasWeapon "NVGoggles") && (_weapongrade > 1) && (daytime < 6 || daytime > 20)) then {
				_unit addWeapon "NVGoggles";
				_unit setVariable["removeNVG",1,false];
				if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Generated temporary NVGs for AI.";};
			};
		};
	} else {
		diag_log format ["MAI Error :: Invalid weapongrade value provided: %1",_weapongrade];
	};
	_unit setVariable ["loadoutDone",true];
};

MAI_setTrigVars = {
	private["_trigger"];

	_trigger = _this select 0;
	_trigger setVariable ["isCleaning",false];
	_trigger setVariable ["GroupArray",(_this select 1)];
	if ((count _this) > 3) then {
		_trigger setVariable ["patrolDist",(_this select 2)];
		_trigger setVariable ["gradeChances",(_this select 3)];
		_trigger setVariable ["locationArray",(_this select 4)];
		_trigger setVariable ["maxUnits",(_this select 5)];
		_trigger setVariable ["initialized",true];
		MAI_actTrigs = MAI_actTrigs + 1;
		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Initialized static trigger at %1. GroupArray: %2, PatrolDist: %3. GradeChances: %4. %LocationArray %5 positions, MaxUnits %6.",triggerText(_this select 0),(_this select 1),(_this select 2),(_this select 3),count (_this select 4),(_this select 5)];};
		} else {
		MAI_actDynTrigs = MAI_actDynTrigs + 1;
		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Initialized dynamic trigger at %1. GroupArray: %2.",getPosATL (_this select 0),(_this select 1)];};
	};

	true
};
