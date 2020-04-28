update eg_appconfig_values set value='{"validBoundary":{"ADMINISTRATION":[{"boundary":"Ward", "displayName":"Election Ward"}],"REVENUE":[{"boundary":"Zone", "displayName":"Zonal Office"}, {"boundary":"Ward", "displayName":"Revenue Ward"}], "LOCATION":[{"boundary":"Locality", "displayName":"Locality"}]}, "crossBoundary":{"fromHierarchy":"REVENUE:Ward:Revenue Ward","toHierarchy":"LOCATION:Locality:Locality,ADMINISTRATION:Ward:Election Ward"}}' where key_id=(select id from eg_appconfig where module=(select id from eg_module where name='BPA') and key_name='BPA_GENERIC_BOUNDARY_CONFIGURATION');
