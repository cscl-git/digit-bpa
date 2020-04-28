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

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>

<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message code="lbl.basic.info" />
	</div>
</div>
<div class="panel-body">
	<div class="form-group">
		<label class="col-sm-3 control-label text-right"><spring:message
				code="lbl.edcr.number" /> <span class="mandatory"></span></label>
		<div class="col-sm-3 add-margin">
			<form:input class="form-control patternvalidation resetValues"
				maxlength="20" id="ocEDcrNumber"
				placeholder="Enter plan scrutiny number" path="eDcrNumber"
				value="${occupancyCertificate.eDcrNumber}" required="required" />
		</div>
		<label class="col-sm-2 control-label text-right"><spring:message
				code="lbl.appln.date" /><span class="mandatory"></span> </label>
		<div class="col-sm-3 add-margin">
			<form:input path="applicationDate" class="form-control datepicker"
				data-date-end-date="0d" id="applicationDate"
				data-inputmask="'mask': 'd/m/y'" required="required" disabled="true" />
			<form:errors path="applicationDate" cssClass="add-margin error-msg" />
		</div>
	</div>

	<div class="form-group">
		<label class="col-sm-3 control-label text-right" id="ownpermitno"> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="planPermissionNumber"
				id="planPermissionNumber"
				class="form-control planPermissionNumber resetValues"
				value="${occupancyCertificate.parent.planPermissionNumber}"
				readonly="readonly">
		</div>
		<label class="col-sm-2 control-label text-right"><spring:message
				code="lbl.service.type" /> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="serviceTypeDesc" id="serviceTypeDesc"
				class="form-control resetValues serviceType" readonly="readonly"
				value="${occupancyCertificate.parent.serviceType.description}">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label text-right"><spring:message
				code="lbl.applicant.name" /> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="applicantName" id="applicantName"
				class="form-control applicantName resetValues"
				value="${occupancyCertificate.parent.owner.name}"
				readonly="readonly">
		</div>
		<label class="col-sm-2 control-label text-right"><spring:message
				code="lbl.occupancy.type" /> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="" id="occupancy"
				class="form-control occupancy resetValues"
				value="${occupancyCertificate.parent.occupanciesName}"
				readonly="readonly">
		</div>
	</div>	
	<div class="form-group">
		<%-- <label class="col-sm-3 control-label text-right"><spring:message
				code="lbl.re.survey.no" /> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="" id="resurveyNumber"
				class="form-control resurveyNumber resetValues"
				value="${occupancyCertificate.parent.siteDetail[0].reSurveyNumber}"
				readonly="readonly">
		</div> --%>
		<label class="col-sm-3 control-label text-right"><spring:message
				code="lbl.extentin.sqmts" /> </label>
		<div class="col-sm-3 add-margin">
			<input type="text" name="extentInSqmts" id="extentInSqmts"
				class="form-control extentInSqmts resetValues decimalfixed"
				value="${occupancyCertificate.extentInSqmts}"
				readonly="readonly">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label text-right"><spring:message
				code="lbl.work.commence.date" /><span class="mandatory"></span> </label>
		<div class="col-sm-3 add-margin">
			<form:input path="commencedDate" class="form-control datepicker"
				data-date-end-date="0d" id="commencedDate"
				data-inputmask="'mask': 'd/m/y'" required="required" />
			<form:errors path="commencedDate" cssClass="add-margin error-msg" />
		</div>
		<label class="col-sm-2 control-label text-right"><spring:message
				code="lbl.work.completion.date" /><span class="mandatory"></span> </label>
		<div class="col-sm-3 add-margin">
			<form:input path="completionDate" class="form-control datepicker"
				data-date-end-date="0d" id="completionDate"
				data-inputmask="'mask': 'd/m/y'" required="required" />
				<small class="view-content text-info">Make sure date of construction completion is appropriate</small>
			<form:errors path="completionDate" cssClass="add-margin error-msg" />
		</div>
	</div>
</div>
