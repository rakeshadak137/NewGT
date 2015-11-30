<%@ page import="com.transaction.InternalMemo" %>
<script>

    $(document).ready(function () {
        $("#vehicleNo").searchable();
    });
    function InternalMemoController($scope, $http) {
        init();

        function init() {
            $scope.currentPage = 0;
            $scope.pageSize = 10;
            $scope.DataList = [];

            $scope.dieselLtr = 0;
            $scope.totalBalance = 0;
            $scope.tripRate = 0;
            $scope.dieselRate = 0;
            $scope.dieselAmount = 0;
            $scope.freight = 0;
            $scope.totalTripRate = 0;
            $scope.advance = 0;
            $scope.balance = 0;
            $scope.showButton = true;
            $scope.tripList = ${com.master.TripRate.findAllByIsActive(true) as grails.converters.JSON}

            $scope.vehicleList = [];
            $http.get("/${grailsApplication.config.erpName}/internalMemo/showVehicleNo")
                    .success(function(data){
                        $scope.vehicleList=data;
                    });

            %{--$scope.vehicleList = ${com.master.VehicleMaster.findAllByIsActive(true) as grails.converters.JSON};--}%
            $scope.PumpList = ${com.master.PumpMaster.findAllByIsActive(true) as grails.converters.JSON};
            $scope.LRData = [];

            <g:if test="${internalMemoInstance?.id}">
            $scope.vehicleNo = ${internalMemoInstance?.vehicleNo?.id};
            $scope.pumpName = parseInt(${internalMemoInstance?.pumpName?.id});
            $scope.dieselLtr = ${internalMemoInstance?.dieselLtr};
            $scope.dieselRate = ${internalMemoInstance?.dieselRate};
            $scope.dieselAmount = ${internalMemoInstance?.dieselAmount};
            $scope.freight = ${internalMemoInstance?.freight};
            $scope.totalTripRate = ${internalMemoInstance?.totalTripRate};
            $scope.advance = ${internalMemoInstance?.advance};
            $scope.balance = ${internalMemoInstance?.balance};

            $scope.tripLocation = ${internalMemoInstance?.tripLocation?.id};
            $scope.totalBalance = ${internalMemoInstance?.totalBalance};
            $scope.tripRate = ${internalMemoInstance?.tripRate};
            debugger;

            $http.get("/${grailsApplication.config.erpName}/internalMemo/editLRData?id=" + ${internalMemoInstance?.id})
                    .success(function (data) {
                        $scope.LRData = data;
                        debugger;
                    });
            </g:if>
        }

        $scope.showRate = function(){
            var tripNo = _.findIndex($scope.tripList,{id:$scope.tripLocation});

            $scope.tripRate = $scope.tripList[tripNo].rate;

            $scope.totalBalance = parseFloat($scope.tripRate).toFixed(2) - parseFloat($scope.balance).toFixed(2);
        };

        $scope.showData = function () {
            debugger;
            var fDate = document.getElementById("fromDate").value;
            var tDate = document.getElementById("toDate").value;
            $http.get("/${grailsApplication.config.erpName}/internalMemo/lrData?vehicleNo=" + $scope.vehicleNo + "&fromDate=" + fDate + "&toDate=" + tDate)
                    .success(function (data) {
                        $scope.LRData = data;
                        debugger;
                    });
        };

        $scope.isNumber = function (a) {
            return isNumberKey(a);
        };

        $scope.showDieselAmount = function () {
            $scope.dieselAmount = parseFloat($scope.dieselLtr).toFixed(2) * parseFloat($scope.dieselRate).toFixed(2);
//            $scope.dieselAmount.toFixed(2);
            doTotalTripAmount();
        };

        function doTotalTripAmount() {
            var total = 0;
            total =  parseFloat($scope.freight).toFixed(2)- parseFloat($scope.dieselAmount).toFixed(2);
            $scope.totalTripRate = total;
            $scope.totalTripRate.toFixed(2);
            $scope.balance = total - parseFloat($scope.advance).toFixed(2);

            $scope.totalBalance = parseFloat($scope.tripRate).toFixed(2) - parseFloat($scope.balance).toFixed(2);
        }

        $scope.showTotalTripAmount = function () {
            doTotalTripAmount();
        };

        $scope.showBalance = function () {
            $scope.balance = parseFloat($scope.totalTripRate).toFixed(2) - parseFloat($scope.advance).toFixed(2);
            $scope.balance.toFixed(2);
        };

        $scope.showDieselRate = function () {
            $http.get("/${grailsApplication.config.erpName}/internalMemo/dieselRate?pumpId=" + $scope.pumpName)
                    .success(function (data) {
                        $scope.dieselRate = data;
                        debugger;
                    });
            $scope.showDieselAmount();
        };

        $scope.numberOfPages = function () {
            return Math.ceil($scope.DataList.length / $scope.pageSize);
        };

        $scope.selectAllValues = function(){
            var i;
            debugger;
            if($scope.LRData.length){
                for(i=0;i<$scope.LRData.length;i++){

                    $scope.LRData[i].bool=$scope.selectAll;

                }
            }

        };

        $scope.setVehicleNo = function(){
            var vehicleNo = _.findIndex($scope.vehicleList,{id:$scope.vehicleNo});
            if(vehicleNo){
                document.getElementById('vehicleNumber').value = $scope.vehicleList[vehicleNo].vehicleNo;
            }
        };

        $scope.checkValidations = function(){
            if(!$scope.vehicleNo){
                alert("Please Select Vehicle No");
                event.preventDefault();
            }
            else if(!$scope.tripLocation){
                alert("Please Select Trip Location or Trip No.");
                event.preventDefault();
            }
            else if($scope.LRData.length<=0){
                alert("There is no data");
                event.preventDefault();
            }
            else{
                $scope.showButton = false;
            }
        }
    }

</script>

<div ng-controller="InternalMemoController">
<input type="hidden" name="ChildJSON" value="{{LRData}}">

<input type="hidden" name="vehicle_no_id" value="{{vehicleNo}}">
<input type="hidden" name="Pumpid" value="{{pumpName}}">
<input type="hidden" name="dieselLtr" value="{{dieselLtr}}">
<input type="hidden" name="dieselRate" value="{{dieselRate}}">
<input type="hidden" name="dieselAmount" value="{{dieselAmount}}">
<input type="hidden" name="freight" value="{{freight}}">
<input type="hidden" name="totalTripRate" value="{{totalTripRate}}">
<input type="hidden" name="advance" value="{{advance}}">
<input type="hidden" name="balance" value="{{balance}}">
<input type="hidden" name="tripId" value="{{tripLocation}}">
<input type="hidden" name="tripRate" value="{{tripRate}}">
<input type="hidden" name="totalBalance" value="{{totalBalance}}">
<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'voucherNo', 'error')} ">
            <td><label for="voucherNo">
                <g:message code="internalMemo.voucherNo.label" default="Voucher No"/>

            </label></td>
            <td><g:textField name="voucherNo" disabled="" value="${internalMemoInstance?.voucherNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'voucherDate', 'error')} required">
            <td><label for="voucherDate">
                <g:message code="internalMemo.voucherDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Voucher Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="date" name="voucherDate"
                       value="${internalMemoInstance?.voucherDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

    </tr>

</table>

<hr>

<table>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'vehicleNo', 'error')} required">
            <td><label for="vehicleNo">
                <g:message code="internalMemo.vehicleNo.label" default="Vehicle No"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select ng-model="vehicleNo" ng-options="v.id as v.vehicleNo for v in vehicleList" required="" id="vehicleNo" ng-change="setVehicleNo()"
                        value="${internalMemoInstance?.vehicleNo?.id}" class="many-to-one"></select></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'fromDate', 'error')} required">
            <td><label for="fromDate">
                <g:message code="internalMemo.fromDate.label" default="From Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="date" name="fromDate" id="fromDate"
                       value="${internalMemoInstance?.fromDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'toDate', 'error')} required">
            <td><label for="toDate">
                <g:message code="internalMemo.toDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="date" name="toDate" id="toDate"
                       value="${internalMemoInstance?.toDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

    </tr>

    <tr>
        <div>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-mini btn-inverse" ng-click="showData()">Show Data</button>
            </td>
        </div>
    </tr>

</table>

<hr>

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
            <td style="text-align: center"><input type="checkbox" ng-model="selectAll" ng-change="selectAllValues()"/><span
                    class="lbl"></span></td>

            <td style="text-align: center">LR No</td>

            <td style="text-align: center">LR Date</td>

            <td style="text-align: center">From Customer</td>

            <td style="text-align: center">To Customer</td>

            <td style="text-align: center">Invoice No.</td>

            <td style="text-align: center">Total Qty.</td>

            <td style="text-align: center">Unit</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in LRData  | filter : search | startFrom: currentPage * pageSize | limitTo: pageSize">

            <td style="text-align: center"><input type="checkbox" ng-model="d.bool" value={{d.bool}}/><span
                    class="lbl"></span></td>
            <td style="text-align: center">{{d.lrNo}}</td>
            <td style="text-align: center">{{d.lrDate}}</td>
            <td style="text-align: center">{{d.fromCustomer}}</td>
            <td style="text-align: center">{{d.toCustomer}}</td>
            <td style="text-align: center">{{d.invoiceNo}}</td>
            <td style="text-align: center">{{d.totalQty}}</td>
            <td style="text-align: center">{{d.unit}}</td>

        </tr>
        </tbody>
    </table>

    <hr>

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

<hr>

<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'dieselReceiptNo', 'error')} required">
            <td><label for="dieselReceiptNo">
                <g:message code="internalMemo.dieselReceiptNo.label" default="Receipt No"/>
            </label></td>
            <td><g:textField id="dieselReceiptNo" name="dieselReceiptNo"
                             value="${internalMemoInstance?.dieselReceiptNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'dieselReceiptDate', 'error')} required">
            <td><label for="dieselReceiptDate">
                <g:message code="internalMemo.dieselReceiptDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Receipt Date"/>
            </label></td>
            <td><input type="date" name="dieselReceiptDate"
                       value="${internalMemoInstance?.dieselReceiptDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'pumpName', 'error')} required">
            <td><label for="pumpName">
                <g:message code="internalMemo.pumpName.label" default="Pump Name"/>
            </label></td>
            <td><select ng-model="pumpName" ng-options="p.id as p.pumpName for p in PumpList"
                        ng-change="showDieselRate()"
                        value="${internalMemoInstance?.pumpName?.id}" class="many-to-one"></select></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'dieselRate', 'error')} required">
            <td><label for="dieselRate">
                <g:message code="internalMemo.dieselRate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Rate"/>
            </label></td>
            <td><input type="text" id="dieselRate" ng-model="dieselRate" disabled=""
                       ng-change="dieselRate=isNumber(dieselRate)"
                       value="${internalMemoInstance?.dieselRate}"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'dieselLtr', 'error')} required">
            <td><label for="dieselLtr">
                <g:message code="internalMemo.dieselLtr.label" default="Diesel Ltr"/>
            </label></td>
            <td><input type="text" id="dieselLtr" ng-model="dieselLtr" required=""
                       ng-change="dieselLtr=isNumber(dieselLtr);showDieselAmount()"
                       value="${internalMemoInstance?.dieselLtr}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'dieselAmount', 'error')} required">
            <td><label for="dieselAmount">
                <g:message code="internalMemo.dieselAmount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Amount"/>
            </label></td>
            <td><input type="text" id="dieselAmount" ng-model="dieselAmount"
                       ng-change="dieselAmount=isNumber(dieselAmount)" disabled=""
                       value="${internalMemoInstance?.dieselAmount}"/></td>
        </div>
    </tr>
</table>

<hr>

<table>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'transportName', 'error')} required">
            <td><label for="transportName">
                <g:message code="internalMemo.transportName.label" default="Transport Name"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField id="transportName" name="transportName"
                             value="${internalMemoInstance?.transportName}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'vehicleNumber', 'error')} required">
            <td><label for="vehicleNumber">
                <g:message code="internalMemo.vehicleNumber.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Vehicle No."/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField id="vehicleNumber" name="vehicleNumber"
                             value="${internalMemoInstance?.vehicleNumber}"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'driverName', 'error')} required">
            <td><label for="driverName">
                <g:message code="internalMemo.driverName.label" default="Driver Name"/>
            </label></td>
            <td><g:textField id="driverName" name="driverName"
                             value="${internalMemoInstance?.driverName}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'freight', 'error')} required">
            <td><label for="freight">
                <g:message code="internalMemo.freight.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Freight"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="text" id="freight" ng-model="freight"
                       ng-change="freight=isNumber(freight);showTotalTripAmount()"
                       value="${internalMemoInstance?.freight}"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'ownerName', 'error')} required">
            <td><label for="ownerName">
                <g:message code="internalMemo.ownerName.label" default="Owner Name"/>
            </label></td>
            <td><g:textField id="ownerName" name="ownerName" value="${internalMemoInstance?.ownerName}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'totalTripRate', 'error')} required">
            <td><label for="totalTripRate">
                <g:message code="internalMemo.advance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Advance"/>
            </label></td>
            <td><input type="text" id="totalTripRate" disabled="" ng-change="totalTripRate=isNumber(totalTripRate)"
                       ng-model="totalTripRate" value="${internalMemoInstance?.totalTripRate}"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'address', 'error')} required">
            <td><label for="address">
                <g:message code="internalMemo.address.label" default="Address"/>
            </label></td>
            <td><g:textField id="address" name="address" value="${internalMemoInstance?.address}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'advance', 'error')} required">
            <td><label for="advance">
                <g:message code="internalMemo.advance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Cash Advance"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="text" id="advance" ng-model="advance" ng-change="advance=isNumber(advance);showBalance()"
                       value="${internalMemoInstance?.advance}"/></td>
        </div>

    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'phoneNo', 'error')} required">
            <td><label for="phoneNo">
                <g:message code="internalMemo.phoneNo.label" default="Phone No"/>
            </label></td>
            <td><g:textField id="phoneNo" name="phoneNo" value="${internalMemoInstance?.phoneNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'balance', 'error')} required">
            <td><label for="balance">
                <g:message code="internalMemo.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Total Amount"/>
            </label></td>
            <td><input type="text" id="balance" ng-model="balance" ng-change="balance=isNumber(balance)" disabled=""
                       value="${internalMemoInstance?.balance}"/></td>
        </div>
    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'tripLocation', 'error')} required">
            <td><label for="tripLocation">
                <g:message code="internalMemo.tripLocation.label" default="Trip Location"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select ng-model="tripLocation" ng-options="t.id as t.location for t in tripList"
                        ng-change="showRate()" required=""
                        value="${internalMemoInstance?.tripLocation?.id}" class="many-to-one"></select></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'tripLocation', 'error')} required">
            <td><label for="tripLocation">
                <g:message code="internalMemo.tripLocation.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Trip No."/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select ng-model="tripLocation" ng-options="t.id as t.srNo for t in tripList"
                        ng-change="showRate()" required=""
                        value="${internalMemoInstance?.tripLocation?.id}" class="many-to-one"></select></td>
        </div>
    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'balance', 'error')} required">
            <td><label for="balance">
                <g:message code="internalMemo.balance.label" default="Trip Rate"/>
            </label></td>
            <td><input type="text" id="tripRate" ng-model="tripRate" ng-change="tripRate=isNumber(tripRate)" disabled=""
                       value="${internalMemoInstance?.tripRate}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: internalMemoInstance, field: 'totalBalance', 'error')} required">
            <td><label for="totalBalance">
                <g:message code="internalMemo.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Total Balance"/>
            </label></td>
            <td><input type="text" id="totalBalance" ng-model="totalBalance" ng-change="totalBalance=isNumber(totalBalance)"
                       value="${internalMemoInstance?.totalBalance}"/></td>
        </div>
    </tr>
</table>

<g:if test="${internalMemoInstance?.id}">
    <g:form method="post" >
        <g:hiddenField name="id" value="${internalMemoInstance?.id}"/>
        <g:hiddenField name="version" value="${internalMemoInstance?.version}"/>
    %{--<fieldset class="form">--}%
    %{--<div class="widget-main padding-8" style="margin-left: 50px; margin-right: 50px;"><g:render--}%
    %{--template="form"/></div>--}%
    %{--</fieldset>--}%
        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
            <g:actionSubmit class=" btn-primary btn-mini" action="update"  ng-click="checkValidations()" ng-show="showButton"
                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            <g:actionSubmit class="btn-primary btn-mini" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            formnovalidate=""
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</g:if>
<g:else>
    <g:form action="save" >
    %{--<fieldset class="form">--}%
    %{--<div class="widget-main padding-8" style="margin-left: 50px; margin-right: 50px;"><g:render--}%
    %{--template="form"/></div>--}%
    %{--</fieldset>--}%
        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
            <g:submitButton name="create" class="btn-primary btn-mini"  ng-click="checkValidations()" ng-show="showButton"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</g:else>

</div>