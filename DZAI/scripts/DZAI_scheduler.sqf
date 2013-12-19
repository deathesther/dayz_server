/*
	DZAI Scheduler
	
	Description:
	
	Last updated: 2:21 PM 8/27/2013
*/

diag_log "DZAI Scheduler is running required script files...";
_objectMonitor = [];
_vehiclesEnabled = ((DZAI_maxHeliPatrols > 0) or (DZAI_maxLandPatrols > 0));

//If serverside object patch enabled, then spawn in serverside objects.
if (DZAI_objPatch) then {
	[] execVM '\z\addons\dayz_server\DZAI\scripts\buildingpatch_all.sqf';
	sleep 5;
};

//Build DZAI weapon classname tables from CfgBuildingLoot data if DZAI_dynamicWeapons = true;
if (DZAI_dynamicWeaponList) then {
	_weaponlist = [DZAI_banAIWeapons] execVM '\z\addons\dayz_server\DZAI\scripts\buildWeaponArrays.sqf';
	waitUntil {sleep 0.005; scriptDone _weaponlist};
};

if (DZAI_verifyTables) then {
	_verify = [	"DZAI_Rifles0","DZAI_Rifles1","DZAI_Rifles2","DZAI_Rifles3","DZAI_Pistols0","DZAI_Pistols1","DZAI_Pistols2","DZAI_Pistols3",
				"DZAI_Backpacks0","DZAI_Backpacks1","DZAI_Backpacks2","DZAI_Backpacks3","DZAI_Edibles","DZAI_Medicals1","DZAI_Medicals2",
				"DZAI_MiscItemS","DZAI_MiscItemL","DZAI_BanditTypes","DZAI_heliTypes","DZAI_launcherTypes"] execVM "\z\addons\dayz_server\DZAI\scripts\verifyTables.sqf";
	waitUntil {sleep 0.005; scriptDone _verify};
};

//Build map location list. If using an unknown map, DZAI will automatically generate basic static triggers at cities and towns.
[] execVM '\z\addons\dayz_server\DZAI\scripts\setup_locations.sqf';

if ((count DZAI_dynAreaBlacklist) > 0) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\setup_blacklist_areas.sqf';};

if (_vehiclesEnabled) then {
	_nul = [] execVM '\z\addons\dayz_server\DZAI\scripts\setup_veh_patrols.sqf';
	_objectMonitor = [] call DZAI_getObjMon;
};

if (DZAI_dynAISpawns) then {
	_dynManagerV2 = [] execVM '\z\addons\dayz_server\DZAI\scripts\dynamicSpawn_manager.sqf';
	if (DZAI_modName == "epoch") then {
		_nul = [] execVM '\z\addons\dayz_server\DZAI\scripts\setup_trader_areas.sqf';
	};
};

sleep 10;

if (DZAI_monitorRate > 0) then {[] execVM '\z\addons\dayz_server\DZAI\scripts\DZAI_monitor.sqf';};

diag_log "DZAI Scheduler will continue tasks in 15 minutes.";
sleep 900;

while {true} do {
	if (DZAI_debugLevel > 0) then {diag_log "DZAI Scheduler is now running.";};
	
	if (_vehiclesEnabled) then {
		//Clean up server object monitor
		_objectMonitor = _objectMonitor - [objNull];
		sleep 3;
	};

	//Clean up dead units spawned by DZAI.
	{
		private ["_deathTime"];
		_deathTime = _x getVariable "DZAI_deathTime";
		if (!isNil "_deathTime") then {
			if ((time - _deathTime) > DZAI_cleanupDelay) then {
				private ["_soundFlies"];
				_soundFlies = _x getVariable "sound_flies";
				deleteVehicle _soundFlies;
				deleteVehicle _x;
			};
		};
		sleep 0.005;
	} forEach allDead;
	
	//Wait until next cycle.
	if (DZAI_debugLevel > 0) then {diag_log "DZAI Scheduler is returning to sleeping state. Resuming in 15 minutes";};
	sleep 900;
};
