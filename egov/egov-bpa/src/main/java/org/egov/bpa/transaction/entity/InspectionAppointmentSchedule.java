/*
 * eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
 * accountability and the service delivery of the government  organizations.
 *
 *  Copyright (C) <2018>  eGovernments Foundation
 *
 *  The updated version of eGov suite of products as by eGovernments Foundation
 *  is available at http://www.egovernments.org
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/ or
 *  http://www.gnu.org/licenses/gpl.html .
 *
 *  In addition to the terms of the GPL license to be adhered to in using this
 *  program, the following additional terms are to be complied with:
 *
 *      1) All versions of this program, verbatim or modified must carry this
 *         Legal Notice.
 *      Further, all user interfaces, including but not limited to citizen facing interfaces,
 *         Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
 *         derived works should carry eGovernments Foundation logo on the top right corner.
 *
 *      For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
 *      For any further queries on attribution, including queries on brand guidelines,
 *         please contact contact@egovernments.org
 *
 *      2) Any misrepresentation of the origin of the material is prohibited. It
 *         is required that all modified versions of this material be marked in
 *         reasonable ways as different from the original version.
 *
 *      3) This license does not grant any rights to any user of the program
 *         with regards to rights under trademark law for use of the trade names
 *         or trademarks of eGovernments Foundation.
 *
 *  In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */

package org.egov.bpa.transaction.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.egov.bpa.transaction.entity.common.AppointmentScheduleCommon;
import org.egov.infra.persistence.entity.AbstractAuditable;

@Entity
@Table(name = "EGBPA_INSPECTION_APPOINTMENT_SCHEDULE")
@SequenceGenerator(name = InspectionAppointmentSchedule.SEQ_EGBPA_APPOINTMENT_SCHEDULE, sequenceName = InspectionAppointmentSchedule.SEQ_EGBPA_APPOINTMENT_SCHEDULE, allocationSize = 1)
public class InspectionAppointmentSchedule extends AbstractAuditable {

    public static final String SEQ_EGBPA_APPOINTMENT_SCHEDULE = "SEQ_EGBPA_INSPECTION_APPOINTMENT_SCHEDULE";
    private static final long serialVersionUID = -1344489436357479689L;

    @Id
    @GeneratedValue(generator = SEQ_EGBPA_APPOINTMENT_SCHEDULE, strategy = GenerationType.SEQUENCE)
    private Long id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "appointmentScheduleCommon")
    private AppointmentScheduleCommon appointmentScheduleCommon;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "inspectionApplication")
    private InspectionApplication inspectionApplication;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public AppointmentScheduleCommon getAppointmentScheduleCommon() {
		return appointmentScheduleCommon;
	}

	public void setAppointmentScheduleCommon(AppointmentScheduleCommon appointmentScheduleCommon) {
		this.appointmentScheduleCommon = appointmentScheduleCommon;
	}

	public InspectionApplication getInspectionApplication() {
		return inspectionApplication;
	}

	public void setInspectionApplication(InspectionApplication inspectionApplication) {
		this.inspectionApplication = inspectionApplication;
	}
}
