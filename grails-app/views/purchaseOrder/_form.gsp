<%@ page import="grails.converters.JSON; com.master.AccountMaster; com.transaction.PurchaseOrder" %>
<script>
    $(document).ready(function () {

        $("#fromCustomer").searchable();
        $("#customer").searchable();
        $("#toCustomer").searchable();
        $("#poType").searchable();
    });
    function check() {
        debugger;
        if (valid) {
            return valid
        }
        else {
            alert("There are no Transaction");
            return valid
        }
    }

    function PurchaseOrderContoller($scope, $http) {
        init();

        function init() {
            $scope.updateButton = false;
            $scope.freight = 0;
            $scope.loading = 0;
            $scope.unLoading = 0;
            $scope.collection = 0;
            $scope.cartage = 0;
            $scope.cata = 0;
            $scope.bilty = 0;
            $scope.doorDelivery = 0;
            $scope.total = 0;
            $scope.advance = 0;
            $scope.haulting = 0;
            $scope.balance = 0;
            $scope.tripRate = 0;
            $scope.amount = 0;
            $scope.customerList = ${AccountMaster.findAllByIsActive(true) as JSON};
            $scope.billTypeList = ${com.master.BillingTypeMaster.findAllByIsActive(true) as JSON}
            $scope.poData = [];

            <g:if test="${purchaseOrderInstance?.id}">
            var id = "${purchaseOrderInstance?.id}";
            $http.get("/${grailsApplication.config.erpName}/purchaseOrder/getData?id=" + id)
                    .success(function (data) {
                        debugger;
                        $scope.poData = data;
                        checkLength();
                    });
            </g:if>
        }

        $scope.isNumber = function(a){
            return isNumberKey(a);
        };

        $scope.remove = function (index) {
            $scope.value = false;
            $scope.poData.splice(index, 1);
            validLength = $scope.poData.length;
            checkLength();
        };

        function checkLength() {
            debugger;
            if ($scope.poData.length > 0) {
                valid = true;
            }
            else {
                valid = false;
            }
        }

        $scope.addData = function(){
            debugger;
            $scope.fromCust = _.find($scope.customerList, {id: $scope.fromCustomer});
            $scope.toCust = _.find($scope.customerList, {id: $scope.toCustomer});
            $scope.poData.push(
                    {
                        fromCustomerId: $scope.fromCustomer,
                        fromCustomerName: $scope.fromCust.accountName,
                        toCustomerId: $scope.toCustomer,
                        toCustomerName: $scope.toCust.accountName,
                        freight: $scope.freight,
                        loading:$scope.loading,
                        unLoading: $scope.unLoading,
                        collection: $scope.collection,
                        cartage: $scope.cartage,
                        cata: $scope.cata,
                        bilty: $scope.bilty,
                        doorDelivery: $scope.doorDelivery,
                        total: $scope.total,
                        advance: $scope.advance,
                        haulting: $scope.haulting,
                        balance: $scope.balance,
                        tripRate: $scope.tripRate,
                        amount: $scope.amount,
                        billType:$scope.billType

                    }
            );
            debugger;
            doBlank();
            checkLength();
        };

        function doBlank(){
            $scope.fromCustomer = "";
            $scope.toCustomer = "";
//            $scope.billType = "";
            $scope.freight = 0;
            $scope.loading = 0;
            $scope.unLoading = 0;
            $scope.collection = 0;
            $scope.cartage = 0;
            $scope.cata = 0;
            $scope.bilty = 0;
            $scope.doorDelivery = 0;
//            $scope.total = 0;
            $scope.advance = 0;
            $scope.haulting = 0;
//            $scope.balance = 0;
            $scope.tripRate = 0;
            $scope.amount = 0;
            $scope.billType = "";
        }

        $scope.edit = function (index) {
            debugger;


            $scope.fromCustomer = $scope.poData[index].fromCustomerId;
            $scope.toCustomer = $scope.poData[index].toCustomerId;
            $scope.freight = $scope.poData[index].freight;
            $scope.loading = $scope.poData[index].loading;
            $scope.unLoading = $scope.poData[index].unLoading;
            $scope.collection = $scope.poData[index].collection;
            $scope.cartage = $scope.poData[index].cartage;
            $scope.cata = $scope.poData[index].cata;
            $scope.bilty = $scope.poData[index].bilty;
            $scope.doorDelivery = $scope.poData[index].doorDelivery;
            $scope.total = $scope.poData[index].total;
            $scope.advance = $scope.poData[index].advance;
            $scope.haulting = $scope.poData[index].haulting;
            $scope.balance = $scope.poData[index].balance;
            $scope.tripRate = $scope.poData[index].tripRate;
            $scope.amount = $scope.poData[index].amount;
            $scope.billType = $scope.poData[index].billType;
            $scope.indexing = index;
            $scope.updateButton = true
        };

        $scope.update = function (){
            $scope.updateButton = false;

            $scope.fromCust = _.find($scope.customerList, {id: $scope.fromCustomer});
            $scope.toCust = _.find($scope.customerList, {id: $scope.toCustomer});

            $scope.poData[$scope.indexing].fromCustomerId = $scope.fromCustomer;
            $scope.poData[$scope.indexing].fromCustomerName = $scope.fromCust.accountName;
            $scope.poData[$scope.indexing].toCustomerId = $scope.toCustomer;
            $scope.poData[$scope.indexing].toCustomerName = $scope.toCust.accountName;
            $scope.poData[$scope.indexing].freight = $scope.freight;
            $scope.poData[$scope.indexing].loading = $scope.loading;
            $scope.poData[$scope.indexing].unLoading = $scope.unLoading;
            $scope.poData[$scope.indexing].collection = $scope.collection;
            $scope.poData[$scope.indexing].cartage = $scope.cartage;
            $scope.poData[$scope.indexing].cata = $scope.cata;
            $scope.poData[$scope.indexing].bilty = $scope.bilty;
            $scope.poData[$scope.indexing].doorDelivery = $scope.doorDelivery;
            $scope.poData[$scope.indexing].total = $scope.total;
            $scope.poData[$scope.indexing].advance = $scope.advance;
            $scope.poData[$scope.indexing].haulting = $scope.haulting;
            $scope.poData[$scope.indexing].balance = $scope.balance;
            $scope.poData[$scope.indexing].tripRate = $scope.tripRate;
            $scope.poData[$scope.indexing].amount = $scope.amount;
            $scope.poData[$scope.indexing].billType = $scope.billType;

            doBlank();
            checkLength();
        };

        $scope.doTotal=function(){
            $scope.total = 0;
            $scope.total = (parseFloat($scope.total) + (parseFloat($scope.freight) + parseFloat($scope.loading) +  parseFloat($scope.unLoading) + parseFloat($scope.collection) +  parseFloat($scope.cartage)+ parseFloat($scope.cata) + parseFloat($scope.bilty) + parseFloat($scope.doorDelivery) + parseFloat($scope.haulting) + parseFloat($scope.tripRate)))

            if(parseFloat($scope.advance) == 0){
                $scope.balance = parseFloat($scope.total);
            }
        };

        $scope.doBalanceTotal = function(){
            $scope.balance = parseFloat($scope.total) - parseFloat($scope.advance);
        };
    };
</script>

<div ng-controller="PurchaseOrderContoller">
<input type="hidden" name="ChildJSON" value="{{poData}}">
<table>


    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'poNo', 'error')} ">
            <td><label for="poNo">
                <g:message code="purchaseOrder.poNo.label" default="Po No"/>

            </label></td>
            <td><g:textField name="poNo" value="${purchaseOrderInstance?.poNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'poDate', 'error')} required">
            <td><label for="poDate">
                <g:message code="purchaseOrder.poDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Po Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            %{--<td><g:datePicker name="poDate" precision="day"  value="${purchaseOrderInstance?.poDate}"  /></td>--}%
            %{--<td><input type="date" name="poDate"  value="${new Date().format("yyyy-MM-dd")}"  /></td>--}%
            <td><input type="date" name="poDate"
                       value="${purchaseOrderInstance?.poDate?.format('yyyy-MM-dd') ?: Date.newInstance().format('yyyy-MM-dd')}"
                       required=""/></td></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'customer', 'error')} required">
            <td><label for="customer">
                <g:message code="purchaseOrder.customer.label" default="Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="customer" name="customer.id" from="${com.master.AccountMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${purchaseOrderInstance?.customer?.id}" class="many-to-one"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderInstance, field: 'poType', 'error')} ">
            <td><label for="poType">
                <g:message code="purchaseOrder.poType.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Po Type"/>

            </label></td>
            <td><g:select name="poType" id="poType" from="${purchaseOrderInstance.constraints.poType.inList}" value="${purchaseOrderInstance?.poType}" valueMessagePrefix="purchaseOrder.poType" noSelection="['': '']"/></td>
        </div>

    </tr>

</table>
<hr>

<table>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'fromCustomer', 'error')} required">
            <td><label for="fromCustomer">
                <g:message code="purchaseOrder.fromCustomer.label" default="From Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select ng-model="fromCustomer" id="fromCustomer" ng-options="c.id as c.accountName for c in customerList" required="" class="many-to-one"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'toCustomer', 'error')} required">
            <td><label for="toCustomer">
                <g:message code="purchaseOrder.toCustomer.label" default="&nbsp;&nbsp;&nbsp;&nbsp; To Customer"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select ng-model="toCustomer" id="toCustomer" ng-options="c.id as c.accountName for c in customerList" required="" value="${purchaseOrderDetailsInstance?.toCustomer?.id}" class="many-to-one"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: LREntryInstance, field: 'billType', 'error')} required">
        <td><label for="billType">
        <g:message code="LREntry.billType.label" default="&nbsp;&nbspBill Type"/>
        <span class="required-indicator">*</span>
        </label></td>
        <td>
            %{--<g:select id="billType" name="billType.id" from="${com.master.BillingTypeMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${LREntryInstance?.billType?.id}" class="many-to-one"/>--}%
            <select ng-model="billType" ng-options="r.id as r.type for r in billTypeList" value=""${LREntryInstance?.billType?.id}"" ></select>
        </td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'freight', 'error')} ">
            <td><label for="freight">
                <g:message code="purchaseOrder.freight.label" default="Freight"/>

            </label></td>
            %{--<td><g:textField name="freight" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'freight')}"/></td>--}%
            <td><input type="text" ng-model="freight" ng-change="freight=isNumber(freight);doTotal()"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'loading', 'error')} ">
            <td><label for="loading">
                <g:message code="purchaseOrder.loading.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Loading"/>

            </label></td>
            %{--<td><g:textField name="loading" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'loading')}"/></td>--}%
            <td><input type="text" ng-model="loading" ng-change="loading=isNumber(loading);doTotal()"/></td>
        </div>
    </tr>
    <tr>
        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'unLoading', 'error')} ">
            <td><label for="unLoading">
                <g:message code="purchaseOrder.unLoading.label" default="Un Loading"/>

            </label></td>
            %{--<td><g:textField name="unLoading" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'unLoading')}"/></td>--}%
            <td><input type="text" ng-model="unLoading" ng-change="unLoading=isNumber(unLoading);doTotal()"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'collection', 'error')} ">
            <td><label for="collection">
                <g:message code="purchaseOrder.collection.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Collection"/>

            </label></td>
            %{--<td><g:textField name="collection" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'collection')}"/></td>--}%
            <td><input type="text" ng-model="collection" ng-change="collection=isNumber(collection);doTotal()"/></td>
        </div>

    </tr>
    <tr>
        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'cartage', 'error')} ">
            <td><label for="cartage">
                <g:message code="purchaseOrder.cartage.label" default="Cartage"/>

            </label></td>
            %{--<td><g:textField name="cartage" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'cartage')}"/></td>--}%
            <td><input type="text" ng-model="cartage" ng-change="cartage=isNumber(cartage);doTotal()"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'cata', 'error')} ">
            <td><label for="cata">
                <g:message code="purchaseOrder.cata.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Cata"/>

            </label></td>
            %{--<td><g:textField name="cata" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'cata')}"/></td>--}%
            <td><input type="text" ng-model="cata" ng-change="cata=isNumber(cata);doTotal()"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'bilty', 'error')} ">
            <td><label for="bilty">
                <g:message code="purchaseOrder.bilty.label" default="Bilty"/>

            </label></td>
            %{--<td><g:textField name="bilty" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'bilty')}"/></td>--}%
            <td><input type="text" ng-model="bilty" ng-change="bilty=isNumber(bilty);doTotal()"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'doorDelivery', 'error')} ">
            <td><label for="doorDelivery">
                <g:message code="purchaseOrder.doorDelivery.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Door Delivery"/>

            </label></td>
            %{--<td><g:textField name="doorDelivery" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'doorDelivery')}"/></td>--}%
            <td><input type="text" ng-model="doorDelivery" ng-change="doorDelivery=isNumber(doorDelivery);doTotal()"/></td>
        </div>

    </tr>

    <tr>
        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'haulting', 'error')} ">
            <td><label for="haulting">
                <g:message code="purchaseOrder.haulting.label" default="Haulting"/>

            </label></td>
            %{--<td><g:textField name="haulting" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'haulting')}"/></td>--}%
            <td><input type="text" ng-model="haulting" ng-change="haulting=isNumber(haulting);doTotal()"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'tripRate', 'error')} ">
            <td><label for="tripRate">
                <g:message code="purchaseOrder.tripRate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Trip Rate"/>

            </label></td>
            %{--<td><g:textField name="tripRate" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'tripRate')}"/></td>--}%
            <td><input type="text" ng-model="tripRate" ng-change="tripRate=isNumber(tripRate);doTotal()"/></td>
        </div>

        %{--<div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'amount', 'error')} ">--}%
        %{--<td><label for="amount">--}%
        %{--<g:message code="purchaseOrder.amount.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Amount"/>--}%

        %{--</label></td>--}%
        %{--<td><g:textField name="amount" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'amount')}"/></td>--}%
        %{--<td><input type="text" ng-model="amount" ng-change="amount=isNumber(amount)"/></td>--}%
        %{--</div>--}%

    </tr>



</table>

<br>
<table>
    <tr>
        <td>
            <button type="button" class="btn btn-small btn-default" ng-click="addData()">Add</button>
        </td>
        <td>
            <div ng-show="updateButton">
                <button type="button" class="btn btn-small btn-default" ng-click="update()">Update</button>
            </div>
        </td>
    </tr>
</table>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Action</td>

            <td>From Customer</td>

            <td>To Customer</td>

            <td>Freight</td>

            <td>Loading</td>

            <td>Unloading</td>

            <td>Collection</td>

            <td>Cartage</td>

            <td>Cata</td>

            <td>Bilty</td>

            <td>Door Delivery</td>

            <td>Total</td>

            <td>Advance</td>

            <td>Haulting</td>

            <td>Balance</td>

            <td>Trip Rate</td>

            %{--<td>Amount</td>--}%
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="p in poData | filter : searchItem | filter:new_search">

            <td><button type="button" ng-click="edit($index)"
                        style="border: none; background: transparent; color: #08c">
                <i class="icon-pencil bigger-130"></i>
            </button>
                <button type="button" value="delete" ng-click="remove($index)"
                        style="border: none; background: transparent">
                    <img src="${resource(dir: 'assets/avatars', file: 'delete1.png')}"></button>
            </td>

            <td>{{p.fromCustomerName}}</td>

            <td>{{p.toCustomerName}}</td>

            <td>{{p.freight}}</td>

            <td>{{p.loading}}</td>

            <td>{{p.unLoading}}</td>
            <td>{{p.collection}}</td>
            <td>{{p.cartage}}</td>
            <td>{{p.cata}}</td>
            <td>{{p.bilty}}</td>
            <td>{{p.doorDelivery}}</td>
            <td>{{p.total}}</td>
            <td>{{p.advance}}</td>
            <td>{{p.haulting}}</td>
            <td>{{p.balance}}</td>
            <td>{{p.tripRate}}</td>
            %{--<td>{{p.amount}}</td>--}%

        </tr>
        </tbody>
    </table>
</div>

<table>
    <br>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'advance', 'error')} ">
            <td><label for="advance">
                <g:message code="purchaseOrder.advance.label" default="Advance"/>

            </label></td>
            %{--<td><g:textField name="advance" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'advance')}"/></td>--}%
            <td><input type="text" ng-model="advance" ng-change="advance=isNumber(advance);doBalanceTotal()"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'total', 'error')} ">
            <td><label for="total">
                <g:message code="purchaseOrder.total.label" default="Total"/>

            </label></td>
            %{--<td><g:textField name="total" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'total')}"/></td>--}%
            <td><input type="text" ng-model="total" disabled=""/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: purchaseOrderDetailsInstance, field: 'balance', 'error')} ">
            <td><label for="balance">
                <g:message code="purchaseOrder.balance.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Balance"/>

            </label></td>
            %{--<td><g:textField name="balance" value="${fieldValue(bean: purchaseOrderDetailsInstance, field: 'balance')}"/></td>--}%
            <td><input type="text" disabled="" ng-model="balance" ng-change="balance=isNumber(balance)"/></td>
        </div>

    </tr>
</table>

</div>