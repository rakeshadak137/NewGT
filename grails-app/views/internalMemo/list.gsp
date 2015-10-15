
<%@ page import="com.transaction.InternalMemo" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'internalMemo.label', default: 'InternalMemo')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>

    <script>
        function ListController($scope, $http) {
            init();

            function init() {
                $scope.currentPage = 0;
                $scope.pageSize = 10;
                $scope.DataList = [];

                $http.get("/${grailsApplication.config.erpName}/InternalMemo/getList")
                        .success(function (data) {
                            debugger;
                            $scope.DataList = data;
                            debugger;
                        });
            }

            $scope.numberOfPages = function () {
                return Math.ceil($scope.DataList.length / $scope.pageSize);
                debugger;
            };
        };
    </script>
</head>

<body>

<div ng-controller="ListController">
<div class="main-content">
    <g:render template="/shared/viewHeader"/>
    <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">
        %{--<div class="row-fluid" style="margin-left:30px; width:95%">--}%
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%

        <div id="list-internalMemo" class="content scaffold-list" role="main">
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
                <div class="row-fluid">
                    <div class="dataTables_filter" id="sample-table-2_filter">
                        <label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2"></label>
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
                            <th>Vehicle No.</th>
                            <th>Total Trip Rate</th>
                            <th>Print</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="r in DataList  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

                            <td style="width: 50px;">
                                <g:form action="delete" controller="internalMemo"
                                        style="padding: 0px; page-break-before: avoid; page-break-after: avoid; margin: 0px">

                                    <g:hiddenField name="id" value="{{r.id}}"/>
                                    <g:hiddenField name="version" value="{{r.version}}"/>
                                    <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                    <a ng-href="/${grailsApplication.config.erpName}/internalMemo/show?id={{r.id}}&scrid=${session['activeScreen'].id}"><i
                                            class="icon-pencil bigger-130"></i></a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <g:actionSubmitImage value="delete" action="delete"
                                                         src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                                </g:form>
                            </td>

                            <td>{{r.voucherNo}}</td>

                            <td>{{r.voucherDate}}</td>

                            <td>{{r.vehicleNo}}</td>

                            <td>{{r.tripRate}}</td>

                            <td><a ng-href="/${grailsApplication.config.erpName}/InternalMemo/print_action?id={{r.id}}&scrid=${session['activeScreen'].id}"
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
                    <h4 style="margin-bottom: 0px;margin-top: 0px;">Total Internal Memo : {{DataList.length}}</h4>
                </div>

            </div>
        </div>

    </div>
</div>
</div>
</body>
</html>
