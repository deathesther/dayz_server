//Bandit Supply Heli Crash by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)

private ["_coords","_MainMarker","_chopper","_wait"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMajor.sqf";

WaitUntil {MissionGo == 1};

_coords = [getMarkerPos "center",0,5500,30,0,20,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A bandit supply helicopter has crash landed! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A bandit supply helicopter has crash landed! Check your map for the location!"] call RE;
[nil,nil,rHINT,"A bandit supply helicopter has crash landed! Check your map for the location!"] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "debug\addmarkers.sqf";

_chopper = ["UH1H_DZ","Mi17_DZ"] call BIS_fnc_selectRandom;

_hueychop = createVehicle [_chopper,_coords,[], 0, "NONE"];
_hueychop setVariable ["Mission",1,true];
_hueychop setFuel 0.1;
_hueychop setVehicleAmmo 0.2;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["Mission",1,true];
_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) + 6, _coords select 1,0],[], 90, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["Mission",1,true];
_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 14, (_coords select 1) -10,0],[], 0, "CAN_COLLIDE"];
[_crate3] execVM "\z\addons\dayz_server\missions\misc\fillBoxesH.sqf";
_crate3 setVariable ["Mission",1,true];
/*
_aispawn = [_coords,80,6,6,1] execVM "\z\addons\dayz_server\missions\add_unit_server.sqf";//AI Guards
sleep 5;
_aispawn = [_coords,80,6,4,1] execVM "\z\addons\dayz_server\missions\add_unit_server.sqf";//AI Guards
sleep 5;
_aispawn = [_coords,40,4,4,1] execVM "\z\addons\dayz_server\missions\add_unit_server.sqf";//AI Guards
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
    [SAR_marker_major,3,3,3,"fortify",false] call SAR_AI;
   diag_log("Mission-DEBUG - SPAWNED MISSION SARGE AI");

waitUntil{{isPlayer _x && _x distance _hueychop < 30  } count playableunits > 0}; 

//Mission accomplished
[nil,nil,rTitleText,"The helicopter has been taken by survivors!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The helicopter has been taken by survivors!"] call RE;
[nil,nil,rHINT,"The helicopter has been taken by survivors!"] call RE;

deleteMarker "SAR_marker_major";

[] execVM "debug\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";


SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\major\SMfinder.sqf";
