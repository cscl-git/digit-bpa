INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-ECFG', 'Exhibition cum Fair Ground', 27, 't', 1, now(), now(), 1, 0, 20, 0.2, 0, (select id from egbpa_occupancy where code='S'), 'Exhibition cum Fair Ground');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'A-FH', 'Farm House', 28, 't', 1, now(), now(), 1, 0, 10, 0.2, 0, (select id from egbpa_occupancy where code='A'), 'Farm House');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-SAS', 'Sports and amenity structures', 29, 't', 1, now(), now(), 1, 0, 20, 0.4, 0, (select id from egbpa_occupancy where code='S'), 'Sports and amenity structures');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'D-B', 'At sub city level in urban extension', 30, 't', 1, now(), now(), 1, 0, 25, 0.5, 0, (select id from egbpa_occupancy where code='D'), 'At sub city level in urban extension');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'D-C', 'Anganwari', 31, 't', 1, now(), now(), 1, 0, 30, 0.6, 0, (select id from egbpa_occupancy where code='D'), 'At Housing area/Cluster level');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'D-A', 'Religious', 32, 't', 1, now(), now(), 1, 0, 35, 0.7, 0, (select id from egbpa_occupancy where code='D'), 'At neighbourhood level');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'H-PP', 'Petrol Pump', 33, 't', 1, now(), now(), 1, 0, 20, 1, 1, (select id from egbpa_occupancy where code='H'), 'Petrol Pump');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-NS', 'Nursury Schools', 34, 't', 1, now(), now(), 1, 0, 33.33, 1, 0.67, (select id from egbpa_occupancy where code='E'), 'Nursury Schools');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'M-DFPAB', 'Dispensary for pet animals and birds', 35, 't', 1, now(), now(), 1, 0, 35, 1, 0, (select id from egbpa_occupancy where code='M'), 'Dispensary for pet animals and birds');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-PS', 'Primary School', 36, 't', 1, now(), now(), 1, 0, 33, 1.2, 1, (select id from egbpa_occupancy where code='E'), 'Primary School');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-SFMC', 'School for Mentally Challenged', 37, 't', 1, now(), now(), 1, 0, 50, 1.2, 0, (select id from egbpa_occupancy where code='E'), 'School for Mentally Challenged');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-SFDAP', 'School for differently abled persons', 38, 't', 1, now(), now(), 1, 0, 50, 1.2, 0, (select id from egbpa_occupancy where code='E'), 'School for differently abled persons');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-EARC', 'Academic, including administration', 39, 't', 1, now(), now(), 1, 0, 30, 1.2, 0.8, (select id from egbpa_occupancy where code='E'), 'Academic, including administration');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-MCH', 'Multipurpose Community Hall', 40, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'Multipurpose Community Hall');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-BH', 'Banquet hall', 41, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'Banquet hall');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-CRC', 'Community Recreational Club', 42, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'Community Recreational Club');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-CA', 'Cultural activities', 43, 't', 1, now(), now(), 1, 0, 35, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'Cultural activities such as auditorium, music, dance & drama centre/mediation & spiritual centre  etc');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-SC', 'Science centre', 44, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'Science centre');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'S-ICC', 'International Convention Centre', 45, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='S'), 'International Convention Centre');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'A2', 'Old Age Home', 46, 't', 1, now(), now(), 1, 0, 30, 1.2, 0, (select id from egbpa_occupancy where code='A'), 'Old Age Home/Care Centre for differently abled persons /Mentally Challenged/Working Women/Men Hostel/ Adult Education Centre/Orphanage/Children’s Centre/Night Shelter');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-CLG', 'College', 47, 't', 1, now(), now(), 1, 0, 35, 1.5, 0.75, (select id from egbpa_occupancy where code='E'), 'College');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'M-OHF', 'Other Health Facilities', 48, 't', 1, now(), now(), 1, 0, 30, 1.5, 0, (select id from egbpa_occupancy where code='M'), 'Maternity Home Nursing Home/Polyclinic / Dispensary like Family Welfare Centre, Pediatric Centre, Geriatric Centre,Diagnostic Centre');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'M-VH', '"Veterinary Hospital for pet animals and birds', 49, 't', 1, now(), now(), 1, 0, 30, 1.5, 0, (select id from egbpa_occupancy where code='M'), 'Veterinary Hospital for pet animals and birds');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'M-NAPI', 'Nursing and Paramedic Institute', 50, 't', 1, now(), now(), 1, 0, 30, 1.5, 0, (select id from egbpa_occupancy where code='M'), 'Nursing and Paramedic Institute');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'A-SA', 'Service Apartment', 51, 't', 1, now(), now(), 1, 0, 30, 2.25, 0, (select id from egbpa_occupancy where code='A'), 'Service Apartment');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'A-SA', 'Hospital/Teritary Health care Centre', 52, 't', 1, now(), now(), 1, 0, 40, 3.75, 2.50, (select id from egbpa_occupancy where code='A'), 'Hospital/Teritary Health care Centre');
INSERT INTO egbpa_sub_occupancy(id, code, name, ordernumber, isactive, createdby, createddate, lastmodifieddate, lastmodifiedby, version, maxcoverage, minfar, maxfar, occupancy, description)  VALUES (nextval('seq_egbpa_sub_occupancy'), 'E-SACA', 'Sports and Cultural Activities', 53, 't', 1, now(), now(), 1, 0,10, 15, 0, (select id from egbpa_occupancy where code='E'), 'Sports and Cultural Activities');