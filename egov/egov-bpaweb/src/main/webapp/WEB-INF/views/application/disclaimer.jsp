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
<%@page import="org.python.modules.jarray"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>

<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message code="lbl.disclaimer" />
	</div>
</div>
<div class="panel-body">
	<div class="form-group">
		<c:choose>
			<c:when test="${isCitizen}">
				<!-- for citizen user login -->
				<div class="col-sm-9 col-sm-offset-2 text-justify">
					<div class="checkbox view-content">
						<form:checkbox path="citizenAccepted" id="citizenAccepted" />
						<span class="mandatory"></span>&nbsp;<spring:message code="lbl.ack.accpt" />
						<ul style="list-style-type: none; padding-left: 10px">
							<li></li> 
							<li><spring:message code="bpa.registration.citizen.declaration" /></li>
						</ul>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<!-- for business user login -->
				<div class="col-sm-9 col-sm-offset-2 text-justify">
					<div class="checkbox view-content">
						<form:checkbox path="architectAccepted" id="architectAccepted" />
						<span class="mandatory"></span>&nbsp;<spring:message code="lbl.ack.accpt" />
						<ul style="list-style-type: none; padding-left: 10px">
							<li></li> 
							<li><spring:message code="lbl.accepted" /></li>
							<li><spring:message code="lbl.accpeted1" /></li>   
						</ul>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>