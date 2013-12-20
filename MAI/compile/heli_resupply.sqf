/*
	Helicopter Resupply
	
	Description: Handles automatic refueling and resupplying ammo for AI helicopter. Destroys helicopter if pilot is killed and allows another AI helicopter to be respawned.
	
	Last updated: 4:44 PM 8/2/2013
	
*/

if (!isServer) exitWith {};

private ["_helicopter","_heliWeapons","_markername","_marker","_startTime","_timePatrolled","_unitGroup","_wpmarkername","_wpmarker","_baseHeight"];

_helicopter = _this select 0;
_heliWeapons = weapons _helicopter;
_unitGroup = _helicopter getVariable "unitGroup";

_baseHeight = if ((typeOf _helicopter) isKindOf "Helicopter") then {100} else {125};

waitUntil {sleep 0.1; (!isNil "_heliWeapons" && !isNull (driver _helicopter))};
_startTime = time;

if ((count _heliWeapons) > 0) then {
	while {(alive _helicopter)&&(!(isNull _helicopter))} do {	
		//Check if helicopter ammunition needs to be replenished
		{
			if ((_helicopter ammo _x) < 20) then {
				_helicopter setVehicleAmmo 1;
				if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Reloaded ammo for AI patrol helicopter.";};
			};
		} forEach _heliWeapons;
		
		//Check if helicopter fuel is low
		if (fuel _helicopter < 0.20) then {
			_helicopter setFuel 1;
			if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Refueled AI patrol helicopter.";};
		};
	
		//Destroy helicopter if pilot is killed
		if ((!alive (driver _helicopter))&&(isEngineOn _helicopter)) exitWith {
			if (MAI_debugLevel > 0) then {diag_log "MAI Debug: Patrol helicopter pilot killed, helicopter is going down!";};
			_helicopter setFuel 0;
			_helicopter setVehicleAmmo 0;
			_helicopter setDamage 1;
		};
		
		//Periodically vary the helicopter's altitude
		/*
		if ((random 1) < 0.3) then {
			_helicopter flyInHeight (_baseHeight + (random 40));
		};*/
	
		sleep MAI_refreshRate;
	};
} else {
	while {(alive _helicopter)&&(!(isNull _helicopter))} do {	
		//Check if helicopter fuel is low
		if (fuel _helicopter < 0.20) then {
			_helicopter setFuel 1;
			if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Refueled AI patrol helicopter.";};
		};
	
		//Destroy helicopter if pilot is killed
		if ((!alive (driver _helicopter))&&(isEngineOn _helicopter)) exitWith {
			if (MAI_debugLevel > 0) then {diag_log "MAI Debug: Patrol helicopter pilot killed, helicopter is going down!";};
			_helicopter setFuel 0;
			_helicopter setVehicleAmmo 0;
			_helicopter setDamage 1;
		};
		
		//Periodically vary the helicopter's altitude
		/*
		if ((random 1) < 0.3) then {
			_helicopter flyInHeight (_baseHeight + (random 40));
		};*/

		sleep MAI_refreshRate;
	};
};

_timePatrolled = time - _startTime;
sleep 0.5;

if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: AI helicopter patrol crash-landed at %1 after %2 seconds of flight.",(getPosATL _helicopter),_timePatrolled];};
if (_timePatrolled < 35) then {
	diag_log "MAI Warning: An AI helicopter was destroyed less than 35 seconds after being spawned. Please check if server_cleanup.fsm was edited properly.";
};
