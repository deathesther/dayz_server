/*
	veh_despawn
	
	Description:
	
	Last updated:
	
*/

if (!isServer) exitWith {};

private ["_vehicle","_unitGroup","_deleteQueue","_cleanupTime","_crewCount","_killer"];

_vehicle = _this select 0;
_killer = _this select 1;
_unitGroup = _vehicle getVariable "unitGroup";
_crewCount = _vehicle getVariable ["crewCount",1];

_vehicle removeAllEventHandlers "GetOut";
_vehicle removeAllEventHandlers "Killed";

{
	deleteVehicle _x;
} forEach (units _unitGroup);
sleep 0.1;
deleteGroup _unitGroup;

MAI_curLandPatrols = MAI_curLandPatrols - 1;
_deleteQueue = [_vehicle];

_cleanupTime = 900;
if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: AI Land Vehicle patrol destroyed. Cleanup in %1 seconds.",_cleanupTime];};
[_deleteQueue,_cleanupTime] spawn MAI_deleteObject;
0 = ["land"] spawn fnc_respawnHandler_M;
