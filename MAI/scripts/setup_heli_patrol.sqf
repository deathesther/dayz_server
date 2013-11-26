
waitUntil {sleep 1; !isNil "MAI_locations_ready"};

_helipatrols = [] spawn fnc_spawnHeliPatrol_M;
