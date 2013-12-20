/*
	Utes static/dynamic trigger configuration 
	
	Last updated: 11:44 AM 6/7/2013
	
*/

#include "spawn_markers\markers_utes.sqf"	//Load manual spawn point definitions file.

if ((MAI_maxHeliPatrols > 0) or (MAI_maxLandPatrols > 0) or MAI_dynAISpawns) then {
	"MAI_centerMarker" setMarkerPos [3519.8037, 3703.0649];
	"MAI_centerMarker" setMarkerSize [1000, 1000];
};

if (MAI_verifyTables) then {
	waitUntil {sleep 0.1; !isNil "MAI_classnamesVerified"};	//Wait for MAI to finish verifying classname arrays.
} else {
	waitUntil {sleep 0.1; !isNil "MAI_weaponsInitialized"};	//Wait for MAI to finish building weapon classname arrays.
};

if (MAI_staticAI) then {

	//begin triggers
	_this = createTrigger ["EmptyDetector", [3389.5076, 4330.6724]];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "Kamenyy";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,200,thisTrigger,[],1] call fnc_spawnmilitary;", "nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger_0 = _this;

	_this = createTrigger ["EmptyDetector", [3561.8384, 3708.8481]];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "Airbase 1";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,2,175,thisTrigger,[],3] call fnc_spawnmilitary;", "nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger_2 = _this;

	_this = createTrigger ["EmptyDetector", [3798.3088, 3443.5945]];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "Airbase 2";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [2,2,200,thisTrigger,[],3] call fnc_spawnmilitary;", "nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger_4 = _this;

	_this = createTrigger ["EmptyDetector", [4355.46, 3207.3979, 0.34515762]];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "Strelka";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],0] call fnc_spawnmilitary;", "nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger_6 = _this;

	_this = createTrigger ["EmptyDetector", [2989.5833, 4469.9492]];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "Kamenyy Mil Base";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "nul = [1,1,175,thisTrigger,[],2] call fnc_spawnmilitary;", "nul = [thisTrigger] spawn fnc_despawnmilitary;"];
	_trigger_8 = _this;

//end of triggers
};

#include "custom_markers\cust_markers_utes.sqf"
#include "custom_spawns\cust_spawns_utes.sqf"

diag_log "Utes static/dynamic trigger configuration loaded.";
