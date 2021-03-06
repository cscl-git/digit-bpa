/*
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2017>  eGovernments Foundation
 *
 *     The updated version of eGov suite of products as by eGovernments Foundation
 *     is available at http://www.egovernments.org
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see http://www.gnu.org/licenses/ or
 *     http://www.gnu.org/licenses/gpl.html .
 *
 *     In addition to the terms of the GPL license to be adhered to in using this
 *     program, the following additional terms are to be complied with:
 *
 *         1) All versions of this program, verbatim or modified must carry this
 *            Legal Notice.
 *
 *         2) Any misrepresentation of the origin of the material is prohibited. It
 *            is required that all modified versions of this material be marked in
 *            reasonable ways as different from the original version.
 *
 *         3) This license does not grant any rights to any user of the program
 *            with regards to rights under trademark law for use of the trade names
 *            or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */

$(document)
    .ready(
        function() {

            $('#btnSearch').click(function (e) {
                var isValid = false;
                $('#nocClearanceReport').find(':input',':select',':textarea').each(function() {
                    if($(this).val()) {
                        isValid =true;
                        return false;
                    } else
                        isValid =false;
                });
                if(isValid) {
                    callAjaxSearch();
                } else {
                    bootbox.alert($('#atleastOneInputReq').val());
                    return false;
                }
            });

            function callAjaxSearch() {
                $('.report-section').removeClass('display-hide');
                $("#nocClearanceTable")
                    .dataTable(
                        {
                            ajax : {
                                url : "/bpa/reports/nocclearance",
                                type : "POST",
                                beforeSend : function() {
                                    $('.loader-class')
                                        .modal(
                                            'show',
                                            {
                                                backdrop : 'static'
                                            });
                                },
                                "data" : getFormData($('form')),
                                complete : function() {
                                    $('.loader-class').modal(
                                        'hide');
                                }
                            },
                            "searching": false,
                            "bDestroy" : true,
                            "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
                            dom: "<'row'<'col-xs-4 pull-right'f>r>t<'row add-margin'<'col-md-3 col-xs-6'i><'col-md-2 col-xs-6'l>" +
                            "<'col-md-2 col-xs-6 text-left'B><'col-md-5 col-xs-6 text-right'p>>",
                            buttons: [{
                                extend: 'pdf',
                                title: 'Noc Clearance Report',
                                filename: 'noc_clearance_report',
                                orientation: 'landscape',
                                pageSize: 'A4',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }, {
                                extend: 'excel',
                                title: 'Noc Clearance Report',
                                filename: 'noc_clearance_report',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }, {
                                extend: 'print',
                                title: 'Noc Clearance Report',
                                filename: 'noc_clearance_report',
                                orientation: 'landscape',
                                pageSize: 'A4',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }],
                            aaSorting : [],
                            columns : [{
								"data" : null,
								render : function(data,
										type, row, meta) {
									return meta.row
											+ meta.settings._iDisplayStart
											+ 1;
								},
								"sClass" : "text-center"
							},
							{
								"data" : "nocDepartmentName",
								"sClass" : "text-left"
							},
							{
								"data" : "nocStatusName",
								"sClass" : "text-left"
							},
							{
								"data" : "nocApplicationNumber",
								"sClass" : "text-left"
							},
							{
								"data" : "permitApplicationNo",
								"sClass" : "text-left"
							},
							{
								"data" : "nocApplicationDate",
								"sClass" : "text-left"
							},
							{
								"data" : "statusUpdatedDate",
								"sClass" : "text-left"
							}]
                        });
            }
        });



function getFormData($form) {
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function(n, i) {
        indexed_array[n['name']] = n['value'];
    });

    return indexed_array;
}

