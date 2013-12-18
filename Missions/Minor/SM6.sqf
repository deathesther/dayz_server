//Weapon Truck Crash by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)

private ["_coords","_wait","_MainMarker75"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords = [getMarkerPos "center",0,5500,10,0,2000,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A bandit weapons truck has crashed! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A bandit weapons truck has crashed! Check your map for the location!"] call RE;
[nil,nil,rHINT,"A bandit weapons truck has crashed! Check your map for the location!"] call RE;


MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_uralcrash = createVehicle ["UralWreck",_coords,[], 0, "CAN_COLLIDE"];
_uralcrash setVariable ["Mission",1,true];

_crate = createVehicle ["USLaunchersBox",[(_coords select 0) + 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate] execVM "\z\addons\dayz_server\missions\misc\fillBoxes.sqf";
_crate setVariable ["Mission",1,true];

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["Mission",1,true];

_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate3] execVM "\z\addons\dayz_server\missions\misc\fillBoxesH.sqf";
_crate3 setVariable ["Mission",1,true];

[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;
[_coords,40,4,3,0] execVM "\z\addons\dayz_server\Missions\add_unit_server.sqf";//AI Guards
sleep 1;



waitUntil{{isPlayer _x && _x distance _uralcrash < 30  } count playableunits > 0}; 

//Mission accomplished
[nil,nil,rTitleText,"The crash site has been secured by survivors!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The crash site has been secured by survivors!"] call RE;
[nil,nil,rHINT,"The crash site has been secured by survivors!"] call RE;

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\Minor\SMfinder.sqf";
