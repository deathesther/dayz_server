/*
	MAI Server Monitor
	
	Description: Periodically reports current numbers of active AI units, static triggers, and dynamic triggers.
	
	Last updated: 4:25 PM 6/7/2013
*/

diag_log "Starting MAI Server Monitor in 60 seconds.";
sleep 60;

while {true} do {
	private ["_uptime"];
	_uptime = [] call MAI_getUptime;
	diag_log format ["MAI Monitor :: Server Uptime - %1 d %2 hr %3 min %4 sec. Active AI Units - %5.",_uptime select 0, _uptime select 1, _uptime select 2, _uptime select 3,MAI_numAIUnits];
	diag_log format ["MAI Monitor :: Static Spawns - %1 active static triggers. %2 groups queued for respawn.",MAI_actTrigs,(count MAI_respawnQueue)];
	if (MAI_dynAISpawns || MAI_aiHeliPatrols) then {diag_log format ["MAI Monitor :: Dynamic Spawns - %1/%2 (active/total) dynamic triggers. Air Patrols: %3/%4 (cur/max).",MAI_actDynTrigs,MAI_curDynTrigs,MAI_curHeliPatrols,MAI_maxHeliPatrols];};
	if (MAI_debugMarkers > 1) then {
		{
			private["_marker"];
			_marker = format ["trigger_%1",_x];
			_marker setMarkerPos (getMarkerPos _marker);
			sleep 1;
		} forEach MAI_dynTriggerArray;
	};
	sleep MAI_monitorRate;
};
