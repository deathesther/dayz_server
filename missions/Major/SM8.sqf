//Aircraft crash sidemission Created by TheSzerdi Edited by Falcyn [QF]

private ["_coords","_dummymarker","_wait","_coord1","_coord2","_coord3","_coord4","_coord5","_coord6","_coord7","_coord8","_coord9","_coord10","_coord11","_coord12"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMajor.sqf";
WaitUntil {MissionGo == 1};

_coord1 = [4908.355,11216.505,0];
_coord2 = [6162.9888,11324.005,0];
_coord3 = [7761.3657,11569.265,0];
_coord4 = [8336.6055,10441.17,0];
_coord5 = [7201.0664,10400.667,0];
_coord6 = [6249.1104,9579.043,0];
_coord7 = [4763.3818,9802.2734,0];
_coord8 = [3675.6865,7353.2798,0];
_coord9 = [6815.6362,5599.0854,0];
_coord10 = [7532.0742,8164.3203,0];
_coord11 = [6046.6455,8771.2178,0];
_coord12 = [5266.6836,7273.8135,0];

_coords = [_coord1, _coord2, _coord3, _coord4, _coord5, _coord6, _coord7, _coord8, _coord9, _coord10, _coord11, _coord12] call BIS_fnc_selectRandom;

//Mission start
[nil,nil,rTitleText,"A C-130 has crash landed!Survivors secure the cargo!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"A C-130 has crash landed!Survivors secure the cargo!"] call RE;
[nil,nil,rHINT,"A C-130 has crash landed!Survivors secure the cargo!"] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "debug\addmarkers.sqf";

c130wreck = createVehicle ["C130J_wreck_EP1",[(_coords select 0) + 30, (_coords select 1) - 5,0],[], 0, "NONE"];
box = createVehicle ["USVehicleBox",[(_coords select 0) - 10, _coords select 1,0],[], 0, "NONE"];
box2 = createVehicle ["USVehicleBox",[(_coords select 0) - 10, (_coords select 1) - 10,0],[], 0, "NONE"];

[BOX] execVM "\z\addons\dayz_server\missions\misc\fillBoxes1.sqf";
[BOX2] execVM "\z\addons\dayz_server\missions\misc\fillBoxes1.sqf";

/*
_aispawn = [[(_coords select 0) + 2, _coords select 1,0],80,6,6,1] execVM "\z\addons\dayz_server\missions\add_unit_server4.sqf";//AI Guards
sleep 5;
_aispawn = [[(_coords select 0) + 2, _coords select 1,0],80,6,6,1] execVM "\z\addons\dayz_server\missions\add_unit_server4.sqf";//AI Guards
sleep 5;
_aispawn = [[(_coords select 0) + 2, _coords select 1,0],40,4,4,1] execVM "\z\addons\dayz_server\missions\add_unit_server4.sqf";//AI Guards
sleep 5;
_aispawn = [[(_coords select 0) + 2, _coords select 1,0],40,4,4,1] execVM "\z\addons\dayz_server\missions\add_unit_server4.sqf";//AI Guards
*/

    _ai_marker = createMarker ["SAR_marker_major", _coords];
    _ai_marker setMarkerShape "RECTANGLE";
    _ai_marker setMarkeralpha 0;
    _ai_marker setMarkerType "Flag";
    _ai_marker setMarkerBrush "Solid";
    _ai_marker setMarkerSize [100,100];
    SAR_marker_major = _ai_marker;
   diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1; //just in case to prevent the marker from not being found in time due to server low fps
    [SAR_marker_major,3,5,6,"patrol",false] call SAR_AI;
   diag_log("Mission-DEBUG - SPAWNED MISSION SARGE AI");

deleteMarker "SAR_marker_major";

waitUntil{{isPlayer _x && _x distance c130wreck < 30  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"Survivors secured the crash site! We'll done.", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"Survivors secured the crash site! We'll done."] call RE;
[nil,nil,rHINT,"Survivors secured the crash site! We'll done."] call RE;

deleteMarker "SAR_marker_major";

[] execVM "debug\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";

SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\major\SMfinder.sqf";
