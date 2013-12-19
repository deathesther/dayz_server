//Humvee Mission Created by TheSzerdi Edited by Falcyn [QF]
//Edited for EMS 

private ["_coords","_dummymarker","_chopper","_wait","_coord1","_coord2","_coord3","_coord4","_coord5","_coord6","_coord7","_coord8","_coord9","_coord10","_coord11","_coord12"];
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
[nil,nil,rTitleText,"A humvee has broken down! Secure it's firepower for yourself!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"A humvee has broken down! Secure it's firepower for yourself!"] call RE;
[nil,nil,rHINT,"A humvee has broken down! Secure it's firepower for yourself!"] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "debug\addmarkers.sqf";

_chopper = ["HMMWV_M998_crows_MK19_DES_EP1","HMMWV_M998_crows_MK19_DES_EP1"] call BIS_fnc_selectRandom;

_hueychop = createVehicle [_chopper,_coords,[], 0, "NONE"];
_hueychop setFuel 0;
_hueychop setVehicleAmmo 0.5;
_hueychop setVariable ["Mission",1,true];

	_this = createMarker ["DZAI_marker_major", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Empty";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [100, 100];
	_this setMarkerAlpha 0;
    DZAI_marker_major = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_major",12,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

waitUntil{{isPlayer _x && _x distance _hueychop < 10  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"The humvee is under survivor control!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The humvee is under survivor control!"] call RE;
[nil,nil,rHINT,"The humvee is under survivor control!"] call RE;

deleteMarker "DZAI_marker_major";

[] execVM "debug\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";

SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\major\SMfinder.sqf";
