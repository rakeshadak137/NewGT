<%@ page import="com.master.GodownMaster; com.transaction.OutEntry" %>
<script>
    $(document).ready(function () {
        $("#fromCustomer").searchable();
        $("#toCustomer").searchable();
        $("#godown").searchable();
    });
    function OUTEntryController($scope, $http) {
        init();

        function init() {
            $scope.dieselLtr = 0;
            $scope.dieselRate = 0;
            $scope.dieselAmount = 0;
            $scope.freight = 0;
            $scope.totalTripRate = 0;
            $scope.advance = 0;
            $scope.balance = 0;
            $scope.showButton = true;
            $scope.currentPage = 0;
            $scope.pageSize = 10;
            $scope.currentPage1 = 0;
            $scope.pageSize1 = 10;

            $scope.stockData = [];
            $scope.stockData1 = [];
            $scope.toCustomer = "";
            $scope.fromCustomer = "";
            $scope.godown = "";
            $scope.accountData = ${com.master.AccountMaster.findAllByIsActive(true) as grails.converters.JSON};
            $scope.godownData = ${com.master.GodownMaster.findAllByIsActive(true) as grails.converters.JSON};

            <g:if test="${outEntryInstance?.id}">
            $scope.fromCustomer = ${outEntryInstance?.fromCustomer.id};
            $scope.toCustomer = ${outEntryInstance?.toCustomer.id};
            $scope.godown = ${outEntryInstance?.godown.id};

            %{--$scope.dieselLtr = ${outEntryInstance?.dieselLtr};--}%
            %{--$scope.dieselRate = ${outEntryInstance?.dieselRate};--}%
            %{--$scope.dieselAmount = ${outEntryInstance?.dieselAmount};--}%
            %{--$scope.freight = ${outEntryInstance?.freight};--}%
            %{--$scope.totalTripRate = ${outEntryInstance?.totalTripRate};--}%
            %{--$scope.advance = ${outEntryInstance?.advance};--}%
            %{--$scope.balance = ${outEntryInstance?.balance};--}%

            $http.get("/${grailsApplication.config.erpName}/OutEntry/editStockData?id=" + ${outEntryInstance?.id})
                    .success(function (data) {
                        $scope.stockData = data;
                        debugger;
                    });

            $http.get("/${grailsApplication.config.erpName}/OutEntry/editStockData1?id=" + ${outEntryInstance?.id})
                    .success(function (data) {
                        $scope.stockData1 = data;
                        debugger;
                    });
            </g:if>
        }

        $scope.showData = function () {
            $http.get("/${grailsApplication.config.erpName}/OutEntry/stockData?fCustomer=" + $scope.fromCustomer + "&tCustomer=" + $scope.toCustomer + "&godown=" + $scope.godown)
                    .success(function (data) {
                        $scope.stockData = data;
                        debugger;
                    });
        };

        $scope.isNumber = function(a){
            return isNumberKey(a);
        };

        $scope.showDieselAmount = function(){
            $scope.dieselAmount = parseFloat($scope.dieselLtr) * parseFloat($scope.dieselRate);
            doTotalTripAmount();
        };

        function doTotalTripAmount(){
            var total = 0;
            total = parseFloat($scope.dieselAmount) + parseFloat($scope.freight);
            $scope.totalTripRate = total;
            $scope.balance = total - parseFloat($scope.advance);
        }

        $scope.showTotalTripAmount = function(){
            doTotalTripAmount();
        };

        $scope.showBalance = function(){
            $scope.balance = parseFloat($scope.totalTripRate) - parseFloat($scope.advance);
        };

        $scope.selectAllValues = function(){
            var i;
            debugger;
            if($scope.stockData.length){
                for(i=0;i<$scope.stockData.length;i++){
                    $scope.stockData[i].bool=$scope.selectAll;
                }

                if($scope.selectAll){
                    for(i=0;i<$scope.stockData.length;i++){
                        $scope.stockData1.push({
                            bool         : true,
                            id           : $scope.stockData[i].id,
                            lrNo         : $scope.stockData[i].lrNo,
                            lrDate       : $scope.stockData[i].lrDate,
                            invoiceNo    : $scope.stockData[i].invoiceNo,
                            productName  : $scope.stockData[i].productName,
                            productId  : $scope.stockData[i].productId,
                            invoiceQty   : $scope.stockData[i].invoiceQty,
                            invoiceUnitId: $scope.stockData[i].invoiceUnitId,
                            invoiceUnit  : $scope.stockData[i].invoiceUnit
                        });
                    }
                }else{
                    $scope.stockData1 = [];
                }
            }

        };
        $scope.checkValidations = function(){
            if(!$scope.fromCustomer){
                alert("Please Select From Customer");
                event.preventDefault();
            }
            else if(!$scope.toCustomer){
                alert("Please Select To Customer");
                event.preventDefault();
            }else if(!$scope.godown){
                alert("Please Select Godown");
                event.preventDefault();
            }else if($scope.stockData.length<=0){
                alert("There is no data");
                event.preventDefault();
            }else if(!document.getElementById("vehicle").value){
                alert("Please Enter Vehicle No:");
                event.preventDefault();
            }
            else{
                $scope.showButton = false
            }
        }

        $scope.numberOfPages = function () {
            return Math.ceil($scope.stockData.length / $scope.pageSize);
            debugger;
        };

        $scope.numberOfPages1 = function () {
            return Math.ceil($scope.stockData1.length / $scope.pageSize1);
            debugger;
        };

        $scope.addToTable = function(index){

            debugger;
            if($scope.stockData[index].bool){
                $scope.stockData1.push({
                    bool         : true,
                    id           : $scope.stockData[index].id,
                    lrNo         : $scope.stockData[index].lrNo,
                    lrDate       : $scope.stockData[index].lrDate,
                    invoiceNo    : $scope.stockData[index].invoiceNo,
                    productName  : $scope.stockData[index].productName,
                    productId  : $scope.stockData[index].productId,
                    invoiceQty   : $scope.stockData[index].invoiceQty,
                    invoiceUnitId: $scope.stockData[index].invoiceUnitId,
                    invoiceUnit  : $scope.stockData[index].invoiceUnit
                });
            }else{
                var l = $scope.stockData1.length;

                for(var i=0;i<l;i++) {
                    debugger;
                    if($scope.stockData[index].id == $scope.stockData1[i].id){
                        $scope.stockData1.splice(i,1);
                    }
                }
            }
        };
    }

</script>

<div ng-controller="OUTEntryController">
<input type="hidden" name="ChildJSON" value="{{stockData1}}">
<input type="hidden" name="fromCustomer.id" value="{{fromCustomer}}">
<input type="hidden" name="toCustomer.id" value="{{toCustomer}}">
<input type="hidden" name="godown.id" value="{{godown}}">

<input type="hidden" name="dieselLtr" value="{{dieselLtr}}">
<input type="hidden" name="dieselRate" value="{{dieselRate}}">
<input type="hidden" name="dieselAmount" value="{{dieselAmount}}">
<input type="hidden" name="freight" value="{{freight}}">
<input type="hidden" name="totalTripRate" value="{{totalTripRate}}">
<input type="hidden" name="advance" value="{{advance}}">
<input type="hidden" name="balance" value="{{balance}}">
<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'voucherNo', 'error')} ">
            <td><label for="voucherNo">
                <g:message code="outEntry.voucherNo.label" default="Out No"/>

            </label></td>
            <td><g:textField name="voucherNo" value="${outEntryInstance?.voucherNo}" disabled=""/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'voucherDate', 'error')} required">
            <td><label for="voucherDate">
                <g:message code="outEntry.voucherDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Out Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input type="date" name="voucherDate"
                       value="${outEntryInstance?.voucherDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'fromCustomer', 'error')} required">
            <td><label for="fromCustomer">
                <g:message code="outEntry.fromCustomer.label" default="From Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select id="fromCustomer" ng-model="fromCustomer"
                        ng-options="a.id as a.accountName for a in accountData"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'toCustomer', 'error')} required">
            <td><label for="toCustomer">
                <g:message code="outEntry.toCustomer.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select id="toCustomer" ng-model="toCustomer" ng-options="a.id as a.accountName for a in accountData"/>
            </td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'godown', 'error')} required">
            <td><label for="godown">
                <g:message code="outEntry.godown.label" default="Godown"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select id="godown" ng-model="godown" ng-options="g.id as g.godownName for g in godownData"/></td>
        </div>

        <div>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-mini btn-inverse" ng-click="showData()">Show Data</button>
            </td>
        </div>

    </tr>
    <tr>
        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'vehicle', 'error')} required">
            <td><label for="vehicle">
                <g:message code="outEntry.vehicle.label" default="Vehicle No"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField id="vehicle" name="vehicle"  value="${outEntryInstance?.vehicle}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'outTime', 'error')} required">
            <td><label for="outTime">
                <g:message code="outEntry.vehicle.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Time"/>
                <span class="required-indicator">*</span>
            </label></td>
            %{--<td><g:textField id="outTime" name="outTime" required="" value="${outEntryInstance?.outTime}"/></td>--}%
            <td><input type="time" id="outTime" name="outTime" disabled="" required="" value="${outEntryInstance?.outTime?.format('hh:mm:ss') ?: Date.newInstance().format('hh:mm:ss')}"/></td>
        </div>
    </tr>

</table>

<hr>

<div class="row-fluid">
    <div class="dataTables_filter" id="sample-table-2_filter">
        <label>Search: <input type="text" ng-model="searchItem" aria-controls="sample-table-2"></label>
    </div>
</div>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td style="text-align: center"><input type="checkbox" ng-model="selectAll" ng-change="selectAllValues()"/><span
                    class="lbl"></span></td>

            <td style="text-align: center">Invoice No</td>
            <td style="text-align: center">Product Name</td>
            <td style="text-align: center">From Party</td>
            <td style="text-align: center">To Party</td>

            <td style="text-align: center">LR No</td>

            <td style="text-align: center">LR Date</td>

            <td style="text-align: center">Invoice Qty</td>

            <td style="text-align: center">Invoice Unit</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in stockData | filter : searchItem | startFrom: currentPage * pageSize | limitTo: pageSize">
            %{--<tr ng-repeat="d in stockData | filter : search">--}%

            <td style="text-align: center"><input type="checkbox" ng-model="d.bool" value={{d.bool}} ng-change="addToTable(d.sr)"/><span
                    class="lbl"></span></td>
            <td style="text-align: center">{{d.invoiceNo}}</td>
            <td style="text-align: center">{{d.productName}}</td>
            <td style="text-align: center">{{d.from}}</td>
            <td style="text-align: center">{{d.to}}</td>
            <td style="text-align: center">{{d.lrNo}}</td>
            <td style="text-align: center">{{d.lrDate}}</td>
            <td style="text-align: center">{{d.invoiceQty}}</td>
            <td style="text-align: center">{{d.invoiceUnit}}</td>
        </tr>
        </tbody>
    </table>

    %{--<div align="center">--}%
    %{--Page Size--}%
    %{--<select ng-model="pageSize" id="pageSize">--}%
    %{--<option value="10">10</option>--}%
    %{--<option value="20">20</option>--}%
    %{--<option value="30">30</option>--}%
    %{--</select>--}%

    %{--<button ng-disabled="currentPage == 0" ng-click="currentPage = currentPage - 1"--}%
    %{--class="btn btn-inverse btn-minier">--}%
    %{--Previous--}%
    %{--</button>--}%
    %{--{{currentPage + 1}}/{{numberOfPages()}}--}%

    %{--<button ng-disabled="currentPage >= DataList.length/pageSize-1"--}%
    %{--ng-click="currentPage = currentPage + 1" class="btn btn-inverse btn-minier">--}%
    %{--Next--}%
    %{--</button>--}%
    %{--</div>--}%

    <div align="center">
        Page Size
        <select ng-model="pageSize" id="pageSize">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="30">30</option>
        </select>

        <input type="button" ng-disabled="currentPage == 0" ng-click="currentPage = currentPage - 1"
               value="Previous" class="btn btn-inverse btn-minier" />
        %{--Previous--}%
        %{--</button>--}%
        {{currentPage + 1}}/{{numberOfPages()}}

        <input type="button" ng-disabled="currentPage >= stockData.length/pageSize-1" value="Next"
               ng-click="currentPage = currentPage + 1" class="btn btn-inverse btn-minier" />
        %{--Next--}%
        %{--</button>--}%
    </div>
</div>

<hr>
%{--2nd table--}%
<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            %{--<td style="text-align: center"><input type="checkbox" ng-model="selectAll" ng-change="selectAllValues()"/><span--}%
            %{--class="lbl"></span></td>--}%

            <td style="text-align: center">Invoice No</td>
            <td style="text-align: center">Product Name</td>
            %{--<td style="text-align: center">From Party</td>--}%
            %{--<td style="text-align: center">To Party</td>--}%

            <td style="text-align: center">LR No</td>

            <td style="text-align: center">LR Date</td>

            <td style="text-align: center">Invoice Qty</td>

            <td style="text-align: center">Invoice Unit</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in stockData1 | startFrom: currentPage1 * pageSize1 | limitTo: pageSize1">
            %{--<tr ng-repeat="d in stockData | filter : search">--}%

            %{--<td style="text-align: center"><input type="checkbox" ng-model="d.bool" value={{d.bool}}/><span--}%
            %{--class="lbl"></span></td>--}%
            <td style="text-align: center">{{d.invoiceNo}}</td>
            <td style="text-align: center">{{d.productName}}</td>
            %{--<td style="text-align: center">{{d.from}}</td>--}%
            %{--<td style="text-align: center">{{d.to}}</td>--}%
            <td style="text-align: center">{{d.lrNo}}</td>
            <td style="text-align: center">{{d.lrDate}}</td>
            <td style="text-align: center">{{d.invoiceQty}}</td>
            <td style="text-align: center">{{d.invoiceUnit}}</td>
        </tr>
        </tbody>
    </table>

    %{--<div align="center">--}%
    %{--Page Size--}%
    %{--<select ng-model="pageSize" id="pageSize">--}%
    %{--<option value="10">10</option>--}%
    %{--<option value="20">20</option>--}%
    %{--<option value="30">30</option>--}%
    %{--</select>--}%

    %{--<button ng-disabled="currentPage == 0" ng-click="currentPage = currentPage - 1"--}%
    %{--class="btn btn-inverse btn-minier">--}%
    %{--Previous--}%
    %{--</button>--}%
    %{--{{currentPage + 1}}/{{numberOfPages()}}--}%

    %{--<button ng-disabled="currentPage >= DataList.length/pageSize-1"--}%
    %{--ng-click="currentPage = currentPage + 1" class="btn btn-inverse btn-minier">--}%
    %{--Next--}%
    %{--</button>--}%
    %{--</div>--}%

    <div align="center">
        Page Size
        <select ng-model="pageSize1" id="pageSize1">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="30">30</option>
        </select>

        <input type="button" ng-disabled="currentPage1 == 0" ng-click="currentPage1 = currentPage1 - 1"
               value="Previous" class="btn btn-inverse btn-minier" />
        %{--Previous--}%
        %{--</button>--}%
        {{currentPage1 + 1}}/{{numberOfPages1()}}

        <input type="button" ng-disabled="currentPage1 >= stockData1.length/pageSize1-1" value="Next"
               ng-click="currentPage1 = currentPage1 + 1" class="btn btn-inverse btn-minier" />
        %{--Next--}%
        %{--</button>--}%
    </div>
</div>
<g:if test="${outEntryInstance?.id}">
    <g:form method="post" >
        <g:hiddenField name="id" value="${outEntryInstance?.id}"/>
        <g:hiddenField name="version" value="${outEntryInstance?.version}"/>
    %{--<fieldset class="form">--}%
    %{--<div class="widget-main padding-8" style="margin-left: 50px; margin-right: 50px;"><g:render--}%
    %{--template="form"/></div>--}%
    %{--</fieldset>--}%
        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
            <g:actionSubmit class="btn btn-info btn-small" action="update"  ng-click="checkValidations()" ng-show="showButton"
                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            <g:actionSubmit class="btn btn-info btn-small" action="delete"
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
            <g:submitButton name="create" class="btn btn-info btn-small"  ng-click="checkValidations()" ng-show="showButton"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</g:else>

%{--<hr>--}%

%{--<table>--}%

%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'dieselReceiptNo', 'error')} required">--}%
%{--<td><label for="dieselReceiptNo">--}%
%{--<g:message code="outEntry.dieselReceiptNo.label" default="Receipt No"/>--}%
%{--</label></td>--}%
%{--<td><g:textField id="dieselReceiptNo" name="dieselReceiptNo" value="${outEntryInstance?.dieselReceiptNo}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'dieselReceiptDate', 'error')} required">--}%
%{--<td><label for="dieselReceiptDate">--}%
%{--<g:message code="outEntry.dieselReceiptDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Receipt Date"/>--}%
%{--</label></td>--}%
%{--<td><input type="date" name="dieselReceiptDate"--}%
%{--value="${outEntryInstance?.dieselReceiptDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"--}%
%{--required=""/></td></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'dieselLtr', 'error')} required">--}%
%{--<td><label for="dieselLtr">--}%
%{--<g:message code="outEntry.dieselLtr.label" default="Diesel Ltr"/>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="dieselLtr" ng-model="dieselLtr" required="" ng-change="dieselLtr=isNumber(dieselLtr);showDieselAmount()" value="${outEntryInstance?.dieselLtr}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'dieselRate', 'error')} required">--}%
%{--<td><label for="dieselRate">--}%
%{--<g:message code="outEntry.dieselRate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Rate"/>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="dieselRate" ng-model="dieselRate" ng-change="dieselRate=isNumber(dieselRate);showDieselAmount()"--}%
%{--value="${outEntryInstance?.dieselRate}"/></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%
%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'pumpName', 'error')} required">--}%
%{--<td><label for="pumpName">--}%
%{--<g:message code="outEntry.pumpName.label" default="Pump Name"/>--}%
%{--</label></td>--}%
%{--<td><g:textField id="pumpName" name="pumpName" value="${outEntryInstance?.pumpName}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'dieselAmount', 'error')} required">--}%
%{--<td><label for="dieselAmount">--}%
%{--<g:message code="outEntry.dieselAmount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Amount"/>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="dieselAmount" ng-model="dieselAmount" ng-change="dieselAmount=isNumber(dieselAmount)" disabled="" value="${outEntryInstance?.dieselAmount}"/></td>--}%
%{--</div>--}%
%{--</tr>--}%
%{--</table>--}%

%{--<hr>--}%

%{--<table>--}%
%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'transportName', 'error')} required">--}%
%{--<td><label for="transportName">--}%
%{--<g:message code="outEntry.transportName.label" default="Transport Name"/>--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label></td>--}%
%{--<td><g:textField id="transportName" name="transportName" required=""--}%
%{--value="${outEntryInstance?.transportName}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'vehicle', 'error')} required">--}%
%{--<td><label for="vehicle">--}%
%{--<g:message code="outEntry.vehicle.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Vehicle"/>--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label></td>--}%
%{--<td><g:textField id="vehicle" name="vehicle" required="" value="${outEntryInstance?.vehicle}"/></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'driverName', 'error')} required">--}%
%{--<td><label for="driverName">--}%
%{--<g:message code="outEntry.driverName.label" default="Driver Name"/>--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label></td>--}%
%{--<td><g:textField id="driverName" name="driverName" required=""--}%
%{--value="${outEntryInstance?.driverName}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'freight', 'error')} required">--}%
%{--<td><label for="freight">--}%
%{--<g:message code="outEntry.freight.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Freight"/>--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="freight" ng-model="freight" ng-change="freight=isNumber(freight);showTotalTripAmount()" value="${outEntryInstance?.freight}"/></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'ownerName', 'error')} required">--}%
%{--<td><label for="ownerName">--}%
%{--<g:message code="outEntry.ownerName.label" default="Owner Name"/>--}%
%{--</label></td>--}%
%{--<td><g:textField id="ownerName" name="ownerName" value="${outEntryInstance?.ownerName}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'totalTripRate', 'error')} required">--}%
%{--<td><label for="totalTripRate">--}%
%{--<g:message code="outEntry.advance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Total Trip Rate"/>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="totalTripRate" disabled="" ng-change="totalTripRate=isNumber(totalTripRate)" ng-model="totalTripRate" value="${outEntryInstance?.totalTripRate}"/></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'address', 'error')} required">--}%
%{--<td><label for="address">--}%
%{--<g:message code="outEntry.address.label" default="Address"/>--}%
%{--</label></td>--}%
%{--<td><g:textField id="address" name="address" value="${outEntryInstance?.address}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'advance', 'error')} required">--}%
%{--<td><label for="advance">--}%
%{--<g:message code="outEntry.advance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Advance"/>--}%
%{--<span class="required-indicator">*</span>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="advance" ng-model="advance" ng-change="advance=isNumber(advance);showBalance()" value="${outEntryInstance?.advance}"/></td>--}%
%{--</div>--}%

%{--</tr>--}%

%{--<tr>--}%
%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'phoneNo', 'error')} required">--}%
%{--<td><label for="phoneNo">--}%
%{--<g:message code="outEntry.phoneNo.label" default="Phone No"/>--}%
%{--</label></td>--}%
%{--<td><g:textField id="phoneNo" name="phoneNo" value="${outEntryInstance?.phoneNo}"/></td>--}%
%{--</div>--}%

%{--<div class="fieldcontain ${hasErrors(bean: outEntryInstance, field: 'balance', 'error')} required">--}%
%{--<td><label for="balance">--}%
%{--<g:message code="outEntry.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Balance"/>--}%
%{--</label></td>--}%
%{--<td><input type="text" id="balance" ng-model="balance" ng-change="balance=isNumber(balance)" disabled="" value="${outEntryInstance?.balance}"/></td>--}%
%{--</div>--}%
%{--</tr>--}%
%{--</table>--}%
</div>