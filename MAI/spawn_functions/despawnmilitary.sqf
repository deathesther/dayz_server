/*
	despawnmilitary
	
	Description: Deletes all AI units spawned by a trigger once all players leave the trigger area. Basic script concept adapted from Sarge AI.
	
	Usage: Called by a static trigger when all players have left the trigger area.
	
	Last updated: 4:44 PM 8/2/2013
	
*/
private ["_trigger","_grpArray","_isCleaning","_grpCount"];
if (!isServer) exitWith {};							//Execute script only on server.

_trigger = _this select 0;							//Get the trigger object

_grpArray = _trigger getVariable ["GroupArray",[]];	//Find the groups spawned by the trigger.
_isCleaning = _trigger getVariable ["isCleaning",nil];	//Find whether or not the trigger has been marked for cleanup, otherwise assume a cleanup has already happened.

_grpCount = count _grpArray;

if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: _grpArray is %1. _isCleaning is %2.",_grpArray,_isCleaning];};
if ((_grpCount == 0) && (isNil "_isCleaning")) exitWith {if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Trigger's _grpCount is zero and _isCleaning is nil. (Nothing to despawn)";};};
if ((_grpCount == 0) || (_isCleaning)) exitWith {if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Trigger's group array is empty, or a despawn script is already running. Exiting despawn script.";};};				//Exit script if the trigger hasn't spawned any AI units, or if a despawn script is already running for the trigger.

_trigger setVariable["isCleaning",true,false];		//Mark the trigger as being in a cleanup state so that subsequent requests to despawn for the same trigger will not run.
if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: No players remain in trigger area at %3. Deleting %1 AI groups in %2 seconds.",_grpCount, MAI_despawnWait,(triggerText _trigger)];};

if (MAI_debugMarkers > 0) then {
	private["_tMarker"];
	_tMarker = str (_trigger);
	_tMarker setMarkerText "STATIC TRIGGER (DESPAWNING)";
	_tMarker setMarkerColor "ColorOrange";
};

sleep MAI_despawnWait;								//Wait some time before deleting units. (amount of time to allow units to exist when the trigger area has no players)

if (triggerActivated _trigger) exitWith {			//Exit script if trigger has been reactivated since MAI_despawnWait seconds has passed.
	if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: A player has entered the trigger area at %1. Cancelling despawn script.",(triggerText _trigger)];};
	if (MAI_debugMarkers > 0) then {
	private["_tMarker"];
		_tMarker = str (_trigger);
		_tMarker setMarkerText "STATIC TRIGGER (ACTIVE)";
		_tMarker setMarkerColor "ColorRed";
	};
	_trigger setVariable ["isCleaning",false,false];	//Allow next despawn request.
};			

{
	if (MAI_debugMarkers > 0) then {
		{
			deleteMarker (str _x);
		} forEach (waypoints _x);
		sleep 0.1;
	};
	MAI_numAIUnits = MAI_numAIUnits - (_x getVariable ["groupSize",0]); //Update active AI count
	{deleteVehicle _x} forEach (units _x); //Delete live units
	if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Group %1 has group size %2.",_x,(_x getVariable ["groupSize",0])];};
	sleep 0.5;
	deleteGroup _x;									//Delete the group after its units are deleted.
} forEach _grpArray;

if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Despawned AI units at %1. Resetting trigger's group array.",(triggerText _trigger)];};

if !(_trigger getVariable ["permadelete",false]) then {
	//Cleanup variables attached to trigger
	_trigger setVariable ["GroupArray",[],false];
	_trigger setVariable ["isCleaning",nil,false];

	if (MAI_debugMarkers > 0) then {
		private["_tMarker"];
		_tMarker = str (_trigger);
		_tMarker setMarkerText "STATIC TRIGGER (INACTIVE)";
		_tMarker setMarkerColor "ColorGreen";
	};
} else {
	if (MAI_debugMarkers > 0) then {
		deleteMarker (str (_trigger));
	};
	deleteMarker (_trigger getVariable ["spawnmarker",""]);
	deleteVehicle _trigger;
};

MAI_actTrigs = (MAI_actTrigs - 1);

true
