/*
	spawnTriggers_random

	Usage:
	
	Description: Spawns a specified number of dynamic triggers using MAI_centerMarker as a reference marker. Three attempts are made per trigger to reduce trigger area overlap. 
				 These triggers have their positions randomized at a set interval by the dynamic trigger manager.

	Last updated: 8:45 PM 6/18/2013
*/
#include "\z\addons\dayz_server\MAI\init\dyn_trigger_configs\dyn_trigger_defs.hpp"

private ["_numTriggers"];

if (!isServer) exitWith {};

_numTriggers = _this select 0;							//Number of triggers to create

if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: Spawning %1 dynamic triggers (spawnTriggers_random).",_numTriggers];};

for "_i" from 1 to _numTriggers do {
	private ["_trigger","_trigPos","_attempts"];
	_attempts = 0;
	//while {_trigPos = [(getMarkerPos "MAI_centerMarker"),300 + random((getMarkerSize "MAI_centerMarker") select 0),random(360),false,[1,300]] call SHK_pos;(({([_trigPos select 0,_trigPos select 1] distance _x) < (2*(MAI_dynTriggerRadius - (MAI_dynTriggerRadius*MAI_dynOverlap)))} count MAI_dynTriggerArray) > 0)&&(_attempts < 4)} do {
	while {_trigPos = ["MAI_centerMarker",false,MAI_dynBlacklist] call SHK_pos;(({([_trigPos select 0,_trigPos select 1] distance _x) < (2*(MAI_dynTriggerRadius - (MAI_dynTriggerRadius*MAI_dynOverlap)))} count MAI_dynTriggerArray) > 0)&&(_attempts < 4)} do {
	_attempts = _attempts +1;
		if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Calculated trigger position intersects with at least 1 other trigger (attempt %1/4).",_attempts];};
		sleep 0.5;
	};
	_trigger = createTrigger ["EmptyDetector",_trigPos];
	_trigger setTriggerArea [MAI_dynTriggerRadius, MAI_dynTriggerRadius, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerTimeout [5, 7, 10, true];
	_trigger setTriggerStatements [DYNTRIG_STATEMENTS_INACTIVE];
	if (MAI_debugMarkers > 0) then {
		private ["_markername","_marker"];
		_markername = format["trigger_%1",_trigger];
		_marker = createMarker[_markername,_trigPos];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerType "Flag";
		_marker setMarkerBrush "SOLID";
		_marker setMarkerSize [MAI_dynTriggerRadius, MAI_dynTriggerRadius];
		_marker setMarkerColor "ColorYellow";
		_marker setMarkerAlpha 0.8;		//Dark yellow = Trigger in ready state.
	};
	if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: Dynamic trigger %1 of %2 spawned at %3 (spawnTriggers_random). Next trigger spawning in 5 seconds.",_i,_numTriggers,_trigPos];};
	MAI_curDynTrigs = MAI_curDynTrigs + 1;
	MAI_dynTriggerArray set [(count MAI_dynTriggerArray),_trigger];
	//diag_log format ["DEBUG :: Contents of MAI_dynTriggerArray: %1.",MAI_dynTriggerArray];
	sleep 1;
};
