INSERT INTO eg_appconfig ( ID, KEYNAME, DESCRIPTION, VERSION, MODULE ) VALUES
(nextval('SEQ_EG_APPCONFIG'), 'DCR_INTEGRATION_REQUIRE_WITH_BPA', 'Is DCR integration require with building plan approval application',0, (select id from eg_module where name='BPA'));

INSERT INTO eg_appconfig_values ( ID, CONFIG, EFFECTIVEFROM, VALUE, VERSION ) 
VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'),(SELECT id FROM EG_APPCONFIG WHERE KEYNAME='DCR_INTEGRATION_REQUIRE_WITH_BPA'
 AND MODULE =(select id from eg_module where name='BPA')),current_date, 'YES',0);