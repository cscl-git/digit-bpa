update eg_appconfig set key_name='DCR_SCRUTINIZED_PLAN_EXPIRY_DAYS' where key_name='RECENT_DCRRULE_AMENDMENTDAYS' and module=(select id from eg_module where name='BPA');