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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="panel-heading">
	<div class="panel-title"><spring:message code="lbl.lp.raised.details" /></div>
</div>

<div class="panel-body custom">
	<table class="table table-bordered  multiheadertbl" id="vacantLandTable">
		<thead>
		<tr>
			<th><spring:message code="lbl.slno"/></th>
			<th><spring:message code="lbl.lp.no"/></th>
			<th><spring:message code="lbl.lp.date"/></th>
			<th><spring:message code="lbl.lp.reason"/></th>
			<th><spring:message code="lbl.lp.sentdate"/></th>
			<th><spring:message code="lbl.modify"/></th>
			<th><spring:message code="lbl.lpprint"/></th>
			<th><spring:message code="lbl.lpreplydate"/></th>
			<th><spring:message code="lbl.lpreply"/></th>
			<th><spring:message code="lbl.lpreply.print"/></th>
			<th><spring:message code="lbl.action"/></th>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${not empty lettertopartylist}">
				<c:forEach items="${lettertopartylist}" var="renewal" varStatus="status">
					<tr id="lprow">
						<td align="center" class="view-content" style="font-size: 90%;">${status.index+1}</td>
						<td align="center" class="view-content" style="font-size: 90%;"><span class="bold">
							<c:out value="${renewal.letterToParty.lpNumber}"/></span></td>
						<td align="center" class="view-content" style="font-size: 90%;"><span class="bold">
							<fmt:formatDate value="${renewal.letterToParty.letterDate}" pattern="dd/MM/yyyy" var="letterDate"/>
								<c:out value="${letterDate}"/></span></td>
						<td class="view-content" style="font-size: 90%;"><span class="bold"> <c:forEach
								items="${renewal.letterToParty.lpReason}" var="lpReason" varStatus="status">
							<c:out value="${lpReason.description}"/>
							<c:if test="${!status.last}">,</c:if>
						</c:forEach>
							</span></td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<c:choose>
								<c:when test="${renewal.letterToParty.sentDate !=null }">
									<fmt:formatDate value="${renewal.letterToParty.sentDate}" pattern="dd/MM/yyyy" var="sentDate"/>
									<c:out value="${sentDate}"></c:out>
								</c:when>
								<c:otherwise>
									<a style="cursor: pointer; font-size: 12px;" href="/bpa/permitrenewal/lettertoparty/capturesentdate/${renewal.id}">
										<i class="fa fa-edit" aria-hidden="true"></i>
										<spring:message code="lbl.save.lpsentdate"/>
									</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<c:choose>
								<c:when test="${renewal.letterToParty.sentDate !=null }">
									LP Sent
								</c:when>
								<c:otherwise>
									<a style="cursor: pointer; font-size: 12px;"  href="/bpa/permitrenewal/lettertoparty/update/${bpaApplication.applicationNumber}">
										<i class="fa fa-edit" aria-hidden="true"></i> Modify
									</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<a style="cursor: pointer; font-size: 12px;" class="open-popup" href="/bpa/permitrenewal/lettertoparty/lettertopartyprint/lp?pathVar=${renewal.id}">
								<i class="fa fa-print" aria-hidden="true"></i>
								<spring:message code="lbl.print"/>
							</a>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<c:if test="${renewal.letterToParty.sentDate !=null }">
								<fmt:formatDate value="${renewal.letterToParty.replyDate}" pattern="dd/MM/yyyy" var="replyDate"/>
								<c:out value="${replyDate eq null ? 'N/A' : replyDate}"></c:out>
							</c:if>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<c:choose>
								<c:when test="${renewal.letterToParty.replyDate !=null }">
									LP Reply Received
								</c:when>
								<c:otherwise>
									<a style="cursor: pointer; font-size: 12px;" href="/bpa/permitrenewal/lettertoparty/lettertopartyreply/${renewal.id}">
										<i class="fa fa-reply" aria-hidden="true"></i> LP Reply
									</a>
								</c:otherwise>
							</c:choose>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;">
							<a style="cursor: pointer; font-size: 12px;" class="open-popup" href="/bpa/permitrenewal/lettertoparty/lettertopartyprint/lpreply?pathVar=${renewal.id}">
								<i class="fa fa-print" aria-hidden="true"></i>
								<spring:message code="lbl.print"/>
							</a>
						</td>
						<td align="center" class="view-content" style="font-size: 90%;"><a style="cursor: pointer; font-size: 14px;"
								onclick="window.open('/bpa/permitrenewal/lettertoparty/viewdetails/lpreply/${renewal.id}','view','width=600, height=400,scrollbars=yes')">
							<i class="fa fa-eye" aria-hidden="true"> <spring:message
									code="lbl.view"/></i>
						</a></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="col-md-12 col-xs-6  panel-title">
					<spring:message code="lbl.no.lp"/>
				</div>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	<input type="hidden" id="lpReplyDateGreaterThanPartySentDate" value="<spring:message code='msg.validate.lpreplydate.greaterthan.party.sentdate'/>"/>
<input type="hidden" id="updateLpSentDate" value="<spring:message code='msg.validate.update.lpsent.date'/>"/>
<input type="hidden" id="partSentDateGreaterThanLpDate" value="<spring:message code='msg.validate.party.sentdate.greaterthan.lpdate'/>"/>
</div>
<script
		src="<cdn:url value='/resources/js/app/lettertoparty/permitrenewal-ltp-helper.js?rnd=${app_release_no}'/> "></script>

