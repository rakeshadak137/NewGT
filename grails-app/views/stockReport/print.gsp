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
                        %{--<h5>LR REPORT</h5>--}%
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div id="tabs">

                        <ul>
                            <li><a href="#tabs-1">Stock Report</a></li>
                            %{--<li><a href="#tabs-2">Party Wise</a></li>--}%
                            %{--<li><a href="#tabs-4">Vehicle Wise</a></li>--}%

                        </ul>


                        <div id="tabs-1">

                            <g:jasperForm controller="stockReport"
                                          action="stockOutDatewise"
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