<%@ page import="com.master.ProductMaster" %>
<script>
    $(document).ready(function(){
        $("#customerName").searchable();
        $("#division").searchable();
        $("#category").searchable();
        $("#unit").searchable();
        $("#billingType").searchable();
    });
    var flag1=false;
    function ProductMasterContoller($scope, $http) {
        init();

        function init(){
            $scope.rate = 0;
            $scope.weight = 0;
            $scope.thickness = 0;
            $scope.length = 0;
            $scope.od = 0;
            $scope.a = true;
            $scope.b = false;

            <g:if test="${productMasterInstance?.id}">
            $scope.productName = "${productMasterInstance?.productName}";
            $scope.rate = ${productMasterInstance?.rate};
            $scope.weight = ${productMasterInstance?.weight};

            if((${productMasterInstance?.od}) != 0 && (${productMasterInstance?.thickNess}) != 0  && (${productMasterInstance?.length}) != 0){
                       $scope.bool = true;
                       $scope.b = true;
                       $scope.a = false;
                       $scope.od = ${productMasterInstance?.od};
                       $scope.thickness = ${productMasterInstance?.thickNess};
                       $scope.length = ${productMasterInstance?.length};
            }
            else{
                $scope.bool = false;
                $scope.b = false;
                $scope.a = true;
                $scope.thickness = 0;
                $scope.length = 0;
                $scope.od = 0;
            }
            </g:if>
        }

        $scope.isNumber = function(a){
            return isNumberKey(a);
        };

        $scope.pipeCalculation = function(){
            if($scope.bool){
                $scope.a = false;
                $scope.b = true;
            }
            else{
                $scope.b = false;
                $scope.a = true;

                $scope.weight = 0;
                $scope.thickness = 0;
                $scope.length = 0;
                $scope.od = 0;
            }
        };

        $scope.doWeight = function (){
            $scope.weight = 0;
            $scope.weight = (((parseFloat($scope.od) - parseFloat($scope.thickness)) * parseFloat($scope.thickness) * 0.025 * parseFloat($scope.length))/1000);

        };
    };
</script>

<div ng-controller="ProductMasterContoller">
    <input type="hidden" name="rate" value="{{rate}}">
    <input type="hidden" name="weight" value="{{weight}}">
    <input type="hidden" name="thickness" value="{{thickness}}">
    <input type="hidden" name="length" value="{{length}}">
    <input type="hidden" name="od" value="{{od}}">
    <table>


        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'productName', 'error')} ">
                <td><label for="productName">
                    <g:message code="productMaster.productName.label" default="Product Name"/>

                </label></td>
                <td><g:textField name="productName" id="productName" ng-model="productName" autofocus="" value="${productMasterInstance?.productName}"/></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'productCode', 'error')} ">
                <td><label for="productCode">
                    <g:message code="productMaster.productCode.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Product Code"/>

                </label></td>
                <td><g:textField name="productCode" value="${productMasterInstance?.productCode}"/></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'customerName', 'error')} required">
                <td><label for="customerName">
                    <g:message code="productMaster.customerName.label" default="Customer Name"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><g:select id="customerName" name="customerName.id" from="${com.master.AccountMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${productMasterInstance?.customerName?.id}" class="many-to-one"/></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'customerPartNo', 'error')} ">
                <td><label for="customerPartNo">
                    <g:message code="productMaster.customerPartNo.label" default="Customer Part No."/>

                </label></td>
                <td><g:textField name="customerPartNo" value="${fieldValue(bean: productMasterInstance, field: 'customerPartNo')}"/></td>
                %{--<td><input type="text" ng-model="rate" ng-change="rate=isNumber(rate)"/></td>--}%
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'division', 'error')} required">
                <td><label for="division">
                    <g:message code="productMaster.division.label" default="Division"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><g:select id="division" name="division.id" from="${com.master.DivisionMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${productMasterInstance?.division?.id}" class="many-to-one"/></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'category', 'error')} ">
                <td><label for="category">
                    <g:message code="productMaster.category.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Category"/>

                </label></td>
                <td><g:select id="category" name="category.id" from="${com.master.CategoryMaster.findAllByIsActive(true)}" optionKey="id" value="${productMasterInstance?.category?.id}" class="many-to-one" noSelection="['null': '']"/></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'unit', 'error')} required">
                <td><label for="unit">
                    <g:message code="productMaster.unit.label" default="Unit"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><g:select id="unit" name="unit.id" from="${com.master.UnitMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${productMasterInstance?.unit?.id}" class="many-to-one"/></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'billingType', 'error')} ">
                <td><label for="billingType">
                    <g:message code="productMaster.billingType.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Billing Type"/>

                </label></td>
                <td><g:select id="billingType" name="billingType.id" from="${com.master.BillingTypeMaster.findAllByIsActive(true)}" optionKey="id" value="${productMasterInstance?.billingType?.id}" class="many-to-one" noSelection="['null': '']"/></td>
            </div>

        </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'rate', 'error')} ">
                <td><label for="rate">
                    <g:message code="productMaster.rate.label" default="Rate"/>

                </label></td>
                %{--<td><g:textField name="rate" value="${fieldValue(bean: productMasterInstance, field: 'rate')}"/></td>--}%
                <td><input type="text" ng-model="rate" /></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'unit', 'error')} required">
                <td><label for="unit">
                    <g:message code="productMaster.unit.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Pipe Calculation"/>
                </label></td>
                <td><input type="checkbox" ng-model="bool" ng-change="pipeCalculation()"/><span class="lbl"></span></td>
            </div>

        </tr>

        %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'weightLn', 'error')} ">--}%
        %{--<td><label for="weightLn">--}%
        %{--<g:message code="productMaster.weightLn.label" default="Weight Ln"/>--}%
        %{----}%
        %{--</label></td>--}%
        %{--<td><g:textField name="weightLn" value="${productMasterInstance?.weightLn}"/></td>--}%
        %{--</div>--}%

        %{--</tr>--}%

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'weight', 'error')} required">
                <td>
                    <div ng-show="a">
                        <label for="weight">
                            <g:message code="productMaster.weight.label" default="Weight"/>
                            <span class="required-indicator">*</span>
                        </label></div></td>
                %{--<td><g:textField name="weight" value="${fieldValue(bean: productMasterInstance, field: 'weight')}" required=""/></td>--}%
                <td><div ng-show="a"><input type="text" ng-model="weight" /></div></td>
            </div>


        </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'weight', 'error')} required">
                <td>
                    <div ng-show="b">
                        <label for="weight">
                            <g:message code="productMaster.weight.label" default="Weight"/>
                            <span class="required-indicator">*</span>
                        </label></div></td>
                %{--<td><g:textField name="weight" value="${fieldValue(bean: productMasterInstance, field: 'weight')}" required=""/></td>--}%
                <td><div ng-show="b"><input type="text" disabled="" ng-model="weight" ng-change="setWeight()"/></div></td>
            </div>
        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'od', 'error')} ">
                <td>
                    <div ng-show="b">
                        <label for="od">
                            <g:message code="productMaster.od.label" default="Od"/>

                        </label></div></td>
                %{--<td><g:textField name="od" value="${fieldValue(bean: productMasterInstance, field: 'od')}"/></td>--}%
                <td><div ng-show="b"><input type="text" ng-model="od" ng-change="od=isNumber(od);doWeight()"/></div></td>
            </div>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'thickNess', 'error')} ">
                <td>
                    <div ng-show="b">
                        <label for="thickNess">
                            <g:message code="productMaster.thickNess.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Thick Ness"/>

                        </label></div></td>
                %{--<td><g:textField name="thickNess" value="${fieldValue(bean: productMasterInstance, field: 'thickNess')}"/></td>--}%
                <td><div ng-show="b"><input type="text" ng-model="thickness" ng-change="thickness=isNumber(thickness);doWeight()"/></div></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: productMasterInstance, field: 'length', 'error')} ">
                <td>
                    <div ng-show="b">
                        <label for="length">
                            <g:message code="productMaster.length.label" default="Length"/>

                        </label></div></td>
                %{--<td><g:textField name="length" value="${fieldValue(bean: productMasterInstance, field: 'length')}"/></td>--}%
                <td><div ng-show="b"><input type="text" ng-model="length" ng-change="length=isNumber(length);doWeight()"/></div></td>
            </div>

        </tr>
    </table>
</div>