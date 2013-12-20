/*
	Trinity Island static/dynamic trigger configuration 
	
	Last updated: 11:44 AM 6/7/2013
	
*/

#include "spawn_markers\markers_trinity.sqf"	//Load manual spawn point definitions file.
#include "spawn_areas\areas_trinity.sqf"		//Load spawn area definitions file.

if ((MAI_maxHeliPatrols > 0) or (MAI_maxLandPatrols > 0) or MAI_dynAISpawns) then {
	"MAI_centerMarker" setMarkerPos [7183.8403, 7067.4727];
	"MAI_centerMarker" setMarkerSize [5250, 5250];
};

if (MAI_verifyTables) then {
	waitUntil {sleep 0.1; !isNil "MAI_classnamesVerified"};	//Wait for MAI to finish verifying classname arrays.
} else {
	waitUntil {sleep 0.1; !isNil "MAI_weaponsInitialized"};	//Wait for MAI to finish building weapon classname arrays.
};

if (MAI_staticAI) then {

	//begin triggers
	["MAI_StansfieldAirport",[2,2],[],2] call MAI_static_spawn;
	["MAI_FarmArea",[0,2],[],0] call MAI_static_spawn;
	["MAI_HouseArea1",[0,2],[],0] call MAI_static_spawn;
	["MAI_HouseArea2",[0,2],[],0] call MAI_static_spawn;
	["MAI_Edan"] call MAI_static_spawn;
	["MAI_Barracks1",[2,1]] call MAI_static_spawn;
	["MAI_ChapelHill",[0,1]] call MAI_static_spawn;
	["MAI_SarasotaS"] call MAI_static_spawn;
	["MAI_Sarasota"] call MAI_static_spawn;
	["MAI_CoastalHouse",[0,1]] call MAI_static_spawn;
	["MAI_Rivlin",[2,2]] call MAI_static_spawn;
	["MAI_RivlinChurch"] call MAI_static_spawn;
	["MAI_MilBase",[1,1],[],3] call MAI_static_spawn;
	["MAI_Ellesmere"] call MAI_static_spawn;
	["MAI_Bree",[1,2]] call MAI_static_spawn;
	["MAI_Helm",[1,2]] call MAI_static_spawn;
	["MAI_HelmE"] call MAI_static_spawn;
	["MAI_MilBase2"] call MAI_static_spawn;
	["MAI_MilBase3"] call MAI_static_spawn;
	["MAI_Abbeyfield",[2,1]] call MAI_static_spawn;
	["MAI_StFrances"] call MAI_static_spawn;
	["MAI_StFrancesW",[0,1],[],0] call MAI_static_spawn;
	["MAI_Contra",[2,1]] call MAI_static_spawn;
	["MAI_ContraNW"] call MAI_static_spawn;
	["MAI_Richmond",[2,1]] call MAI_static_spawn;
	["MAI_Totley",[1,2],[],1,2] call MAI_static_spawn;
	["MAI_Koul"] call MAI_static_spawn;
	["MAI_DurrasHights"] call MAI_static_spawn;
	["MAI_LodgeMoor"] call MAI_static_spawn;
	["MAI_MilBase4",[2,1],[],2] call MAI_static_spawn;
	["MAI_MilBase5"] call MAI_static_spawn;
	["MAI_Deepcut",[2,2]] call MAI_static_spawn;
	["MAI_FarmArea2"] call MAI_static_spawn;
	["MAI_LibertyAirport",[2,1],[],2] call MAI_static_spawn;
	["MAI_Maine",[1,2]] call MAI_static_spawn;
	["MAI_Eastwick"] call MAI_static_spawn;
	["MAI_HessIsland",[0,2]] call MAI_static_spawn;
	["MAI_StattonPort"] call MAI_static_spawn;
	["MAI_HarleyW"] call MAI_static_spawn;
	["MAI_Harley"] call MAI_static_spawn;
	["MAI_MilBarracks",[2,2],[],3] call MAI_static_spawn;
	["MAI_Yale",[2,1]] call MAI_static_spawn;
	["MAI_YaleS",[0,1],[],0] call MAI_static_spawn;
	["MAI_Madison"] call MAI_static_spawn;
	["MAI_MilBase6"] call MAI_static_spawn;
	["MAI_Lavayette"] call MAI_static_spawn;
	["MAI_TimberlandN",[2,1]] call MAI_static_spawn;
	["MAI_MilBase7"] call MAI_static_spawn;
	["MAI_TimberlandIndustrial"] call MAI_static_spawn;
	//end of triggers
};

#include "custom_markers\cust_markers_trinity.sqf"
#include "custom_spawns\cust_spawns_trinity.sqf"

diag_log "Trinity Island/dynamic trigger configuration loaded.";
