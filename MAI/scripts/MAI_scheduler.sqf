/*
	MAI Scheduler
	
	Description:
	
	Last updated: 2:21 PM 8/27/2013
*/

diag_log "MAI Scheduler is running required script files...";
_objectMonitor = [];
_vehiclesEnabled = ((MAI_maxHeliPatrols > 0) or (MAI_maxLandPatrols > 0));

//If serverside object patch enabled, then spawn in serverside objects.
if (MAI_objPatch) then {
	[] execVM '\z\addons\dayz_server\MAI\scripts\buildingpatch_all.sqf';
	sleep 5;
};

//Build MAI weapon classname tables from CfgBuildingLoot data if MAI_dynamicWeapons = true;
if (MAI_dynamicWeaponList) then {
	_weaponlist = [MAI_banAIWeapons] execVM '\z\addons\dayz_server\MAI\scripts\buildWeaponArrays.sqf';
	waitUntil {sleep 0.005; scriptDone _weaponlist};
};

if (MAI_verifyTables) then {
	_verify = [	"MAI_Rifles0","MAI_Rifles1","MAI_Rifles2","MAI_Rifles3","MAI_Pistols0","MAI_Pistols1","MAI_Pistols2","MAI_Pistols3",
				"MAI_Backpacks0","MAI_Backpacks1","MAI_Backpacks2","MAI_Backpacks3","MAI_Edibles","MAI_Medicals1","MAI_Medicals2",
				"MAI_MiscItemS","MAI_MiscItemL","MAI_militaryTypes","MAI_heliTypes","MAI_launcherTypes"] execVM "\z\addons\dayz_server\MAI\scripts\verifyTables.sqf";
	waitUntil {sleep 0.005; scriptDone _verify};
};

//Build map location list. If using an unknown map, MAI will automatically generate basic static triggers at cities and towns.
[] execVM '\z\addons\dayz_server\MAI\scripts\setup_locations.sqf';

if ((count MAI_dynAreaBlacklist) > 0) then {[] execVM '\z\addons\dayz_server\MAI\scripts\setup_blacklist_areas.sqf';};

if (_vehiclesEnabled) then {
	_nul = [] execVM '\z\addons\dayz_server\MAI\scripts\setup_veh_patrols.sqf';
	_objectMonitor = [] call MAI_getObjMon;
};

if (MAI_dynAISpawns) then {
	_dynManagerV2 = [] execVM '\z\addons\dayz_server\MAI\scripts\dynamicSpawn_manager.sqf';
	if (MAI_modName == "epoch") then {
		_nul = [] execVM '\z\addons\dayz_server\MAI\scripts\setup_trader_areas.sqf';
	};
};

sleep 10;

if (MAI_monitorRate > 0) then {[] execVM '\z\addons\dayz_server\MAI\scripts\MAI_monitor.sqf';};

diag_log "MAI Scheduler will continue tasks in 15 minutes.";
sleep 900;

while {true} do {
	if (MAI_debugLevel > 0) then {diag_log "MAI Scheduler is now running.";};
	
	if (_vehiclesEnabled) then {
		//Clean up server object monitor
		_objectMonitor = _objectMonitor - [objNull];
		sleep 3;
	};

	//Clean up dead units spawned by MAI.
	{
		private ["_deathTime"];
		_deathTime = _x getVariable "MAI_deathTime";
		if (!isNil "_deathTime") then {
			if ((time - _deathTime) > MAI_cleanupDelay) then {
				private ["_soundFlies"];
				_soundFlies = _x getVariable "sound_flies";
				deleteVehicle _soundFlies;
				deleteVehicle _x;
			};
		};
		sleep 0.005;
	} forEach allDead;
	
	//Wait until next cycle.
	if (MAI_debugLevel > 0) then {diag_log "MAI Scheduler is returning to sleeping state. Resuming in 15 minutes";};
	sleep 900;
};
