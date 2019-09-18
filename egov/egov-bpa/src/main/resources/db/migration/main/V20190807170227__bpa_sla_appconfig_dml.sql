INSERT INTO eg_appconfig ( ID, KEYNAME, DESCRIPTION, VERSION, MODULE ) VALUES
(nextval('SEQ_EG_APPCONFIG'), 'SLA_BPA_APPLICATION', 'Sla Bpa Application',0, (select id from eg_module where name='BPA'));

INSERT INTO eg_appconfig_values ( ID, CONFIG, EFFECTIVEFROM, VALUE, VERSION ) 
VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'),(SELECT id FROM EG_APPCONFIG WHERE KEYNAME='SLA_BPA_APPLICATION'
 AND MODULE =(select id from eg_module where name='BPA')),current_date, '15',0);


INSERT INTO eg_appconfig ( ID, KEYNAME, DESCRIPTION, VERSION, MODULE ) VALUES
(nextval('SEQ_EG_APPCONFIG'), 'SLA_PERMIT_RENEWAL_APPLICATION', 'Sla Permit Renewal Application',0, (select id from eg_module where name='BPA'));

INSERT INTO eg_appconfig_values ( ID, CONFIG, EFFECTIVEFROM, VALUE, VERSION ) 
VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'),(SELECT id FROM EG_APPCONFIG WHERE KEYNAME='SLA_PERMIT_RENEWAL_APPLICATION'
 AND MODULE =(select id from eg_module where name='BPA')),current_date, '7',0);


INSERT INTO eg_appconfig ( ID, KEYNAME, DESCRIPTION, VERSION, MODULE ) VALUES
(nextval('SEQ_EG_APPCONFIG'), 'SLA_OC_APPLICATION', 'Sla OC Application',0, (select id from eg_module where name='BPA'));

INSERT INTO eg_appconfig_values ( ID, CONFIG, EFFECTIVEFROM, VALUE, VERSION ) 
VALUES (nextval('SEQ_EG_APPCONFIG_VALUES'),(SELECT id FROM EG_APPCONFIG WHERE KEYNAME='SLA_OC_APPLICATION'
 AND MODULE =(select id from eg_module where name='BPA')),current_date, '15',0);
