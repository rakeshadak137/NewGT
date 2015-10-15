
<%@ page import="com.transaction.CashVoucher" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
    <script>
        function ListController($scope, $http) {
            init();

            function init() {
                $scope.currentPage = 0;
                $scope.pageSize = 10;
                $scope.DataList = [];

                $http.get("/${grailsApplication.config.erpName}/cashVoucher/getList")
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

        <div id="list-cashVoucher" class="content scaffold-list" role="main">
            <div class="table-header">
                <g:message code="default.list.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px" params="${[scrid:session['activeScreen'].id]}"
                        action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>
            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
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
                        %{--<g:sortableColumn property="voucherType" title="${message(code: 'cashVoucher.voucherType.label', default: 'Voucher Type')}"/>--}%
                        %{----}%
                        %{--<th><g:message code="cashVoucher.vehicleNo.label"--}%
                                       %{--default="Vehicle No"/></th>--}%
                        %{----}%
                        %{--<g:sortableColumn property="paymentType" title="${message(code: 'cashVoucher.paymentType.label', default: 'Payment Type')}"/>--}%
                        %{----}%
                        %{--<th><g:message code="cashVoucher.pumpName.label"--}%
                                       %{--default="Pump Name"/></th>--}%
                        %{----}%
                        %{--<g:sortableColumn property="dieselReceiptNo" title="${message(code: 'cashVoucher.dieselReceiptNo.label', default: 'Diesel Receipt No')}"/>--}%
                        %{----}%
                        %{--<g:sortableColumn property="dieselReceiptDate" title="${message(code: 'cashVoucher.dieselReceiptDate.label', default: 'Diesel Receipt Date')}"/>--}%
                        %{----}%
                    %{--</tr>--}%
                    %{--</thead>--}%
                    %{--<tbody>--}%
                    %{--<g:each in="${cashVoucherInstanceList}" status="i" var="cashVoucherInstance">--}%
                        %{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
                            %{--<g:form><td style="width: 50px;">--}%
                                %{--<g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>--}%
                                %{--<g:hiddenField name="id" value="${cashVoucherInstance?.id}"/>--}%
                                %{--<g:hiddenField name="version" value="${cashVoucherInstance?.version}"/>--}%
                                %{--<g:link action="edit" id="${cashVoucherInstance?.id}" params="${[scrid:session['activeScreen'].id]}">--}%
                                    %{--<i class="icon-pencil bigger-130"></i>--}%
                                %{--</g:link>   &nbsp;&nbsp;&nbsp;&nbsp;--}%
                                %{--<g:actionSubmitImage value="delete" action="delete"--}%
                                                     %{--src="${resource(dir: 'assets/avatars',file: 'delete1.png')}"--}%
                                                     %{--onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>--}%

                            %{--</td></g:form>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: cashVoucherInstance, field: "voucherType")}--}%
                            %{--</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: cashVoucherInstance, field: "vehicleNo")}</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: cashVoucherInstance, field: "paymentType")}</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: cashVoucherInstance, field: "pumpName")}</td>--}%
                            %{----}%
                            %{--<td>${fieldValue(bean: cashVoucherInstance, field: "dieselReceiptNo")}</td>--}%
                            %{----}%
                            %{--<td><g:formatDate date="${cashVoucherInstance.dieselReceiptDate}"/></td>--}%
                            %{----}%
                        %{--</tr>--}%
                    %{--</g:each>--}%
                    %{--</tbody>--}%
                %{--</table>--}%

                %{--<div class="pagination">--}%
                    %{--<g:paginate total="${cashVoucherInstanceTotal}"/>--}%
                %{--</div>--}%
            %{--</div>--}%
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
                    <th>Voucher Type</th>
                    <th>Amount</th>
                    <th>Bank Name</th>
                    <th>Cheque No</th>
                    <th>Pay To</th>
                    <th>Vehicle No</th>
                    <th>Description</th>
                    <th>Print</th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="r in DataList  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

                    <td style="width: 50px;">
                        <g:form action="delete" controller="cashVoucher"
                                style="padding: 0px; page-break-before: avoid; page-break-after: avoid; margin: 0px">

                            <g:hiddenField name="id" value="{{r.id}}"/>
                            <g:hiddenField name="version" value="{{r.version}}"/>
                            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                            <a ng-href="/${grailsApplication.config.erpName}/cashVoucher/show?id={{r.id}}&scrid=${session['activeScreen'].id}"><i
                                    class="icon-pencil bigger-130"></i></a>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <g:actionSubmitImage value="delete" action="delete"
                                                 src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"
                                                 onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </g:form>
                    </td>

                    <td>{{r.voucherNo}}</td>
                    <td>{{r.voucherDate}}</td>
                    <td>{{r.voucherType}}</td>
                    <td>{{r.amount}}</td>
                    <td>{{r.bankName}}</td>
                    <td>{{r.chequeNo}}</td>
                    <td>{{r.payTo}}</td>
                    <td>{{r.vehicleNo}}</td>
                    <td>{{r.description}}</td>

                    <td><a ng-href="/${grailsApplication.config.erpName}/cashVoucher/print_action?id={{r.id}}&scrid=${session['activeScreen'].id}"
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
            <h4 style="margin-bottom: 0px;margin-top: 0px;">Total Cash Vouchers : {{DataList.length}}</h4>
        </div>

    </div>
        </div>

    </div>
</div>
</div>
</body>
</html>
