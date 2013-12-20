/*
		MAI_airLanding
		
		Description: Called when AI air vehicle performs a landing. Converts onboard AI crew into static-type units.
		
        Usage: [_helicopter] call MAI_airLanding;
		
		Last updated: 12:02 AM 11/21/2013
*/

private ["_helicopter","_trigger","_heliPos","_weapongrade","_unitsAlive","_unitGroup"];
_helicopter = _this select 0;

_helicopter removeAllEventHandlers "GetOut";
_helicopter removeAllEventHandlers "Killed";
_helicopter removeAllEventHandlers "HandleDamage";
_helicopter addEventHandler ["GetIn",{
	if (isPlayer (_this select 2)) then {
		(_this select 2) action ["getOut",(_this select 0)]; 
		0 = [nil,(_this select 2),"loc",rTITLETEXT,"Players are not permitted to enter AI vehicles!","PLAIN DOWN",5] call RE;
		(_this select 0) setVehicleLock "LOCKED";
	};
}];

_unitGroup = _helicopter getVariable ["unitGroup",(group (_this select 2))];
_heliPos = getPosATL _helicopter;
_weapongrade = [MAI_weaponGrades,MAI_gradeChancesHeli] call fnc_selectRandomWeighted_M;

//Convert helicrew units to ground units
{
	if (alive _x) then {
		0 = [_x, _weapongrade] call MAI_setupLoadout;
		0 = [_x, _weapongrade] call MAI_setSkills;
		0 = [_x, _weapongrade] spawn MAI_autoRearm_unit;
		_x setVariable ["unconscious",false];
		_x setVariable ["unithealth",[12000,0,0,false,false]];
		_x setHit["hands",0];
		_x setHit["legs",0];
		unassignVehicle _x;
	};
} forEach (units _unitGroup);

{
	deleteWaypoint _x;
} forEach (waypoints _unitGroup);

0 = [_unitGroup,_heliPos,75,MAI_debugMarkers] spawn MAI_BIN_taskPatrol;
_unitsAlive = {alive _x} count (units _unitGroup);
_unitGroup allowFleeing 0;

//Create area trigger
_trigger = createTrigger ["EmptyDetector",_heliPos];
_trigger setTriggerArea [600, 600, 0, false];
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerTimeout [15, 15, 15, true];
_trigger setTriggerText (format ["HeliLandingArea_%1",mapGridPosition _helicopter]);
_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;","","0 = [thisTrigger] spawn fnc_despawnmilitary;"];
0 = [_trigger,[_unitGroup],75,MAI_gradeChancesHeli,[],[_unitsAlive,0]] call MAI_setTrigVars;
_trigger setVariable ["respawn",false];
_trigger setVariable ["permadelete",true];

_unitGroup setVariable ["unitType","static"];
_unitGroup setVariable ["trigger",_trigger];
_unitGroup setVariable ["GroupSize",_unitsAlive];

[_helicopter,900] spawn MAI_deleteObject;
MAI_curHeliPatrols = MAI_curHeliPatrols - 1;
0 = ["air"] spawn fnc_respawnHandler_M;
if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: AI helicopter %1 landed at %2.",typeOf _helicopter,mapGridPosition _helicopter];};
