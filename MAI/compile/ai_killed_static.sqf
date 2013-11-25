/*
	fnc_staticAIDeathmil

	Usage: _victim call fnc_staticAIDeathmil;
	
	Description: Script is called when an AI unit is killed, and waits for the specified amount of time before respawning the unit into the same group it was part of previously.
	If the killed unit was the last surviving unit of its group, a dummy AI unit is created to occupy the group until a dead unit in the group is respawned.
	
	Last updated: 3:05 PM 6/24/2013
*/

private ["_victim","_sleepTime","_unitGroup","_trigger","_dummy","_unitsAlive"];

_victim = _this select 0;
_unitGroup = _this select 1;

_trigger = _unitGroup getVariable "trigger";
_unitsAlive = {alive _x} count (units _unitGroup);
//diag_log format ["%1 units alive in group.",_unitsAlive];

if (!(_trigger getVariable ["respawn",true])) then {
	private ["_maxUnits"];
	_maxUnits = _trigger getVariable "maxUnits";
	_maxUnits set [0,(_maxUnits select 0) - 1];
	if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: MaxUnits variable for group %1 set to %2. (fnc_staticAIDeathmil)",_unitGroup,_maxUnits];};
};

if (_unitsAlive == 0) then {
	if (_trigger getVariable ["respawn",true]) then {
		_unitGroup setBehaviour "AWARE";
		_dummy = _unitGroup createUnit ["Survivor1_DZ",[0,0,0],[],0,"FORM"];
		[_dummy] joinSilent _unitGroup;
		_dummy setVehicleInit "this hideObject true;this allowDamage false;this enableSimulation false;"; processInitCommands;
		_dummy disableAI "FSM";
		_dummy disableAI "ANIM";
		_dummy disableAI "MOVE";
		_dummy disableAI "TARGET";
		_dummy disableAI "AUTOTARGET";
		_unitGroup setVariable ["dummyUnit",_dummy];
		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Spawned 1 dummy AI unit for group %1. (fnc_staticAIDeathmil)",_unitGroup];};
		
		0 = [(time + MAI_respawnTime),_trigger,_unitGroup] spawn fnc_respawnHandlermill;
	} else {
		if (MAI_debugMarkers > 0) then {deleteMarker str(_trigger)};
		if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: Deleting custom-defined AI spawn %1 at %2. (fnc_staticAIDeathmil)",triggerText _trigger, mapGridPosition _trigger];};
		{
			if (MAI_debugMarkers > 0) then {
				{
					private["_markername"];
					_markername = (str _x);
					deleteMarker _markername;
				} forEach (waypoints _x);
				sleep 0.1;
			};
			sleep 0.5;
			deleteGroup _x;
		} forEach (_trigger getVariable ["GroupArray",[]]);
		deleteMarker (_trigger getVariable ["spawnmarker",""]);
		deleteVehicle _trigger;
		MAI_actTrigs = MAI_actTrigs - 1;
	};
};
