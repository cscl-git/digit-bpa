<%--
  ~ eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
  ~ accountability and the service delivery of the government  organizations.
  ~
  ~  Copyright (C) <2017>  eGovernments Foundation
  ~
  ~  The updated version of eGov suite of products as by eGovernments Foundation
  ~  is available at http://www.egovernments.org
  ~
  ~  This program is free software: you can redistribute it and/or modify
  ~  it under the terms of the GNU General Public License as published by
  ~  the Free Software Foundation, either version 3 of the License, or
  ~  any later version.
  ~
  ~  This program is distributed in the hope that it will be useful,
  ~  but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~  GNU General Public License for more details.
  ~
  ~  You should have received a copy of the GNU General Public License
  ~  along with this program. If not, see http://www.gnu.org/licenses/ or
  ~  http://www.gnu.org/licenses/gpl.html .
  ~
  ~  In addition to the terms of the GPL license to be adhered to in using this
  ~  program, the following additional terms are to be complied with:
  ~
  ~      1) All versions of this program, verbatim or modified must carry this
  ~         Legal Notice.
  ~ 	Further, all user interfaces, including but not limited to citizen facing interfaces,
  ~         Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
  ~         derived works should carry eGovernments Foundation logo on the top right corner.
  ~
  ~ 	For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
  ~ 	For any further queries on attribution, including queries on brand guidelines,
  ~         please contact contact@egovernments.org
  ~
  ~      2) Any misrepresentation of the origin of the material is prohibited. It
  ~         is required that all modified versions of this material be marked in
  ~         reasonable ways as different from the original version.
  ~
  ~      3) This license does not grant any rights to any user of the program
  ~         with regards to rights under trademark law for use of the trade names
  ~         or trademarks of eGovernments Foundation.
  ~
  ~  In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
  --%>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="panel-heading toggle-header custom_form_panel_heading">
	<div class="panel-title">
		<spring:message code="lbl.rejection.reasons" />
	</div>
	<div class="history-icon toggle-icon">
		<i class="fa fa-angle-up fa-2x"></i>
	</div>
</div>
<div class="panel-body rejectionReason display-hide">
	<table class="table table-bordered  multiheadertbl"
		   id="bpaRejectionResaons">
		<thead>
		<tr>
			<th><spring:message code="lbl.srl.no" /></th>
			<th><spring:message code="lbl.select" /></th>
			<th><spring:message code="lbl.description" /></th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${not empty occupancyCertificate.rejectionReasonsTemp}">
				<c:forEach var="rejectionReason" items="${occupancyCertificate.rejectionReasonsTemp}" varStatus="rejectPCStatus">
					<tr>
						<td class="text-center">
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].oc" value="${occupancyCertificate.id}" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.checklistServicetype" value="${rejectionReason.noticeCondition.checklistServicetype.id}" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.type" value="OCREJECTIONREASONS" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.orderNumber" value="${rejectPCStatus.index+1}" />
						<c:out value="${rejectPCStatus.index+1}"></c:out>
						</td>
						<c:choose>
							<c:when test="${rejectionReason.noticeCondition.required}">
								<td class="text-center"><input type="checkbox" data-change-to="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.required"
								                               name="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.required" class="rejectionReasons" checked="checked" value="${rejectionReason.noticeCondition.required}" /></td>
							</c:when>
							<c:otherwise>
								<td class="text-center"><input type="checkbox" data-change-to="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.required"
															   name="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.required" class="rejectionReasons" value="${rejectionReason.noticeCondition.required}" /></td>
							</c:otherwise>
						</c:choose>
						<td class="view-content" style="font-size: 105%;">
						<c:out value="${rejectionReason.noticeCondition.checklistServicetype.checklist.description}"></c:out></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach var="rejectionReason" items="${rejectionReasons}" varStatus="rejectPCStatus">
					<tr>
						<td class="text-center">
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].oc" value="${occupancyCertificate.id}" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.checklistServicetype" value="${rejectionReason.id}" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.type" value="OCREJECTIONREASONS" />
						<form:hidden path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.orderNumber" value="${rejectPCStatus.index+1}" />
						<c:out value="${rejectPCStatus.index+1}"></c:out></td>
						<td class="text-center"><form:checkbox path="rejectionReasonsTemp[${rejectPCStatus.index}].noticeCondition.required"
								class="rejectionReasons" /></td>
						<td class="view-content" style="font-size: 105%;"><c:out value="${rejectionReason.checklist.description}"></c:out></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<div class="panel-heading">
		<div class="panel-title">
			<spring:message code="lbl.addnl.reject.reasons" />
		</div>
	</div>
	<table class="table table-bordered  multiheadertbl"
		   id="bpaAdditionalRejectionReasons">
		<thead>
		<tr>
			<th><spring:message code="lbl.srl.no" /></th>
			<th><spring:message code="lbl.select" /></th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when
					test="${not empty occupancyCertificate.additionalRejectReasonsTemp}">
				<c:forEach var="addnlPermitCondition" items="${occupancyCertificate.additionalRejectReasonsTemp}"
						   varStatus="addnlPCStatus">
					<tr>
						<td class="text-center">
						<form:hidden path="additionalRejectReasonsTemp[${addnlPCStatus.index}].oc" value="${occupancyCertificate.id}" />
							<form:hidden id="additionalPermitCondition" path="additionalRejectReasonsTemp[${addnlPCStatus.index}].noticeCondition.checklistServicetype"
							value="${addnlPermitCondition.noticeCondition.checklistServicetype.id}"/>
							<form:hidden path="additionalRejectReasonsTemp[${addnlPCStatus.index}].noticeCondition.type" value="ADDITIONALREJECTIONREASONS" />
							<form:hidden class="serialNo" path="additionalRejectReasonsTemp[${addnlPCStatus.index}].noticeCondition.orderNumber" value="${addnlPermitCondition.noticeCondition.orderNumber}" />
							<c:out value="${addnlPCStatus.index+1}"></c:out></td>
						<td><form:textarea path="additionalRejectReasonsTemp[${addnlPCStatus.index}].noticeCondition.additionalCondition"
								rows="2" maxlength="500" data-pattern="alphanumericspecialcharacters"
								class="form-control patternvalidation additionalPermitCondition" value=""></form:textarea></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
			<c:forEach var="addnlRejectionReason" items="${additionalRejectionReasons}">
				<tr>
					<td class="text-center">
					<form:hidden path="additionalRejectReasonsTemp[0].oc" value="${occupancyCertificate.id}" />
					<form:hidden id="additionalPermitCondition" path="additionalRejectReasonsTemp[0].noticeCondition.checklistServicetype" value="${addnlRejectionReason.id}" />
					<form:hidden path="additionalRejectReasonsTemp[0].noticeCondition.type" value="ADDITIONALREJECTIONREASONS" />
					<form:hidden class="serialNo" path="additionalRejectReasonsTemp[0].noticeCondition.orderNumber" value="1" />
						1</td>
					<td><form:textarea path="additionalRejectReasonsTemp[0].noticeCondition.additionalCondition" rows="2" maxlength="500" data-pattern="alphanumericspecialcharacters"
							class="form-control patternvalidation additionalPermitCondition" value=""></form:textarea></td>
				</tr>
			</c:forEach>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<div class="text-right add-padding">
		<button type="button" class="btn btn-sm btn-primary"
				id="addAddnlRejectRow">Add Additional Reason</button>
	</div>
</div>