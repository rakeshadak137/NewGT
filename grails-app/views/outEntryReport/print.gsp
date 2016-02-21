<%--
  Created by IntelliJ IDEA.
  User: Bhavesh
  Date: 30/01/2016
  Time: 3:11 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(default: 'Out Entry Report')}"/>
    <title>Out Entry Report</title>


    <script>
        $(document).ready(function () {
            $("#party1").searchable();
            $("#party2").searchable();
            $("#vehicle").searchable();
            $("#tabs").tabs();
        });

        function BillAgainstLR($scope, $http) {
            $scope.accountList = [];
            $scope.vehicleList = [];
            init();

            function init() {
                $http.get("/${grailsApplication.config.erpName}/transactionReport/accountList")
                        .success(function (data) {
                            $scope.accountList = data;
                        });

                $http.get("/${grailsApplication.config.erpName}/transactionReport/vehicleListForOutEntry")
                        .success(function (data) {
                            if(data){
                                $.each(data, function(index) {
                                    var html = '<option value = "' + data[index] + '">' + data[index] +'</option>';
                                    $('#vehicle').append(html);
                                })
                            }
                        });
            }
        }
    </script>
</head>

<body>
<div ng-app="">
    <%=newId%>
    <div ng-controller="BillAgainstLR">

        <div class="main-content">

            <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">

                <div id="list-examSchedule" class="content scaffold-list" role="main">

                    <div class="table-header">
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div id="tabs">

                        <ul>
                            <li><a href="#tabs-1">Date wise Report</a></li>
                            <li><a href="#tabs-2">Party wise Report</a></li>
                            <li><a href="#tabs-3">Vehicle wise Report</a></li>

                        </ul>

                        <div id="tabs-1">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span1">
                                        <label>From</label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" style="width: 150px;" ng-model="fromDate"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>

                                    <div class="span1">
                                        <label>To</label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" style="width: 150px;" ng-model="toDate"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/outEntryReport/allInOtEntryReport?scrid=${session['activeScreen'].id}&fromDate={{fromDate}}&toDate={{toDate}}&format=PDF"
                                           class="btn btn-primary btn-mini" target="_blank">
                                            Print Report</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="tabs-2">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span1">
                                        <label>From</label>
                                    </div>

                                    <div class="span4">
                                        <select id="party1" ng-model="fromParty"
                                                ng-options="r.id as r.accountName for r in accountList"></select>
                                    </div>

                                    <div class="span1"></div>

                                    <div class="span1">
                                        <label>To</label>
                                    </div>

                                    <div class="span4">
                                        <select id="party2" ng-model="toParty"
                                                ng-options="r.id as r.accountName for r in accountList"></select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span1">
                                        <label>From</label>
                                    </div>

                                    <div class="span4">
                                        <input type="date" style="width: 150px;" ng-model="fromDatep"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>

                                    <div class="span1"></div>

                                    <div class="span1">
                                        <label>To</label>
                                    </div>

                                    <div class="span4">
                                        <input type="date" style="width: 150px;" ng-model="toDatep"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/outEntryReport/allInOtEntryReport?scrid=${session['activeScreen'].id}&fromDate={{fromDatep}}&toDate={{toDatep}}&fromParty={{fromParty}}&toParty={{toParty}}&format=PDF"
                                           class="btn btn-primary btn-mini" target="_blank">
                                            Print Report</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="tabs-3">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span1">
                                        <label>Vehicle</label>
                                    </div>

                                    <div class="span4">
                                        <select id="vehicle" ng-model="vehicleNo"></select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span1">
                                        <label>From</label>
                                    </div>

                                    <div class="span4">
                                        <input type="date" style="width: 150px;" ng-model="fromDatev"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>

                                    <div class="span1"></div>

                                    <div class="span1">
                                        <label>To</label>
                                    </div>

                                    <div class="span4">
                                        <input type="date" style="width: 150px;" ng-model="toDatev"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/outEntryReport/allInOtEntryReport?scrid=${session['activeScreen'].id}&fromDate={{fromDatev}}&toDate={{toDatev}}&vNo={{vehicleNo}}&format=PDF"
                                           class="btn btn-primary btn-mini" target="_blank">
                                            Print Report</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>