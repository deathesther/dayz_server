/*
	despawnmilitary_dynamic

	Description:
	
	Usage:

	Last updated: 7:42 PM 10/20/2013
	
*/

private ["_trigger","_grpArray","_isCleaning","_grpCount","_waitTime","_forceDespawn"];
if (!isServer) exitWith {};										//Execute script only on server.

_trigger = _this select 0;										//Get the trigger object

_grpArray = _trigger getVariable ["GroupArray",[]];				//Find the groups spawned by the trigger. Or set an empty group array if none are found.
_isCleaning = _trigger getVariable ["isCleaning",nil];			//Find whether or not the trigger has been marked for cleanup, otherwise assume a cleanup has already happened.
_forceDespawn = _trigger getVariable ["forceDespawn",false];	//Check whether to run despawn script even if players are present in the trigger area.
if (isNil "_forceDespawn") then {_forceDespawn = false;};

_waitTime = if (_forceDespawn) then {MAI_dynRemoveDeadWait} else {MAI_dynDespawnWait};

_grpCount = count _grpArray;

if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: _grpArray is %1. _isCleaning is %2.",_grpArray,_isCleaning];};
if ((_grpCount == 0) && (isNil "_isCleaning")) exitWith {if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Trigger's _grpCount is zero and _isCleaning is nil. (Nothing to despawn).";};};
if ((_grpCount == 0) || (_isCleaning)) exitWith {if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Trigger's group array is empty, or a despawn script is already running. Exiting despawn script.";};};				//Exit script if the trigger hasn't spawned any AI units, or if a despawn script is already running for the trigger.

_trigger setVariable["isCleaning",true,false];			//Mark the trigger as being in a cleanup state so that subsequent requests to despawn for the same trigger will not run.
if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: No players remain in %1 %2. Deleting spawned AI in %3 seconds.",triggerText _trigger,mapGridPosition _trigger,_waitTime];};
if (MAI_debugMarkers > 0) then {
	private["_marker"];
	_marker = format["trigger_%1",_trigger];
	_marker setMarkerColor "ColorGreenAlpha";
	_marker setMarkerAlpha 0.7;							//Light green: Active trigger awaiting despawn.
};
sleep _waitTime;								//Wait some time before deleting units. (amount of time to allow units to exist when the trigger area has no players)

if ((triggerActivated _trigger) && (!_forceDespawn)) exitWith {
	if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: A player has entered the trigger area. Cancelling despawn script.";}; //Exit script if trigger has been reactivated since _waitTime seconds has passed.
	_trigger setVariable ["isCleaning",false,false];	//Allow next despawn request.
	if (MAI_debugMarkers > 0) then {
		private["_marker"];
		_marker = format["trigger_%1",_trigger];
		_marker setMarkerColor "ColorOrange";
		_marker setMarkerAlpha 0.9;						//Reset trigger indicator color to Active.
	};
};			

{
	if (MAI_debugMarkers > 0) then {
		{
			deleteMarker (str _x);
		} forEach (waypoints _x);
		sleep 0.1;
	};
	MAI_numAIUnits = MAI_numAIUnits - (_x getVariable ["GroupSize",0]);	//Update active AI count
	{deleteVehicle _x} forEach (units _x);							//Delete live units
	sleep 0.5;
	deleteGroup _x;													//Delete the group after its units are deleted.
	sleep 0.1;
} forEach _grpArray;

if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Deleting expired dynamic trigger at %1.",mapGridPosition _trigger];};

//Remove dynamic trigger from global dyn trigger array and clean up trigger
MAI_dynTriggerArray = MAI_dynTriggerArray - [_trigger];
MAI_actDynTrigs = MAI_actDynTrigs - 1;
MAI_curDynTrigs = MAI_curDynTrigs - 1;
if (MAI_debugMarkers > 0) then {deleteMarker format["trigger_%1",_trigger]};

deleteVehicle _trigger;

true
