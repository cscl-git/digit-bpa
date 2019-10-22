ALTER TABLE EGW_LINEESTIMATE ALTER COLUMN subject DROP NOT NULL;
ALTER TABLE EGW_LINEESTIMATE ALTER COLUMN description DROP NOT NULL;
ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN quantity DROP NOT NULL;
ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN uom DROP NOT NULL;
ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN beneficiary DROP NOT NULL;

--rollback ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN beneficiary SET NOT NULL;
--rollback ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN uom SET NOT NULL;
--rollback ALTER TABLE EGW_LINEESTIMATE_DETAILS ALTER COLUMN quantity SET NOT NULL;
--rollback ALTER TABLE EGW_LINEESTIMATE ALTER COLUMN subject SET NOT NULL;
--rollback ALTER TABLE EGW_LINEESTIMATE ALTER COLUMN description SET NOT NULL;