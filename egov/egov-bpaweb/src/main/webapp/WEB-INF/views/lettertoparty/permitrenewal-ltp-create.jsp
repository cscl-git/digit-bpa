<%--
  ~ eGov suite of products aim to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) <2017>  eGovernments Foundation
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
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<form:form role="form" action="/bpa/permitrenewal/lettertoparty/create/${permitRenewal.applicationNumber}" method="post"
		   modelAttribute="permitRenewalLetterToParty" id="lettertoPartyform"
		   cssClass="form-horizontal form-groups-bordered"
		   enctype="multipart/form-data">
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-primary" data-collapsed="0">
				<%-- <jsp:include page="../application/viewapplication-details.jsp"></jsp:include> --%>
						<div class="panel-heading custom_form_panel_heading">
							<div class="panel-title">
								<spring:message code="lbl.permit.renewal" />
							</div>
						</div>
						<div class="form-group">

							<div class="col-sm-3 control-label text-right">
								<spring:message code="lbl.application.number" />
							</div>
							<div class="col-sm-3 add-margin view-content text-justify">
								<c:out
									value="${permitRenewalLetterToParty.permitRenewal.applicationNumber}"
									default="N/A"></c:out>
							</div>
							<div class="col-sm-3 control-label text-right">
								<spring:message code="lbl.appln.date" />
							</div>
							<fmt:formatDate
								value="${permitRenewalLetterToParty.permitRenewal.applicationDate}"
								pattern="dd/MM/yyyy" var="applicationDate" />
							<div class="col-sm-3 add-margin view-content text-justify">
								<c:out value="${applicationDate}" default="N/A"></c:out>
							</div>
						</div>
						<div class="form-group">

							<div class="col-sm-3 control-label text-right">
								<spring:message code="lbl.status" />
							</div>
							<div class="col-sm-3 add-margin view-content text-justify">
								<c:out
									value="${permitRenewalLetterToParty.permitRenewal.status.code}"
									default="N/A"></c:out>
							</div>
							
							
						</div>
				<div class="panel-heading custom_form_panel_heading">
					<div class="panel-title">
						<spring:message code="lbl.lp.details"/>
					</div>
				</div>
				<div class="panel-body">
					<div class="row add-border">
					<form:hidden path="permitRenewal.id" id="permitRenewalId"
										 value="${permitRenewal.id}"/>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right"><spring:message
									code="lbl.lpreason"/><span class="mandatory"></span> </label>
							<div class="col-sm-3 add-margin">
								<form:select path="letterToParty.lpReason" data-first-option="false"
											 id="lpReason" cssClass="form-control tick-indicator" multiple="true"
											 required="required">
									<form:options items="${lpReasonList}" itemValue="id"
												  itemLabel="description"/>
								</form:select>
								<form:errors path="letterToParty.lpReason" cssClass="error-msg"/>
							</div>

							<label class="col-sm-2 control-label text-right"><spring:message
									code="lbl.lpdescription"/><span class="mandatory"></span></label>
							<div class="col-sm-3 add-margin">
								<form:textarea path="letterToParty.lpDesc"
											   class="form-control patternvalidation"
											   data-pattern="alphanumericspecialcharacters"
											   maxlength="1016" rows="5" id="lpDesc" required="required"/>
								<form:errors path="letterToParty.lpDesc" cssClass="error-msg"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right"><spring:message
									code="lbl.lastreplydate"/></label>
							<div class="col-sm-3 add-margin">
								<form:input path="letterToParty.lastReplyDate" class="form-control datepicker"
											data-date-start-date="0d" id="lastReplyDate"
											data-inputmask="'mask': 'd/m/y'"/>
								<form:errors path="letterToParty.lastReplyDate"
											 cssClass="add-margin error-msg"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="panel panel-primary" data-collapsed="0">
				<div class="panel-body">
					<c:choose>
						<c:when test="${!checkListDetailList.isEmpty()}">
							<div class="panel-heading custom_form_panel_heading">
								<div class="panel-title">
									<spring:message code="lbl.encloseddocuments"/>
									-
									<spring:message code="lbl.checklist"/>
								</div>
							</div>
							<div class="form-group view-content header-color hidden-xs">
								<div class="col-sm-3">
									<spring:message code="lbl.documentname"/>
								</div>
								<div class="col-sm-3">
									<spring:message code="lbl.isrequested"/>
								</div>
								<div class="col-sm-5">
									<spring:message code="lbl.remarks"/>
								</div>
							</div>
							<c:forEach var="docs" items="${checkListDetailList}"
									   varStatus="status">
								<div class="form-group">
									<div class="col-sm-3 add-margin check-text">
										<c:out value="${docs.checklist.description}"></c:out>
										<c:if test="${docs.mandatory}">
											<span class="mandatory"></span>
										</c:if>
										<form:hidden
												id="letterToParty.letterToPartyDocuments${status.index}serviceChecklist.id"
												path="letterToParty.letterToPartyDocuments[${status.index}].serviceChecklist"
												value="${docs.id}"/>
										<form:hidden
												id="letterToParty.letterToPartyDocuments${status.index}serviceChecklist"
												path="letterToParty.letterToPartyDocuments[${status.index}].serviceChecklist.mandatory"
												value="${docs.mandatory}"/>
										<form:hidden
												id="letterToParty.letterToPartyDocuments${status.index}serviceChecklist.checklist.description"
												path="letterToParty.letterToPartyDocuments[${status.index}].serviceChecklist.checklist.description"
												value="${docs.checklist.description}"/>
									</div>

									<div class="col-sm-3 add-margin">
										<form:checkbox
												id="letterToParty.letterToPartyDocuments${status.index}isrequested"
												path="letterToParty.letterToPartyDocuments[${status.index}].isRequested"
												class="requested"/>
									</div>

									<div class="col-sm-5 add-margin">

										<form:textarea class="form-control patternvalidation"
													   data-pattern="alphanumericspecialcharacters" maxlength="248"
													   id="letterToParty.letterToPartyDocuments${status.index}remarks" rows="3"
													   path="letterToParty.letterToPartyDocuments[${status.index}].remarks"/>
										<form:errors
												path="letterToParty.letterToPartyDocuments[${status.index}].remarks"
												cssClass="add-margin error-msg"/>
									</div>
								</div>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div class="text-center">
		<button type='submit' class='btn btn-primary' id="buttonCreateSubmit">
			<spring:message code='lbl.create'/>
		</button>
		<a href='javascript:void(0)' class='btn btn-default'
		   onclick='self.close()'><spring:message code='lbl.close'/></a>
	</div>
</form:form>
<input type="hidden" id="lpReplyDateGreaterThanPartySentDate" value="<spring:message code='msg.validate.lpreplydate.greaterthan.party.sentdate'/>"/>
<input type="hidden" id="updateLpSentDate" value="<spring:message code='msg.validate.update.lpsent.date'/>"/>
<input type="hidden" id="partSentDateGreaterThanLpDate" value="<spring:message code='msg.validate.party.sentdate.greaterthan.lpdate'/>"/>

<link rel="stylesheet" href="<c:url value='/resources/css/bpa-style.css?rnd=${app_release_no}'/>">
<script
		src="<cdn:url value='/resources/global/js/bts/bts-datepicker.js' context='/egi'/>"></script>
<link rel="stylesheet"
	  href="<cdn:url value='/resources/global/css/bts/bts-datepicker.css' context='/egi'/>">
<script
		src="<cdn:url value='/resources/global/js/jq/plugins/datatables/moment.min.js' context='/egi'/>"></script>
<script
		src="<cdn:url value='/resources/js/app/lettertoparty.js?rnd=${app_release_no}'/> "></script>
