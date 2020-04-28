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

<%@ include file="/includes/taglibs.jsp"%>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/finAccountsTable.js?rnd=${app_release_no}"></script>
<script type="text/javascript">
function onBodyLoad()
{
	document.getElementById("voucherApprovedDetails").style.display="none";
	document.getElementById("urlDetails").style.display = "none";
}

function EnableVoucherDetails(obj){
	if(obj.checked){
		document.getElementById("voucherApprovedDetails").style.display="";
		}
		else{
		document.getElementById("voucherApprovedDetails").style.display="none";
		}
}
</script>
<title> <s:text name="service.master.search.header"></s:text> </title>

</head>
<body onload="onBodyLoad();loadDropDownCodes();loadDropDownCodesFunction();loadGridOnValidationFail();">
<s:form theme="simple" name="serviceDetailsForm" action="serviceDetails-create.action" method="post">
<s:token />
<s:push value="model">
	
	<jsp:include page="serviceDetails-form.jsp"/>
	<div class="buttonbottom">
			<label>
				<s:submit type="submit" cssClass="buttonsubmit" id="button"
					value="Save" onClick = "return validate();"/>
			</label>&nbsp;
			
			<label>
				<input type="button" id="Close" value="Close" onclick="javascript:window.close()" class="buttonsubmit"/>
			</label>			
		</div>
</s:push>
</s:form>

</body>
</html>
