/*
	fnc_respawnHandlermill
	
	Description: Creates a queue for AI groups requiring respawn. Terminates when the queue has been processed and cleared. Queue is recreated with the first AI group KIA.
	
	Usage: [_respawnTime,_trigger,_unitGroup] spawn fnc_respawnHandlermill;
	
	Last updated: 7:49 PM 7/9/2013
*/
#define PROCESSING_WAIT_TIME 5

private ["_unitGroup","_respawnTime","_trigger"];

_respawnTime = _this select 0;
_trigger = _this select 1; //attached variables: _patrolDist, _gradeChances, _spawnPositions, _spawnType, _maxUnits
_unitGroup = _this select 2;

//Add group to respawn queue.
MAI_respawnQueue set [(count MAI_respawnQueue),[_respawnTime,_trigger,_unitGroup]];
if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Added Group %1 to respawn queue. Queue position %2. (respawnHandler)",_unitGroup,(count MAI_respawnQueue)];};

if (!isNil "MAI_respawnActive") exitWith {};

MAI_respawnActive = true;
sleep (MAI_respawnTime);

while {(count MAI_respawnQueue) > 0} do {
	//diag_log format ["DEBUG: Contents of respawn queue before cleanup stage 1: %1.",MAI_respawnQueue];
	//Remove expired entries before proceeding.
	{
		if (isNull (_x select 2)) then {
			MAI_respawnQueue set [_forEachIndex,objNull];
		};
	} forEach MAI_respawnQueue;
	//diag_log format ["DEBUG: Contents of respawn queue before cleanup stage 2: %1.",MAI_respawnQueue];
	MAI_respawnQueue = MAI_respawnQueue - [objNull];
	//diag_log format ["DEBUG: Contents of respawn queue after cleanup: %1.",MAI_respawnQueue];
	
	//Begin examining queue entries.
	for "_i" from 0 to ((count MAI_respawnQueue) - 1) do {
		private["_timeToRespawn"];
		_timeToRespawn = (MAI_respawnQueue select _i) select 0;

		//If enough time has passed to respawn the group.
		if (time >= _timeToRespawn) then {
			private["_unitGroup","_trigger","_grpArray"];
			
			_trigger = (MAI_respawnQueue select _i) select 1;
			_unitGroup = (MAI_respawnQueue select _i) select 2;
			_grpArray = _trigger getVariable "GroupArray";
			
			if ((!isNull _unitGroup) && (_unitGroup in _grpArray)) then {
				private["_maxUnits","_respawn"];
				_maxUnits = _trigger getVariable "maxUnits";
				_respawn = [_unitGroup,_trigger,_maxUnits] call fnc_respawnmilitary;
				if (!_respawn) then {if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: No units were respawned for group %1 at %2. Group %1 reinserted into respawn queue.",_unitGroup,(mapGridPosition _trigger)];};};
			};
			MAI_respawnQueue set [_i,objNull];
			sleep PROCESSING_WAIT_TIME;
		};
		//Delay respawning if it is too early. If the next respawn is due in less than 5 seconds, then enforce 5 second delay.
		if (time < _timeToRespawn) exitWith {
			private["_sleepTime"];
			_sleepTime = (ceil (_timeToRespawn - time)) max PROCESSING_WAIT_TIME;
			if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Respawn handler is entering sleep state. Next AI group is scheduled to respawn in %1 seconds. (respawnHandler)",_sleepTime];};
			sleep _sleepTime;
		};
	};
	//Remove processed entries
	MAI_respawnQueue = MAI_respawnQueue - [objNull];
	if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: %1 groups left in respawn queue.",(count MAI_respawnQueue)];};
};
MAI_respawnActive = nil;
if (MAI_debugLevel > 0) then {diag_log "MAI Debug: Respawn queue is empty. Exiting respawn handler. (respawnHandler)";};
