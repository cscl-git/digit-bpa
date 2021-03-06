<%--
  ~    eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) 2017  eGovernments Foundation
  ~
  ~     The updated version of eGov suite of products as by eGovernments Foundation
  ~     is available at http://www.egovernments.org
  ~
  ~     This program is free software: you can redistribute it and/or modify
  ~     it under the terms of the GNU General Public License as published by
  ~     the Free Software Foundation, either version 3 of the License, or
  ~     any later version.
  ~
  ~     This program is distributed in the hope that it will be useful,
  ~     but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~     GNU General Public License for more details.
  ~
  ~     You should have received a copy of the GNU General Public License
  ~     along with this program. If not, see http://www.gnu.org/licenses/ or
  ~     http://www.gnu.org/licenses/gpl.html .
  ~
  ~     In addition to the terms of the GPL license to be adhered to in using this
  ~     program, the following additional terms are to be complied with:
  ~
  ~         1) All versions of this program, verbatim or modified must carry this
  ~            Legal Notice.
  ~            Further, all user interfaces, including but not limited to citizen facing interfaces,
  ~            Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
  ~            derived works should carry eGovernments Foundation logo on the top right corner.
  ~
  ~            For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
  ~            For any further queries on attribution, including queries on brand guidelines,
  ~            please contact contact@egovernments.org
  ~
  ~         2) Any misrepresentation of the origin of the material is prohibited. It
  ~            is required that all modified versions of this material be marked in
  ~            reasonable ways as different from the original version.
  ~
  ~         3) This license does not grant any rights to any user of the program
  ~            with regards to rights under trademark law for use of the trade names
  ~            or trademarks of eGovernments Foundation.
  ~
  ~   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
  ~
  --%>

<%@page import="org.python.modules.jarray"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>

<form:form role="form" action="" modelAttribute="bpaAppointmentSchedule"
	id="bpaAppointmentReScheduleForm"
	cssClass="form-horizontal form-groups-bordered"
	enctype="multipart/form-data">
	<input type="hidden" id="bpaAppointmentScheduleId"
		name="bpaAppointmentScheduleId"
		value="${appointmentScheduledList[0].id}" />
	<input type="hidden" id="previoueappointmentDate"
		name="bpaAppointmentappointmentDate"
		value="${appointmentScheduledList[0].appointmentDate}" />
	<input type="hidden" id="prevAppointmentTime"
		name="prevAppointmentTime"
		value="${appointmentScheduledList[0].appointmentTime}" />
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-primary" data-collapsed="0">
			<c:if test="${bpaAppointmentSchedule.purpose eq 'DOCUMENTSCRUTINY'}">
			<div class="panel-heading custom_form_panel_heading">
				<div class="panel-title">
					<spring:message code="lbl.existing.schedule.scrutiny" />
				</div>
			</div>
			</c:if>
			<c:if test="${bpaAppointmentSchedule.purpose eq 'INSPECTION'}">
				<div class="panel-heading custom_form_panel_heading">
					<div class="panel-title">
					<spring:message code="lbl.existing.schedule.inspection" />
					</div>
				</div>
			</c:if>
				<jsp:include page="view-schedule-appiontment.jsp"></jsp:include>
			</div>
			<div class="panel panel-primary" data-collapsed="0">
				
				<c:if test="${bpaAppointmentSchedule.purpose eq 'DOCUMENTSCRUTINY'}">
				<div class="panel-heading custom_form_panel_heading">
					<div class="panel-title">
						<spring:message code="lbl.schedule.doc.scrutiny" />
					</div>
				</div>
			</c:if>
			<c:if test="${bpaAppointmentSchedule.purpose eq 'INSPECTION'}">
			<div class="panel-heading custom_form_panel_heading">
				<div class="panel-title">
					<spring:message code="lbl.schedule.field.ins" />
				</div>
			</div>
			</c:if>
				<jsp:include page="schedule-appiontment-form.jsp"></jsp:include>
			</div>
			<div class="text-center">
				<button type="submit" class='btn btn-primary' id="rescheduleSubmit">
					<spring:message code='lbl.reschedule' />
				</button>
				<a href='javascript:void(0)' class='btn btn-default'
					onclick='self.close()'><spring:message code='lbl.close' /></a>
			</div>
		</div>
	</div>
</form:form>
