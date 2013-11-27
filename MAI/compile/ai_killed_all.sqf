/*
		fnc_militaryAIKilled
		
		Description: Adds loot to AI corpse if killed by a player. Script is shared between AI spawned from static and dynamic triggers.
		
        Usage: [_unit,_killer] spawn fnc_militaryAIKilled;
		
		Last updated: 2:52 AM 11/9/2013
*/

private["_victim","_killer","_unitGroup","_groupSize"];
_victim = _this select 0;
_killer = _this select 1;
_unitGroup = _this select 2;

//Remove temporary NVGs.
if ((_victim getVariable["removeNVG",0]) == 1) then {_victim removeWeapon "NVGoggles";}; //Remove temporary NVGs from AI.

//Set study_body variables.
_victim setVariable ["bodyName",_victim getVariable ["bodyName","unknown"],true];		//Broadcast the unit's name (was previously a private variable).
_victim setVariable ["deathType",_victim getVariable ["deathType","bled"],true];
_victim setVariable ["MAI_deathTime",time];

//Update AI count
_groupSize = _unitGroup getVariable "groupSize";
_groupSize = _groupSize - 1;
MAI_numAIUnits = MAI_numAIUnits - 1;
_unitGroup setVariable ["groupSize",_groupSize];
if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Group %1 has group size: %2.",_unitGroup,_groupSize];};

if (isPlayer _killer) then {
	private ["_trigger","_gradeChances","_weapongrade"];

	if (MAI_findKiller) then {_unitGroup setBehaviour "AWARE"; 0 = [_victim,_killer,_unitGroup] spawn MAI_huntKiller} else {_unitGroup setBehaviour "COMBAT"};

	_trigger = _unitGroup getVariable "trigger";
	_gradeChances = _trigger getVariable ["gradeChances",MAI_gradeChances1];
	if (isNil "_gradeChances") then {_gradeChances = MAI_gradeChances1};

	_weapongrade = [MAI_weaponGrades,_gradeChances] call fnc_selectRandomWeighted_M;
	0 = [_victim,_weapongrade] spawn MAI_addLoot;
	
	0 = [[_victim,_killer],"humanKills"] call local_eventKill;
	
	if (MAI_humanityGain > 0) then {
		private ["_humanity"];
		_humanity = _killer getVariable["humanity",0];
		_killer setVariable ["humanity",(_humanity - MAI_humanityGain),true];
	};
} else {
	if (_killer != _victim) then {
		{
			_victim removeMagazine _x;
		} forEach (magazines _victim);
	};
};

_nul = _victim spawn MAI_deathFlies;

true
