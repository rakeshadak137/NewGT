<%@ page import="com.master.BillingTypeMaster" %>
<script>
    var flag1=false;
         function billController($http,$scope){
             init();
             function init(){
                  <g:if test="${billingTypeMasterInstance?.id}">
                  $scope.type="${billingTypeMasterInstance?.type}";
                  </g:if>
             }
             $scope.checkEmpty = function(){
                 if($scope.type){
                    flag1 = true;
                 }
                 else{
                     flag1 = false
                 }
             }

         }
</script>
<div ng-controller="billController">
<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: billingTypeMasterInstance, field: 'type', 'error')} ">
            <td><label for="type">
                <g:message code="billingTypeMaster.type.label" default="Type"/>
                
            </label></td>
            <td><g:textField name="type" ng-model="type" ng-change="checkEmpty()" autofocus="" value="${billingTypeMasterInstance?.type}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: billingTypeMasterInstance, field: 'description', 'error')} ">
            <td><label for="description">
                <g:message code="billingTypeMaster.description.label" default="Description"/>
                
            </label></td>
            <td><g:textArea name="description" value="${billingTypeMasterInstance?.description}"/></td>
        </div>

    </tr>
    
</table>
</div>
