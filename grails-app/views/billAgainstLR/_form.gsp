<%@ page import="grails.converters.JSON; com.master.AccountMaster; com.transaction.BillAgainstLR" %>

<script>

    $(document).ready(function () {
        $("#company").searchable();
        $("#fromCompany").searchable();
        $("#toCompany").searchable();
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

    function BillAgainstLRContoller($scope, $http) {
        init();

        function init(){
            $scope.totalAmount = 0;
            $scope.companyList = ${AccountMaster.list() as JSON};
            $scope.LRData = [];
            $scope.productData = [];
            $scope.updateButton = false;
            $scope.finalData = [];
            $scope.poDate = "";
            $scope.otherTotal=0


            $scope.fromDate = ${new Date().format("yyyy-MM-dd")};
            $scope.toDate = ${new Date().format("yyyy-MM-dd")};
        }

        $scope.getLRData = function(){
            var fDate = document.getElementById("fromDate").value;
            var tDate = document.getElementById("toDate").value;
            debugger;

            if($scope.company && !$scope.fromCompany && !$scope.toCompany){
                if($scope.company){
                    $scope.LRData = [];
                    $http.get("/${grailsApplication.config.erpName}/BillAgainstLR/fetchAllLRData?fComp=" +$scope.company+"&fromDate=" + fDate + "&toDate=" + tDate)
                            .success(function (data) {
                                $scope.LRData = data;
                            });
                }
            }

           else if($scope.fromCompany && $scope.toCompany) {
                $scope.LRData = [];
                $http.get("/${grailsApplication.config.erpName}/BillAgainstLR/getLRData?fromDate=" + fDate + "&toDate=" + tDate +"&fComp=" +$scope.fromCompany +"&tComp=" +$scope.toCompany)
                        .success(function (data) {
                            $scope.LRData = data;

                            debugger;
                        });
            }
        };

        %{--$scope.getAllLrData = function(){--}%
            %{--var fDate = document.getElementById("fromDate").value;--}%
            %{--var tDate = document.getElementById("toDate").value;--}%
            %{--if($scope.company){--}%
                %{--$http.get("/${grailsApplication.config.erpName}/BillAgainstLR/fetchAllLRData?fComp=" +$scope.company+"&fromDate=" + fDate + "&toDate=" + tDate)--}%
                        %{--.success(function (data) {--}%
                            %{--$scope.LRData = data;--}%
                        %{--});--}%
            %{--}--}%
        %{--};--}%

        $scope.showProduct = function(bool,index){
            if(bool){
                $scope.poNo = $scope.LRData[index].poNo;
                $scope.poDate = $scope.LRData[index].poDate;

                %{--$http.get("/${grailsApplication.config.erpName}/BillAgainstLR/findParentData?chId=" + + $scope.LRData[index].Id)--}%
                        %{--.success(function (data) {--}%
                            %{--$scope.otherTotal = data;--}%
                        %{--});--}%


                $http.get("/${grailsApplication.config.erpName}/BillAgainstLR/getProductData?chId=" + $scope.LRData[index].Id)
                        .success(function (data) {
                            $scope.productData = data;

                            var l = $scope.productData.length;

                            for(var i=0;i<l;i++) {
                                $scope.finalData.push(
                                        {
                                            lrId: $scope.productData[i].lrId,
                                            lrNo: $scope.productData[i].lrNo,
                                            itemId: $scope.productData[i].itemId,
                                            itemName: $scope.productData[i].itemName,
                                            unitId: $scope.productData[i].unitId,
                                            unit: $scope.productData[i].unit,
                                            qty: $scope.productData[i].qty,
                                            rate: $scope.productData[i].rate,
                                            wtPiece: $scope.productData[i].wtPiece,
                                            totalWeight: $scope.productData[i].qty * $scope.productData[i].wtPiece,
                                            amount: $scope.productData[i].amount,
                                            customerPartNo: $scope.productData[i].customerPartNo
                                        }
                                );
                                getTotalAmount();
                            }
                            debugger;
                        })

            }
            else{
                var l = $scope.finalData.length;

                for(var i=0;i<l;i++) {
                    debugger;
                    if($scope.LRData[index].lrNo == $scope.finalData[i].lrNo){
                        $scope.finalData.splice(i);
                        getTotalAmount();
                    }
                }
                $scope.productData = [];
            }
        };

        $scope.selectDeselect = function(){
                $scope.totalAmount = 0;
                for(var j=0;j<$scope.LRData.length;j++){
                  $scope.LRData[j].bool = $scope.selectAll;
                    if($scope.LRData[j].bool){
                        $scope.poNo = $scope.LRData[j].poNo;
                        $scope.poDate = $scope.LRData[j].poDate;
                        $http.get("/${grailsApplication.config.erpName}/BillAgainstLR/getProductData?chId=" + $scope.LRData[j].Id)
                                .success(function (data) {
                                    $scope.productData = data;

                                    var l = $scope.productData.length;

                                    for(var i=0;i<l;i++) {
                                        $scope.finalData.push(
                                                {
                                                    lrId: $scope.productData[i].lrId,
                                                    lrNo: $scope.productData[i].lrNo,
                                                    itemId: $scope.productData[i].itemId,
                                                    itemName: $scope.productData[i].itemName,
                                                    unitId: $scope.productData[i].unitId,
                                                    unit: $scope.productData[i].unit,
                                                    qty: $scope.productData[i].qty,
                                                    rate: $scope.productData[i].rate,
                                                    wtPiece: $scope.productData[i].wtPiece,
                                                    totalWeight: $scope.productData[i].qty * $scope.productData[i].wtPiece,
                                                    amount: $scope.productData[i].amount,
                                                    customerPartNo: $scope.productData[i].customerPartNo
                                                }
                                        );
                                        getTotalAmount();
                                    }
                                    debugger;
                                })

                    }
                    else{
                        var l = $scope.finalData.length;

                        for(var i=0;i<l;i++) {
                            debugger;
                                $scope.finalData.splice(i);
                                getTotalAmount();
                        }
                        $scope.productData = [];
                    }
                }
            debugger;
//            if($scope.selectAll){
//                var l = $scope.finalData.length;
//                var total = 0;
//
//                for(var i=0;i<l;i++) {
//                    total = total + $scope.finalData[i].amount;
//                }
//                $scope.totalAmount = total;
//            }

        };

        function getTotalAmount(){
            var l = $scope.finalData.length;
            var total = 0;

            for(var i=0;i<l;i++) {
                total = total + $scope.finalData[i].amount;
            }
            $scope.totalAmount = total;
        }
    }
</script>

<div ng-controller="BillAgainstLRContoller">

<input type="hidden" name="ChildJSON" value="{{finalData}}">
<input type="hidden" name="mainComp" value="{{company}}">
<input type="hidden" name="fromComp" value="{{fromCompany}}">
<input type="hidden" name="toComp" value="{{toCompany}}">
<input type="hidden" name="poNo" value="{{poNo}}">
<input type="hidden" name="totalAmount" value="{{totalAmount}}">
<input type="hidden" name="poDate" value="{{poDate}}">

<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'billNo', 'error')} ">
            <td><label for="billNo">
                <g:message code="billAgainstLR.billNo.label" default="Bill No"/>
                
            </label></td>
            <td><g:textField name="billNo" value="${billAgainstLRInstance?.billNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'billDate', 'error')} required">
            <td><label for="billDate">
                <g:message code="billAgainstLR.billDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Bill Date"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><input  type="date"  name="billDate"  value="${billAgainstLRInstance?.billDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'company', 'error')} required">
            <td><label for="company">
                <g:message code="billAgainstLR.company.label" default="Company"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select name="company.id" id="company" ng-model="company" ng-options="c.id as c.accountName for c in companyList" required="" class="many-to-one" ng-change="getAllLrData()"></select></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'fromCompany', 'error')} required">
            <td><label for="fromCompany">
                <g:message code="billAgainstLR.fromCompany.label" default="From Company"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select name="fromCompany.id" id="fromCompany" required="" ng-model="fromCompany" ng-options="c.id as c.accountName for c in companyList" class="many-to-one"></select></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'toCompany', 'error')} required">
            <td><label for="toCompany">
                <g:message code="billAgainstLR.toCompany.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Company"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><select name="toCompany.id" required="" id="toCompany" ng-model="toCompany" ng-options="c.id as c.accountName for c in companyList" class="many-to-one"></select></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'vehicleNo', 'error')} ">
            <td><label for="vehicleNo">
                <g:message code="billAgainstLR.vehicleNo.label" default="Vehicle No"/>
                
            </label></td>
            <td><g:textField name="vehicleNo" value="${billAgainstLRInstance?.vehicleNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'poNo', 'error')} ">
            <td><label for="poNo">
                <g:message code="billAgainstLR.poNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Po No"/>

            </label></td>
            <td><input  type="text" disabled=""  name="poNo" ng-model="poNo" /></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'totalAmount', 'error')} required">
            <td><label for="totalAmount">
                <g:message code="billAgainstLR.totalAmount.label" default="Total Amount"/>
            </label></td>
            <td><g:textField disabled="" name="totalAmount" ng-model="totalAmount"/></td>
        </div>

    </tr>
    
</table>

<hr>
    <table>
        <tr>
            <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'fromDate', 'error')} required">
                <td><label for="fromDate">
                    <g:message code="billAgainstLR.fromDate.label" default="From Date&nbsp;&nbsp;&nbsp;&nbsp;"/>
                </label></td>
                <td><input id="fromDate" type="date" style="width: 140px"  name="fromDate" value="${billAgainstLRInstance?.fromDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}"  required=""  /></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: billAgainstLRInstance, field: 'toDate', 'error')} required">
                <td><label for="toDate">
                    <g:message code="billAgainstLR.fromDate.label" default="&nbsp;&nbsp;&nbsp;&nbsp;To Date&nbsp;&nbsp;&nbsp;&nbsp;"/>
                </label></td>
                <td><input id="toDate" type="date" style="width: 140px"  name="toDate" value="${billAgainstLRInstance?.toDate?.format('yyyy-MM-dd')?:Date.newInstance().format('yyyy-MM-dd')}" required=""  /></td>
            </div>

            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="btn btn-small btn-default" ng-click="getLRData()">Show LR</button>
            </td>
        </tr>
    </table>

<hr>

    <div role="grid" class="dataTables_wrapper" id="sample-table-5_wrapper">

        <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-5"
               aria-describedby="sample-table-2_info">
            <thead>
            <tr>
                <td><input type="checkbox" name="selectAll" ng-model="selectAll" ng-change="selectDeselect()" /> <span class="lbl"></span></td>

                <td>LR No.</td>

                <td>LR Date</td>

                <td>From Company</td>

                <td>To Company</td>

                <td>Vehicle No.</td>

                <td>PO No.</td>

            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="d in LRData | filter : searchItem | filter:new_search">

                <td style="width:20px"><input type="checkbox" ng-model="d.bool" ng-change="showProduct(d.bool,$index)"/><span class="lbl"></span></td>

                <td>{{d.lrNo}}</td>

                <td>{{d.lrDate}}</td>

                <td>{{d.fromCompany}}</td>

                <td>{{d.toCompany}}</td>

                <td>{{d.vehicleNo}}</td>

                <td>{{d.poNo}}</td>
            </tr>
            </tbody>
        </table>
    </div>

<hr>

<div role="grid" class="dataTables_wrapper" id="sample-table-7_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-7"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Part Description</td>

            <td>Unit</td>

            <td>Qty.</td>

            <td>Rate</td>

            <td>Wt-Piece</td>

            <td>Total Weight</td>

            <td>Amount</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in productData | filter : searchItem | filter:new_search">

            <td>{{d.itemName}}</td>

            <td>{{d.unit}}</td>

            <td>{{d.qty}}</td>

            <td>{{d.rate}}</td>

            <td>{{d.wtPiece}}</td>

            <td>{{d.totalWeight}}</td>

            <td>{{d.amount}}</td>
        </tr>
        </tbody>
    </table>
</div>

<hr>
%{--<table>--}%
    %{--<tr>--}%
        %{--<td>--}%
            %{--<button type="button" class="btn btn-small btn-default" ng-click="addData()">Add</button>--}%
            %{--<input type="hidden" name="lrData" value="{{LRData}}" />--}%
        %{--</td>--}%
        %{--<td>--}%
            %{--<div ng-show="updateButton">--}%
                %{--<button type="button" class="btn btn-small btn-default" ng-click="update()">Update</button>--}%
            %{--</div>--}%
        %{--</td>--}%
    %{--</tr>--}%
%{--</table>--}%

<div role="grid" class="dataTables_wrapper" id="sample-table-51_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-51"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>LR No.</td>

            <td>Part Description</td>

            <td>Qty.</td>

            <td>Rate</td>

            <td>Unit</td>

            <td>Customer Part No.</td>

            <td>Wt-Piece</td>

            <td>Total Weight</td>

            <td>Amount</td>

        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="d in finalData | filter : searchItem | filter:new_search">

            <td>{{d.lrNo}}</td>

            <td>{{d.itemName}}</td>

            <td>{{d.qty}}</td>

            <td>{{d.rate}}</td>

            <td>{{d.unit}}</td>

            <td>{{d.customerPartNo}}</td>

            <td>{{d.wtPiece}}</td>

            <td>{{d.totalWeight}}</td>

            <td>{{d.amount}}</td>

        </tr>
        </tbody>
    </table>
</div>

</div>