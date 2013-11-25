/*
	MAI_randDynTriggers
	
	Description:
	
	Last updated:	3:15 PM 8/10/2013
	
*/
private ["_randomizeCount","_trigger"];

_randomizeCount = _this select 0;

if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Randomizing %1 dynamic trigger locations... (MAI_randDynTriggers)",_randomizeCount];};
for "_i" from 1 to _randomizeCount do {
private ["_trigger"];
	if (MAI_debugLevel > 0) then {diag_log "MAI Debug: Selecting a random dynamic trigger to randomize location. (MAI_randDynTriggers)";};
	_trigger = MAI_dynTriggerArray call BIS_fnc_selectRandom3;
	//Select only dynamic triggers that haven't spawned any AI and not in cleaning state
	if ((count (_trigger getVariable ["GroupArray",[]]) == 0) && (!(_trigger getVariable ["isCleaning",false]))) then {
		private ["_newPos"];
		_newPos = _trigger call MAI_relocDynTrigger;
		if (MAI_debugLevel > 0) then {diag_log format["MAI Debug: A dynamic trigger has been relocated to %1. (MAI_randDynTriggers)",_newPos];};
	};
	sleep 1;
};
