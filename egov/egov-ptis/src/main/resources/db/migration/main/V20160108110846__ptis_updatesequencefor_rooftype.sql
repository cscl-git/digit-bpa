SELECT setval('"seq_egpt_roof_type"',(SELECT MAX(ID) FROM egpt_roof_type ));