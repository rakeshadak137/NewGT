<%@ page contentType="text/html;charset=UTF-8" %>
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
            $("#bank").searchable();
            $("#cheque").searchable();
            $("#tabs").tabs();
        });

        //        $(function () {
        //            debugger;
        //            $("#tabs").tabs();
        //        });
        function BillAgainstLR($scope, $http) {
            $scope.accountList=[];
            $scope.itemList=[];
            $scope.vehicleList=[];
            $scope.bankList=[];
            init();

            function init() {
                $scope.date1 = "${new Date().format("yyyy-MM-dd")}";
                $scope.date2 = "${new Date().format("yyyy-MM-dd")}";
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
                $http.get("/${grailsApplication.config.erpName}/transactionReport/chequeList")
                        .success(function(data){
                            $scope.chequeList=data;
                        });

                $scope.bankList=${com.master.BankMaster.findAllByIsActive(true) as grails.converters.JSON}
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
                        <h5>VOUCHER REPORT</h5>
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div id="tabs">

                        <ul>
                            <li><a href="#tabs-1">Datewise</a></li>
                            <li><a href="#tabs-2">Bank Wise</a></li>
                            <li><a href="#tabs-3">Check No Wise</a></li>
                            <li><a href="#tabs-4">Party Wise</a></li>

                        </ul>


                        <div id="tabs-1">

                            <g:jasperForm controller="transactionReport"
                                          action="dateWiseVoucherReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                                <input type="date" id="date1"  style="width: 150px;" ng-model="date1"
                                       value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                <input type="date" id="date2"  style="width: 150px;" ng-model="date2"
                                       value="${Date.newInstance().format("yyyy-MM-dd")}" />

                                <input type="hidden" name="fdate" value="{{date1}}" />
                                <input type="hidden" name="tdate" value="{{date2}}" />

                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

                        </div>
                        <div id="tabs-2">
                            <g:jasperForm controller="transactionReport"
                                          action="bankwiseVoucherReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">
                                <table>
                                    <tr>
                                        <td>Party</td>
                                        <td>
                                            <select  id="bank" ng-model="bank" ng-options="r.id as r.bankName for r in bankList"></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        %{--<td>Product Name</td>--}%
                                        %{--<td>--}%
                                            %{--<select id="item" ng-model="item" ng-options="r.id as r.productName for r in itemList" ></select>--}%
                                        %{--</td>--}%
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="date"   style="width: 150px;" ng-model="date1"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                            <input type="date"   style="width: 150px;" ng-model="date2"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                        </td>
                                    </tr>
                                </table>

                                <input type="hidden" name="fdate" value="{{date1}}" />
                                <input type="hidden" name="tdate" value="{{date2}}" />
                                <input type="hidden" name="bank" value="{{bank}}" />
                            %{--<input type="hidden" name="id" value="${newId}">--}%
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

                        </div>
                        <div id="tabs-3">
                            <g:jasperForm controller="transactionReport"
                                          action="chequewiseVoucherReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">
                                <table>
                                    <tr>
                                        <td>Cheque No</td>
                                        <td>
                                            <select  id="cheque" ng-model="cheque" ng-options="r.chequeNo as r.chequeNo for r in chequeList" ></select>
                                        </td>
                                    </tr>
                                </table>

                                <input type="hidden" name="cheque" value="{{cheque}}" />
                            %{--<input type="hidden" name="id" value="${newId}">--}%
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

                        </div>
                        <div id="tabs-4">

                            <g:jasperForm controller="transactionReport"
                                          action="partywiseVoucherReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                                <table>
                                    <tr>
                                        <td>Paid To</td>
                                        <td>
                                            <select  id="party" ng-model="party" ng-options="r.payTo as r.payTo for r in chequeList" ></select>
                                        </td>
                                    </tr>

                                </table>
                                <input type="hidden" name="party" value="{{party}}" />
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

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