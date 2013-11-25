/*
	Description: Definition file for dynamic triggers
*/

#define DYNTRIG_STATEMENTS_INACTIVE "{(isPlayer _x) && !(_x isKindOf 'Air')} count thisList > 0;","[225,thisTrigger,thisList] call fnc_spawnmilitary_dynamic;", "[thisTrigger] spawn fnc_despawnmilitary_dynamic;"
#define DYNTRIG_STATEMENTS_ACTIVE "{isPlayer _x} count thisList > 0;","[225,thisTrigger,thisList] call fnc_spawnmilitary_dynamic;", "[thisTrigger] spawn fnc_despawnmilitary_dynamic;"
