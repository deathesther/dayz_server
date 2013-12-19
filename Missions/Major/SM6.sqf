//Medical Crate by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)

private ["_coords","_MainMarker","_wait"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMajor.sqf";

WaitUntil {MissionGo == 1};

_coords = [getMarkerPos "center",0,5500,30,0,2000,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A medical supply crate has been secured by bandits! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A medical supply crate has been secured by bandits! Check your map for the location!"] call RE;
[nil,nil,rHINT,"A medical supply crate has been secured by bandits! Check your map for the location!"] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "debug\addmarkers.sqf";

_hummer = createVehicle ["HMMWV_DZ",[(_coords select 0) + 10, (_coords select 1) - 10,0],[], 0, "CAN_COLLIDE"];
_hummer1 = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 20, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

_hummer setVariable ["Mission",1,true];
_hummer1 setVariable ["Mission",1,true];

_crate = createVehicle ["USVehicleBox",[(_coords select 0) - 1, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate] execVM "\z\addons\dayz_server\missions\misc\fillBoxesM.sqf";
_crate setVariable ["permaLoot",true];

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["permaLoot",true];

	_this = createMarker ["DZAI_marker_major", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Empty";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [150, 150];
	_this setMarkerAlpha 0;
    DZAI_marker_major = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_major",9,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

waitUntil{{isPlayer _x && _x distance _hummer < 10  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"The medical crate is under survivor control!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The medical crate is under survivor control!"] call RE;
[nil,nil,rHINT,"The medical crate is under survivor control!"] call RE;

deleteMarker "DZAI_marker_major";

[] execVM "debug\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";



SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\major\SMfinder.sqf";
