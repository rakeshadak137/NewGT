<%@ page import="com.transaction.LRReceivedEntry" %>
<script>
    var valid = false;
    $(document).ready(function () {
        $("#party1").searchable();
        $("#party2").searchable();
        $("#vehicle").searchable();
    });

    function AngularController($scope, $http) {
        init();

        function init() {
            $scope.currentPage = 0;
            $scope.pageSize = 10;
            $scope.accountList = [];
            $scope.vehicleList = [];
            $scope.LRData = [];
            $scope.finalLRData = [];
            $scope.godownList = ${com.master.GodownMaster.findAllByIsActive(true) as grails.converters.JSON};
            checkLength();

            $http.get("/${grailsApplication.config.erpName}/transactionReport/accountList")
                    .success(function (data) {
                        $scope.accountList = data;
                    });

            $http.get("/${grailsApplication.config.erpName}/transactionReport/vehicleList")
                    .success(function (data) {
                        $scope.vehicleList = data;
                    });

            <g:if test="${LRReceivedEntryInstance?.id}">
                $scope.goDown = ${LRReceivedEntryInstance?.goDown?.id};

                $http.get("/${grailsApplication.config.erpName}/LRReceivedEntry/editLRData?id="+${LRReceivedEntryInstance?.id})
                        .success(function (data) {
                            $scope.finalLRData = data;
                            checkLength();
                        });
            </g:if>
        }

        $scope.showData = function () {
            $http.get("/${grailsApplication.config.erpName}/LRReceivedEntry/showLrData?fromParty=" + $scope.fromParty + "&toParty=" + $scope.toParty + "&fromDate=" + $scope.fromDate + "&toDate=" + $scope.toDate + "&vNo=" + $scope.vNo)
                    .success(function (data) {
                        $scope.LRData = data;
                    });
        };

        $scope.numberOfPages = function () {
            return Math.ceil($scope.LRData.length / $scope.pageSize);
        };

        $scope.addData = function (id) {
            var v = _.find($scope.finalLRData, {id: id});

            if (v) {
                alert("This LR is already Added.")
            } else {
                v = _.find($scope.LRData, {id: id});
                $scope.finalLRData.push({
                    id: v.id,
                    lrNo: v.lrNo,
                    lrDate: v.lrDate,
                    fromParty: v.fromParty,
                    toParty: v.toParty,
                    vehicleNo: v.vehicleNo,
                    godown: v.godown
                });
            }
            checkLength();
        };


        $scope.remove = function (index) {
            $scope.finalLRData.splice(index, 1);
            checkLength();
        };

        function checkLength() {
            if ($scope.finalLRData.length > 0) {
                valid = true;
            }
            else {
                valid = false;
            }
        }
    }
</script>

<div ng-controller="AngularController">
<input type="hidden" name="ChildJSON" value="{{finalLRData}}">
<input type="hidden" name="goDown.id" value="{{goDown}}">

<div class="row-fluid">
    <div class="span12">
        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="Receive Date"/>
                    <span class="required-indicator">*</span>
                </label>
            </div>

            <div class="span6">
                <input type="date" name="receiveDate"
                       value="${LRReceivedEntryInstance?.receiveDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/>
            </div>
        </div>

        <div class="span6">
            <div class="span3">
                <label for="goDown">
                    <g:message code="LRReceivedEntry.goDown.label" default="Go Down"/>
                    <span class="required-indicator">*</span>
                </label>
            </div>

            <div class="span6">
                <select id="goDown" name="goDown" ng-model="goDown"
                        ng-options="g.id as g.godownName for g in godownList"
                        required="" value="${LRReceivedEntryInstance?.goDown?.id}" class="many-to-one">
                    <option value="">---Select One---</option>
                </select>
            </div>
        </div>
    </div>
</div>

<hr>

<div class="row-fluid">
    <div class="span12">
        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="Form Party"/>
                </label>
            </div>

            <div class="span8">
                <select id="party1" ng-model="fromParty" ng-options="p.id as p.accountName for p in accountList">
                    <option value="">---Select One---</option>
                </select>
            </div>
        </div>

        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="To Party"/>
                </label>
            </div>

            <div class="span8">
                <select id="party2" ng-model="toParty" ng-options="p.id as p.accountName for p in accountList">
                    <option value="">---Select One---</option>
                </select>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span12">
        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="Form Date"/>
                </label>
            </div>

            <div class="span8">
                <input type="date" ng-model="fromDate"/>
            </div>
        </div>

        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="To Date"/>
                </label>
            </div>

            <div class="span8">
                <input type="date" ng-model="toDate"/>
            </div>
        </div>
    </div>
</div>

<div class="row-fluid">
    <div class="span12">
        <div class="span6">
            <div class="span3">
                <label for="receiveDate">
                    <g:message code="LRReceivedEntry.receiveDate.label" default="Vehicle No."/>
                </label>
            </div>

            <div class="span8">
                <select id="vehicle" ng-model="vNo"
                        ng-options="r.id as r.state+'-'+r.rto+' '+r.series+' '+r.vehicleNo for r in vehicleList">
                    <option value="">---Select One---</option>
                </select>/
            </div>
        </div>

        <div class="span6">
            <input type="button" value="Show Data" class="btn btn-info btn-small" ng-click="showData()">
        </div>
    </div>
</div>

<div role="grid" class="well" id="sample-table_wrapper">
    <div class="dataTables_filter" id="sample-table-2_filter">
        <label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2">
        </label>
    </div>

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <th>Action</th>
            <th>LR No.</th>
            <th>LR Date</th>
            <th>From</th>
            <th>To</th>
            <th>Vehicle No.</th>
            <th>Godown</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="r in LRData  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

            <td style="width: 50px;">
                <input type="button" ng-click="addData(r.id)" value="ADD">
            </td>

            <td>{{r.lrNo}}</td>

            <td>{{r.lrDate}}</td>

            <td>{{r.fromParty}}</td>

            <td>{{r.toParty}}</td>

            <td>{{r.vehicleNo}}</td>

            <td>{{r.godown}}</td>

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

        <input type="button" ng-disabled="currentPage == 0" ng-click="currentPage = currentPage - 1"
               class="btn btn-inverse btn-minier" value="Previous">

        {{currentPage + 1}}/{{numberOfPages()}}

        <input type="button" ng-disabled="currentPage >= LRData.length/pageSize-1"
               ng-click="currentPage = currentPage + 1" class="btn btn-inverse btn-minier" value="Next">
    </div>
</div>

<hr>

<div role="grid" class="dataTables_wrapper" id="sample-table-5_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-5"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Action</td>

            <td>LR No.</td>

            <td>LR Date</td>

            <td>From</td>

            <td>To</td>

            <td>Vehicle No.</td>

            <td>Godown</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in finalLRData">

            <td>
                <button type="button" value="delete" ng-click="remove($index)"
                        style="border: none; background: transparent">
                    <img src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"></button>
            </td>

            <td>{{d.lrNo}}</td>
            <td>{{d.lrDate}}</td>
            <td>{{d.fromParty}}</td>
            <td>{{d.toParty}}</td>
            <td>{{d.vehicleNo}}</td>
            <td>{{d.godown}}</td>
        </tr>
        </tbody>
    </table>
</div>
</div>