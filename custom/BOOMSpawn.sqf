
sleep 60;
_this = createMarker ["bandit_main_base_N1", [9512.9766, 11456.078]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [15, 15];
_this setMarkerAlpha 0;
bandit_main_base_N1 = _this;
sleep 1;
	["bandit_main_base_N1",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N2", [9369.1045, 11470.009]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N2 = _this;
sleep 1;
	["bandit_main_base_N2",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N3", [9456.9629, 11506.402, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N3 = _this;
sleep 1;
	["bandit_main_base_N3",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N4", [9505.8662, 11495.6]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N4 = _this;
sleep 1;
	["bandit_main_base_N4",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N5", [9602.8232, 11453.802, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N5 = _this;
sleep 1;
	["bandit_main_base_N5",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N6", [9525.4863, 11431.624, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N6 = _this;
sleep 1;
	["bandit_main_base_N6",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N7", [9440.7559, 11424.232, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N7 = _this;
sleep 1;
	["bandit_main_base_N7",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N8", [9399.5283, 11400.348, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N8 = _this;
sleep 1;
	["bandit_main_base_N8",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N8", [9448.7158, 11341.493]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N9 = _this;
sleep 1;
	["bandit_main_base_N9",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N9", [9518.9463, 11364.523, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N9 = _this;
sleep 1;
	["bandit_main_base_N10",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N10", [9599.4121, 11282.922, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N10 = _this;
sleep 1;
	["bandit_main_base_N11",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N11", [9598.5586, 11371.063, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N11 = _this;
sleep 1;
	["bandit_main_base_N12",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N12", [9529.1826, 11307.942]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N12 = _this;
sleep 1;
	["bandit_main_base_N13",6,3,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_N13", [9457.5322, 11267.853, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_N13 = _this;
sleep 1;
	["bandit_main_base_N14",6,3,False] call DZAI_spawn;

	_cratenb = createVehicle ["USVehicleBox", [9530.1797, 11448.866],[], 0, "CAN_COLLIDE"];
	[_cratenb] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesH.sqf";
	_cratenb setVariable ["permaLoot",true];

	_cratenb2 = createVehicle ["USVehicleBox", [9529.3867, 11445.663],[], 0, "CAN_COLLIDE"];
	[_cratenb2] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesH.sqf";
	_cratenb2 setVariable ["permaLoot",true];

	_cratenb3 = createVehicle ["USVehicleBox", [9520.8506, 11432.43, 2.7616425],[], 0, "CAN_COLLIDE"];
	[_cratenb3] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesT.sqf";
	_cratenb3 setVariable ["permaLoot",true];

	_cratenb4 = createVehicle ["USVehicleBox", [9527.251, 11448.261, 0],[], 0, "CAN_COLLIDE"];
	[_cratenb4] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAH.sqf";
	_cratenb4 setVariable ["permaLoot",true];

	_cratenb5 = createVehicle ["USVehicleBox", [9437.2285, 11547.095, 0],[], 0, "CAN_COLLIDE"];
	[_cratenb5] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesM.sqf";
	_cratenb5 setVariable ["permaLoot",true];

	_cratenb6 = createVehicle ["USVehicleBox", [9434.7207, 11543.825, -1.5258789e-005],[], 0, "CAN_COLLIDE"];
	[_cratenb6] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesM.sqf";
	_cratenb6 setVariable ["permaLoot",true];

	_cratenb7 = createVehicle ["USVehicleBox", [9432.7061, 11546.581, -1.5258789e-005],[], 0, "CAN_COLLIDE"];
	[_cratenb7] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAM.sqf";
	_cratenb7 setVariable ["permaLoot",true];

	_cratenb8 = createVehicle ["USVehicleBox", [9503.1563, 11347.494],[], 0, "CAN_COLLIDE"];
	[_cratenb8] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesO.sqf";
	_cratenb8 setVariable ["permaLoot",true];

	_cratenb9 = createVehicle ["USVehicleBox", [9644.6484, 11281.413, -1.5258789e-005],[], 0, "CAN_COLLIDE"];
	[_cratenb9] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesC.sqf";
	_cratenb9 setVariable ["permaLoot",true];

	_cratenb10 = createVehicle ["USVehicleBox", [9647.6494, 11275.214, -3.0517578e-005],[], 0, "CAN_COLLIDE"];
	[_cratenb10] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesMED.sqf";
	_cratenb10 setVariable ["permaLoot",true];