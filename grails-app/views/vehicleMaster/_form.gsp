<%@ page import="com.master.VehicleMaster" %>
<script>
          function vehicleController($scope,$http){
              init();
              function init(){
                  $scope.showAlert=false;
                  $scope.showHideButton=false;
                  $scope.vehicleState="";
                  $scope.vehicleRto="";
                  $scope.vehicleSeries="";
                  $scope.vehicleNumber="";

                  <g:if test="${vehicleMasterInstance?.id}">
                  $scope.vehicleState = "${vehicleMasterInstance?.state}";
                  $scope.vehicleRto = "${vehicleMasterInstance?.rto}";
                  $scope.vehicleSeries = "${vehicleMasterInstance?.series}";
                  $scope.vehicleNumber = "${vehicleMasterInstance?.vehicleNo}";
                  </g:if>

              }
              $scope.isNumber = function(number){
                  return isNumberKey(number);
              };

              $scope.checkValidation = function(){
                  if(!$scope.vehicleState){
                      alert("Please enter vehicle state....");
                      event.preventDefault();
                  }
                  else if(!$scope.vehicleRto){
                      alert("Please enter RTO....");
                      event.preventDefault();
                  }
                  else if(!$scope.vehicleSeries){
                      alert("Please enter vehicle series....");
                      event.preventDefault();
                  }
                  else if(!$scope.vehicleNumber){
                      alert("Please enter vehicle No....");
                      event.preventDefault();
                  }
                  else if($scope.showAlert){
                      event.preventDefault();
                  }
              };

              $scope.checkDuplicate = function(){
                 $http.get("/${grailsApplication.config.erpName}/vehicleMaster/searchDuplicateVehicleNo?state="+$scope.vehicleState+"&rto="+$scope.vehicleRto+"&series="+$scope.vehicleSeries+"&no="+$scope.vehicleNumber)
                         .success(function(data){
                              if(data){
                                  $scope.showAlert=true;
                                  $scope.showHideButton=true;
                              }
                             else{
                                  $scope.showAlert=false;
                                  $scope.showHideButton=false;
                              }
                         })
              }

          }
</script>
<div ng-controller="vehicleController">
<table>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: vehicleMasterInstance, field: 'vehicleNo', 'error')} ">
            <td><label for="vehicleNo">
                <g:message code="vehicleMaster.vehicleNo.label" default="Vehicle No"/>
                
            </label></td>
           %{--<td>--}%
                %{--<g:textField name="vehicleNo" id="vehicleNo" autofocus="" value="${vehicleMasterInstance?.vehicleNo}"/>--}%
                <td><input type="text" class="input-mini" name="state" ng-model="vehicleState" ng-change="checkDuplicate()" placeholder="State" maxlength="2" />
                <input type="text" class="input-mini" name="rto" ng-model="vehicleRto" ng-change="vehicleRto=isNumber(vehicleRto);checkDuplicate()" placeholder="RTO" maxlength="2" />
                <input type="text" class="input-mini" name="series" ng-model="vehicleSeries" ng-change="checkDuplicate()" placeholder="Series" maxlength="2" />
                <input type="text" class="input-mini" name="vehicleNo" ng-model="vehicleNumber" ng-change="vehicleNumber=isNumber(vehicleNumber);checkDuplicate()" placeholder="Number" maxlength="4"/></td>
            %{--</td>--}%
        </div>

        <div class="fieldcontain ${hasErrors(bean: vehicleMasterInstance, field: 'vehicleType', 'error')} ">
            <td><label for="vehicleType">
                <g:message code="vehicleMaster.vehicleType.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Vehicle Type"/>

            </label></td>
            <td><g:textField name="vehicleType" value="${vehicleMasterInstance?.vehicleType}"/></td>
        </div>

    </tr>

    <tr ng-show="showAlert"><td style="color: red">This Vehicle No Already Exist</td></tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: vehicleMasterInstance, field: 'companyName', 'error')} ">
            <td><label for="companyName">
                <g:message code="vehicleMaster.companyName.label" default="Company Name"/>
                
            </label></td>
            <td><g:textField name="companyName" value="${vehicleMasterInstance?.companyName}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: vehicleMasterInstance, field: 'ownerName', 'error')} ">
            <td><label for="ownerName">
                <g:message code="vehicleMaster.ownerName.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Owner Name"/>

            </label></td>
            <td><g:textField name="ownerName" id="ownerName" value="${vehicleMasterInstance?.ownerName}"/></td>
        </div>

    </tr>
    

    <tr>

        <div class="fieldcontain ${hasErrors(bean: vehicleMasterInstance, field: 'mobileNo', 'error')} ">
            <td><label for="mobileNo">
                <g:message code="vehicleMaster.mobileNo.label" default="Mobile No"/>
                
            </label></td>
            <td><g:textField name="mobileNo"  value="${vehicleMasterInstance?.mobileNo}"/></td>
        </div>

    </tr>
    
</table>

    <g:if test="${vehicleMasterInstance?.id}">
        <g:hiddenField name="id" value="${vehicleMasterInstance?.id}"/>
        <g:hiddenField name="version" value="${vehicleMasterInstance?.version}"/>
        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">

            <g:actionSubmit class="btn btn-info btn-small" action="update" ng-click="checkValidation()" ng-hide="showHideButton"
                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
            <g:actionSubmit class="btn btn-info btn-small" action="delete" ng-hide="showHideButton"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            formnovalidate=""
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:if>
    <g:else>

        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
            <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
            <g:submitButton name="create" class="btn btn-info btn-small" ng-click="checkValidation()" ng-hide="showHideButton"
                            value="${message(code: 'default.button.create.label', default: 'Create')}" />
        </fieldset>
    </g:else>
</div>