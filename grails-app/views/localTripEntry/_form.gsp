<%@ page import="com.transaction.LocalTripEntry" %>
<script>

    $(document).ready(function () {
        $("#fromCustomer").searchable();
        $("#fromCustomer1").searchable();
        $("#toCustomer").searchable();
        $("#vehicleNo").searchable();
        $("#poNo").searchable();
        $("#productName").searchable();
        $("#godown").searchable();
    });

    function check() {
        if (valid) {
            return valid
        }
        else {
            alert("There are no Transaction");
            return valid
        }
    }

         function localController($scope,$http) {
             var grandTotal = 0;
             init();

             function init() {
                 $('#timepicker1').timepicker();
                 $scope.ManualVehicle = false;
                 $scope.showProduct = false;
                 $scope.disableRate = true;
                 $scope.LRData = [];
                 $scope.poData = [];
                 $scope.freight = 0;
                 $scope.totalTripRate = 0;
                 $scope.advance = 0;
                 $scope.balance = 0;
                 $scope.disableTripRate = false;
                 $scope.showField = "${session['activeUser'].admin}";

                 $scope.customerList = ${com.master.AccountMaster.findAllByIsActive(true) as grails.converters.JSON};
                 $scope.productList = ${com.master.ProductMaster.findAllByIsActive(true) as grails.converters.JSON};
                 $scope.unitList = ${com.master.UnitMaster.findAllByIsActive(true) as grails.converters.JSON};

                 <g:if test="${localTripEntryInstance?.id}">
                 debugger;

                 $scope.balance = parseFloat("${localTripEntryInstance?.balance}");
                 $scope.advance = parseFloat("${localTripEntryInstance?.advance}");
                 $scope.totalTripRate = parseFloat("${localTripEntryInstance?.totalTripRate}");

                 var id = "${localTripEntryInstance?.id}";
                 $http.get("/${grailsApplication.config.erpName}/localTripEntry/getData?id=" + id)
                         .success(function (data) {
                             debugger;
                             if(data){
                                 $scope.LRData = data;
                             }
//                             checkLength();
                         });

                 $http.get("/${grailsApplication.config.erpName}/localTripEntry/getOtherData?id=" + id)
                         .success(function (data) {
                             $scope.fromCustomer = data.fromCustomerID;
                             $scope.toCustomer = data.toCustomerID;
                             $scope.amount = data.amount;
                             $scope.totalAmount = data.totalAmount;
                             $scope.grandTotal = data.grandTotal;

                             $http.get("/${grailsApplication.config.erpName}/LREntry/getPOData?id=" + data.fromCustomerID +"&id1=" + data.toCustomerID)
                                     .success(function (data) {
                                         $scope.poData = data;
                                     });

                             $scope.poNo = data.poID;
                         });

                 doGrandTotal();

                 </g:if>
             }
             $scope.showHideVehicleNo = function(){
                 if($scope.checkManualVehicle) {
                     $scope.ManualVehicle = true;
                     document.getElementById("vehicleNo").value="";

                 }
                 else{
                     $scope.ManualVehicle = false;
                     document.getElementById("vehicleManual").value="";
                 }
             };

             $scope.showHideProduct = function(){
                 $scope.rate="";
                 $scope.productName = "";
                 $scope.unit = "";

                 if($scope.checkManualProduct){
                     $scope.showProduct = true;
                     $scope.disableRate = false;
                 }
                 else{
                     $scope.showProduct = false;
                     $scope.disableRate = true;
                 }
             };

             $scope.setProductInfo = function(){
                 $http.get("/${grailsApplication.config.erpName}/LREntry/getProductData?id=" + $scope.productName)
                         .success(function (data) {
                             if(data) {
                                 $scope.unit = data.unitId;
                                 $scope.rate = data.rate;
                                 $scope.weight = data.weight;
                             }
                         });
             };

             $scope.gettAmount = function(){
                 $scope.tAmount = 0;
                 $scope.tAmount = parseFloat($scope.qty) * parseFloat($scope.rate);
             };

             $scope.isNumber = function(a){
                 return isNumberKey(a);
             };

             $scope.addData = function(){
                 if($scope.LRData.length >= 25){
                     alert("List Full. You Can Not Add More Than 25 Items");
                     doBlank();
                     return false;
                 }
                 if((!$scope.productName && !$scope.checkManualProduct) ||(!$scope.manualProductName && $scope.checkManualProduct)){
                     alert("Please Enter Product Name");
                     return false;
                 }
                 if(!$scope.invoiceNo){
                     alert("Please Enter Invoice No");
                     return false;
                 }
                 if(!$scope.unit){
                     alert("Please Select Unit");
                     return false;
                 }
                 if(!$scope.qty){
                     alert("Please Enter Quantity");
                     return false;
                 }
                 else{
                     $scope.unitData = _.find($scope.unitList, {id: $scope.unit});
                     if($scope.productList){
                         $scope.productData = _.find($scope.productList, {id: $scope.productName});
                     }
                     $scope.LRData.push(
                             {
                                 productId: $scope.productData ? $scope.productData.id:"",
                                 productName: $scope.productName ? ($scope.productData.productCode +'-'+ $scope.productData.productName):$scope.manualProductName ,
                                 manualProductName: $scope.manualProductName,
                                 qty: $scope.qty,
                                 unitId: $scope.unitData.unitName,
                                 unitName: $scope.unit,
                                 invoiceNo: $scope.invoiceNo,
//                                 rate: $scope.rate,
//                                 tAmount: $scope.tAmount,
                                 bool:$scope.checkManualProduct
                             }
                     );
                     $scope.createDisable = false;
                     debugger;
                     doBlank();
//                     getGrandTotal();
                     doGrandTotal();
                 }
             };

             $scope.edit = function (index) {
                 $scope.productName = $scope.LRData[index].productId;
                 $scope.manualProductName = $scope.LRData[index].manualProductName;
                 $scope.qty = $scope.LRData[index].qty;
                 $scope.invoiceNo = $scope.LRData[index].invoiceNo;
                 $scope.unit = $scope.LRData[index].unitName;
                 $scope.unitId = $scope.LRData[index].unitId;
                 $scope.rate = $scope.LRData[index].rate;
                 $scope.tAmount = $scope.LRData[index].tAmount;
                 $scope.checkManualProduct = $scope.LRData[index].bool;
//                 $scope.showHideProduct();
                 debugger;
                 $scope.indexing = index;
                 $scope.updateButton = true;

                 if($scope.LRData[index].bool){
                     $scope.showProduct = true;
                     $scope.disableRate = false;
                 }
                 else{
                     $scope.showProduct = false;
                     $scope.disableRate = true;
                 }
             };

             $scope.update = function (){
                 $scope.updateButton = false;

//                 $scope.unitData = _.find($scope.unitList, {id: $scope.invoiceUnit});
                 $scope.productData = _.find($scope.productList, {id: $scope.productName});

                 $scope.LRData[$scope.indexing].productId = $scope.productData.id;
                 $scope.LRData[$scope.indexing].productName = $scope.productData.productCode +'-'+ $scope.productData.productName;
                 $scope.LRData[$scope.indexing].manualProductName = $scope.manualProductName;
                 $scope.LRData[$scope.indexing].qty = $scope.qty;
                 $scope.LRData[$scope.indexing].invoiceNo = $scope.invoiceNo;
                 $scope.LRData[$scope.indexing].unitId = $scope.unitId;
                 $scope.LRData[$scope.indexing].unitName = $scope.unit;
//                 $scope.LRData[$scope.indexing].rate = $scope.rate;
//                 $scope.LRData[$scope.indexing].tAmount = $scope.tAmount;
                 $scope.LRData[$scope.indexing].bool = $scope.checkManualProduct;
                 doBlank();
                 checkLength();
//                 getGrandTotal();
                 doGrandTotal();

             };
             $scope.remove = function (index) {
                 $scope.value = false;
                 $scope.LRData.splice(index, 1);
                 validLength = $scope.LRData.length;
                 checkLength();
//                 getGrandTotal();
                 doGrandTotal();
             };


             function doBlank(){
                 $scope.productName = "";
                 $scope.manualProductName = "";
                 $scope.qty = 0;
                 $scope.unit = "";
                 $scope.rate = 0;
                 $scope.tAmount = 0;
                 $scope.invoiceNo = "";
             }

             function checkLength() {
                 if($scope.LRData.length > 0) {
                     valid = true;
                 }
                 else {
                     valid = false;
                 }
             }

             $scope.getGrandTotal = function(){
               doGrandTotal();
             };

             $scope.setFromInfo = function(){
                 if($scope.fromCustomer) {
                     %{--$http.get("/${grailsApplication.config.erpName}/LREntry/getCustomerData?id=" + $scope.fromCustomer)--}%
                             %{--.success(function (data) {--}%
                                 %{--$scope.fromAddress = data.address;--}%
                                 %{--$scope.fromLocation = data.city;--}%
                             %{--});--}%

                     $http.get("/${grailsApplication.config.erpName}/LREntry/getItemData?id=" + $scope.fromCustomer)
                             .success(function (data) {
                                 if (data) {
                                     $scope.productList = data;
                                 }
                             });

//                     if ($scope.toCustomer) {
                         $http.get("/${grailsApplication.config.erpName}/localTripEntry/getPOData?id=" + $scope.fromCustomer)
                                 .success(function (data) {
                                     $scope.poData = data;
                                 });
//                     }
                 }
             };

             $scope.setToInfo = function(){
                 $http.get("/${grailsApplication.config.erpName}/LREntry/getCustomerData?id=" + $scope.toCustomer)
                         .success(function (data) {
                             $scope.toAddress = data.address;
                             $scope.toLocation = data.city;
                         });

                 if($scope.fromCustomer) {
                     $http.get("/${grailsApplication.config.erpName}/LREntry/getPOData?id=" + $scope.fromCustomer +"&id1=" +$scope.toCustomer)
                             .success(function (data) {
                                 $scope.poData = data;
                             });
                 }
             };

             $scope.doOtherTotal = function(){
                 $http.get("/${grailsApplication.config.erpName}/LREntry/getOtherChild?id=" + $scope.poNo)
                         .success(function (data) {
                             debugger;
                             if(data){
                                 $scope.totalTripRate = parseFloat(data.freight) + parseFloat(data.tripRate);
                                 debugger;
                                 doGrandTotal();
                                 $scope.disableTripRate = true;
                                 $scope.fromAddress = data.fromAddress;
                                 $scope.toAddress = data.toAddress;
                                 var frId = _.find($scope.customerList,{id:data.fromCustId});
                                 var toId = _.find($scope.customerList,{id:data.toCustId});
                                 $scope.frCust = frId.id;
                                 $scope.toCust = toId.id;

                             }
                             else{
                                 $scope.disableTripRate = true;
                             }

                         });
             };


             $scope.showTotalTripAmount = function(){
                 doTotalTripAmount();
             };

             $scope.showBalance = function(){
//                 $scope.balance = parseFloat($scope.totalTripRate) - parseFloat($scope.advance);
                 $scope.balance = grandTotal - parseFloat($scope.advance);
             };

             function doGrandTotal(){
                 $scope.balance = parseFloat($scope.totalTripRate) - parseFloat($scope.advance);
                 debugger;
             }

             $scope.checkDuplicateInvoice = function(){
                 $http.get("/${grailsApplication.config.erpName}/localTripEntry/checkDuplicateInvoice?no=" + $scope.invoiceNo+"&from="+$scope.fromCustomer+"&to="+$scope.toCustomer)
                         .success(function (data) {
                             if(data[0]){
                                 debugger;
                                 alert("Invoice No:"+data[0].invNo+" Already Exist For Local Entry No:"+data[0].tripNo);
                                 $scope.invoiceNo="";
                             }
                         });
             };

             $scope.saveData = function(){
                 $http.get("/${grailsApplication.config.erpName}/localTripEntry/saveData?fCust="+$scope.frCust+"&tCust="+$scope.toCust+"&tripRate="+$scope.totalTripRate+"&advance="+$scope.advance+"&balance="+$scope.balance+"&vehicle="+$scope.vehicleNo+"&godownId="+$scope.godownId+"&childData="+JSON.stringify($scope.LRData))
                         .success(function (data) {
                             alert(""+data);
                             $scope.LRData = [];
                         });
             }

         }
</script>
<div ng-controller="localController">

<input type="hidden" name="ChildJSON" value="{{LRData}}">
<input type="hidden" name="fromCustomer.id" value="{{fromCustomer}}">
<input type="hidden" name="toCustomer.id" value="{{toCustomer}}">
%{--<input type="hidden" name="godown.id" value="{{godown}}">--}%
<input type="hidden" name="totalTripRate" value="{{totalTripRate}}">
<input type="hidden" name="advance" value="{{advance}}">
<input type="hidden" name="balance" value="{{balance}}">

<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'localOutEntryNo', 'error')} ">
            <td><label for="localOutEntryNo">
                <g:message code="localTripEntry.localOutEntryNo.label" default="Local Out Entry No"/>
                
            </label></td>
            <td><g:textField name="localOutEntryNo" disabled="" value="${localTripEntryInstance?.localOutEntryNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'localOutEntryDate', 'error')} required">
            <td><label for="localOutEntryDate">
                <g:message code="localTripEntry.localOutEntryDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Local Out Entry Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input  type="date"  name="localOutEntryDate"  value="${localTripEntryInstance?.localOutEntryDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>
        </div>

    </tr>


    <tr>

        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'fromCustomer', 'error')} required">
            <td><label for="fromCustomer">
                <g:message code="localTripEntry.fromCustomer.label" default="Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td>
                %{--<g:select id="fromCustomer" name="fromCustomer.id" from="${com.master.AccountMaster.list()}" optionKey="id" required="" value="${localTripEntryInstance?.fromCustomer?.id}" class="many-to-one"/>--}%
            <select id="fromCustomer" class="many-to-one" ng-model="fromCustomer" ng-options="c.id as c.accountName for c in customerList" ng-change="setFromInfo()"></select>

        </td>
        </div>


        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'toCustomer', 'error')} required">
            <td><label for="toCustomer">
                <g:message code="localTripEntry.toCustomer.label" default="&nbsp;&nbsp;&nbsp;&nbsp;PO No."/>
                <span class="required-indicator">*</span>
            </label></td>
            <td>
                %{--<g:select id="toCustomer" name="toCustomer.id" from="${com.master.AccountMaster.list()}" optionKey="id" required="" value="${localTripEntryInstance?.toCustomer?.id}" class="many-to-one"/>--}%

                %{--<select id="toCustomer" ng-model="toCustomer" ng-options="c.id as c.accountName for c in customerList" ng-change="setToInfo()" class="many-to-one"></select>--}%

                <select id="poNo" ng-model="poNo" ng-options="p.id as p.poNo for p in poData" ng-change="doOtherTotal()"></select>


            </td>
        </div>

    </tr>

<tr>
    <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'fromCustomer', 'error')} required">
        <td><label for="fromCustomer">
            <g:message code="localTripEntry.fromCustomer.label" default="From Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td>
            %{--<g:select id="fromCustomer" name="fromCustomer.id" from="${com.master.AccountMaster.list()}" optionKey="id" required="" value="${localTripEntryInstance?.fromCustomer?.id}" class="many-to-one"/>--}%
            <select id="fromCustomer1" class="many-to-one" ng-model="frCust" ng-options="c.id as c.accountName for c in customerList" ng-change="setFromInfo()"></select>

        </td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'fromCustomer', 'error')} required">
        <td><label for="fromCustomer">
            <g:message code="localTripEntry.fromCustomer.label" default="To Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td>
            %{--<g:select id="fromCustomer" name="fromCustomer.id" from="${com.master.AccountMaster.list()}" optionKey="id" required="" value="${localTripEntryInstance?.fromCustomer?.id}" class="many-to-one"/>--}%
            <select id="toCustomer" ng-model="toCust" ng-options="c.id as c.accountName for c in customerList" ng-change="setToInfo()" class="many-to-one"></select>

        </td>
    </div>
</tr>

   <tr>
       <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
           <td><label for="fromLocation">
               <g:message code="LREntry.fromLocation.label" default="From Address"/>

           </label></td>
           <td><textarea disabled=""  ng-model="fromAddress"></textarea></td>
       </div>

       <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
           <td><label for="fromLocation">
               <g:message code="LREntry.fromLocation.label" default="To Address"/>

           </label></td>
           <td><textarea disabled=""  ng-model="toAddress"></textarea></td>
       </div>
   </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'godown', 'error')} required">
            <td><label for="godown">
                <g:message code="localTripEntry.godown.label" default="Godown"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="godown" ng-model="godownId" name="godown.id" from="${com.master.GodownMaster.list()}" optionKey="id" required="" value="${localTripEntryInstance?.godown?.id}" class="many-to-one"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'localOutTime', 'error')} ">
            <td><label for="localOutTime">
                <g:message code="localTripEntry.localOutTime.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Local Out Time"/>

            </label></td>
            <td>
                %{--<input  type="date"  name="localOutTime"  value="${localTripEntryInstance?.localOutTime?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  />--}%
                <input type="time"  name="localOutTime" disabled=""  value="${localTripEntryInstance?.localOutTime?.format('hh:mm:ss') ?: Date.newInstance().format('hh:mm:ss')}" />
            </td>
        </div>
        %{--<div class="input-append bootstrap-timepicker">--}%
            %{--<td>--}%
                %{--<label for="balance">--}%
                    %{--<g:message code="localTripEntry.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Out Time"/>--}%
            %{--</td>--}%
            %{--<td>--}%
                %{--<input type="text" id="timepicker1" name="localOutTime"  disabled=""  class="input-small" />--}%
                %{--<input id="timepicker1" name="localOutTime" type="text" disabled=""  class="input-small" data-template="modal" data-minute-step="1" data-modal-backdrop="true" />--}%
                %{--<span class="add-on"><i class="icon-time"></i></span>--}%
            %{--</td>--}%
        %{--</div>--}%

    </tr>
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'poNo', 'error')} ">--}%
            %{--<td><label for="poNo">--}%
                %{--<g:message code="localTripEntry.poNo.label" default="Po No"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td>--}%
                %{--<g:select id="poNo" name="poNo.id" from="${com.transaction.PurchaseOrder.list()}" optionKey="id" value="${localTripEntryInstance?.poNo?.id}" class="many-to-one" noSelection="['null': '']"/>--}%

                %{--<select id="poNo" ng-model="poNo" ng-options="p.id as p.poNo for p in poData" ng-change="doOtherTotal()"></select>--}%
            %{--</td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'transportName', 'error')} ">--}%
            %{--<td><label for="transportName">--}%
                %{--<g:message code="localTripEntry.transportName.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Transport Name"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="transportName" value="${localTripEntryInstance?.transportName}"/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'driverName', 'error')} ">--}%
            %{--<td><label for="driverName">--}%
                %{--<g:message code="localTripEntry.driverName.label" default="Driver Name"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><g:textField name="driverName" value="${localTripEntryInstance?.driverName}"/></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'ownerName', 'error')} ">--}%
            %{--<td><label for="ownerName">--}%
                %{--<g:message code="localTripEntry.ownerName.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Owner Name"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="ownerName" value="${localTripEntryInstance?.ownerName}"/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'address', 'error')} ">--}%
            %{--<td><label for="address">--}%
                %{--<g:message code="localTripEntry.address.label" default="Address"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><g:textField name="address" value="${localTripEntryInstance?.address}"/></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'phoneNo', 'error')} ">--}%
            %{--<td><label for="phoneNo">--}%
                %{--<g:message code="localTripEntry.phoneNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Phone No"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="phoneNo" value="${localTripEntryInstance?.phoneNo}"/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%

    <tr>
        <div>
            <td ><label for="vehicleNo">
                <g:message code="localTripEntry.vehicleNo.label" default="Vehicle No"/>
                
            </label></td>
            <td ng-hide="ManualVehicle"><g:select id="vehicleNo" ng-model="vehicleNo" name="vehicleNo.id" from="${com.master.VehicleMaster.findAllByIsActive(true)}" optionKey="id" value="${localTripEntryInstance?.vehicleNo?.id}" class="many-to-one" noSelection="['null': '']"/></td>
            <td ng-show="ManualVehicle"><g:textField id="vehicleManual" name="vehicleManual" value="${localTripEntryInstance?.vehicleManual}"/></td>
        </div>

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'vehicleManual', 'error')} ">--}%
            %{--<td><label for="vehicleManual">--}%
                %{--<g:message code="localTripEntry.vehicleManual.label" default="Vehicle Manual"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="vehicleManual" value="${localTripEntryInstance?.vehicleManual}"/></td>--}%
        %{--</div>--}%



        <div>
            <td><label for="manualVehicleNo">
                <g:message code="localTripEntry.manualVehicleNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Manual Vehicle No"/>

            </label></td>
            <td><input type="checkbox" name="checkManualVehicle" ng-model="checkManualVehicle" ng-change="showHideVehicleNo()" />
                <span class="lbl"></span> </td>
        </div>

    </tr>
    


    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselReceiptDate', 'error')} ">--}%
            %{--<td><label for="dieselReceiptDate">--}%
                %{--<g:message code="localTripEntry.dieselReceiptDate.label" default="Diesel Receipt Date"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><input  type="date"  name="dieselReceiptDate"  value="${localTripEntryInstance?.dieselReceiptDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselLtr', 'error')} ">--}%
            %{--<td><label for="dieselLtr">--}%
                %{--<g:message code="localTripEntry.dieselLtr.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Ltr"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="dieselLtr" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselLtr')}"/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    %{----}%

    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselRate', 'error')} ">--}%
            %{--<td><label for="dieselRate">--}%
                %{--<g:message code="localTripEntry.dieselRate.label" default="Diesel Rate"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><g:textField name="dieselRate" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselRate')}"/></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselAmount', 'error')} ">--}%
            %{--<td><label for="dieselAmount">--}%
                %{--<g:message code="localTripEntry.dieselAmount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Amount"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="dieselAmount" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselAmount')}"/></td>--}%
        %{--</div>--}%
    %{--</tr>--}%
    %{----}%
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'pumpName', 'error')} ">--}%
            %{--<td><label for="pumpName">--}%
                %{--<g:message code="localTripEntry.pumpName.label" default="Pump Name"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><g:textField name="pumpName" value="${localTripEntryInstance?.pumpName}"/></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'freight', 'error')} required">--}%
            %{--<td><label for="freight">--}%
                %{--<g:message code="localTripEntry.freight.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Freight"/>--}%
                %{--<span class="required-indicator">*</span>--}%
            %{--</label></td>--}%
            %{--<td><g:textField name="freight" value="${fieldValue(bean: localTripEntryInstance, field: 'freight')}" required=""/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    %{----}%
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'totalTripRate', 'error')} required">--}%
            %{--<td><label for="totalTripRate">--}%
                %{--<g:message code="localTripEntry.totalTripRate.label" default="Total Trip Rate"/>--}%
                %{--<span class="required-indicator">*</span>--}%
            %{--</label></td>--}%
            %{--<td><g:textField name="totalTripRate" value="${fieldValue(bean: localTripEntryInstance, field: 'totalTripRate')}" required=""/></td>--}%
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'advance', 'error')} ">--}%
            %{--<td><label for="advance">--}%
                %{--<g:message code="localTripEntry.advance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Advance"/>--}%

            %{--</label></td>--}%
            %{--<td><g:textField name="advance" value="${fieldValue(bean: localTripEntryInstance, field: 'advance')}"/></td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    %{----}%

    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'balance', 'error')} ">--}%
            %{--<td><label for="balance">--}%
                %{--<g:message code="localTripEntry.balance.label" default="Balance"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td><g:textField name="balance" value="${fieldValue(bean: localTripEntryInstance, field: 'balance')}"/></td>--}%
        %{--</div>--}%



    %{--</tr>--}%
    
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'localOutEntryDetails', 'error')} ">--}%
            %{--<td><label for="localOutEntryDetails">--}%
                %{--<g:message code="localTripEntry.localOutEntryDetails.label" default="Local Out Entry Details"/>--}%
                %{----}%
            %{--</label></td>--}%
            %{--<td>--}%
%{--<ul class="one-to-many">--}%
%{--<g:each in="${localTripEntryInstance?.localOutEntryDetails?}" var="l">--}%
    %{--<li><g:link controller="localOutEntryDetails" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>--}%
%{--</g:each>--}%
%{--<li class="add">--}%
%{--<g:link controller="localOutEntryDetails" action="create" params="['localTripEntry.id': localTripEntryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'localOutEntryDetails.label', default: 'LocalOutEntryDetails')])}</g:link>--}%
%{--</li>--}%
%{--</ul>--}%
%{--</td>--}%
        %{--</div>--}%

    %{--</tr>--}%
    
</table>

<hr>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Product Name</td>

            <td>Manual Product</td>

            <td>Invoice No</td>

            <td>Unit</td>

            <td>Qty.</td>

        </tr>
        </thead>
        <tbody>
        <tr>

            <td ng-hide="showProduct"><select id="productName" ng-model="productName" ng-options="p.id as p.productName for p in productList" ng-change="setProductInfo()" style="width: 150px"/></td>
            <td ng-show="showProduct"><input type="text" name="manualProductName" ng-model="manualProductName" /> </td>
            <td><input type="checkbox" name="checkManualProduct" ng-model="checkManualProduct" ng-change="showHideProduct()" /><span class="lbl"></span></td>
            <td><input type="text" name="invoiceNo" ng-model="invoiceNo" ng-blur="checkDuplicateInvoice()" /></td>
            <td><select ng-model="unit" style="width: 70px" ng-options="u.id as u.unitName for u in unitList"/></td>
            <td><input type="text" ng-model="qty" style="width: 50px" ng-focus="focusAlert()" ng-change="qty=isNumber(qty);gettAmount()"/></td>

        </tr>
        </tbody>
    </table>
</div>

<hr>
<table>
    <tr>
        <td>
            <button type="button" class="btn btn-mini btn-inverse" ng-click="addData()">Add</button>
        </td>
        <td>
            <div ng-show="updateButton">
                <button type="button" class="btn btn-mini btn-inverse" ng-click="update()">Update</button>
            </div>
        </td>
    </tr>
</table>

<div role="grid" class="dataTables_wrapper" id="sample-table-5_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-5"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Action</td>
            <td>Product</td>
            <td>Invoice No</td>
            <td>Unit</td>
            <td>Qty.</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in LRData | filter : searchItem | filter:new_search">

            <td><button type="button" ng-click="edit($index)"
                        style="border: none; background: transparent; color: #08c">
                <i class="icon-pencil bigger-130"></i>
            </button>
                <button type="button" value="delete" ng-click="remove($index)"
                        style="border: none; background: transparent">
                    <img src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"></button>
            </td>

            <td>{{d.productName}}</td>
            <td>{{d.invoiceNo}}</td>
            <td>{{d.unitId}}</td>
            <td>{{d.qty}}</td>

        </tr>
        </tbody>
    </table>
</div>
<hr>
<table>
%{--<tr>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselReceiptNo', 'error')} ">--}%
        %{--<td><label for="dieselReceiptNo">--}%
            %{--<g:message code="localTripEntry.dieselReceiptNo.label" default="Diesel Receipt No"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="dieselReceiptNo" value="${localTripEntryInstance?.dieselReceiptNo}"/></td>--}%
    %{--</div>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselReceiptDate', 'error')} ">--}%
        %{--<td><label for="dieselReceiptDate">--}%
            %{--<g:message code="localTripEntry.dieselReceiptDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Receipt Date"/>--}%

        %{--</label></td>--}%
        %{--<td><input  type="date"  name="dieselReceiptDate"  value="${localTripEntryInstance?.dieselReceiptDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>--}%
    %{--</div>--}%

%{--</tr>--}%


%{--<tr>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselLtr', 'error')} ">--}%
        %{--<td><label for="dieselLtr">--}%
            %{--<g:message code="localTripEntry.dieselLtr.label" default="Diesel Ltr"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="dieselLtr" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselLtr')}"/></td>--}%
        %{--<td><input type="text" id="dieselLtr" ng-model="dieselLtr" required="" ng-change="dieselLtr=isNumber(dieselLtr);showDieselAmount()" value="${outEntryInstance?.dieselLtr}"/></td>--}%

    %{--</div>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselRate', 'error')} ">--}%
        %{--<td><label for="dieselRate">--}%
            %{--<g:message code="localTripEntry.dieselRate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Diesel Rate"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="dieselRate" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselRate')}"/></td>--}%
        %{--<td><input type="text" id="dieselRate" ng-model="dieselRate" ng-change="dieselRate=isNumber(dieselRate);showDieselAmount()"--}%
        %{--value="${outEntryInstance?.dieselRate}"/></td>--}%
    %{--</div>--}%


%{--</tr>--}%

%{--<tr>--}%
    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'dieselAmount', 'error')} ">--}%
        %{--<td><label for="dieselAmount">--}%
            %{--<g:message code="localTripEntry.dieselAmount.label" default="Diesel Amount"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="dieselAmount" value="${fieldValue(bean: localTripEntryInstance, field: 'dieselAmount')}"/></td>--}%
        %{--<td><input type="text" id="dieselAmount" ng-model="dieselAmount" ng-change="dieselAmount=isNumber(dieselAmount)" disabled="" value="${outEntryInstance?.dieselAmount}"/></td>--}%

    %{--</div>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'pumpName', 'error')} ">--}%
        %{--<td><label for="pumpName">--}%
            %{--<g:message code="localTripEntry.pumpName.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Pump Name"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="pumpName" value="${localTripEntryInstance?.pumpName}"/></td>--}%
    %{--</div>--}%



%{--</tr>--}%

<tr>

    %{--<div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'freight', 'error')} required">--}%
        %{--<td><label for="freight">--}%
            %{--<g:message code="localTripEntry.freight.label" default="Freight"/>--}%
            %{--<span class="required-indicator">*</span>--}%
        %{--</label></td>--}%
        %{--<td><g:textField name="freight" value="${fieldValue(bean: localTripEntryInstance, field: 'freight')}" required=""/></td>--}%
        %{--<td><input type="text" id="freight" ng-model="freight" ng-change="freight=isNumber(freight);showTotalTripAmount()" value="${outEntryInstance?.freight}"/></td>--}%

    %{--</div>--}%

    <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'totalTripRate', 'error')} required">
        <td ng-show="showField"><label for="totalTripRate">
            <g:message code="localTripEntry.totalTripRate.label" default="Total Trip Rate"/>
            <span class="required-indicator">*</span>
        </label></td>
        %{--<td><g:textField name="totalTripRate" value="${fieldValue(bean: localTripEntryInstance, field: 'totalTripRate')}" required=""/></td>--}%
        <td ng-show="showField"><input type="text" id="totalTripRate"  ng-change="totalTripRate=isNumber(totalTripRate);getGrandTotal()" ng-model="totalTripRate" value="${outEntryInstance?.totalTripRate}"/></td>

    </div>

</tr>


<tr>

    <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'advance', 'error')} ">
        <td ng-show="showField"><label for="advance">
            <g:message code="localTripEntry.advance.label" default="Advance"/>

        </label></td>
        %{--<td><g:textField name="advance" value="${fieldValue(bean: localTripEntryInstance, field: 'advance')}"/></td>--}%
        <td ng-show="showField"><input type="text" id="advance" ng-model="advance" ng-change="advance=isNumber(advance);getGrandTotal()" value="${outEntryInstance?.advance}"/></td>

    </div>

    <div class="fieldcontain ${hasErrors(bean: localTripEntryInstance, field: 'balance', 'error')} ">
        <td ng-show="showField"><label for="balance">
            <g:message code="localTripEntry.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Grand Total"/>

        </label></td>
        <td ng-show="showField">
            %{--<g:textField name="balance" value="${fieldValue(bean: localTripEntryInstance, field: 'balance')}"/>--}%
            <input type="text" id="balance" ng-model="balance" ng-change="balance=isNumber(balance)" disabled="" value="${outEntryInstance?.balance}"/>
        </td>
    </div>

</tr>


</table>

<div>
    <input type="button" ng-click="saveData()" class="btn btn-primary btn-mini" value="Create" />
</div>

</div>