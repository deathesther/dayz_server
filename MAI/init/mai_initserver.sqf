/*
	MAI Server Initialization File
	
	Description: Handles startup process for MAI. Does not contain any values intended for modification.
	
	Last updated: 2:40 AM 8/18/2013
*/
private ["_startTime"];

if (!isServer || !isNil "MAI_isActive") exitWith {};
MAI_isActive = true;

#include "MAI_version.hpp"
diag_log format ["Initializing %1 version %2",MAI_TYPE,MAI_VERSION];

_startTime = diag_tickTime;

//Load MAI variables
#include "MAI_config.sqf"

//Load MAI functions
#include "MAI_functions.sqf"

//Load MAI classname tables
#include "world_classname_configs\default\default_classnames.sqf"

//Set internal-use variables
MAI_weaponGrades = [0,1,2,3];								//All possible weapon grades. A "weapon grade" is a tiered classification of gear. 0: Civilian, 1: Military, 2: MilitarySpecial, 3: Heli Crash. Weapon grade also influences the general skill level of the AI unit.
MAI_numAIUnits = 0;										//Tracks current number of currently active AI units, including dead units waiting for respawn.
MAI_actDynTrigs = 0;										//Tracks current number of active dynamically-spawned triggers
MAI_curDynTrigs = 0;										//Tracks current number of inactive dynamically-spawned triggers.
MAI_actTrigs = 0;											//Tracks current number of active static triggers.	
MAI_curHeliPatrols = 0;
MAI_dynTriggerArray = [];									//List of all generated dynamic triggers.
MAI_respawnQueue = [];										//Queue of AI groups that require respawning. Group ID is removed from queue after it is respawned.

//Set side relations
createcenter east;
createcenter resistance;
if (MAI_freeForAll) then {
	//Free For All mode - All AI groups are hostile to each other.
	east setFriend [resistance, 0];
	resistance setFriend [east, 0];	
	east setFriend [east, 0];	//East is hostile to self (static and dynamic AI)
} else {
	//Normal settings - All AI groups are friendly to each other.
	east setFriend [resistance, 0];
	resistance setFriend [east, 0];	
};
east setFriend [west, 0];	
resistance setFriend [west, 1];
west setFriend [resistance, 1];
west setFriend [east, 0];

//Detect DayZ mod variant being used.
if (MAI_modName == "") then {
	private["_modVariant"];
	_modVariant = getText (configFile >> "CfgMods" >> "DayZ" >> "dir");
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Detected mod variant %1.",_modVariant];};
	switch (_modVariant) do {
		case "@DayZ_Epoch":{
			MAI_modName = "epoch"; 
			_nul = [] execVM '\z\addons\dayz_server\MAI\scripts\setup_trader_areas.sqf';
		};
		case "DayzOverwatch":{MAI_modName = "overwatch"};
		case "@DayzOverwatch":{MAI_modName = "overwatch"};
		case "@DayZHuntingGrounds":{MAI_modName = "huntinggrounds"};
		case "DayZLingor":{
			private["_modCheck"];
			_modCheck = getText (configFile >> "CfgMods" >> "DayZ" >> "action");
			if (_modCheck == "http://www.Skaronator.com") then {MAI_modName = "lingorskaro"};
			if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Detected DayZ Lingor variant %1.",_modCheck];};
		};
	};
};

//If serverside object patch enabled, then spawn in serverside objects.
if (MAI_objPatch) then {[] execVM '\z\addons\dayz_server\MAI\scripts\buildingpatch_all.sqf';};

//Build MAI weapon classname tables from CfgBuildingLoot data if MAI_dynamicWeapons = true;
if (MAI_dynamicWeaponList) then {[MAI_banAIWeapons] execVM '\z\addons\dayz_server\MAI\scripts\buildWeaponArrays.sqf';};

//Create reference marker for dynamic triggers and set default values. These values are modified on a per-map basis.
if (MAI_aiHeliPatrols or MAI_dynAISpawns) then {
	MAI_centerMarker = createMarker ["MAI_centerMarker", (getMarkerPos 'center')];
	MAI_centerMarker setMarkerShape "ELLIPSE";
	MAI_centerMarker setMarkerType "Empty";
	MAI_centerMarker setMarkerBrush "Solid";
	MAI_centerMarker setMarkerAlpha 0;
	MAI_dynTriggerRadius = 600;
	MAI_dynOverlap = 0.15;
};

private["_worldname"];
_worldname=toLower format ["%1",worldName];
diag_log format["[MAI] Server is running map %1. Loading static trigger and classname configs.",_worldname];

//Load map-specific configuration file. Config files contain trigger/marker information, addition and removal of items/skins, and/or other variable customizations.
//Classname files will overwrite basic settings specified in base_classnames.sqf
if (_worldname in ["chernarus","utes","zargabad","fallujah","takistan","tavi","lingor","namalsk","mbg_celle2","oring","panthera2","isladuala","sara","trinity"]) then {
	call compile preprocessFileLineNumbers format ["\z\addons\dayz_server\MAI\init\world_classname_configs\%1_classnames.sqf",_worldname];
	[] execVM format ["\z\addons\dayz_server\MAI\init\world_map_configs\world_%1.sqf",_worldname];
} else {
	"MAI_centerMarker" setMarkerSize [7000, 7000];
	if (MAI_modName == "epoch") then {
		#include "world_classname_configs\epoch\dayz_epoch.sqf"
		_nul = [] execVM '\z\addons\dayz_server\MAI\scripts\setup_trader_areas.sqf';
	};
	MAI_newMap = true;
	diag_log "[MAI] Unrecognized worldname found. Generating settings for new map...";
};

//Build map location list. If using an unknown map, MAI will automatically generate basic static triggers at cities and towns.
[] execVM '\z\addons\dayz_server\MAI\scripts\setup_locations.sqf';

//Initialize AI settings
if (MAI_zombieEnemy) then {diag_log "[MAI] AI to zombie hostility is enabled.";
	if (MAI_weaponNoise > 0) then {MAI_zAggro = true; diag_log "[MAI] Zombie hostility to AI is enabled.";} else {MAI_zAggro = false;diag_log "[MAI] Zombie hostility to AI is disabled.";};
} else {diag_log "[MAI] AI to zombie hostility is disabled.";};
if (isNil "DDOPP_taser_handleHit") then {MAI_taserAI = false;} else {MAI_taserAI = true;diag_log "[MAI] DDOPP Taser Mod detected.";};

if (MAI_verifyTables) then {["MAI_Rifles0","MAI_Rifles1","MAI_Rifles2","MAI_Rifles3","MAI_Pistols0","MAI_Pistols1","MAI_Pistols2","MAI_Pistols3","MAI_Backpacks0","MAI_Backpacks1","MAI_Backpacks2","MAI_Backpacks3","MAI_Edibles","MAI_Medicals1","MAI_Medicals2","MAI_MiscItemS","MAI_MiscItemL","MAI_militaryTypes","MAI_heliTypes"] execVM "\z\addons\dayz_server\MAI\scripts\verifyTables.sqf";};
[] execVM '\z\addons\dayz_server\MAI\scripts\MAI_scheduler.sqf';
if (MAI_monitorRate > 0) then {[] execVM '\z\addons\dayz_server\MAI\scripts\MAI_monitor.sqf';};
diag_log format ["[MAI] MAI loaded with settings: Debug Level: %1. DebugMarkers: %2. ModName: %3. MAI_dynamicWeaponList: %4. VerifyTables: %5.",MAI_debugLevel,MAI_debugMarkers,MAI_modName,MAI_dynamicWeaponList,MAI_verifyTables];
diag_log format ["[MAI] MAI loading completed in %1 seconds.",(diag_tickTime - _startTime)];
