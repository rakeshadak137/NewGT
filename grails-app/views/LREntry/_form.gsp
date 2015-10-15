<%@ page import="com.transaction.LREntry" %>
<script>

    $(document).ready(function () {
        $("#fromCustomer").searchable();
        $("#toCustomer").searchable();
        $("#vehicleNo").searchable();
        $("#poNo").searchable();
        $("#billPayTypeAuto").searchable();
        $("#productName").searchable();
        $("#goDown").searchable();
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

    function LREntryContoller($scope, $http) {
        init();

        function init() {

            $scope.showButton = true;
            $scope.createDisable = true;
            $scope.billString="";
            $scope.billTypeString="";
            $scope.rateCalculate = false;
            $scope.typeOfBill = false;
            $scope.showField = "${session['activeUser'].admin}";
            debugger;
            $http.get("/${grailsApplication.config.erpName}/LREntry/findCustomerList")
                    .success(function(data){
                        $scope.customerList=data;
                    });
            %{--$scope.customerList = ${com.master.AccountMaster.findAllByIsActive(true) as grails.converters.JSON};--}%
            $http.get("/${grailsApplication.config.erpName}/LREntry/findProductList")
                    .success(function(data){
                        $scope.productList=data;
                    });
            %{--$scope.productList = ${com.master.ProductMaster.findAllByIsActive(true) as grails.converters.JSON};--}%
            $http.get("/${grailsApplication.config.erpName}/LREntry/findUnitList")
                    .success(function(data){
                        $scope.unitList=data;
                    });
            %{--$scope.unitList = ${com.master.UnitMaster.findAllByIsActive(true) as grails.converters.JSON};--}%
            $scope.billPayTypeList = [{'s':'To Be Billed'},{'s':'Paid'},{'s':'To Pay'}];
            $scope.billPayType = $scope.billPayTypeList[0].s;

            $scope.vehicleList = [];
            $http.get("/${grailsApplication.config.erpName}/internalMemo/showVehicleNo")
                    .success(function(data){
                        $scope.vehicleList=data;
                    });

            $scope.unitId = 0;
            $scope.poData = [];
            $scope.totalAmount = 0;
            $scope.grandTotal = 0;
            $scope.amount = 0;
            $scope.qty = 0;
            $scope.invoiceQty = 0;
            $scope.LRData = [];
            $scope.updateButton = false;

            $scope.rate = 0;
            $scope.weight = 0;
            $scope.tAmount = 0;

            $scope.freight = 0;
            $scope.loading = 0;
            $scope.unloading = 0;
            $scope.collection = 0;
            $scope.cartage = 0;
            $scope.cata = 0;
            $scope.bilty = 0;
            $scope.doorDelivery = 0;

            $scope.autoCustomerAddress = true;
            $scope.autoCustomer = true;
            $scope.autoLocation = true;
            $scope.autoTable = true;
            $scope.autopo = true;

            <g:if test="${LREntryInstance?.id}">
            debugger;
            if("${LREntryInstance?.fromCustomer?.id}" && "${LREntryInstance?.toCustomer?.id}"){
                debugger;
                $scope.manualCustomerAddress = false;
                $scope.autoCustomerAddress = true;
                $scope.autoCustomer = true;
                $scope.manualCustomer = false;
                $scope.manualLocation = false;
                $scope.autoLocation = true;
                $scope.autoTable = true;
                $scope.manualTable = false;
                $scope.autopo = true;
                $scope.manualpo = false;
            }
            else{
                $scope.manualCustomerAddress = true;
                $scope.autoCustomerAddress = false;
                $scope.autoCustomer = false;
                $scope.manualCustomer = true;
                $scope.manualLocation = true;
                $scope.autoLocation = false;
                $scope.autoTable = false;
                $scope.manualTable = true;
                $scope.autopo = false;
                $scope.manualpo = true;
            }

            $scope.freight = ${LREntryInstance?.freight};
            $scope.loading = ${LREntryInstance?.loading};
            $scope.unloading = ${LREntryInstance?.unloading};
            $scope.collection = ${LREntryInstance?.collection};
            $scope.cartage = ${LREntryInstance?.cartage};
            $scope.cata = ${LREntryInstance?.cata};
            $scope.bilty = ${LREntryInstance?.bilty};
            $scope.doorDelivery = ${LREntryInstance?.doorDelivery};
            $scope.billPayType = "${LREntryInstance?.billPayType}";
            $scope.vehicleNo = ${LREntryInstance?.vehicleNo?.id};

            var id = "${LREntryInstance?.id}";
            $http.get("/${grailsApplication.config.erpName}/LREntry/getData?id=" + id)
                    .success(function (data) {
                        $scope.LRData = data;
                        checkLength();
                    });

            $http.get("/${grailsApplication.config.erpName}/LREntry/getOtherData?id=" + id)
                    .success(function (data) {
                        $scope.fromCustomer = data.fromCustomerID;
                        $scope.toCustomer = data.toCustomerID;
                        $scope.fromLocation = data.fromLocation;
                        $scope.toLocation = data.toLocation;
                        $scope.fromAddress = data.fromAddress;
                        $scope.toAddress = data.toAddress;
                        $scope.amount = data.amount;
                        $scope.totalAmount = data.totalAmount;
                        $scope.grandTotal = data.grandTotal;

                        if(data.billingType=="Weight"){
                            $scope.rateCalculate = true
                        }
                        else if(data.billingType=="Weight And Pieces"){
                            $scope.typeOfBill = true;
                        }

                        $http.get("/${grailsApplication.config.erpName}/LREntry/getPOData?id=" + data.fromCustomerID +"&id1=" + data.toCustomerID)
                                .success(function (data) {
                                    $scope.poData = data;
                                });

                        $scope.poNo = data.poID;
                    });
            $scope.createDisable = false;

            </g:if>
        }

        $scope.setFromInfo = function(){
            debugger;
            var custId = "";
            if($scope.billingTypeTo){
                custId = $scope.toCustomer;
                debugger;
            }
            else{
                custId = $scope.fromCustomer;
                debugger;
            }
            if($scope.fromCustomer) {
                $http.get("/${grailsApplication.config.erpName}/LREntry/getCustomerData?id=" + $scope.fromCustomer)
                        .success(function (data) {
                            debugger;
                            $scope.fromAddress = data.address;
                            $scope.fromLocation = data.city;
                            debugger;
                            if(data.billingType=="Weight"){
                                $scope.rateCalculate = true
                            }
                            else if(data.billingType=="Weight And Pieces"){
                                $scope.typeOfBill = true;
                            }
                        });

                $http.get("/${grailsApplication.config.erpName}/LREntry/getItemData?id=" + $scope.fromCustomer)
                        .success(function (data) {
                            debugger;
                            if (data) {
                                debugger;
                                $scope.productList = data;
                            }
                        });
                debugger;
                var v = _.find($scope.customerList,{id:$scope.fromCustomer});
                debugger;
                if(v && v.billType){
                    %{----}%
                    $scope.billId = v.billType.id;
                    $http.get("/${grailsApplication.config.erpName}/LREntry/findBillType?id=" + $scope.billId)
                            .success(function(data){
                                if(data){
                                    $scope.billTypeString = data;
                                }
                            });
                }
                if ($scope.toCustomer) {
                    $http.get("/${grailsApplication.config.erpName}/LREntry/getPOData?id=" + $scope.fromCustomer + "&id1=" + $scope.toCustomer)
                            .success(function (data) {
                                $scope.poData = data;
                            });
                }
            }
        };

        $scope.isNumber = function(a){
            return isNumberKey(a);
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

        $scope.setProductInfo = function(){
            $http.get("/${grailsApplication.config.erpName}/LREntry/getProductData?id=" + $scope.productName)
                    .success(function (data) {
                        $scope.unitId = data.unitId;
                        $scope.unit = data.unitName;
                        $scope.rate = data.rate;
                        $scope.weight = data.weight;
                    });
        };

        $scope.gettAmount = function(){
            $scope.tAmount = 0;
            debugger;
            if($scope.rateCalculate){
                debugger;
                $scope.tAmount = parseFloat($scope.weight) * parseFloat($scope.rate);
            }
            else if($scope.typeOfBill){
                debugger;
                $scope.tAmount = (parseFloat($scope.qty)* parseFloat($scope.weight)) * parseFloat($scope.rate);
            }
            else{
                debugger;
                $scope.tAmount = parseFloat($scope.qty) * parseFloat($scope.rate);
            }
        };

        $scope.setTotalAmount = function(){
            var l = $scope.LRData.length;
            var total = 0;
            var total1 = 0;
            total1 = parseFloat($scope.freight) + parseFloat($scope.loading) + parseFloat($scope.bilty)  + parseFloat($scope.unloading)+
                    parseFloat($scope.collection) + parseFloat($scope.cartage) + parseFloat($scope.cata) + parseFloat($scope.doorDelivery);

            for (var i = 0; i < l; i++) {
                total += parseFloat($scope.LRData[i].tAmount)
            }
            $scope.grandTotal = (parseFloat(total) + total1) - parseFloat($scope.amount);
        };

        $scope.remove = function (index) {
            $scope.value = false;
            $scope.LRData.splice(index, 1);
            validLength = $scope.LRData.length;
            checkLength();
            getGrandTotal();
        };

        function checkLength() {
            if ($scope.LRData.length > 0) {
                valid = true;
            }
            else {
                valid = false;
            }
        }

        $scope.addData = function(){
            if($scope.LRData.length >= 20){
                alert("List Full. You Can Not Add More Than 20 Items");
                doBlank();
                return false;
            }
//            debugger;
//            if($scope.LRData.length >= 1){
//
//                $scope.createDisable = false;
//                debugger;
//            }
//            debugger;
            else{
                $scope.unitData = _.find($scope.unitList, {id: $scope.invoiceUnit});
                $scope.productData = _.find($scope.productList, {id: $scope.productName});

                $scope.LRData.push(
                        {
                            productId: $scope.productData.id,
                            productName: $scope.productData.productCode +'-'+ $scope.productData.productName,
                            invoiceNo: $scope.invoiceNo,
                            qty: $scope.qty,
                            unitId: $scope.unitId,
                            unitName: $scope.unit,
                            invoiceQty: $scope.invoiceQty,
                            invoiceUnitId: $scope.unitData.id,
                            invoiceUnitName: $scope.unitData.unitName,
                            rate: $scope.rate,
                            weight: $scope.weight,
                            tAmount: $scope.tAmount
                        }
                );
                $scope.createDisable = false;
                debugger;
                doBlank();
                getGrandTotal();
            }
        };

        function doBlank(){
            $scope.productName = "";
            $scope.invoiceNo = "";
            $scope.qty = 0;
            $scope.unit = "";
            $scope.invoiceQty = 0;
            $scope.invoiceUnit = "";
            $scope.rate = 0;
            $scope.weight = 0;
            $scope.tAmount = 0;
        }

        function getGrandTotal(){
            var l = $scope.LRData.length;
            var total = 0;
            var total1 = 0;
            total1 = parseFloat($scope.freight) + parseFloat($scope.loading) + parseFloat($scope.bilty)  + parseFloat($scope.unloading)+
                    parseFloat($scope.collection) + parseFloat($scope.cartage) + parseFloat($scope.cata) + parseFloat($scope.doorDelivery);

            for (var i = 0; i < l; i++) {
                total += parseFloat($scope.LRData[i].tAmount)
            }
            $scope.totalAmount = total;
            $scope.grandTotal = (parseFloat($scope.totalAmount) + total1) - parseFloat($scope.amount);
        }

        $scope.edit = function (index) {
            debugger;
            $scope.productName = $scope.LRData[index].productId;
            $scope.invoiceNo = $scope.LRData[index].invoiceNo;
            $scope.qty = $scope.LRData[index].qty;
            $scope.unit = $scope.LRData[index].unitName;
            $scope.unitId = $scope.LRData[index].unitId;
            $scope.invoiceQty = $scope.LRData[index].invoiceQty;
            $scope.invoiceUnit = $scope.LRData[index].invoiceUnitId;
            $scope.rate = $scope.LRData[index].rate;
            $scope.weight = $scope.LRData[index].weight;
            $scope.tAmount = $scope.LRData[index].tAmount;
            $scope.indexing = index;
            $scope.updateButton = true
        };

        $scope.update = function (){
            $scope.updateButton = false;

            $scope.unitData = _.find($scope.unitList, {id: $scope.invoiceUnit});
            $scope.productData = _.find($scope.productList, {id: $scope.productName});
            debugger;
            $scope.LRData[$scope.indexing].productId = $scope.productData.id;
            $scope.LRData[$scope.indexing].productName = $scope.productData.productCode +'-'+ $scope.productData.productName;
            $scope.LRData[$scope.indexing].invoiceNo = $scope.invoiceNo;
            $scope.LRData[$scope.indexing].qty = $scope.qty;
            $scope.LRData[$scope.indexing].unitId = $scope.unitId;
            $scope.LRData[$scope.indexing].unitName = $scope.unit;
            $scope.LRData[$scope.indexing].invoiceQty = $scope.invoiceQty;
            $scope.LRData[$scope.indexing].invoiceUnitId = $scope.unitData.id;
            $scope.LRData[$scope.indexing].invoiceUnitName = $scope.unitData.unitName;
            $scope.LRData[$scope.indexing].rate = $scope.rate;
            $scope.LRData[$scope.indexing].weight = $scope.weight;
            $scope.LRData[$scope.indexing].tAmount = $scope.tAmount;

            doBlank();
            checkLength();
            getGrandTotal();
        };

        $scope.showManual = function(bool){
            $scope.fromCustomer = "";
            $scope.toCustomer = "";
            $scope.fromCustomerManual = "";
            $scope.toCustomerManual = "";
            $scope.fromAddress = "";
            $scope.toAddress = "";
            $scope.fromLocation = "";
            $scope.toLocation  = "";
            $scope.poNo  = "";
            $scope.billPayType  = "";
            $scope.LRData  = [];

            $scope.freight = 0;
            $scope.loading = 0;
            $scope.unloading = 0;
            $scope.collection = 0;
            $scope.cartage = 0;
            $scope.cata = 0;
            $scope.bilty = 0;
            $scope.doorDelivery = 0;

            $scope.amount  = 0;
            $scope.totalAmount  = 0;
            $scope.grandTotal  = 0;

            if(bool){
                $scope.manualCustomerAddress = true;
                $scope.autoCustomerAddress = false;
                $scope.autoCustomer = false;
                $scope.manualCustomer = true;
                $scope.manualLocation = true;
                $scope.autoLocation = false;
                $scope.autoTable = false;
                $scope.manualTable = true;
                $scope.autopo = false;
                $scope.manualpo = true;
            }
            else{
                $scope.manualCustomerAddress = false;
                $scope.autoCustomerAddress = true;
                $scope.autoCustomer = true;
                $scope.manualCustomer = false;
                $scope.manualLocation = false;
                $scope.autoLocation = true;
                $scope.autoTable = true;
                $scope.manualTable = false;
                $scope.autopo = true;
                $scope.manualpo = false;
            }
        };

        $scope.doOtherTotal = function(){
            $http.get("/${grailsApplication.config.erpName}/LREntry/getOtherChild?id=" + $scope.poNo)
                    .success(function (data) {
                        $scope.freight = data.freight;
                        $scope.loading = data.loading;
                        $scope.unloading = data.unloading;
                        $scope.collection = data.collection;
                        $scope.cartage = data.cartage;
                        $scope.cata = data.cata;
                        $scope.bilty = data.bilty;
                        $scope.doorDelivery = data.doorDelivery;

                        getGrandTotal();
                    });
        };

        $scope.setGrandTotal = function(){
            var l = $scope.LRData.length;
            var total = 0;
            var total1 = 0;
            total1 = parseFloat($scope.freight) + parseFloat($scope.loading) + parseFloat($scope.bilty)  + parseFloat($scope.unloading)+
                    parseFloat($scope.collection) + parseFloat($scope.cartage) + parseFloat($scope.cata) + parseFloat($scope.doorDelivery);

            for (var i = 0; i < l; i++) {
                total += parseFloat($scope.LRData[i].tAmount)
            }
            $scope.totalAmount = total;
            $scope.grandTotal = (parseFloat($scope.totalAmount) + total1) - parseFloat($scope.amount);
        };

        $scope.showManualData = function(bool){
            if(bool){
                $scope.manualTable = true;
                $scope.autoTable = false;
            }else{
                $scope.manualTable = false;
                $scope.autoTable = true;
            }
        };

        $scope.checkInvoiceNo = function(){
            $http.get("/${grailsApplication.config.erpName}/LREntry/checkDuplicateInvoiceNo?no=" + $scope.invoiceNo+"&from="+$scope.fromCustomer+"&to="+$scope.toCustomer)
                    .success(function (data) {
                        if(data[0]){
                            debugger;
                            alert("Invoice No:"+data[0].invNo+" Already Exist For LR No:"+data[0].lrNo);
                            $scope.invoiceNo="";
                        }
                    });
        };

        $scope.checkValidations=function(){
            if($scope.poData.length && !$scope.poNo){
                alert("Please Select PO");
                event.preventDefault();
            }
            else{
                $scope.showButton = false;
            }

        };

        $scope.focusAlert=function(){
            debugger;
            if($scope.billTypeString=="Pieces(Nos)"){
                alert("Enter No Of Box/Bags Here ");
            }
            else if($scope.billTypeString=="Weight"){
                alert("Enter Invoice Material Quantity Here");
            }
        };
        $scope.focusAlert2=function(){
            if($scope.billTypeString=="Pieces(Nos)"){
                alert("Enter Invoice Material Quantity Here ");
            }
            else if($scope.billTypeString=="Weight"){
                alert("Enter No Of Box/Bags Here");
            }
        };
        $scope.focusAlert3=function(){
            if($scope.billTypeString=="Pieces(Nos)"){
                alert("Select Unit as Nos");
            }
            else if($scope.billTypeString=="Weight"){
                alert("Select Unit Box/Bags/Bundles");
            }
        }
    }

    function checkAlert(){
        alert("Please check corretct PO for vehicle whether" +
                "\n407(Single Side)/" +
                "\nPickup(Single Side)/" +
                "\n909(Single Side)/" +
                "\n909(Return Side)");
    }
</script>
<body>
<div ng-controller="LREntryContoller">
<input type="hidden" name="ChildJSON" value="{{LRData}}">
<input type="hidden" name="fromCustomer.id" value="{{fromCustomer}}">
<input type="hidden" name="toCustomer.id" value="{{toCustomer}}">
<input type="hidden" name="fromAddress" value="{{fromAddress}}">
<input type="hidden" name="toAddress" value="{{toAddress}}">
<input type="hidden" name="fCustomerManual" value="{{fromCustomerManual}}">
<input type="hidden" name="tCustomerManual" value="{{toCustomerManual}}">
<input type="hidden" name="fromLocation" value="{{fromLocation}}">
<input type="hidden" name="toLocation" value="{{toLocation}}">
<input type="hidden" name="poNo" value="{{poNo}}">
<input type="hidden" name="amount" value="{{amount}}">
%{--<input type="hidden" name="totalAmount" value="{{totalAmount}}">--}%
<input type="hidden" name="vehicleNo.id" value="{{vehicleNo}}">
<input type="hidden" name="freight" value="{{freight}}">
<input type="hidden" name="loading" value="{{loading}}">
<input type="hidden" name="unloading" value="{{unloading}}">
<input type="hidden" name="collection" value="{{collection}}">
<input type="hidden" name="cartage" value="{{cartage}}">
<input type="hidden" name="cata" value="{{cata}}">
<input type="hidden" name="bilty" value="{{bilty}}">
<input type="hidden" name="doorDelivery" value="{{doorDelivery}}">
<input type="hidden" name="billPay" value="{{billPayType}}">

<table>


<tr>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'lrNo', 'error')} ">
        <td><label for="lrNo">
            <g:message code="LREntry.lrNo.label" default="Lr No"/>

        </label></td>
        <td><g:textField name="lrNo" disabled="" value="${LREntryInstance?.lrNo}"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'lrDate', 'error')} required">
        <td><label for="lrDate">
            <g:message code="LREntry.lrDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Lr Date"/>
            <span class="required-indicator">*</span>
        </label></td>
        %{--<td><g:datePicker name="lrDate" precision="day"  value="${LREntryInstance?.lrDate}"  /></td>--}%
        <td><input type="date" name="lrDate"
                   value="${LREntryInstance?.lrDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                   required=""/></td></td>
    </div>

    <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" ng-model="bool" ng-change="showManual(bool)"/><span class="lbl">&nbsp;&nbsp;Manual LR</span></td>

</tr>

<tr>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'vehicleNo', 'error')} required">
        <td><label for="vehicleNo">
            <g:message code="LREntry.vehicleNo.label" default="Vehicle No"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td>
            %{--<g:select id="vehicleNo" name="vehicleNo.id" onchange="checkAlert()" from="${com.master.VehicleMaster.findAllByIsActive(true)}" optionKey="id" value="${LREntryInstance?.vehicleNo?.id}" class="many-to-one"/>--}%
        <select ng-model="vehicleNo" ng-options="v.id as v.vehicleNo for v in vehicleList" required="" id="vehicleNo" onchange="checkAlert()"
                value="${LREntryInstance?.vehicleNo?.id}" class="many-to-one"></select>
        </td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'driverName', 'error')} required">
        <td><label for="driverName">
            <g:message code="LREntry.driverName.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Driver Name"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><g:select id="driverName" name="driverName.id" from="${com.master.DriverMaster.findAllByIsActive(true)}" optionKey="id" value="${LREntryInstance?.driverName?.id}" class="many-to-one"/></td>
    </div>

    %{--<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" ng-model="billingTypeTo" name="billingTypeTo" ng-change="setFromInfo()"/><span class="lbl">&nbsp;&nbsp;Billing Type To</span></td>--}%

</tr>

<tr ng-show="autoCustomer">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromCustomer', 'error')}">
        <td><label for="fromCustomer">
            <g:message code="LREntry.fromCustomer.label" default="From Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><select id="fromCustomer" class="input-mini" ng-model="fromCustomer" ng-options="c.id as c.accountName for c in customerList" ng-change="setFromInfo()"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toCustomer', 'error')} ">
        <td><label for="toCustomer">
            <g:message code="LREntry.toCustomer.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        %{--<td><g:select id="toCustomer" name="toCustomer.id" from="${com.master.AccountMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${LREntryInstance?.toCustomer?.id}" class="many-to-one"/></td>--}%
        <td><select id="toCustomer" ng-model="toCustomer" ng-options="c.id as c.accountName for c in customerList" ng-change="setToInfo()" class="many-to-one"/></td>
    </div>

</tr>

<tr ng-show="manualCustomer">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromCustomer', 'error')}">
        <td><label for="fromCustomer">
            <g:message code="LREntry.fromCustomer.label" default="From Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><input type="text" ng-model="fromCustomerManual"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toCustomer', 'error')} ">
        <td><label for="toCustomer">
            <g:message code="LREntry.toCustomer.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Customer"/>
            <span class="required-indicator">*</span>
        </label></td>
        %{--<td><g:select id="toCustomer" name="toCustomer.id" from="${com.master.AccountMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${LREntryInstance?.toCustomer?.id}" class="many-to-one"/></td>--}%
        <td><input type="text" ng-model="toCustomerManual" /></td>
    </div>

</tr>


<tr ng-show="autoCustomerAddress">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
        <td><label for="fromLocation">
            <g:message code="LREntry.fromLocation.label" default="Address"/>

        </label></td>
        <td><textarea disabled=""  ng-model="fromAddress"></textarea></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toAddress', 'error')} ">
        <td><label for="toAddress">
            <g:message code="LREntry.toLocation.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Address"/>

        </label></td>
        <td><textarea disabled="" ng-model="toAddress"></textarea></td>
    </div>

</tr>

<tr ng-show="manualCustomerAddress">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
        <td><label for="fromLocation">
            <g:message code="LREntry.fromLocation.label" default="Address"/>

        </label></td>
        <td><textarea  ng-model="fromAddress"></textarea></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toAddress', 'error')} ">
        <td><label for="toAddress">
            <g:message code="LREntry.toLocation.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Address"/>

        </label></td>
        <td><textarea ng-model="toAddress"></textarea></td>
    </div>

</tr>

<tr ng-show="autoLocation">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
        <td><label for="fromLocation">
            <g:message code="LREntry.fromLocation.label" default="From Location"/>

        </label></td>
        <td><input type="text" disabled="" name="fromLocationAuto" ng-model="fromLocation"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toLocation', 'error')} ">
        <td><label for="toLocation">
            <g:message code="LREntry.toLocation.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Location"/>

        </label></td>
        <td><input type="text" disabled="" name="toLocationAuto" ng-model="toLocation"/></td>
    </div>

</tr>

<tr ng-show="manualLocation">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'fromLocation', 'error')} ">
        <td><label for="fromLocation">
            <g:message code="LREntry.fromLocation.label" default="From Location"/>

        </label></td>
        <td><input type="text" name="fromLocationManual" ng-model="fromLocation"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'toLocation', 'error')} ">
        <td><label for="toLocation">
            <g:message code="LREntry.toLocation.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Location"/>

        </label></td>
        <td><input type="text" name="toLocationManual" ng-model="toLocation"/></td>
    </div>

</tr>

<tr ng-show="autopo">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'poNO', 'error')} ">
        <td><label for="poNO">
            <g:message code="LREntry.poNO.label" default="Po NO"/>

        </label></td>
        <td><select id="poNo" ng-model="poNo" ng-options="p.id as p.poNo for p in poData" ng-change="doOtherTotal()"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'billPayType', 'error')} ">
        <td><label for="billPayType">
            <g:message code="LREntry.billPayType.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Bill Pay Type"/>

        </label></td>
        <td><select id="billPayTypeAuto" name="billPayTypeAuto" ng-model="billPayType" ng-options="s.s as s.s for s in billPayTypeList"/></td>
    </div>

</tr>

<tr ng-show="manualpo">

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'poNO', 'error')} ">
        <td><label for="poNO">
            <g:message code="LREntry.poNO.label" default="Po NO"/>

        </label></td>
        <td><select ng-model="poNo" disabled="" ng-options="p.id as p.poNo for p in poData"/></td>
    </div>

    <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'billPayType', 'error')} ">
        <td><label for="billPayType">
            <g:message code="LREntry.billPayType.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Bill Pay Type"/>

        </label></td>
        <td><select name="billPayTypeManual" ng-model="billPayType" ng-options="s.s as s.s for s in billPayTypeList"/></td>
    </div>

</tr>



</table>



<hr>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Product Name</td>

            <td>Invoce No</td>

            <td>Qty/Boxes/KG./Bags</td>

            <td>Unit</td>

            <td>Invoice Qty</td>

            <td>Invoice Unit</td>

            <td ng-show="showField">Rate</td>

            <td>Weight</td>

            <td ng-show="showField">Total Amount</td>

        </tr>
        </thead>
        <tbody>
        <tr>

            <td><select id="productName" ng-model="productName" ng-options="p.id as p.productCode+'-'+p.productName for p in productList" ng-change="setProductInfo()" style="width: 150px"/></td>
            <td><input type="text" ng-model="invoiceNo" style="width: 50px" ng-change="invoiceNo=isNumber(invoiceNo)" ng-blur="checkInvoiceNo()"/></td>
            <td><input type="text" ng-model="qty" style="width: 50px" ng-focus="focusAlert()" ng-change="qty=isNumber(qty);gettAmount()" /></td>
            <td><input type="text" ng-model="unit" disabled="" style="width: 50px"/></td>
            <td><input type="text" ng-model="invoiceQty" style="width: 50px" ng-focus="focusAlert2()" ng-change="invoiceQty=isNumber(invoiceQty)"/></td>
            <td><select ng-model="invoiceUnit" style="width: 70px" ng-focus="focusAlert3()" ng-options="u.id as u.unitName for u in unitList"/></td>
            <td ng-show="showField"><input type="text" ng-model="rate" disabled="" style="width: 50px" ng-change="rate=isNumber(rate)"/></td>
            <td><input type="text" ng-model="weight"  style="width: 50px" ng-change="weight=isNumber(weight);gettAmount()"/></td>
            <td ng-show="showField"><input type="text" ng-model="tAmount" disabled="" style="width: 50px" ng-change="tAmount=isNumber(tAmount)"/></td>

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

            <td>Invoice No.</td>

            <td>Qty.</td>

            <td>Unit</td>

            <td>Invoice Qty.</td>

            <td>Invoice Unit</td>

            <td ng-show="showField">Rate</td>

            <td>Weight</td>

            <td ng-show="showField">Total Amount</td>

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
            <td>{{d.qty}}</td>
            <td>{{d.unitName}}</td>
            <td>{{d.invoiceQty}}</td>
            <td>{{d.invoiceUnitName}}</td>
            <td ng-show="showField">{{d.rate}}</td>
            <td>{{d.weight}}</td>
            <td ng-show="showField">{{d.tAmount}}</td>

        </tr>
        </tbody>
    </table>
</div>

<hr>
<table>
    <tr>
        <td><input type="checkbox" ng-model="bool" ng-change="showManualData(bool)"/><span class="lbl">&nbsp;&nbsp;&nbsp;&nbsp;Manual Data Entry</span></td>
    </tr>
</table>
<hr>
<div role="grid" class="dataTables_wrapper" id="sample-table-23_wrapper" ng-show="autoTable">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-32"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Freight</td>

            <td>Loading</td>

            <td>Unloading</td>

            <td>Collection</td>

            <td>Cartage</td>

            <td>Cata</td>

            <td>Bilty</td>

            <td>Door Delivery</td>
        </tr>
        </thead>
        <tbody>
        <tr>

            <td><input type="text" disabled="" ng-model="freight" style="width: 50px" ng-change="freight=isNumber(freight);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="loading" style="width: 50px" ng-change="loading=isNumber(loading);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="unloading" style="width: 50px" ng-change="unloading=isNumber(unloading);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="collection" style="width: 50px" ng-change="collection=isNumber(collection);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="cartage" style="width: 70px" ng-change="cartage=isNumber(cartage);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="cata" style="width: 50px" ng-change="cata=isNumber(cata);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="bilty" style="width: 50px" ng-change="bilty=isNumber(bilty);setGrandTotal()"/></td>
            <td><input type="text" disabled="" ng-model="doorDelivery" style="width: 50px" ng-change="doorDelivery=isNumber(doorDelivery);setGrandTotal()"/></td>

        </tr>
        </tbody>
    </table>
</div>

<div role="grid" class="dataTables_wrapper" id="sample-table-25_wrapper" ng-show="manualTable">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-35"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Freight</td>

            <td>Loading</td>

            <td>Unloading</td>

            <td>Collection</td>

            <td>Cartage</td>

            <td>Cata</td>

            <td>Bilty</td>

            <td>Door Delivery</td>
        </tr>
        </thead>
        <tbody>
        <tr>

            <td><input type="text" ng-model="freight" style="width: 50px" ng-change="freight=isNumber(freight);setGrandTotal()"/></td>
            <td><input type="text" ng-model="loading" style="width: 50px" ng-change="loading=isNumber(loading);setGrandTotal()"/></td>
            <td><input type="text" ng-model="unloading" style="width: 50px" ng-change="unloading=isNumber(unloading);setGrandTotal()"/></td>
            <td><input type="text" ng-model="collection" style="width: 50px" ng-change="collection=isNumber(collection);setGrandTotal()"/></td>
            <td><input type="text" ng-model="cartage" style="width: 70px" ng-change="cartage=isNumber(cartage);setGrandTotal()"/></td>
            <td><input type="text" ng-model="cata" style="width: 50px" ng-change="cata=isNumber(cata);setGrandTotal()"/></td>
            <td><input type="text" ng-model="bilty" style="width: 50px" ng-change="bilty=isNumber(bilty);setGrandTotal()"/></td>
            <td><input type="text" ng-model="doorDelivery" style="width: 50px" ng-change="doorDelivery=isNumber(doorDelivery);setGrandTotal()"/></td>

        </tr>
        </tbody>
    </table>
</div>

<hr>

<table>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'particular', 'error')} ">
            <td><label for="invoiceNo">
                <g:message code="LREntry.invoiceNo.label" default="Invoice No."/>

            </label></td>
            <td><g:textField name="invoiceNo" value="${LREntryInstance?.invoiceNo}"/></td>
        </div>

        <div  class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'invoiceAmount', 'error')} ">
            <td><label for="invoiceAmount">
                <g:message code="LREntry.invoiceAmount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Invoice Amount"/>

            </label></td>
            <td><g:textField name="invoiceAmount" value="${LREntryInstance?.invoiceAmount}"/></td>
        </div>

    </tr>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'particular', 'error')} ">
            <td><label for="particular">
                <g:message code="LREntry.particular.label" default="Particular"/>

            </label></td>
            <td><g:textField name="particular" value="${LREntryInstance?.particular}"/></td>
        </div>

        <div  class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'amount', 'error')} ">
            <td ng-show="showField"><label for="amount">
                <g:message code="LREntry.amount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Amount"/>

            </label></td>
            <td ng-show="showField"><input type="text" ng-model="amount" ng-change="amount=isNumber(amount);setTotalAmount()"/></td>
        </div>

    </tr>

    <tr>

        <div  class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'totalAmount', 'error')} required">
            <td ng-show="showField"><label for="totalAmount">
                <g:message code="LREntry.totalAmount.label" default="Total Amount"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td ng-show="showField"><input type="text" name="totalAmount" ng-model="totalAmount" readonly required=""/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'goDown', 'error')} required">
            <td><label for="goDown">
                <g:message code="LREntry.goDown.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Go Down"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="goDown" name="goDown.id" from="${com.master.GodownMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${LREntryInstance?.goDown?.id}" class="many-to-one"/></td>
        </div>
    </tr>


    <tr>
        <div  class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'grandTotal', 'error')} required">
            <td ng-show="showField"><label for="grandTotal">
                <g:message code="LREntry.grandTotal.label" default="Grand Total"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td ng-show="showField"><input type="text" name="grandTotal" ng-model="grandTotal" readonly required=""/></td>
        </div>

    <div  class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'grandTotal', 'error')} required">
            <td><label for="lcNo">
                <g:message code="LREntry.grandTotal.label" default="&nbsp;&nbsp;&nbsp;&nbsp;LC No"/>
            </label></td>
            <td><input type="text" name="lcNo" value="${LREntryInstance?.lcNo}" /></td>
        </div>
    </tr>
</table>

<g:if test="${LREntryInstance?.id}">
    <g:form method="post" >
        <g:hiddenField name="id" value="${LREntryInstance?.id}"/>
        <g:hiddenField name="version" value="${LREntryInstance?.version}"/>
    %{--<fieldset class="form">--}%
    %{--<div class="widget-main padding-8" style="margin-left: 50px; margin-right: 50px;"><g:render--}%
    %{--template="form"/></div>--}%
    %{--</fieldset>--}%
        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
            <g:actionSubmit class="btn btn-info btn-small" action="update" ng-disabled="createDisable" ng-click="checkValidations()" ng-show="showButton"
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
            <g:submitButton name="create" class="btn btn-info btn-small" ng-disabled="createDisable" ng-click="checkValidations()" ng-show="showButton"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</g:else>


</div>

</body>