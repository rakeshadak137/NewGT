<%@ page import="com.master.CustomerMaster" %>
<script>
    var flag = false;
    var customerName = "";

    function AngularController($scope, $http) {
        $(document).ready(function () {
            init();

            function init() {
                $("#errorMessage").hide();

                <g:if test="${customerMasterInstance?.id}">
                    customerName = "${customerMasterInstance?.name}";
                    $("#name").val("${customerMasterInstance?.name}");
                </g:if>
            };

            $scope.checkDuplicate = function (name) {
               if(customerName == name){
                   $("#errorMessage").hide();
                   flag = false
               }else{
                   $http.get("/${grailsApplication.config.erpName}/customerMaster/checkDuplicate?name=" + name)
                           .success(function (data) {
                               if(data == "true"){
                                   $("#errorMessage").show();
                                   flag = true
                               }else{
                                   $("#errorMessage").hide();
                                   flag = false
                               }
                           });
               }
            }
        });
    }
</script>

<div ng-controller="AngularController">
    <table>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: customerMasterInstance, field: 'name', 'error')} ">
                <td><label for="name">
                    <g:message code="customerMaster.name.label" default="Name"/>
                    <span class="required-indicator">*</span>
                </label></td>
                <td><g:textField name="name" ng-model="name" ng-change="checkDuplicate(name)" value="${customerMasterInstance?.name}" required=""/></td>

                <td>
                    <span class="required-indicator" id="errorMessage">This Name is Already Exist</span>
                </td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: customerMasterInstance, field: 'address', 'error')} ">
                <td><label for="address">
                    <g:message code="customerMaster.address.label" default="Address"/>

                </label></td>
                <td><g:textField name="address" value="${customerMasterInstance?.address}"/></td>
            </div>

        </tr>

        <tr>

            <div class="fieldcontain ${hasErrors(bean: customerMasterInstance, field: 'mobileNo', 'error')} ">
                <td><label for="mobileNo">
                    <g:message code="customerMaster.mobileNo.label" default="Mobile No"/>

                </label></td>
                <td><g:textField name="mobileNo" value="${customerMasterInstance?.mobileNo}"/></td>
            </div>

        </tr>

    </table>
</div>