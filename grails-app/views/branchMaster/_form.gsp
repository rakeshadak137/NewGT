<%@ page import="com.master.BranchMaster" %>
<script>
    var flag1=false;
    var flag2=false;
           function branchController($http,$scope){
              init();
               function init(){
                     <g:if test="${branchMasterInstance?.id}">
                             $scope.branchName = "${branchMasterInstance?.branchName}";
                             $scope.branchAddress = "${branchMasterInstance?.branchAddress}"
                     </g:if>
               }
               $scope.checkEmpty = function(){
                   if(!$scope.branchName){
                       flag1=true;
                   }
                   else{
                       flag1=false;
                   }
                   if($scope.branchAddress){
                       flag2=true;
                   }
                   else{
                       flag2=false;
                   }
               }

           }
</script>
<div ng-controller="branchController">
<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: branchMasterInstance, field: 'branchName', 'error')} ">
            <td><label for="branchName">
                <g:message code="branchMaster.branchName.label" default="Branch Name"/>
                
            </label></td>
            <td><g:textField name="branchName" id="branchName" autofocus="" ng-model="branchName"  value="${branchMasterInstance?.branchName}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: branchMasterInstance, field: 'branchAddress', 'error')} ">
            <td><label for="branchAddress">
                <g:message code="branchMaster.branchAddress.label" default="Branch Address"/>
                
            </label></td>
            <td><g:textArea name="branchAddress" id="branchAddress" ng-model="branchAddress" ng-change="checkEmpty()" value="${branchMasterInstance?.branchAddress}"/></td>
        </div>

    </tr>
    
</table>
</div>