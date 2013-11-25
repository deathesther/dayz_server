/*
	fn_findKiller
	
	Description: If an AI unit is killed, surviving members of their group will aggressively pursue the killer for a set amount of time. After this amount of time has passed, the group will return to their patrol state.
	
	Last updated: 11:52 PM 9/24/2013
*/
private ["_killerPos","_unitGroup","_victim","_killer","_inPursuit","_trigger","_detectRange","_chaseDist"];

_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;

_groupSize = _unitGroup getVariable ["groupSize",0];
if (_groupSize == 0) exitWith {if (DZAI_debugLevel > 0) then {diag_log "DZAI Debug: All units in group are dead. (fn_findKiller)";};};

_inPursuit = _unitGroup getVariable ["inPursuit",false];
if (_inPursuit) exitWith {if (DZAI_debugLevel > 0) then {diag_log "DZAI Debug: Group is already in pursuit of a target. (fn_findKiller)";};};

//Reveal killer to AI group and order units to target and fire.
_unitGroup reveal [(vehicle _killer),4];
(units _unitGroup) doTarget (vehicle _killer);
(units _unitGroup) doFire (vehicle _killer);

_trigger = (group _victim) getVariable "trigger";

//Calculate detection range.
_detectRange = 250 + (random 200); //Min: 250, Max: 450
	
if (((_victim distance _killer) < _detectRange) && (_killer isKindOf "Man")) then {
	private["_endTime"];
	if (DZAI_debugLevel > 0) then {diag_log format ["DZAI Debug: Group %1 has entered pursuit state. Target: %2. (fn_findKiller)",_unitGroup,_killer];};
	_unitGroup setVariable ["inPursuit",true];
	
	//Calculate maximum pursuit range, using victim's location as origin.
	_chaseDist = (350 + (random 100)); //Min: 350, Max: 450
	
	//Temporarily cancel patrol state.
	_unitGroup lockWP true;
	
	_endTime = (time + 120);
	//Begin pursuit state.
	while {(time < _endTime) && (alive _killer) && ((_unitGroup getVariable ["groupSize",0]) > 0) && !(isNull _killer) && ((_trigger distance _killer) < _chaseDist) && (((vehicle _killer) isKindOf "Man") or ((vehicle _killer) isKindOf "Motorcycle"))} do {
		_killerPos = getPosATL _killer;
		(units _unitGroup) doMove _killerPos;
		{if (alive _x) then {_x moveTo _killerPos;/*diag_log "AI unit in pursuit.";*/};} forEach (units _unitGroup);
		if (DZAI_debugLevel > 1) then {diag_log format ["DZAI Extended Debug: AI group %3 in pursuit state. Time: %1/%2.",time,_endTime,_unitGroup];};
		if ((_killer hasWeapon "ItemRadio")&&DZAI_radioMsgs) then {
			private ["_radioText"];
			_radioText = format ["[RADIO] You are being pursued by a bandit group. (Distance: %1m)",round(_killer distance (leader _unitGroup))];
			[nil,_killer,"loc",rTITLETEXT,_radioText,"PLAIN DOWN",5] call RE;
		};
		sleep 15;
	};

	//End of pursuit state. Re-enable patrol state.
	_unitGroup setVariable ["inPursuit",false];
	_unitGroup lockWP false;
	_unitGroup setCurrentWaypoint ((waypoints _unitGroup) call BIS_fnc_selectRandom2);
	if (DZAI_debugLevel > 0) then {diag_log format ["DZAI Debug: Pursuit state ended for group %1. Returning to patrol state. (fn_findKiller)",_unitGroup];};
	
	sleep 5;
	if ((_killer hasWeapon "ItemRadio")&&DZAI_radioMsgs) then {
		[nil,_killer,"loc",rTITLETEXT,"[RADIO] You have evaded the bandit pursuit.","PLAIN DOWN",5] call RE;
	};
	_unitGroup setBehaviour "AWARE";
};
