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

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/taglib/cdn.tld" prefix="cdn"%>

<div class="panel-heading toggle-header custom_form_panel_heading">
    <div class="panel-title">
        <spring:message code="lbl.inpn.chklst.dtl" />
    </div>
</div>
<div class="panel-body">


<c:choose>
	<c:when test="${!permitInspection.inspection.docket.isEmpty()}">
		<c:forEach var="doc" items="${permitInspection.inspection.docket}" varStatus="status1">
			<c:choose>
				<c:when test="${!doc.docketDetail.isEmpty()}">
					<div class="panel-heading custom_form_panel_heading">
					<form:hidden 
						id="inspection.docket[${status1.index}].checklistType.id" 
						path="inspection.docket[${status1.index}].checklistType"
						value="${doc.checklistType.id}" />
						<div class="panel-title"><c:out value="${doc.checklistType.description}" /></div>
					</div>
					<div class="form-group view-content header-color hidden-xs">
						<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
						<div class="col-sm-3 text-left">&nbsp;&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
						<div class="col-sm-4 text-left">
							<spring:message code="lbl.remarks" />
						</div>
					</div>
					<c:forEach var="docs" items="${doc.docketDetail}" varStatus="status">
						<div class="form-group">
							<div class="col-sm-5 add-margin check-text text-left">
								<c:out value="${docs.serviceChecklist.checklist.description}" />
								<form:hidden
									id="inspection.docket[${status1.index}].docketDetail[${status.index}].serviceChecklist.id"
									path="inspection.docket[${status1.index}].docketDetail[${status.index}].serviceChecklist"
									value="${docs.serviceChecklist.id}" />
								<form:hidden
									id="inspection.docket[${status1.index}].docketDetail[${status.index}].serviceChecklist.checklist.description"
									path="inspection.docket[${status1.index}].docketDetail[${status.index}].serviceChecklist.checklist.description"
									value="${docs.serviceChecklist.checklist.description}" />
							</div>
			
							<div class="col-sm-3 add-margin text-left"> 
			                    <c:choose>
			                        <c:when test="${mode =='editinsp'}">
			                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
			                               <!--  <div class="radio"> -->
			                                    <label>&nbsp;&nbsp;
			                                    <input type="radio" value="${inspnVal}"
			                                                  name="inspection.docket[${status1.index}].docketDetail[${status.index}].value"
			                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
			                                    </label>
			                               <!--  </div> -->
			                            </c:forEach>
			                        </c:when>
			                        <c:otherwise>
			                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
			                              <!--   <div class="radio"> -->
			                                    <label>&nbsp;&nbsp;
			                                    <input type="radio" value="${inspnVal}"
			                                                  name="inspection.docket[${status1.index}].docketDetail[${status.index}].value"
			                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
			                                    </label>
			                               <!--  </div> -->
			                            </c:forEach>
			                        </c:otherwise>
			                    </c:choose>
								<form:errors path="inspection.docket[${status1.index}].docketDetail[${status.index}].value"
											 cssClass="add-margin error-msg"/>
							</div>
							<div class="col-sm-4 add-margin text-left">
								<form:textarea class="form-control patternvalidation"
									data-pattern="alphanumericspecialcharacters" maxlength="255"
									id="inspection.docket[${status1.index}].docketDetail[${status.index}].remarks" rows="2"
									path="inspection.docket[${status1.index}].docketDetail[${status.index}].remarks" />
			
								<form:errors path="inspection.docket[${status1.index}].docketDetail[${status.index}].remarks"
									cssClass="add-margin error-msg" />
							</div>
						</div>
					</c:forEach>
				</c:when>
			</c:choose>
		</c:forEach>
	</c:when>
</c:choose>

<%-- 




<c:choose>
	<c:when test="${!docketDetailLocList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailLocList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailLocList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailLocList${status.index}serviceChecklist.id"
						path="inspection.docketDetailLocList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailLocList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailLocList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>

				<div class="col-sm-3 add-margin text-left"> 
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}"
                                                  name="inspection.docketDetailLocList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                              <!--   <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}"
                                                  name="inspection.docketDetailLocList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailLocList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailLocList${status.index}remarks" rows="2"
						path="inspection.docketDetailLocList[${status.index}].remarks" />

					<form:errors path="inspection.docketDetailLocList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailMeasurementList.isEmpty() }">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailMeasurementList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailMeasurementList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailMeasurementList${status.index}serviceChecklist"
						path="inspection.docketDetailMeasurementList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailMeasurementList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailMeasurementList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailMeasurementList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailMeasurementList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

					<form:errors path="inspection.docketDetailMeasurementList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailMeasurementList${status.index}remarks" rows="2"
						path="inspection.docketDetailMeasurementList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailMeasurementList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailAccessList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailAccessList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailAccessList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailAccessList${status.index}serviceChecklist"
						path="inspection.docketDetailAccessList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailAccessList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailAccessList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                             <!--    <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailAccessList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailAccessList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailAccessList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>

				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailAccessList${status.index}remarks" rows="2"
						path="inspection.docketDetailAccessList[${status.index}].remarks" />

					<form:errors path="inspection.docketDetailAccessList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>


<c:choose>
	<c:when test="${!docketDetailSurroundingPlotList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailSurroundingPlotList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailSurroundingPlotList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailSurroundingPlotList${status.index}serviceChecklist"
						path="inspection.docketDetailSurroundingPlotList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailSurroundingPlotList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailSurroundingPlotList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailSurroundingPlotList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                           <!--  <div class="radio"> -->
                                <label>&nbsp;&nbsp;
                                <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                              name="inspection.docketDetailSurroundingPlotList[${status.index}].value"
                                        <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                </label>
                           <!--  </div> -->
                        </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailSurroundingPlotList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailSurroundingPlotList${status.index}remarks" rows="2"
						path="inspection.docketDetailSurroundingPlotList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailSurroundingPlotList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>


<c:choose>
	<c:when test="${!docketDetailLandTypeList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailLandTypeList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailLandTypeList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailLandTypeList${status.index}serviceChecklist"
						path="inspection.docketDetailLandTypeList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailLandTypeList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailLandTypeList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailLandTypeList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailLandTypeList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailLandTypeList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailLandTypeList${status.index}remarks" rows="2"
						path="inspection.docketDetailLandTypeList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailLandTypeList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailProposedWorkList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailProposedWorkList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailProposedWorkList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailProposedWorkList${status.index}serviceChecklist"
						path="inspection.docketDetailProposedWorkList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailProposedWorkList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailProposedWorkList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailProposedWorkList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailProposedWorkList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailProposedWorkList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailProposedWorkList${status.index}remarks" rows="2"
						path="inspection.docketDetailProposedWorkList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailProposedWorkList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>


<c:choose>
	<c:when test="${!docketDetailWorkAsPerPlanList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailWorkAsPerPlanList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailWorkAsPerPlanList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailWorkAsPerPlanList${status.index}serviceChecklist"
						path="inspection.docketDetailWorkAsPerPlanList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailWorkAsPerPlanList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailWorkAsPerPlanList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailWorkAsPerPlanList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailWorkAsPerPlanList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailWorkAsPerPlanList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailWorkAsPerPlanList${status.index}remarks" rows="2"
						path="inspection.docketDetailWorkAsPerPlanList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailWorkAsPerPlanList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailHgtAbuttRoadList.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailHgtAbuttRoadList[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailHgtAbuttRoadList}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailHgtAbuttRoadList${status.index}serviceChecklist"
						path="inspection.docketDetailHgtAbuttRoadList[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailHgtAbuttRoadList${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailHgtAbuttRoadList[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailHgtAbuttRoadList[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                                <!-- </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailHgtAbuttRoadList[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailHgtAbuttRoadList[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailHgtAbuttRoadList${status.index}remarks" rows="2"
						path="inspection.docketDetailHgtAbuttRoadList[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailHgtAbuttRoadList[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailAreaLoc.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailAreaLoc[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left">&nbsp;&nbsp;<spring:message code="lbl.is.applicable" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailAreaLoc}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailAreaLoc${status.index}serviceChecklist"
						path="inspection.docketDetailAreaLoc[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailAreaLoc${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailAreaLoc[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailAreaLoc[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                              <!--   <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailAreaLoc[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailAreaLoc[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailAreaLoc${status.index}remarks" rows="2"
						path="inspection.docketDetailAreaLoc[${status.index}].remarks" />

					<form:errors
						path="inspection.docketDetailAreaLoc[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailLengthOfCompWall.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailLengthOfCompWall[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left"><spring:message code="lbl.value" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailLengthOfCompWall}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailLengthOfCompWall${status.index}serviceChecklist"
						path="inspection.docketDetailLengthOfCompWall[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailLengthOfCompWall${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailLengthOfCompWall[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                              <!--   <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailLengthOfCompWall[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;
                                    <input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailLengthOfCompWall[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailLengthOfCompWall[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailLengthOfCompWall${status.index}remarks" rows="2"
						path="inspection.docketDetailLengthOfCompWall[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailLengthOfCompWall[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailNumberOfWell.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailNumberOfWell[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left"><spring:message code="lbl.value" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailNumberOfWell}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailNumberOfWell${status.index}serviceChecklist"
						path="inspection.docketDetailNumberOfWell[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailNumberOfWell${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailNumberOfWell[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailNumberOfWell[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailNumberOfWell[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailNumberOfWell[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailNumberOfWell${status.index}remarks" rows="2"
						path="inspection.docketDetailNumberOfWell[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailNumberOfWell[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailShutter.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailShutter[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left"><spring:message code="lbl.value" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailShutter}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailShutter${status.index}serviceChecklist"
						path="inspection.docketDetailShutter[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailShutter${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailShutter[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailShutter[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                                <!-- </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                               <!--  <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailShutter[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailShutter[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphanumericspecialcharacters" maxlength="255"
						id="inspection.docketDetailShutter${status.index}remarks" rows="2"
						path="inspection.docketDetailShutter[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailShutter[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${!docketDetailRoofConversion.isEmpty()}">
		<div class="panel-heading custom_form_panel_heading">
			<div class="panel-title"><c:out value="${docketDetailRoofConversion[0].serviceChecklist.checklist.checklistType.description}" /></div>
		</div>
		<div class="form-group view-content header-color hidden-xs">
			<div class="col-sm-5 text-left"><spring:message code="lbl.files" /></div>
			<div class="col-sm-3 text-left"><spring:message code="lbl.value" /></div>
			<div class="col-sm-4 text-left">
				<spring:message code="lbl.remarks" />
			</div>
		</div>
		<c:forEach var="docs" items="${docketDetailRoofConversion}"
			varStatus="status">
			<div class="form-group">
				<div class="col-sm-5 add-margin check-text text-left">
					<c:out value="${docs.serviceChecklist.checklist.description}" />
					<form:hidden
						id="inspection.docketDetailRoofConversion${status.index}serviceChecklist"
						path="inspection.docketDetailRoofConversion[${status.index}].serviceChecklist"
						value="${docs.serviceChecklist.id}" />
					<form:hidden
						id="inspection.docketDetailRoofConversion${status.index}serviceChecklist.checklist.description"
						path="inspection.docketDetailRoofConversion[${status.index}].serviceChecklist.checklist.description"
						value="${docs.serviceChecklist.checklist.description}" />
				</div>
				<div class="col-sm-3 add-margin text-left">
                    <c:choose>
                        <c:when test="${mode =='editinsp'}">
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                             <!--    <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailRoofConversion[${status.index}].value"
                                            <c:if test="${inspnVal eq docs.value}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                              <!--   </div> -->
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${planScrutinyValues}" var="inspnVal">
                                <!-- <div class="radio"> -->
                                    <label>&nbsp;&nbsp;<input type="radio" value="${inspnVal}" class="radioBtnClass"
                                                  name="inspection.docketDetailRoofConversion[${status.index}].value"
                                            <c:if test="${inspnVal eq 'NOT_APPLICABLE'}"> checked="checked" </c:if> />&nbsp;${inspnVal.checkListVal}
                                    </label>
                               <!--  </div> -->
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
					<form:errors path="inspection.docketDetailRoofConversion[${status.index}].value"
								 cssClass="add-margin error-msg"/>
				</div>
				<div class="col-sm-4 add-margin text-left">
					<form:textarea class="form-control patternvalidation"
						data-pattern="alphabetspecialcharacters" maxlength="255"
						id="inspection.docketDetailRoofConversion${status.index}remarks" rows="2"
						path="inspection.docketDetailRoofConversion[${status.index}].remarks" />
					<form:errors
						path="inspection.docketDetailRoofConversion[${status.index}].remarks"
						cssClass="add-margin error-msg" />
				</div>
			</div>
		</c:forEach>
	</c:when>
</c:choose> --%>
<div class="form-group">
	<%--<label class="col-sm-3 control-label text-right"><spring:message
			code="lbl.dimensionofplot" /></label>
	<div class="col-sm-3 add-margin">
		<form:radiobutton path="inspection.boundaryDrawingSubmitted" value="true" checked="checked"/>
		<spring:message code="lbl.yes" />
		<form:radiobutton path="inspection.boundaryDrawingSubmitted" value="false" />
		<spring:message code="lbl.no" />
		<form:errors path="inspection.boundaryDrawingSubmitted"
			cssClass="add-margin error-msg" />
	</div>--%>
	<label class="col-sm-3 control-label text-right"><spring:message
			code="lbl.righttomake.construction" /></label>
	<div class="col-sm-3 add-margin">
		<form:radiobutton path="inspection.rightToMakeConstruction" value="true"
			checked="checked" />
		<spring:message code="lbl.yes" />
		<form:radiobutton path="inspection.rightToMakeConstruction" value="false" />
		<spring:message code="lbl.no" />
		<form:errors path="inspection.rightToMakeConstruction"
			cssClass="add-margin error-msg" />
	</div>
</div>

<div class="form-group">
	<%-- <label class="col-sm-3 control-label text-right"><spring:message
			code="lbl.typeofland" /></label>
	<div class="col-sm-3 add-margin">
		<form:input class="form-control patternvalidation" maxlength="120"
			data-pattern="alphanumeric" id="inspection.typeofLand" path="inspection.typeofLand" />
		<form:errors path="inspection.typeofLand" cssClass="add-margin error-msg" />
	</div> --%>
	<label class="col-sm-3 control-label text-right"><spring:message
			code="lbl.ins.remarks" /></label>
	<div class="col-sm-6 add-margin text-left">
		<form:textarea class="form-control patternvalidation"
			data-pattern="alphanumericspecialcharacters" maxlength="1000"
			id="inspection.inspectionRemarks" rows="3" path="inspection.inspectionRemarks" />

		<form:errors path="inspection.inspectionRemarks" cssClass="add-margin error-msg" />
	</div>
</div>
</div>

<script>
    jQuery(document).ready(function ($) {
        window.onunload = function () {
            window.opener.location.reload();
        };
    });
</script>