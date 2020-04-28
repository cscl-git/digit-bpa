<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/includes/taglibs.jsp"%>
<form:form role="form" action="search" modelAttribute="nocDepartment"
	id="nocDepartmentsearchform"
	cssClass="form-horizontal form-groups-bordered"
	enctype="multipart/form-data">
	<div class="main-content">
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-primary" data-collapsed="0">
					<div class="panel-heading">
						<div class="panel-title">SearchNocDepartment</div>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-3 control-label text-right"><spring:message
									code="lbl.code" /> </label>
							<div class="col-sm-3 add-margin">
								<form:input path="code"
									class="form-control text-left patternvalidation"
									data-pattern="alphanumeric" maxlength="20" />
								<form:errors path="code" cssClass="error-msg" />
							</div>
							<label class="col-sm-3 control-label text-right"><spring:message
									code="lbl.name" /> </label>
							<div class="col-sm-3 add-margin">
								<form:input path="name"
									class="form-control text-left patternvalidation"
									data-pattern="alphanumeric" maxlength="124" />
								<form:errors path="name" cssClass="error-msg" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label text-right"><spring:message
									code="lbl.isactive" /> </label>
							<div class="col-sm-3 add-margin">
								<form:checkbox path="isActive" />
								<form:errors path="isActive" cssClass="error-msg" />
							</div>
							<input type="hidden" id="mode" name="mode" value="${mode}" />
							<div class="form-group">
								<div class="text-center">
									<button type='button' class='btn btn-primary' id="btnsearch">
										<spring:message code='lbl.search' />
									</button>
									<a href='javascript:void(0)' class='btn btn-default'
										onclick='self.close()'><spring:message code='lbl.close' /></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</form:form>
<div class="row display-hide report-section">
	<div class="col-md-12 table-header text-left">NocDepartment
		Search Result</div>
	<div class="col-md-12 form-group report-table-container">
		<table class="table table-bordered table-hover multiheadertbl"
			id="resultTable">
			<thead>
				<tr>
					<th><spring:message code="lbl.code" /></th>
					<th><spring:message code="lbl.name" /></th>
					<th><spring:message code="lbl.isactive" /></th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script> 
$('#btnsearch').click(function(e){
 if($('form').valid()){
 }else{
 e.preventDefault();
 }  });
</script>
<link rel="stylesheet"
	href="<c:url value='/resources/global/css/font-icons/entypo/css/entypo.css' context='/egi'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/global/css/bts/bts-datepicker.css' context='/egi'/>" />
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/datatables/jq.dataTables.min.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/datatables/dataTables.bts.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/datatables/dataTables.tableTools.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/datatables/TableTools.min.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/datatables/jq.dataTables.columnFilter.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/bts/typeahead.bundle.js' context='/egi'/>"></script>
<script
	src="<c:url value='/resources/global/js/jq/plugins/jq.inputmask.bundle.min.js' context='/egi'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/global/js/jq/plugins/jq.validate.min.js' context='/egi'/>"></script>
<script
	src="<c:url value='/resources/global/js/bts/bts-datepicker.js' context='/egi'/>"
	type="text/javascript"></script>
<script type="text/javascript"
	src="<c:url value='/resources/app/js/nocDepartmentHelper.js'/>"></script>
