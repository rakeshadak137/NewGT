
<%@ page import="com.transaction.LocalTripEntry" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'localTripEntry.label', default: 'LocalTripEntry')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <script>

        $(document).ready(function () {
            $("#fromCustomer").searchable();
            $("#toCustomer").searchable();
        });
        function localController($scope,$http){
            init();
            function init() {
                $scope.currentPage = 0;
                $scope.pageSize = 10;
                $scope.DataList = [];
                $scope.date1 = "${new Date().format("yyyy-MM-dd")}";
                $scope.date2 = "${new Date().format("yyyy-MM-dd")}";

                $scope.customerList = ${com.master.AccountMaster.findAllByIsActive(true) as grails.converters.JSON};

                $http.get("/${grailsApplication.config.erpName}/localTripEntry/getList")
                        .success(function (data) {
                            debugger;
                            $scope.DataList = data;
                            debugger;
                        });


            }

            $scope.getSearchData = function () {
                var fDate = document.getElementById("date1").value;
                var tDate = document.getElementById("date2").value;
                $scope.DataList = [];
                $http.get("/${grailsApplication.config.erpName}/localTripEntry/getSearchList?fDate=" + $scope.date1 + "&tDate=" + $scope.date2 + "&fid=" + $scope.fromCustomer + "&tid=" + $scope.toCustomer)
                        .success(function (data) {
                            debugger;
                            $scope.DataList = data;
                            debugger;
                        });
            };


            $scope.numberOfPages = function () {
                return Math.ceil($scope.DataList.length / $scope.pageSize);
                debugger;
            };
        }
    </script>
</head>

<body>
<div ng-controller="localController">
<div class="main-content">
    <g:render template="/shared/viewHeader"/>
    <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">
        %{--<div class="row-fluid" style="margin-left:30px; width:95%">--}%
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%

        <div id="list-localTripEntry" class="content scaffold-list" role="main">
            <div class="table-header">
                <g:message code="default.list.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create" params="${[scrid:session['activeScreen'].id]}">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>
            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

    <div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">
        %{--<div class="row-fluid">--}%
            %{--<div class="dataTables_filter" id="sample-table-2_filter">--}%
                %{--<label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2"></label>--}%
            %{--</div>--}%
        %{--</div>--}%

        <div class="row-fluid">
            <div class="span4">
                <select id="fromCustomer" class="input-mini" ng-model="fromCustomer"
                        ng-options="c.id as c.accountName for c in customerList"></select>
            </div>

            <div class="span4">
                <select id="toCustomer" ng-model="toCustomer"
                        ng-options="c.id as c.accountName for c in customerList"></select>
            </div>

            <div class="span4">
                <div class="dataTables_filter" id="sample-table-2_filter">
                    <label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2">
                    </label>
                </div>
            </div>

        </div>

        <div class="row-fluid">
            <div class="span7">
                <input type="date" id="date1" ng-model="date1" style="width: 150px;"
                       value="${Date.newInstance().format("yyyy-MM-dd")}">
                <input type="date" id="date2" ng-model="date2" style="width: 150px;"
                       value="${Date.newInstance().format("yyyy-MM-dd")}">
                <input type="button" class="btn-minier btn-inverse" value="Search LR"
                       ng-click="getSearchData()">
                <a ng-href="/${grailsApplication.config.erpName}/LREntry/exportData?fDate={{date1}}&tDate={{date2}}&fid={{fromCustomer}}&tid={{toCustomer}}&scrid=${session['activeScreen'].id}"
                   class="btn btn-minier btn-inverse">Export To Excel</a>
            </div>
        </div>

        <div role="grid" class="dataTables_wrapper" id="sample-table_wrapper">

            <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
                   aria-describedby="sample-table-2_info">
                <thead>
                <tr>
                    <th>Action</th>
                    <th>Voucher No.</th>
                    <th>Voucher Date</th>
                    <th>From Customer</th>
                    <th>To Cutomer</th>
                    <th>Godown</th>
                    <th>Vehicle No</th>
                    <th>Local Out Time</th>
                    <th>Print</th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="r in DataList  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

                    <td style="width: 50px;">
                        <g:form action="delete" controller="outEntry"
                                style="padding: 0px; page-break-before: avoid; page-break-after: avoid; margin: 0px">

                            <g:hiddenField name="id" value="{{r.id}}"/>
                            <g:hiddenField name="version" value="{{r.version}}"/>
                            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                            <a ng-href="/${grailsApplication.config.erpName}/localTripEntry/show?id={{r.id}}&scrid=${session['activeScreen'].id}"><i
                                    class="icon-pencil bigger-130"></i></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <g:actionSubmitImage value="delete" action="delete"
                                                 src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </g:form>
                    </td>

                    <td>{{r.entryNo}}</td>

                    <td>{{r.entryDate}}</td>

                    <td>{{r.fromCustomer}}</td>

                    <td>{{r.toCustomer}}</td>

                    <td>{{r.godown}}</td>

                    <td>{{r.vehicleNo}}</td>

                    <td>{{r.outTime}}</td>

                    <td><a ng-href="/${grailsApplication.config.erpName}/localTripEntry/print_action?id={{r.id}}&scrid=${session['activeScreen'].id}"
                           target="_blank">Print</a></td>

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
            <h4 style="margin-bottom: 0px;margin-top: 0px;">Total Out Entries : {{DataList.length}}</h4>
        </div>

    </div>
            %{--<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">--}%
                %{--<div class="row-fluid">--}%
                    %{--<div class="span6">--}%
                        %{--<div id="sample-table-2_length" class="dataTables_length">--}%
                            %{--<label>Display <select name="sample-table-2_length" size="1" aria-controls="sample-table-2">--}%
                                %{--<option value="10" selected="selected">10</option><option value="25">25</option>--}%
                                %{--<option value="50">50</option><option value="100">100</option>--}%
                            %{--</select> records</label>--}%
                        %{--</div>--}%
                    %{--</div>--}%

                    %{--<div class="span6">--}%
                        %{--<div class="dataTables_filter" id="sample-table-2_filter">--}%
                            %{--<label>Search: <input type="text" aria-controls="sample-table-2"></label>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
                %{--<table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"--}%
                       %{--aria-describedby="sample-table-2_info">--}%

                    %{--<thead>--}%
                    %{--<tr>--}%
                        %{--<th>Action</th>--}%
                        %{----}%
                        %{--<g:sortableColumn property="localOutEntryNo" title="${message(code: 'localTripEntry.localOutEntryNo.label', default: 'Local Out Entry No')}"/>--}%
                        %{----}%
                        %{--<g:sortableColumn property="localOutEntryDate" title="${message(code: 'localTripEntry.localOutEntryDate.label', default: 'Local Out Entry Date')}"/>--}%
                        %{----}%
                        %{--<th><g:message code="localTripEntry.fromCustomer.label"--}%
                                       %{--default="From Customer"/></th>--}%
                        %{----}%
                        %{--<th><g:message code="localTripEntry.toCustomer.label"--}%
                                       %{--default="To Customer"/></th>--}%
                        %{----}%
                        %{--<th><g:message code="localTripEntry.godown.label"--}%
                                       %{--default="Godown"/></th>--}%
                        %{----}%
                        %{--<g:sortableColumn property="localOutTime" title="${message(code: 'localTripEntry.localOutTime.label', default: 'Local Out Time')}"/>--}%
                        %{----}%
                    %{--</tr>--}%
                    %{--</thead>--}%
                    %{--<tbody>--}%
                    %{--<g:each in="${localTripEntryInstanceList}" status="i" var="localTripEntryInstance">--}%
                        %{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
                            %{--<g:form><td style="width: 50px;">--}%

                                %{--<g:hiddenField name="id" value="${localTripEntryInstance?.id}"/>--}%
                                %{--<g:hiddenField name="version" value="${localTripEntryInstance?.version}"/>--}%
                                %{--<g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>--}%
                                %{--<g:link action="edit" id="${localTripEntryInstance?.id}" params="${[scrid:session['activeScreen'].id]}">--}%
                                    %{--<i class="icon-pencil bigger-130"></i>--}%
                                %{--</g:link>   &nbsp;&nbsp;&nbsp;&nbsp;--}%
                                %{--<g:actionSubmitImage value="delete" action="delete"--}%
                                                     %{--src="${resource(dir: 'assets/avatars',file: 'delete1.png')}"--}%
                                                     %{--onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>--}%

                            %{--</td></g:form>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: localTripEntryInstance, field: "localOutEntryNo")}--}%
                            %{--</td>--}%
                            %{----}%
                            %{--<td><g:formatDate date="${localTripEntryInstance.localOutEntryDate}"/></td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: localTripEntryInstance, field: "fromCustomer")}</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: localTripEntryInstance, field: "toCustomer")}</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: localTripEntryInstance, field: "godown")}</td>--}%

                            %{--<td>${fieldValue(bean: localTripEntryInstance, field: "localOutTime")}</td>--}%

                            %{--<td><g:formatDate date="${localTripEntryInstance.localOutTime}"/></td>--}%
                            %{----}%
                        %{--</tr>--}%
                    %{--</g:each>--}%
                    %{--</tbody>--}%
                %{--</table>--}%

                %{--<div class="pagination">--}%
                    %{--<g:paginate total="${localTripEntryInstanceTotal}"/>--}%
                %{--</div>--}%
            %{--</div>--}%
        </div>

    </div>
</div>
%{--</div>--}%
</body>
</div>
</html>
