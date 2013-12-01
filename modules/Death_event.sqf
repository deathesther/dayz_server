private ["_spawnChance", "_spawnMarker", "_spawnRadius", "_markerRadius", "_item", "_debug", "_start_time", "_loot", "_loot_amount", "_loot_box", "_wait_time", "_spawnRoll", "_position", "_event_marker", "_loot_pos", "_debug_marker","_loot_box", "_hint"];

_spawnChance =  1; // Percentage chance of event happening
_markerRadius = 400; // Radius the loot can spawn and used for the marker
_debug = false; // Puts a marker exactly were the loot spawns

_loot_box = "RUBasicWeaponsBox";
_loot_lists = [
[
["DMR","BAF_LRR_scoped","M40A3"], 
["20Rnd_762x51_DMR","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","ItemMorphine","ItemMorphine","ItemBloodbag","ItemBloodbag","ItemPainkiller","ItemPainkiller","ItemBandage","ItemBandage","ItemBandage","ItemBandage","DZ_GunBag_EP1","ItemGoldBar10oz","Skin_Sniper1_DZ"]
],
[
["SVD","M4A3_CCO_EP1","UZI_EP1"], 
["30Rnd_9x19_UZI","30Rnd_9x19_UZI","10Rnd_762x54_SVD","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","ItemMorphine","ItemMorphine","ItemBloodbag","ItemBloodbag","ItemPainkiller","ItemPainkiller","ItemBandage","ItemBandage","ItemBandage","ItemBandage","Skin_Sniper2_DZ","DZ_GunBag_EP1"]
],
[
["M240_DZ","AK_74"], 
["30Rnd_762x39_AK47","30Rnd_762x39_AK47","HandGrenade_west","100Rnd_762x51_M240","Skin_Soldier1_DZ","revolver_gold_EP1","6Rnd_45ACP","6Rnd_45ACP","FoodmuttonCooked","ItemSodaCoke","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemMorphine","ItemMorphine","DZ_ALICE_Pack_EP1"]
],
[
["M4A1_AIM_SD_camo","G36K_camo","glock17_EP1","glock17_EP1"], 
["20Rnd_762x51_SB_SCAR","20Rnd_762x51_SB_SCAR","17Rnd_9x19_glock17","17Rnd_9x19_glock17","17Rnd_9x19_glock17","17Rnd_9x19_glock17","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","FoodmuttonCooked","ItemSodaCoke","ItemBloodbag","ItemBloodbag","Skin_Camo1_DZ","Skin_Camo1_DZ"]
],
[
["M9SD"],
["15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemMorphine","ItemMorphine","ItemMorphine","ItemMorphine","ItemMorphine","ItemMorphine","ItemMorphine","ItemMorphine","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemAntibiotic","ItemAntibiotic","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemPainkiller","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","Skin_Rocker1_DZ","Skin_Soldier_Bodyguard_AA12_PMC_DZ"]
],
[
["M9SD"],
["15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","CinderBlocks","CinderBlocks","CinderBlocks","ItemSandbag","ItemPole","ItemPole","ItemToolbox","ItemCrowbar","ItemJerrycanEmpty","ItemJerrycanEmpty","ItemJerrycanEmpty","PartGeneric","PartGeneric","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","MortarBucket","PartPlywoodPack","Bulk_empty"]
],
[
["M9SD"],
["15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","FoodCanPasta","FoodCanPasta","FoodCanPasta","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","CinderBlocks","CinderBlocks","ItemPole","ItemToolbox","ItemCrowbar","ItemJerrycanEmpty","ItemJerrycanEmpty","PartGeneric","PartPlankPack","PartPlankPack","PartPlywoodPack","Bulk_empty","ItemBriefcaseEmpty"]
],
[
["M9SD"],
["15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","FoodCanPasta","FoodCanPasta","ItemSodaCoke","ItemSodaCoke","CinderBlocks","ItemToolbox","ItemCrowbar","ItemJerrycanEmpty","PartGeneric","PartPlankPack","MortarBucket","PartPlywoodPack","PartWoodPlywood","PartWoodPlywood","PartWoodLumber","PartWoodLumber","PartWoodLumber","Bulk_empty"]
]
];
_loot = _loot_lists call BIS_fnc_selectRandom;

_loot_amount = 75;
_wait_time = 900; 

// Dont mess with theses unless u know what yours doing
_start_time = time;
_spawnRadius = 5000;
_spawnMarker = 'center';

if (isNil "EPOCH_EVENT_RUNNING") then {
	EPOCH_EVENT_RUNNING = false;
};

// Check for another event running
if (EPOCH_EVENT_RUNNING) exitWith {
	diag_log("Event already running");
};

// Random chance of event happening
_spawnRoll = random 1;
if (_spawnRoll > _spawnChance and !_debug) exitWith {};

// Random location
_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;

diag_log(format["Spawning loot event at %1", _position]);

_event_marker = createMarker [ format ["loot_event_marker_%1", _start_time], _position];
_event_marker setMarkerShape "ELLIPSE";
_event_marker setMarkerColor "ColorRed";
_event_marker setMarkerAlpha 0.5;
_event_marker setMarkerSize [(_markerRadius + 50), (_markerRadius + 50)];

_loot_pos = [_position,0,(_markerRadius - 100),10,0,2000,0] call BIS_fnc_findSafePos;

if (_debug) then {
	_debug_marker = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _loot_pos];
	_debug_marker setMarkerShape "ICON";
	_debug_marker setMarkerType "mil_dot";
	_debug_marker setMarkerColor "ColorBlue";
	_debug_marker setMarkerAlpha 1;
};

diag_log(format["Creating ammo box at %1", _loot_pos]);

// Create ammo box
_loot_box = createVehicle [_loot_box,_loot_pos,[], 0, "NONE"];
clearMagazineCargoGlobal _loot_box;
clearWeaponCargoGlobal _loot_box;

	_this = createTrigger ["EmptyDetector", _loot_pos];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "loot_event";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "0 = [5,5,200,thisTrigger,[],3] call fnc_spawnBandits;", "0 = [thisTrigger] spawn fnc_despawnBandits;"];
	_trigger_250 = _this;

// Cut the grass around the loot position
_clutter = createVehicle ["ClutterCutter_small_2_EP1", _loot_pos, [], 0, "CAN_COLLIDE"];
_clutter setPos _loot_pos;
// cut the grass    end

// Add loot
{
_loot_box addWeaponCargoGlobal [_x,1];
} forEach (_loot select 0);
{
_loot_box addMagazineCargoGlobal [_x,1];
} forEach (_loot select 1);

// Send message to users
[nil,nil,rTitleText,"A weapons cache has been located within the shaded area on the map, you have 15 minutes to grab the loot. - Red", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A weapons cache has been located within the shaded area on the map, you have 15 minutes to grab the loot. - Red"] call RE;
[nil,nil,rHINT,"A weapons cache has been located within the shaded area on the map, you have 15 minutes to grab the loot. - Red"] call RE;

diag_log(format["Loot event setup, waiting for %1 seconds", _wait_time]);

// Wait
sleep _wait_time;

// Clean up
EPOCH_EVENT_RUNNING = false;
deleteVehicle _trigger_250
deleteVehicle _loot_box;
deletemarker _event_marker;
if (_debug) then {
	deleteMarker _debug_marker;
};

// Send message to users 
[nil,nil,rTitleText,"The Weapons Cache is gone and everything that was around is gone with it. You missed your chance.", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"The Weapons Cache is gone and everything that was around is gone with it. You missed your chance."] call RE;
[nil,nil,rHINT,"The Weapons Cache is gone and everything that was around is gone with it. You missed your chance."] call RE;