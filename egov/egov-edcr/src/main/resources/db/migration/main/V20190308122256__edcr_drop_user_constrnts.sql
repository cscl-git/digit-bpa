ALTER TABLE edcr_subrule DROP CONSTRAINT fk_edcr_subrule_crtby;
ALTER TABLE edcr_application DROP CONSTRAINT fk_edcr_application_mdfdby;
ALTER TABLE edcr_planrule DROP CONSTRAINT fk_edcr_planrule_mdfdby;
ALTER TABLE edcr_planinfo DROP CONSTRAINT fk_edcr_planinfo_mdfdby;
ALTER TABLE edcr_application DROP CONSTRAINT fk_edcr_appln_bldg_licensee;
ALTER TABLE edcr_planinfo DROP CONSTRAINT fk_edcr_planinfo_crtedby;
ALTER TABLE edcr_planrule DROP CONSTRAINT fk_edcr_planrule_crtby;
ALTER TABLE edcr_application_detail DROP CONSTRAINT fk_edcr_dxf_document_mdfdby;
ALTER TABLE edcr_application DROP CONSTRAINT fk_edcr_application_crtedby;
ALTER TABLE edcr_rule DROP CONSTRAINT fk_edcr_rule_crtby;
ALTER TABLE edcr_application_detail DROP CONSTRAINT fk_edcr_dxf_document_crtby;
ALTER TABLE edcr_subrule DROP CONSTRAINT fk_edcr_subrule_mdfdby;
ALTER TABLE edcr_rule DROP CONSTRAINT fk_edcr_rule_mdfdby;