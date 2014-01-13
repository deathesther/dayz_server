
sleep 60;
_this = createMarker ["bandit_main_base_S1", [1080.4541, 2427.7761, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_S1 = _this;
sleep 1;
	["bandit_main_base_S1",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S2", [1125.2408, 2504.8452, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_S2 = _this;
sleep 1;
	["bandit_main_base_S2",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S3", [1140.9453, 2555.7385, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_S3 = _this;
sleep 1;
	["bandit_main_base_S3",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S4", [1239.5344, 2551.6672, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_S4 = _this;
sleep 1;
	["bandit_main_base_S4",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S5", [1344.5217, 2460.9302, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_S5 = _this;
sleep 1;
	["bandit_main_base_S5",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S6", [1195.0385, 2493.2107, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [100, 100];
_this setMarkerAlpha 0;
bandit_main_base_S6 = _this;
sleep 1;
	["bandit_main_base_S6",6,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S7", [1268.3259, 2482.1604, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [100, 100];
_this setMarkerAlpha 0;
bandit_main_base_S7 = _this;
sleep 1;
	["bandit_main_base_S7",6,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S8", [1173.8083, 2443.1899, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [100, 100];
_this setMarkerAlpha 0;
bandit_main_base_S8 = _this;
sleep 1;
	["bandit_main_base_S8",6,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S9", [1124.5784, 2420.0967, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [100, 100];
_this setMarkerAlpha 0;
bandit_main_base_S9 = _this;
sleep 1;
	["bandit_main_base_S9",6,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_S10", [1211.9705, 2400.7068, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [100, 100];
_this setMarkerAlpha 0;
bandit_main_base_S10 = _this;
sleep 1;
	["bandit_main_base_S10",6,2,False] call DZAI_spawn;

	_cratesb = createVehicle ["USVehicleBox", [1154.5842, 2473.0718],[], 0, "CAN_COLLIDE"];
	[_cratesb] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesH.sqf";
	_cratesb setVariable ["permaLoot",true];

	_cratesb2 = createVehicle ["USVehicleBox", [1208.6947, 2537.0837],[], 0, "CAN_COLLIDE"];
	[_cratesb2] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesM.sqf";
	_cratesb2 setVariable ["permaLoot",true];

	_cratesb3 = createVehicle ["USVehicleBox", [1217.261, 2543.7644],[], 0, "CAN_COLLIDE"];
	[_cratesb3] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAM.sqf";
	_cratesb3 setVariable ["permaLoot",true];

	_cratesb4 = createVehicle ["USVehicleBox", [1226.493, 2550.4604],[], 0, "CAN_COLLIDE"];
	[_cratesb4] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesC.sqf";
	_cratesb4 setVariable ["permaLoot",true];

	_cratesb5 = createVehicle ["USVehicleBox", [1071.4041, 2405.7681, -4.7683716e-007],[], 0, "CAN_COLLIDE"];
	[_cratesb5] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesMED.sqf";
	_cratesb5 setVariable ["permaLoot",true];

	_cratesb6 = createVehicle ["USVehicleBox", [1338.3754, 2464.8286],[], 0, "CAN_COLLIDE"];
	[_cratesb6] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesL.sqf";
	_cratesb6 setVariable ["permaLoot",true];

	_cratesb7 = createVehicle ["USVehicleBox", [1354.0651, 2472.1196],[], 0, "CAN_COLLIDE"];
	[_cratesb7] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAL.sqf";
	_cratesb7 setVariable ["permaLoot",true];

	_cratesb8 = createVehicle ["USVehicleBox", [1148.1849, 2539.0923],[], 0, "CAN_COLLIDE"];
	[_cratesb8] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesO.sqf";
	_cratesb8 setVariable ["permaLoot",true];