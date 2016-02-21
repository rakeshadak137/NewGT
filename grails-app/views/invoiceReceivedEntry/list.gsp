<%@ page import="com.transaction.InvoiceReceivedEntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'invoiceReceivedEntry.label', default: 'InvoiceReceivedEntry')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

    <script>
        $(document).ready(function () {
            $("#party1").searchable();
            $("#party2").searchable();
        });

        function ListController($scope, $http) {
            $scope.accountList = [];
            $scope.vehicleList = [];
            init();

            function init() {
                $scope.currentPage = 0;
                $scope.pageSize = 10;
                $scope.DataList = [];

                $http.get("/${grailsApplication.config.erpName}/InvoiceReceivedEntry/getList")
                        .success(function (data) {
                            $scope.DataList = data;
                        });

                $http.get("/${grailsApplication.config.erpName}/transactionReport/accountList")
                        .success(function (data) {
                            $scope.accountList = data;
                        });

                $http.get("/${grailsApplication.config.erpName}/transactionReport/vehicleList")
                        .success(function (data) {
                            $scope.vehicleList = data;
                        });
            }

            $scope.numberOfPages = function () {
                return Math.ceil($scope.DataList.length / $scope.pageSize);
            };
        }
    </script>
</head>

<body>
<div ng-controller="ListController">
    <div class="main-content">
        <g:render template="/shared/viewHeader"/>
        <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">
            %{--<div class="row-fluid" style="margin-left:30px; width:95%">--}%
            %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%

            <div id="list-invoiceReceivedEntry" class="content scaffold-list" role="main">
                <div class="table-header">
                    <g:message code="default.list.label" args="[entityName]"/>
                    <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                            action="create" params="${[scrid: session['activeScreen'].id]}">
                        <i class="icon-pencil bigger-50"></i>New
                    </g:link>
                </div>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <br>

                <div class="well">
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
                                <input type="date" style="width: 150px;" ng-model="fromDate"
                                       value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                            </div>

                            <div class="span1"></div>

                            <div class="span1">
                                <label>To</label>
                            </div>

                            <div class="span4">
                                <input type="date" style="width: 150px;" ng-model="toDate"
                                       value="${Date.newInstance().format("yyyy-MM-dd")}"/>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid">
                        <div class="span12">
                            <div class="span2">
                                <a ng-href="/${grailsApplication.config.erpName}/invoiceReceivedEntry/dcReport?scrid=${session['activeScreen'].id}&fromDate={{fromDate}}&toDate={{toDate}}&fromParty={{fromParty}}&toParty={{toParty}}&format=PDF"
                                   class="btn btn-primary btn-mini" target="_blank">
                                    Print Report</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div role="grid" class="dataTables_wrapper" id="sample-table_wrapper">
                    <div class="dataTables_filter" id="sample-table-2_filter">
                        <label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2">
                        </label>
                    </div>

                    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
                           aria-describedby="sample-table-2_info">
                        <thead>
                        <tr>
                            <th>Action</th>
                            <th>SR No.</th>
                            <th>Receiced Date</th>
                            <th>Godown</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="r in DataList  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

                            <td style="width: 50px;">
                                <g:form action="delete" controller="InvoiceReceivedEntry"
                                        style="padding: 0px; page-break-before: avoid; page-break-after: avoid; margin: 0px">

                                    <g:hiddenField name="id" value="{{r.id}}"/>
                                    <g:hiddenField name="version" value="{{r.version}}"/>
                                    <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                    <a ng-href="/${grailsApplication.config.erpName}/InvoiceReceivedEntry/edit?id={{r.id}}&scrid=${session['activeScreen'].id}"><i
                                            class="icon-pencil bigger-130"></i></a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <g:actionSubmitImage value="delete" action="delete"
                                                         src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                                </g:form>
                            </td>

                            <td>{{r.srNo}}</td>

                            <td>{{r.date}}</td>

                            <td>{{r.goDown}}</td>

                        </tr>
                        </tbody>
                    </table>

                    <div align="center">
                        Page Size
                        <select ng-model="pageSize" id="pageSize">
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                        </select>

                        <button ng-disabled="currentPage == 0" ng-click="currentPage = currentPage - 1"
                                class="btn btn-inverse btn-minier">
                            Previous
                        </button>
                        {{currentPage + 1}}/{{numberOfPages()}}

                        <button ng-disabled="currentPage >= DataList.length/pageSize-1"
                                ng-click="currentPage = currentPage + 1" class="btn btn-inverse btn-minier">
                            Next
                        </button>
                    </div>
                </div>

                <div align="center" class="well">
                    <h4 style="margin-bottom: 0px;margin-top: 0px;">Total Received Entry : {{DataList.length}}</h4>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>
