<%@ page import="com.master.DivisionMaster" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'Bill Related Report')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>


    <script>
        $(document).ready(function () {
            $("#party").searchable();
            $("#item").searchable();
            $("#vehicle").searchable();
            $("#tabs").tabs();
        });


        function BillAgainstLR($scope, $http) {
            $scope.accountList=[];
            $scope.itemList=[];
            $scope.vehicleList=[];
            init();

            function init() {
                $scope.date1 = "${new Date().format("yyyy-MM-dd")}";
                $scope.date2 = "${new Date().format("yyyy-MM-dd")}";
                $scope.goDownList = ${com.master.GodownMaster.findAllByIsActive(true) as grails.converters.JSON};
                $scope.divisionList = ${DivisionMaster.findAllByIsActive(true) as grails.converters.JSON};
                $http.get("/${grailsApplication.config.erpName}/transactionReport/accountList")
                        .success(function(data){
                            $scope.accountList=data;
                        });
                $http.get("/${grailsApplication.config.erpName}/transactionReport/itemList")
                        .success(function(data){
                            $scope.itemList=data;
                        });
                $http.get("/${grailsApplication.config.erpName}/transactionReport/vehicleList")
                        .success(function(data){
                            $scope.vehicleList=data;
                        });
            }
        }
    </script>
</head>

<body>
<div ng-app="">
    <%= newId %>
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
                            <li><a href="#tabs-1">Party Item Wise</a></li>
                            <li><a href="#tabs-2">Godown Wise</a></li>
                            <li><a href="#tabs-3">Division Wise</a></li>

                        </ul>


                        <div id="tabs-1">

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="From Party"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="fromParty" ng-options="p.id as p.accountName for p in accountList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>

                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="To Party"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="toParty" ng-options="p.id as p.accountName for p in accountList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="Product Code"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="itemName" ng-options="p.id as p.productCode for p in itemList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>

                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="Product Name"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="itemName" ng-options="p.id as p.productName for p in itemList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date1"  style="width: 150px;" ng-model="fromDate"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>

                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date2"  style="width: 150px;" ng-model="toDate"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action?scrid=${session['activeScreen'].id}&fromParty={{fromParty}}&toParty={{toParty}}&fromDate={{fromDate}}&toDate={{toDate}}&itemName={{itemName}}&format=PDF"
                                           class="btn btn-primary btn-mini">
                                            PDF</a>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action?scrid=${session['activeScreen'].id}&fromParty={{fromParty}}&toParty={{toParty}}&fromDate={{fromDate}}&toDate={{toDate}}&itemName={{itemName}}&format=XLSX"
                                           class="btn btn-primary btn-mini">
                                            EXCEL</a>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div id="tabs-2">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="Godown Name"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="godownName" ng-options="g.id as g.godownName for g in goDownList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date3"  style="width: 150px;" ng-model="fromDateg"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>

                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date4"  style="width: 150px;" ng-model="toDateg"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action1?scrid=${session['activeScreen'].id}&godownName={{godownName}}&fromDate={{fromDateg}}&toDate={{toDateg}}&format=PDF"
                                           class="btn btn-primary btn-mini">
                                            PDF</a>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action1?scrid=${session['activeScreen'].id}&godownName={{godownName}}&fromDate={{fromDateg}}&toDate={{toDateg}}&format=XLSX"
                                           class="btn btn-primary btn-mini">
                                            EXCEL</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="tabs-3">
                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="Division Name"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <select ng-model="divName" ng-options="d.id as d.divisionName for d in divisionList">
                                            <option value="">---Select One---</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="From Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date4"  style="width: 150px;" ng-model="fromDated"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>

                                    <div class="span2">
                                        <label for="quotationNo">
                                            <g:message code="quotationEntry.quotationNo.label" default="To Date"/>
                                        </label>
                                    </div>

                                    <div class="span3">
                                        <input type="date" id="date5"  style="width: 150px;" ng-model="toDated"
                                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                    </div>
                                </div>
                            </div>

                            <div class="row-fluid">
                                <div class="span12">
                                    <div class="span2">
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action2?scrid=${session['activeScreen'].id}&divName={{divName}}&fromDate={{fromDated}}&toDate={{toDated}}&format=PDF"
                                           class="btn btn-primary btn-mini">
                                            PDF</a>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a ng-href="/${grailsApplication.config.erpName}/stockReport/print_action2?scrid=${session['activeScreen'].id}&divName={{divName}}&fromDate={{fromDated}}&toDate={{toDated}}&format=XLSX"
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
</div>
</body>
</html>
</html>