/*
	MAI Scheduler
	
	Description:
	
	Last updated: 2:21 PM 8/27/2013
*/
private ["_randomizeCount"];

diag_log "Starting MAI Scheduler in 30 seconds.";

sleep 30;

if (MAI_verifyTables) then {
	waitUntil {sleep 0.1; !isNil "MAI_classnamesVerified"};	//Wait for MAI to finish verifying classname arrays.
} else {
	waitUntil {sleep 0.1; !isNil "MAI_weaponsInitialized"};	//Wait for MAI to finish building weapon classname arrays.
};

if (MAI_aiHeliPatrols) then {if ((count MAI_heliTypes) < 1) then {MAI_heliTypes = ["UH1H_DZ"]}; _nul = [] execVM '\z\addons\dayz_server\MAI\scripts\setup_heli_patrol.sqf';};

if (MAI_dynAISpawns) then {
	if (!MAI_V2dynSpawns) then {
		if (!(isNil "MAI_newMap")) then {waitUntil {sleep 1; MAI_locations_ready};};
		_dynTriggers = [MAI_dynTriggersMax] execVM '\z\addons\dayz_server\MAI\scripts\spawnTriggers_random.sqf';
		waitUntil {sleep 1; scriptDone _dynTriggers};
		_randomizeCount = ceil(0.25*MAI_dynTriggersMax);
	} else {
		_dynManagerV2 = [] execVM '\z\addons\dayz_server\MAI\scripts\dynamicSpawn_manager.sqf';
	};
};

sleep 3;

diag_log "MAI Scheduler will continue tasks in 15 minutes.";
sleep 900;

while {true} do {
	if (MAI_debugLevel > 0) then {diag_log "MAI Scheduler is now running.";};

	//Randomize some dynamic triggers
	if (MAI_dynAISpawns && (!MAI_V2dynSpawns)) then {
		_dynTriggers = [_randomizeCount] spawn MAI_randDynTriggers;
		waitUntil {sleep 1; scriptDone _dynTriggers};
		sleep 3;
	};
	
	//Respawn any destroyed AI helicopters
	if (MAI_aiHeliPatrols) then {
		_helipatrols = [] spawn fnc_spawnHeliPatrolmill;
		waitUntil {sleep 1; scriptDone _helipatrols};
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
