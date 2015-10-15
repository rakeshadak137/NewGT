<%@ page import="com.master.DriverMaster" %>
<script>
          function driverController($http,$scope){
              init();
              function init(){
               <g:if test="driverMasterInstance?.id">
                  $scope.mobileNo="${driverMasterInstance?.mobileNo}";
               </g:if>
              }
              $scope.isNumber=function(val){
                  return isNumberKey(val);
              }
          }
</script>
<div ng-controller="driverController">
<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: driverMasterInstance, field: 'driverName', 'error')} ">
            <td><label for="driverName">
                <g:message code="driverMaster.driverName.label" default="Driver Name"/>
                
            </label></td>
            <td><g:textField name="driverName" id="driverName" autofocus="" value="${driverMasterInstance?.driverName}" /></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: driverMasterInstance, field: 'driverId', 'error')} ">
            <td><label for="driverId">
                <g:message code="driverMaster.driverId.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Driver Id"/>

            </label></td>
            <td><g:textField name="driverId"  value="${driverMasterInstance?.driverId}"/></td>
        </div>

    </tr>
    

    <tr>

        <div class="fieldcontain ${hasErrors(bean: driverMasterInstance, field: 'address', 'error')} ">
            <td><label for="address">
                <g:message code="driverMaster.address.label" default="Address"/>
                
            </label></td>
            <td><g:textArea name="address" value="${driverMasterInstance?.address}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: driverMasterInstance, field: 'mobileNo', 'error')} ">
            <td><label for="mobileNo">
                <g:message code="driverMaster.mobileNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Mobile No"/>

            </label></td>
            <td>
                <g:textField name="mobileNo" ng-model="mobileNo" ng-change="mobileNo=isNumber(mobileNo)" value="${driverMasterInstance?.mobileNo}"/>
            </td>
        </div>

    </tr>
    

</table>
</div>