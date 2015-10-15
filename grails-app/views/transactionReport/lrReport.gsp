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
                        <h5>LR REPORT</h5>
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div id="tabs">

                        <ul>
                            <li><a href="#tabs-1">Datewise</a></li>
                            <li><a href="#tabs-2">Party Wise</a></li>
                            %{--<li><a href="#tabs-3">Item Wise</a></li>--}%
                            <li><a href="#tabs-4">Vehicle Wise</a></li>

                        </ul>


                        <div id="tabs-1">

                            <g:jasperForm controller="transactionReport"
                                          action="datewiseLRreport"
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
                                          action="partywiseLRreport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">
                                <table>
                                    <tr>
                                        <td>Party</td>
                                        <td><select  id="party" ng-model="party" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Product Name</td>
                                        <td><select id="item" ng-model="item" ng-options="r.id as r.productName for r in itemList" ></select>
                                        </td>
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
                                <input type="hidden" name="party" value="{{party}}" />
                                <input type="hidden" name="item" value="{{item}}" />
                                %{--<input type="hidden" name="id" value="${newId}">--}%
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

                        </div>


                        <div id="tabs-4">

                            <g:jasperForm controller="transactionReport"
                                          action="vehiclewiseLRreport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                                <table>
                                    <tr>
                                        <td>Vehicle No</td>
                                        <td><select id="vehicle" ng-model="vehicle" ng-options="r.id as r.state+'-'+r.rto+' '+r.series+' '+r.vehicleNo for r in vehicleList"></select>
                                        </td>
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
                                <input type="hidden" name="vehicle" value="{{vehicle}}" />
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