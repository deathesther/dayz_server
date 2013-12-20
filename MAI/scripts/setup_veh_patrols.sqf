
waitUntil {sleep 0.1; !isNil "MAI_locations_ready"};

if (MAI_maxHeliPatrols > 0) then {
	if ((count MAI_heliTypes) < 1) then {MAI_heliTypes = ["UH1H_DZ"]}; 
	_helipatrols = MAI_maxHeliPatrols spawn MAI_spawnHeliPatrol;
	sleep 5;
};

if (MAI_maxLandPatrols > 0) then {
	if ((count MAI_vehTypes) < 1) then {MAI_vehTypes = ["UAZ_Unarmed_TK_EP1"]};
	_vehpatrols = MAI_maxLandPatrols spawn MAI_spawnVehPatrol;
};
