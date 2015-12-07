<%@ page import="com.transaction.CashVoucher" %>
<script>
    $(document).ready(function () {
        $("#vehicleNo").searchable();
    });
         function cashController($scope,$http){
             init();

             function init(){
                $scope.dieselAmount=0;
                $scope.dieselLtr=0;
                $scope.dieselRate=0;
                $scope.memoTotal=0;
                $scope.memoTotalAmt=0;
                $scope.vehicleList = ${com.master.VehicleMaster.findAllByIsActive(true) as grails.converters.JSON};
                $scope.pumpList = ${com.master.PumpMaster.findAllByIsActive(true) as grails.converters.JSON};
                $scope.pTypeList= [{s:"Cash"},{s:"Cheque"},{s:"Diesel"}];
                $scope.vTypeList= [{s:"Cash Voucher-Memo"},{s:"Cash Voucher-Other"},{s:"Diesel Voucher"},{s:"Maintenance Voucher"}];
                $scope.showBank=false;
                $scope.showDiesel=false;
                 $scope.memoData = [];
                 $scope.tempMemoData = [];

                 debugger;
                <g:if test="${cashVoucherInstance?.id}">

                 var id = ${cashVoucherInstance?.id};
                        $scope.vType = "${cashVoucherInstance?.voucherType}";
                        $scope.paymentType = "${cashVoucherInstance?.paymentType}";
                        $scope.memoTotal = "${cashVoucherInstance?.netAmount}";
                        if("${cashVoucherInstance?.vehicleNo?.id}") $scope.vehicleNo = parseInt("${cashVoucherInstance?.vehicleNo?.id}");
                        if("${cashVoucherInstance?.pumpName?.id}"){
                            $scope.pumpName = parseInt("${cashVoucherInstance?.pumpName?.id}");
                            $scope.dieselRate = parseFloat("${cashVoucherInstance?.dieselRate}").toFixed(2);
                            $scope.dieselAmount = parseFloat("${cashVoucherInstance?.dieselAmount}").toFixed(2);
                            $scope.dieselLtr = parseFloat("${cashVoucherInstance?.dieselLtr}").toFixed(2);
                        }
                        if($scope.paymentType=="Cash"){
                            $scope.showBank=false;
                            $scope.showDiesel=false;
                        }
                        else if($scope.paymentType=="Cheque"){
                            $scope.showBank=true;
                            $scope.showDiesel=false;
                        }
                        else if($scope.paymentType=="Diesel"){
                            $scope.showBank=false;
                            $scope.showDiesel=true;
                        }
                 $http.get("/${grailsApplication.config.erpName}/cashVoucher/editData?id=" + id+"&vid="+$scope.vehicleNo)
                         .success(function (data) {
                             $scope.memoData = data;
                             debugger;
                         });
                </g:if>
                 debugger;
             }
             $scope.getMemoDetails = function(){
//                 $scope.tempMemoData = $scope.memoData;
                 $http.get("/${grailsApplication.config.erpName}/cashVoucher/findMemos?id=" + $scope.vehicleNo)
                         .success(function (data) {
                             $scope.memoData=data;
                             debugger;
                         });
//                 $scope.memoData.push($scope.tempMemoData);
             };

             $scope.selectAllValues = function(){
                 for(var i=0;i<$scope.memoData.length;i++){
                     $scope.memoData[i].bool=$scope.selectAll;
                 }
             };

             $scope.doTotal = function(){
                 $scope.memoTotal=0;
                 debugger;
                 for(var i=0;i<$scope.memoData.length;i++){
                     if($scope.memoData[i].bool){
                         $scope.memoTotal+=parseFloat($scope.memoData[i].balance);
//                         $scope.memoTotal=parseFloat($scope.memoTotal).toFixed(2);
                     }
                 }
                 debugger;

             };
             $scope.getPtype = function(){
                 debugger;
                 if($scope.paymentType=="Cash"){
                     $scope.showBank=false;
                     $scope.showDiesel=false;
                 }
                 else if($scope.paymentType=="Cheque"){
                        $scope.showBank=true;
                        $scope.showDiesel=false;
                 }
                 else if($scope.paymentType=="Diesel"){
                     $scope.showBank=false;
                     $scope.showDiesel=true;
                     $scope.dieselAmount = $scope.memoTotal;

                 }
             };
             $scope.getRate=function(){
                 var pumpObj= _.find($scope.pumpList,{id:$scope.pumpName});
                 $scope.dieselRate = pumpObj.dieselRate;
                 $scope.getDieselLtr();
             };
             $scope.getDieselLtr=function(){
               if($scope.pumpName){
                   $scope.dieselLtr=($scope.dieselAmount/$scope.dieselRate).toFixed(2);
               }
               else{
               alert("Please select Pump Name");
                   $scope.dieselAmount=0;
               }
             };
             $scope.isNumber=function(num){
                 debugger;
                 return isNumberKey(num)
             }
             $scope.checkDuplicateChequeNo=function(){
                 var bankId=document.getElementById("bankName").value;

                 $http.get("/${grailsApplication.config.erpName}/cashVoucher/checkDuplicateChequeNo?chequeNo=" + $scope.chequeNo+"&bankId="+bankId)
                         .success(function (data) {
                             if(data){
                                 $scope.duplicateVoucherNo = data;
                                 $scope.showChequeAlert = true;
                             }
                             else{
                                 $scope.showChequeAlert = false;
                             }
                         });
             }

             $scope.uncheckOther = function(index){
                 if($scope.memoData[index].bool) {
                     for (var i = 0; i < $scope.memoData.length; i++) {
                         $scope.memoData[i].bool = false;
                     }
                     $scope.memoData[index].bool = true;
                 }else{
                     $scope.memoData[index].bool=false;
                 }
             };
         }
</script>
<body>
<div ng-controller="cashController">
%{--{{memoTotal}}--}%
<input type="hidden" name="childJson" value="{{memoData}}" />
<input type="hidden" name="vehicleNo.id" value="{{vehicleNo}}" />
<input type="hidden" name="pumpName.id" value="{{pumpName}}" />
<input type="hidden" name="paymentType" value="{{paymentType}}" />
<input type="hidden" name="voucherType" value="{{vType}}" />
<table>

<tr>

    %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'netAmount', 'error')} required">--}%
    %{--<td><label for="netAmount">--}%
    %{--<g:message code="cashVoucher.netAmount.label" default="Net Amount"/>--}%
    %{--<span class="required-indicator">*</span>--}%
    %{--</label></td>--}%
    %{--<td><g:field name="netAmount" value="${fieldValue(bean: cashVoucherInstance, field: 'netAmount')}" required=""/></td>--}%
    %{--</div>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'voucherDate', 'error')} required">--}%
        <td><label for="voucherDate">
            <g:message code="cashVoucher.voucherDate.label" default="Voucher Date"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><input  type="date"  name="voucherDate"  value="${cashVoucherInstance?.voucherDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>
    %{--</div>--}%

    %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'voucherNo', 'error')} required">--}%
        <td><label for="voucherNo">
            <g:message code="cashVoucher.voucherNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Voucher No"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><g:textField name="voucherNo" value="${cashVoucherInstance.voucherNo}"  disabled=""> </g:textField></td>
    %{--</div>--}%
</tr>
    <tr>

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'voucherType', 'error')} ">--}%
            <td><label for="voucherType">
                <g:message code="cashVoucher.voucherType.label" default="Voucher Type"/>
                
            </label></td>
            <td>
                %{--<g:textField name="voucherType" value="${cashVoucherInstance?.voucherType}"/>--}%
                <select ng-model="vType" ng-options="s.s as s.s for s in vTypeList" ng-change="getType()" value="${cashVoucherInstance?.voucherType}" >
                %{--<option value="">Cash Voucher</option>--}%
                %{--<option value="">Diesel Voucher</option>--}%
                %{--<option value="">Maintenance Voucher</option>--}%
                </select>
            </td>
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'vehicleNo', 'error')} ">--}%
            <td><label for="vehicleNo">
                <g:message code="cashVoucher.vehicleNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Vehicle No"/>

            </label></td>
            <td>
                %{--<g:select id="vehicleNo" name="vehicleNo.id" from="${com.master.VehicleMaster.findAllByIsActive(true)}" optionKey="id" value="${cashVoucherInstance?.vehicleNo?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
                <select id="vehicleNo" ng-model="vehicleNo"
                        ng-options="r.id as r.state+' '+r.rto+' '+r.series+' '+ r.vehicleNo for r in vehicleList"
                        ng-change="getMemoDetails()"></select>
            </td>
        %{--</div>--}%


    </tr>
    <tr>
        <td>Pay To</td>
        <td><g:textArea name="payTo" value="${cashVoucherInstance.payTo}" style="text-transform:uppercase;" onkeyup="javascript:this.value=this.value.toUpperCase();"> </g:textArea></td>
    </tr>
%{--<div class="row-fluid">--}%
    %{--<div class="dataTables_filter" id="sample-table-2_filter">--}%
        %{--<label>Search: <input type="text" ng-model="search" aria-controls="sample-table-2"></label>--}%
    %{--</div>--}%
%{--</div>--}%
</table>

<div role="grid" class="dataTables_wrapper" id="sample-table_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td style="text-align: center"><input type="checkbox" ng-model="selectAll" disabled="" ng-change="selectAllValues()"/><span
                    class="lbl"></span></td>

            <td style="text-align: center">Date</td>

            <td style="text-align: center">Memo No</td>

            <td style="text-align: center">Total Amt</td>

            <td style="text-align: center">Diesel Ltr</td>

            <td style="text-align: center">Diesel Amt</td>

            <th style="text-align: center">Balance</th>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in memoData  | filter : search">

            <td style="text-align: center"><input type="checkbox" ng-model="d.bool" value={{d.bool}} ng-change="uncheckOther($index);doTotal()"/><span
                    class="lbl"></span></td>
            <td style="text-align: center">{{d.memoDate}}</td>
            <td style="text-align: center">{{d.memoNo}}</td>
            <td style="text-align: center">{{d.amount}}</td>
            <td style="text-align: center">{{d.ltr}}</td>
            <td style="text-align: center">{{d.dieselAmt}}</td>
            <th style="text-align: center">{{d.balance}}</th>

        </tr>
        </tbody>
    </table>

</div>

<br>
<table>
        <tr>

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'paymentType', 'error')} ">--}%
            <td><label for="paymentType">
                <g:message code="cashVoucher.paymentType.label" default="Payment Type"/>
                
            </label></td>
            <td>
                %{--<g:textField name="paymentType" value="${cashVoucherInstance?.paymentType}"/>--}%
                <select ng-model="paymentType" ng-options="r.s as r.s for r in pTypeList" ng-change="getPtype()" value="${cashVoucherInstance?.paymentType}" >
                </select>
            </td>

            <td>&nbsp;&nbsp;&nbsp;&nbsp;Total Amount</td>
            <td>
                <input type="text" ng-model="memoTotal" name="netAmount" />
            </td>
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'pumpName', 'error')} ">--}%
            </tr>
            <tr ng-show="showDiesel">
            <td><label for="pumpName">
                <g:message code="cashVoucher.pumpName.label" default="Pump Name"/>

            </label></td>
            <td>
                %{--<g:select id="pumpName" name="pumpName.id" from="${com.master.PumpMaster.findAllByIsActive(true)}" optionKey="id" value="${cashVoucherInstance?.pumpName?.id}" class="many-to-one" noSelection="['null': '']"/>--}%
                <select ng-model="pumpName" ng-options="r.id as r.pumpName for r in pumpList" ng-change="getRate();" ></select>
            </td>
        %{--</div>--}%
            %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'dieselLtr', 'error')} required">--}%

            %{--</div>--}%

            %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'dieselRate', 'error')} required">--}%
                <td><label for="dieselRate">
                    <g:message code="cashVoucher.dieselRate.label" default="Diesel Rate"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><g:textField name="dieselRate" ng-model="dieselRate" value="${fieldValue(bean: cashVoucherInstance, field: 'dieselRate')}" required=""/></td>
            %{--</div>--}%

    </tr>
    <tr ng-show="showDiesel">
        <td><label for="dieselLtr">
            <g:message code="cashVoucher.dieselLtr.label" default="Diesel Ltr"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><g:textField name="dieselLtr" ng-model="dieselLtr" ng-change="dieselLtr=isNumber(dieselLtr)" value="${fieldValue(bean: cashVoucherInstance, field: 'dieselLtr')}" required=""/></td>

        <td><label for="dieselAmount">
            <g:message code="cashVoucher.dieselAmount.label" default="Diesel Amount"/>
            <span class="required-indicator">*</span>
        </label></td>
        <td><g:textField name="dieselAmount" ng-model="dieselAmount" ng-change="dieselAmount=isNumber(dieselAmount);getDieselLtr()" value="${fieldValue(bean: cashVoucherInstance, field: 'dieselAmount')}" required=""/></td>
    </tr>

    <tr ng-show="showDiesel">

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'dieselReceiptNo', 'error')} ">--}%
            <td><label for="dieselReceiptNo">
                <g:message code="cashVoucher.dieselReceiptNo.label" default="Diesel Slip No"/>
                
            </label></td>
            <td><g:textField name="dieselReceiptNo" value="${cashVoucherInstance?.dieselReceiptNo}"/></td>
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'dieselReceiptDate', 'error')} ">--}%
            <td><label for="dieselReceiptDate">
                <g:message code="cashVoucher.dieselReceiptDate.label" default="Diesel Slip Date"/>

            </label></td>
            <td><input  type="date"  name="dieselReceiptDate"  value="${cashVoucherInstance?.dieselReceiptDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>
        %{--</div>--}%


    </tr>
    
    <tr ng-show="showBank">

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'bankName', 'error')} ">--}%
            <td ><label for="bankName">
                <g:message code="cashVoucher.bankName.label" default="Bank Name"/>
                
            </label></td>
            <td>
                <g:select id="bankName" name="bankName.id" from="${com.master.BankMaster.list()}" optionKey="id" value="${cashVoucherInstance?.bankName?.id}" class="many-to-one" noSelection="['null': '']"/>
            </td>
        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'chequeNo', 'error')} ">--}%
            <td><label for="chequeNo">
                <g:message code="cashVoucher.chequeNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Cheque No"/>

            </label></td>
            <td><g:textField name="chequeNo" value="${cashVoucherInstance?.chequeNo}" ng-model="chequeNo" ng-change="checkDuplicateChequeNo()" />

            </td>
        %{--</div>--}%

    </tr>
    

    <tr>

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'description', 'error')} ">--}%
            <td><label for="description">
                <g:message code="cashVoucher.description.label" default="Description"/>
                
            </label></td>
            <td><g:textArea name="description" value="${cashVoucherInstance?.description}" style="text-transform:uppercase;" onkeyup="javascript:this.value=this.value.toUpperCase();" /></td>

        <td><label for="vehicleNumber">
            <g:message code="cashVoucher.vehicleNumber.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Vehicle No."/>

        </label></td>
        <td><g:textField name="vehicleNumber" value="${cashVoucherInstance?.vehicleNumber}"/></td>

        %{--</div>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: cashVoucherInstance, field: 'dieselAmount', 'error')} required">--}%

        %{--</div>--}%


    </tr>


</table>
        <g:if test="${cashVoucherInstance?.id}">

        </g:if>
        <g:else>

        </g:else>
</div>
</body>