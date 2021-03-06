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
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="panel-heading toggle-header custom_form_panel_heading">
	<div class="panel-title">
		<spring:message code="lbl.site.details" />
	</div>
	<div class="history-icon toggle-icon">
		<i class="fa fa-angle-up fa-2x"></i>
	</div>
</div>
<div class="panel-body display-hide ">

	<%-- <jsp:include page="view-amenities-details.jsp"></jsp:include> --%>

	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.re.survey" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].reSurveyNumber}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.nature.of.ownership" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].natureofOwnership}"
				default="N/A"></c:out>
		</div>
	</div>
	
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.khata.no" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].khataNumber}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.holding.no" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].holdingNumber}"
				default="N/A"></c:out>
		</div>
	</div>
	

	
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.nearest.build.no" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].nearestbuildingnumber}"
				default="N/A"></c:out>
		</div>
		<div class="doorNo">
			<div class="col-sm-3 add-margin">
				<spring:message code="lbl.addr.dno" />
			</div>
			<div class="col-sm-3 add-margin view-content text-justify">
				<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].plotdoornumber}"
					default="N/A"></c:out>
			</div>
		</div>
	</div>

	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.street.address1" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].streetaddress1}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.street.address2" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].streetaddress2}"
				default="N/A"></c:out>
		</div>
	</div>

	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.city" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].citytown}" default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.plot.no" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].mspPlotNumber}"
				default="N/A"></c:out>
		</div>
				
		
	</div>
	

	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.town.plan.zone" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].scheme.description}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.proposed.land.use" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].landUsage.description}"
				default="N/A"></c:out>
		</div>
	</div>
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.previousowner.details" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].previousownerdetails}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.landregistration.details" />
		</div>
		<div class="col-sm-3 add-margin view-content text-justify">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].landregistrationdetails}"
				default="N/A"></c:out>
		</div>
	</div>
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.charitable.trust" />
		</div>
		<div class="col-sm-3 add-margin view-content">
			<c:out value="${permitNocApplication.bpaApplication.siteDetail[0].charitableTrustBuilding ? 'YES' : 'NO'}"
				default="N/A"></c:out>
		</div>
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.affordable.scheme" />
		</div>
		<div class="col-sm-3 add-margin view-content">
			<c:out
				value="${permitNocApplication.bpaApplication.siteDetail[0].affordableHousingScheme ? 'YES' : 'NO'}"
				default="N/A"></c:out>
		</div>
	</div>
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.government.type" />
		</div>
		<div class="col-sm-3 add-margin view-content">
			<input type="hidden" id="governmentType"
				value="${permitNocApplication.bpaApplication.governmentType}">
			<c:out value="${permitNocApplication.bpaApplication.governmentType.governmentTypeVal}"
				default="N/A"></c:out>
		</div>
		<div id="isEconomicallyWeakerSec">
			<div class="col-sm-3 add-margin">
				<spring:message code="lbl.is.econ.weaker.sec" />
			</div>
			<div class="col-sm-3 add-margin view-content">
				<c:out
					value="${permitNocApplication.bpaApplication.isEconomicallyWeakerSection ? 'YES' : 'NO'}"
					default="N/A"></c:out>
			</div>
		</div>
	</div>
	
	<div class="row add-border">
		<div class="col-sm-3 add-margin">
			<spring:message code="lbl.annual.expenditure" />
		</div>
		<div class="col-sm-3 add-margin view-content">
			<input type="hidden" id="governmentType"
				value="${permitNocApplication.bpaApplication.constructionCost}">
			<c:out value="${permitNocApplication.bpaApplication.constructionCost}"
				default="N/A"></c:out>
		</div>
		<div id="isEconomicallyWeakerSec">
			<%-- <div class="col-sm-3 add-margin">
				<spring:message code="lbl.infrastructure.cost" />
			</div>
			<div class="col-sm-3 add-margin view-content">
				<c:out
					value="${permitNocApplication.bpaApplication.infrastructureCost}"
					default="N/A"></c:out>
			</div> --%>
		</div>
	</div>
</div>