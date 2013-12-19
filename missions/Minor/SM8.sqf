//Landing party sidemission Created by TheSzerdi Edited by Falcyn [QF]
//Edited by Fuchs

private ["_coord1","_coord2","_coord3","_coords","_wait","_dummymarker"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

//Mission start
[nil,nil,rTitleText,"A landing party is establishing a beachhead!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"A landing party is establishing a beachhead!"] call RE;
[nil,nil,rHINT,"A landing party is establishing a beachhead!"] call RE;

_coord1 =[[7871.2979, 3066.8784,0],[7813.6245, 3113.5232,0]];
_coord2 =[[7785.7861, 3124.6489,0],[7690.1489, 3114.0837,0]];
_coord3 =[[7661.8218, 3099.8113,0],[7597.4658, 3051.6685,0]];

_coords = [_coord1, _coord2, _coord3] call BIS_fnc_selectRandom;

MCoords = _coords select 1;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

pbxride = createVehicle ["PBX",_coords select 0,[], 0, "NONE"];
pbxride setVariable ["Mission",1,true];
pbxride setFuel 1;

[_coords select 0,4,1] execVM "\z\addons\dayz_server\missions\add_unit_server6.sqf";//AI Guards
sleep 3;
LandingParty addVehicle pbxride;
LandingParty move (_coords select 1);
waitUntil{(pbxride distance (_coords select 1)) < 50}; 
tentloot = createVehicle ["TentStorage",_coords select 1,[], 0, "NONE"];
tentloot setVariable ["Mission",1,true];
sleep 1;

tentloot addWeaponCargoGlobal ["ItemCompass", 2];
tentloot addWeaponCargoGlobal ["ItemGPS", 3];
tentloot addWeaponCargoGlobal ["NVGoggles", 1];
tentloot addMagazineCargoGlobal ["FoodCanBakedBeans", 4];
tentloot addMagazineCargoGlobal ["ItemBandage", 4];
tentloot addMagazineCargoGlobal ["ItemMorphine", 4];
tentloot addMagazineCargoGlobal ["ItemPainkiller", 4];
tentloot addMagazineCargoGlobal ["ItemAntibiotic", 2]
tentloot addWeaponCargoGlobal ["ItemKnife", 2];
tentloot addWeaponCargoGlobal ["ItemToolbox", 2];
tentloot addWeaponCargoGlobal ["ItemMatches", 2];
tentloot addMagazineCargoGlobal ["ItemBloodbag", 2];
tentloot addMagazineCargoGlobal ["ItemJerryCan", 2];
tentloot addMagazineCargoGlobal ["MP5A5", 2]
tentloot addMagazineCargoGlobal ["30Rnd_9x19_MP5", 5]
tentloot addMagazineCargoGlobal ["glock17_EP1", 2]
tentloot addMagazineCargoGlobal ["17Rnd_9x19_glock17", 4]


waitUntil{{isPlayer _x && _x distance tentloot < 10  } count playableunits > 0}; 

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

//Mission accomplished
[nil,nil,rTitleText,"You've secured the beachhead! Good work.", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"You've secured the beachhead! Good work."] call RE;
[nil,nil,rHINT,"You've secured the beachhead! Good work."] call RE;

SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\minor\SMfinder.sqf";
