<%--
  Created by IntelliJ IDEA.
  User: Bhavesh
  Date: 05/01/2016
  Time: 9:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'Invoice Report')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>


    <script>
        $(document).ready(function () {
            $("#party").searchable();
            $("#party2").searchable();
            $("#party3").searchable();
            $("#party4").searchable();
            $("#vehicle").searchable();
            $("#goDown").searchable();
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
                $scope.godownList = ${com.master.GodownMaster.findAllByIsActive(true) as grails.converters.JSON};

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
    <li><a href="#tabs-1">Invoice Received</a></li>
    <li><a href="#tabs-2">Invoice Receoved Godownwise</a></li>
    <li><a href="#tabs-3">Invoice Not Received</a></li>

</ul>

    <div id="tabs-1">


        <g:jasperForm controller="transactionReport"
                      action="LRReceivedReport"
                      jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

            <table>
                <tr>
                    <td> From Party</td>
                    <td><select  id="party1" ng-model="fromPartyLRR" ng-options="r.id as r.accountName for r in accountList" ></select>
                    </td>
                    <td></td>
                    <td> To Party</td>
                    <td><select  id="party2" ng-model="toPartyLRR" ng-options="r.id as r.accountName for r in accountList" ></select>
                    </td>
                </tr>

                <tr>
                    <td>Vehicle No</td>
                    <td><select id="vehicle1" ng-model="vehicleLRR" ng-options="r.id as r.state+'-'+r.rto+' '+r.series+' '+r.vehicleNo for r in vehicleList"></select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="date"   style="width: 150px;" ng-model="fromDateLRR"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                        <input type="date"   style="width: 150px;" ng-model="toDateLRR"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                    </td>
                </tr>
            </table>
            <a ng-href="/${grailsApplication.config.erpName}/invoiceReport/invoiceReceivedReport?scrid=${session['activeScreen'].id}&fromParty={{fromPartyLRR}}&toParty={{toPartyLRR}}&fromDate={{fromDateLRR}}&toDate={{toDateLRR}}&vNo={{vehicleLRR}}&format=PDF"
               class="btn btn-primary btn-mini" target="_blank">
                Print Report</a>

        </g:jasperForm>


    </div>

    <div id="tabs-2">

        <g:jasperForm controller="transactionReport"
                      action="LRReceivedReport"
                      jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

            <table>
                <tr>
                    <td>Godown</td>
                    <td>
                        <select id="goDown" name="goDown" ng-model="goDown"
                                ng-options="g.id as g.godownName for g in godownList">
                            <option value="">---Select One---</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <input type="date"   style="width: 150px;" ng-model="fromDateLRRG"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                        <input type="date"   style="width: 150px;" ng-model="toDateLRRG"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                    </td>
                </tr>
            </table>
            <a ng-href="/${grailsApplication.config.erpName}/invoiceReport/invoiceReceivedGodownwiseReport?scrid=${session['activeScreen'].id}&goDown={{goDown}}&fromDate={{fromDateLRRG}}&toDate={{toDateLRRG}}&format=PDF"
               class="btn btn-primary btn-mini" target="_blank">
                Print Report</a>

        </g:jasperForm>

    </div>

    <div id="tabs-3">
        <g:jasperForm controller="transactionReport"
                      action="LRReceivedReport"
                      jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

            <table>
                <tr>
                    <td> From Party</td>
                    <td><select  id="party3" ng-model="fromPartyLRNR" ng-options="r.id as r.accountName for r in accountList" ></select>
                    </td>
                    <td></td>
                    <td> To Party</td>
                    <td><select  id="party4" ng-model="toPartyLRNR" ng-options="r.id as r.accountName for r in accountList" ></select>
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <input type="date"   style="width: 150px;" ng-model="fromDateLRNR"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                        <input type="date"   style="width: 150px;" ng-model="toDateLRNR"
                               value="${Date.newInstance().format("yyyy-MM-dd")}" />
                    </td>
                </tr>
            </table>
            <a ng-href="/${grailsApplication.config.erpName}/invoiceReport/invoiceNotReceivedReport?scrid=${session['activeScreen'].id}&fromParty={{fromPartyLRNR}}&toParty={{toPartyLRNR}}&fromDate={{fromDateLRNR}}&toDate={{toDateLRNR}}&format=PDF"
               class="btn btn-primary btn-mini" target="_blank">
                Print Report</a>

        </g:jasperForm>

    </div>


</div>

</div>
</div>
</div>
</div>
</div>
</body>
</html>