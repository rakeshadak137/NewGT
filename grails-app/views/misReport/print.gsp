<%--
  Created by IntelliJ IDEA.
  User: Bhavesh
  Date: 11/4/2015
  Time: 9:36 AM
--%>

<%@ page import="com.master.DivisionMaster" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'MIS Report')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>


    <script>
        $(document).ready(function () {
            $("#party").searchable();
            $("#party2").searchable();
            $("#party3").searchable();
            $("#party4").searchable();
            $("#vehicle").searchable();
            $("#tabs").tabs();
        });


        function BillAgainstLR($scope, $http) {
            $scope.accountList = [];
            $scope.itemList = [];
            $scope.vehicleList = [];
            init();

            function init() {
                $scope.date1 = "${new Date().format("yyyy-MM-dd")}";
                $scope.date2 = "${new Date().format("yyyy-MM-dd")}";

                $http.get("/${grailsApplication.config.erpName}/transactionReport/accountList")
                        .success(function (data) {
                            $scope.accountList = data;
                        });

                $http.get("/${grailsApplication.config.erpName}/transactionReport/vehicleList")
                        .success(function (data) {
                            $scope.vehicleList = data;
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
    %{--<h5>LR REPORT</h5>--}%
</div>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div id="tabs">

    <ul>
        <li><a href="#tabs-1">Date Wise Report</a></li>
        <li><a href="#tabs-2">Party Wise Report</a></li>
        <li><a href="#tabs-3">Vehicle Wise Report</a></li>

    </ul>


    <div id="tabs-1">

        <div class="row-fluid">
            <div class="span12">
                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date1" style="width: 150px;" ng-model="fromDate"
                               ng-change="showMemoData()"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>

                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date2" style="width: 150px;" ng-model="toDate" ng-change="showMemoData()"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="span2">
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action?scrid=${session['activeScreen'].id}&fromDate={{fromDate}}&toDate={{toDate}}&format=PDF"
                       class="btn btn-primary btn-mini" target="_blank">
                        PDF</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action?scrid=${session['activeScreen'].id}&fromDate={{fromDate}}&toDate={{toDate}}&format=XLSX"
                       class="btn btn-primary btn-mini">
                        EXCEL</a>
                </div>
            </div>
        </div>

    </div>

    <div id="tabs-2">
        <div class="row-fluid">
            <div class="span12">
                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="From Party"/>
                        </label>
                    </div>

                    <div class="span8">
                        <select ng-model="fromParty1" ng-options="p.id as p.accountName for p in accountList"
                                id="party3">
                            %{--<option value="">---Select One---</option>--}%
                        </select>
                    </div>
                </div>

                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="To Party"/>
                        </label>
                    </div>

                    <div class="span8">
                        <select ng-model="toParty1" ng-options="p.id as p.accountName for p in accountList" id="party4">
                            %{--<option value="">---Select One---</option>--}%
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date3" style="width: 150px;" ng-model="fromDateg"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>

                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date4" style="width: 150px;" ng-model="toDateg"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="span2">
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action1?scrid=${session['activeScreen'].id}&fromParty={{fromParty1}}&toParty={{toParty1}}&fromDate={{fromDateg}}&toDate={{toDateg}}&format=PDF"
                       class="btn btn-primary btn-mini" target="_blank">
                        PDF</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action1?scrid=${session['activeScreen'].id}&fromParty={{fromParty1}}&toParty={{toParty1}}&fromDate={{fromDateg}}&toDate={{toDateg}}&format=XLSX"
                       class="btn btn-primary btn-mini">
                        EXCEL</a>
                </div>
            </div>
        </div>
    </div>

    <div id="tabs-3">
        <div class="row-fluid">
            <div class="span12">
                <span class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="Vehicle No."/>
                        </label>
                    </div>

                    <div class="span8">
                        <select ng-model="vehicleNo" ng-options="r.id as r.state+'-'+r.rto+' '+r.series+' '+r.vehicleNo for r in vehicleList" id="vehicle">
                            %{--<option value="">---Select One---</option>--}%
                        </select>
                    </div>
                </span>

                <div class="span6"></div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date5" style="width: 150px;" ng-model="fromDatev"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>

                <div class="span6">
                    <div class="span4">
                        <label for="quotationNo">
                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                        </label>
                    </div>

                    <div class="span8">
                        <input type="date" id="date6" style="width: 150px;" ng-model="toDatev"
                               value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row-fluid">
            <div class="span12">
                <div class="span2">
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action2?scrid=${session['activeScreen'].id}&vNo={{vehicleNo}}&fromDate={{fromDatev}}&toDate={{toDatev}}&format=PDF"
                       class="btn btn-primary btn-mini" target="_blank">
                        PDF</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a ng-href="/${grailsApplication.config.erpName}/misReport/print_action2?scrid=${session['activeScreen'].id}&vNo={{vehicleNo}}&fromDate={{fromDatev}}&toDate={{toDatev}}&format=XLSX"
                       class="btn btn-primary btn-mini">
                        EXCEL</a>
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