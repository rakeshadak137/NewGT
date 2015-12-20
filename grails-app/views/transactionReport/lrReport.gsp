<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'Bill Related Report')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>


    <script>
        $(document).ready(function () {
            $("#party").searchable();
            $("#party2").searchable();
            $("#party1").searchable();
            $("#party3").searchable();
            $("#party4").searchable();
            $("#party5").searchable();
            $("#party6").searchable();
            $("#party7").searchable();
            $("#party8").searchable();
            $("#party9").searchable();
            $("#item").searchable();
            $("#vehicle").searchable();
            $("#vehicle1").searchable();
            $("#goDown").searchable();
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
                $scope.godownList = ${com.master.GodownMaster.findAllByIsActive(true) as grails.converters.JSON};
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
                            <li><a href="#tabs-3">Vehicle Wise</a></li>
                            <li><a href="#tabs-4">Issued Bills</a></li>
                            <li><a href="#tabs-5">Pending Bills</a></li>
                            <li><a href="#tabs-6">LR Received</a></li>
                            <li><a href="#tabs-7">LR Received Godownwise</a></li>
                            <li><a href="#tabs-8">LR Not Received</a></li>

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
                                        <td> From Party</td>
                                        <td><select  id="party" ng-model="party" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                        <td></td>
                                        <td> To Party</td>
                                        <td><select  id="party2" ng-model="toParty" ng-options="r.id as r.accountName for r in accountList" ></select>
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
                                <input type="hidden" name="toParty" value="{{toParty}}" />
                                <input type="hidden" name="item" value="{{item}}" />
                                %{--<input type="hidden" name="id" value="${newId}">--}%
                                <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                                <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-primary btn-mini"
                                                text="Print Report"/>

                            </g:jasperForm>

                        </div>


                        <div id="tabs-3">

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

                        <div id="tabs-4">


                            <g:jasperForm controller="transactionReport"
                                          action="billIssuedReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                                <table>
                                    <tr>
                                        <td> From Party</td>
                                        <td><select  id="party1" ng-model="fromParty1" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                        <td></td>
                                        <td> To Party</td>
                                        <td><select  id="party3" ng-model="toParty1" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="date"   style="width: 150px;" ng-model="fromDate"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                            <input type="date"   style="width: 150px;" ng-model="toDate"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" name="fromDate" value="{{fromDate}}" />
                                <input type="hidden" name="toDate" value="{{toDate}}" />
                                <input type="hidden" name="fromParty" value="{{fromParty1}}" />
                                <input type="hidden" name="toParty" value="{{toParty1}}" />
                                %{--<g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>--}%
                                <a ng-href="/${grailsApplication.config.erpName}/transactionReport/billIssuedReport?scrid=${session['activeScreen'].id}&fromParty={{fromParty1}}&toParty={{toParty1}}&fromDate={{fromDate}}&toDate={{toDate}}&format=PDF"
                                   class="btn btn-primary btn-mini" target="_blank">
                                    Print Report</a>

                            </g:jasperForm>


                        </div>

                        <div id="tabs-5">


                            <g:jasperForm controller="transactionReport"
                                          action="billPendingReport"
                                          jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                                <table>
                                    <tr>
                                        <td> From Party</td>
                                        <td><select  id="party4" ng-model="fromParty4" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                        <td></td>
                                        <td> To Party</td>
                                        <td><select  id="party5" ng-model="toParty5" ng-options="r.id as r.accountName for r in accountList" ></select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="date"   style="width: 150px;" ng-model="fromDate4"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                            <input type="date"   style="width: 150px;" ng-model="toDate5"
                                                   value="${Date.newInstance().format("yyyy-MM-dd")}" />
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" name="fromDate" value="{{fromDate4}}" />
                                <input type="hidden" name="toDate" value="{{toDate5}}" />
                                <input type="hidden" name="fromParty" value="{{fromParty4}}" />
                                <input type="hidden" name="toParty" value="{{toParty5}}" />
                                %{--<g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>--}%
                                <a ng-href="/${grailsApplication.config.erpName}/transactionReport/billPendingReport?scrid=${session['activeScreen'].id}&fromParty={{fromParty4}}&toParty={{toParty5}}&fromDate={{fromDate4}}&toDate={{toDate5}}&format=PDF"
                                   class="btn btn-primary btn-mini" target="_blank">
                                    Print Report</a>

                            </g:jasperForm>


                        </div>

                    <div id="tabs-6">


                        <g:jasperForm controller="transactionReport"
                                      action="LRReceivedReport"
                                      jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                            <table>
                                <tr>
                                    <td> From Party</td>
                                    <td><select  id="party6" ng-model="fromPartyLRR" ng-options="r.id as r.accountName for r in accountList" ></select>
                                    </td>
                                    <td></td>
                                    <td> To Party</td>
                                    <td><select  id="party7" ng-model="toPartyLRR" ng-options="r.id as r.accountName for r in accountList" ></select>
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
                            <a ng-href="/${grailsApplication.config.erpName}/transactionReport/LRReceivedReport?scrid=${session['activeScreen'].id}&fromParty={{fromPartyLRR}}&toParty={{toPartyLRR}}&fromDate={{fromDateLRR}}&toDate={{toDateLRR}}&vNo={{vehicleLRR}}&format=PDF"
                               class="btn btn-primary btn-mini" target="_blank">
                                Print Report</a>

                        </g:jasperForm>


                    </div>

                    <div id="tabs-7">

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
                            <a ng-href="/${grailsApplication.config.erpName}/transactionReport/LRReceivedGodownwiseReport?scrid=${session['activeScreen'].id}&goDown={{goDown}}&fromDate={{fromDateLRRG}}&toDate={{toDateLRRG}}&format=PDF"
                               class="btn btn-primary btn-mini" target="_blank">
                                Print Report</a>

                        </g:jasperForm>

                    </div>

                    <div id="tabs-8">
                        <g:jasperForm controller="transactionReport"
                                      action="LRReceivedReport"
                                      jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                            <table>
                                <tr>
                                    <td> From Party</td>
                                    <td><select  id="party8" ng-model="fromPartyLRNR" ng-options="r.id as r.accountName for r in accountList" ></select>
                                    </td>
                                    <td></td>
                                    <td> To Party</td>
                                    <td><select  id="party9" ng-model="toPartyLRNR" ng-options="r.id as r.accountName for r in accountList" ></select>
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
                            <a ng-href="/${grailsApplication.config.erpName}/transactionReport/lrNotReceivedReport?scrid=${session['activeScreen'].id}&fromParty={{fromPartyLRNR}}&toParty={{toPartyLRNR}}&fromDate={{fromDateLRNR}}&toDate={{toDateLRNR}}&format=PDF"
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
</div>
</body>
</html>
</html>