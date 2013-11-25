/*
	heli_despawn
	
	Description:
	
	Last updated: 4:40 PM 11/2/2013
	
*/

if (!isServer) exitWith {};

private ["_helicopter","_unitGroup","_deleteQueue","_cleanupTime","_crewCount","_killer"];

_helicopter = _this select 0;
_killer = _this select 1;
_unitGroup = _helicopter getVariable "unitGroup";
_crewCount = _helicopter getVariable ["crewCount",1];

{
	deleteVehicle _x;
} forEach (units _unitGroup);
sleep 0.1;
deleteGroup _unitGroup;

MAI_curHeliPatrols = MAI_curHeliPatrols - 1;
_deleteQueue = [_helicopter];

if (MAI_airLootMode > 0) then {
	private ["_heliPos"];
	_heliPos = getPosATL _helicopter;
	if (!(surfaceIsWater _heliPos)) then {
		if (MAI_airLootMode == 1) then {
			for "_i" from 1 to _crewCount do {
				private ["_dropPos","_agentType","_weapongrade","_agent","_parachute"];
				_agentType = (MAI_militaryTypes call BIS_fnc_selectRandom3);
				_weapongrade = [MAI_weaponGrades,MAI_gradeChancesHeli] call fnc_selectRandomWeightedmil;
				_dropPos = [((_heliPos select 0) + (random 10) - (random 10)),((_heliPos select 1) + (random 10) - (random 10)),90];
				_parachute = createVehicle ["ParachuteWest", _dropPos, [], 0, "FLY"];
				_agent = createAgent [_agentType,[0,0,0],[],1,"NONE"];
				_agent moveInDriver _parachute;
				_nul = [_agent,_weapongrade] call MAI_setupLoadout;
				_nul = [_agent,_weapongrade] spawn MAI_addLoot;
				_agent setDamage 1;
				_agent spawn MAI_deathFlies;
				[_deleteQueue,[_agent,(_agent getVariable ["sound_flies",objNull])]] call MAI_append;
				if (MAI_debugLevel > 0) then {
					diag_log format ["MAI Debug: Spawned loot agent with weapongrade %2 at %1.",mapGridPosition _dropPos,_weapongrade];
					if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Agent %1 deployed in parachute %2. Parachute passenger is %3.",_agent,_parachute,(crew _parachute)];};
				};
				sleep 0.5;
			};
		} else {
			private ["_dropMarker","_dropTrigger","_statements"];
			
			//Create spawn area marker
			_dropMarker = createMarker [str _helicopter, _heliPos];
			_dropMarker setMarkerShape "ELLIPSE";
			_dropMarker setMarkerType "Empty";
			_dropMarker setMarkerBrush "Solid";
			_dropMarker setMarkerSize [100, 100];
			_dropMarker setMarkerAlpha 0;
			
			//Create area trigger
			_dropTrigger = createTrigger ["EmptyDetector",_heliPos];
			_dropTrigger setTriggerArea [600, 600, 0, false];
			_dropTrigger setTriggerActivation ["ANY", "PRESENT", true];
			_dropTrigger setTriggerTimeout [5, 5, 5, true];
			_dropTrigger setTriggerText (format ["Paradrop%1",mapGridPosition _helicopter]);
			_statements = format ["0 = [%1,0,100,thisTrigger,-1,'%2'] call fnc_spawnmilitary_custom;",_crewCount,_dropMarker];
			_dropTrigger setTriggerStatements ["{isPlayer _x} count thisList > 0;",_statements,"0 = [thisTrigger] spawn fnc_despawnmilitary;"];
			_dropTrigger setVariable ["respawn",false];
			_dropTrigger setVariable ["spawnmarker",_dropMarker];
			_dropTrigger setVariable ["permadelete",true];
			
			_nul = _dropTrigger spawn {
				private ["_timelimit","_deleteTrigger"];

				_timelimit = time +60;
				_deleteTrigger = true;
				while {(time < _timelimit) && _deleteTrigger} do {
					if ((count (_this getVariable ["GroupArray",[]])) > 0) then {_deleteTrigger = false};
					sleep 10;
				};
				if (_deleteTrigger) then {deleteVehicle _this};
			};
			
			if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Spawning AI paradrop at %1.",mapGridPosition _trigger];};
		};
	};
};

_cleanupTime = 900;	//seconds to despawn helicopter and loot agents.
if (MAI_debugLevel > 0) then {diag_log format ["MAI Debug: Helicopter patrol destroyed. Cleanup in %1 seconds.",_cleanupTime];};
[_deleteQueue,_cleanupTime] spawn MAI_deleteObject;
