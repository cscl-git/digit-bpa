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
<%@ page language="java"%>
<html>
<head>
<title><s:if test="%{showMode=='edit'}">
		<s:text name="userDefCode.modify" />
	</s:if> <s:if test="%{showMode=='view'}">
		<s:text name="userDefCode.view" />
	</s:if></title>
<script type="text/javascript">
						
	function disableControls(isDisable) {
		for ( var i = 0; i < document.userDefCodeForm.length; i++)
			document.userDefCodeForm.elements[i].disabled = isDisable;
		document.getElementById('Close').disabled = false;
	}	
	
	function onLoadTask() {
		var close = '<s:property value="close"/>';
		var isactive = '<s:property value="isactive"/>';
		var showMode = '<s:property value="showMode"/>';
		var clearVal = '<s:property value="clearValues"/>';
		var success = '<s:property value="success"/>';

		if (success == 'yes') {
			bootbox.alert("UserDefinedCodes Modified Successfully");
			} else if((success == 'no')){
				bootbox.alert("UserDefinedCodes Could Not be Modified");
				}
		
		if (close == 'true') {
			window.close();
		}
		
		if (isactive == 'true') {
			document.getElementById("isactive").checked="checked";
		}
		
		if (showMode == 'edit') {
			disableControls(false);
		} else {
			disableControls(true);
		}
		
		if (clearVal == 'true') {
			document.getElementById('code').value = "";
			document.getElementById('name').value = "";
			document.getElementById('narration').value = "";
			document.getElementById('accEntity.accountdetailtype.id').value = "";
			document.forms[0].isactive.checked=false;
		}
	}
	
	function validate(){
		if(document.getElementById('accEntity.accountdetailtype.id').value == "" 
				|| document.getElementById('accEntity.accountdetailtype.id').value=='---- Choose ----'){
			bootbox.alert("Please Select Sub Code For");
			return false;
		}
		if(document.getElementById('code').value == null || document.getElementById('code').value==''){
			bootbox.alert("Please enter Code");
			return false;
		}
		if(document.getElementById('name').value == null || document.getElementById('name').value==''){
			bootbox.alert("Please enter Name");
			return false;
		}
		return true;
	}

	function setClose() {
		var close = document.getElementById('close');    
		   close.value = true;
		   return true;
		}
</script>

</head>
<body onload="onLoadTask();">
	<div class="formmainbox">
		<div class="subheadnew">
			<s:if test="%{showMode=='edit'}">
				<s:text name="userDefCode.modify" />
			</s:if>
			<s:if test="%{showMode=='view'}">
				<s:text name="userDefCode.view" />
			</s:if>
		</div>
	</div>

	<div style="color: red">
		<s:actionmessage theme="simple" />
		<s:actionerror />
		<s:fielderror />
	</div>

	<s:form name="userDefCodeForm" action="userDefinedCodes" theme="simple">

		<s:push value="model">
			<s:hidden name="showMode" />
			<s:hidden name="id" />
			<%@include file="userDefinedCodes-form.jsp"%>
			<div class="buttonbottom">
				<s:if test="%{showMode=='edit'}">
					<s:submit name="edit" value="Modify And View" method="edit"
						cssClass="buttonsubmit" onclick="javascript: return validate();" />
					<s:submit name="edit" value="Modify And Close" method="edit"
						cssClass="buttonsubmit" onclick="validate();setClose();" />
					<s:hidden name="close" id="close" />
				</s:if>
				<input type="button" id="Close" value="Close"
					onclick="javascript:window.close()" class="button" />
			</div>
		</s:push>
		<s:token />
	</s:form>
</body>
</html>
