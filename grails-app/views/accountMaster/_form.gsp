<%@ page import="com.master.BillingTypeMaster; com.master.CityMaster; grails.converters.JSON; com.master.States; com.master.AccountMaster" %>

<script>
    var flag1=false;
    var flag2=false;
function AccountMasterContoller($scope, $http) {
    init();

    function init(){
        <g:if test="${accountMasterInstance?.id}">
        $scope.accountName="${accountMasterInstance?.accountName}";
        $scope.address="${accountMasterInstance?.address}";
        $scope.mobileNo="${accountMasterInstance?.mobileNo}";
        $scope.phoneNo="${accountMasterInstance?.phoneNo}";
        $scope.phoneNo="${accountMasterInstance?.phoneNo}";
        $scope.pinCode="${accountMasterInstance?.pinCode}";
        $scope.contactMobile="${accountMasterInstance?.contactMobile}";
        </g:if>
        $scope.stateList = ${States.findAllByIsActive(true) as JSON};
        $scope.cityList = ${CityMaster.findAllByIsActive(true) as JSON};
    }
    $scope.isNumber = function(val){
        if($scope.accountName){
            flag1=true
        }
        if($scope.address){
            flag2=true
        }
        return isNumberKey(val);
    }
};
</script>

<div ng-controller="AccountMasterContoller">
<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'accountName', 'error')} ">
            <td><label for="accountName">
                <g:message code="accountMaster.accountName.label" default="Account Name"/>
                
            </label></td>
            <td><g:textField name="accountName" ng-model="accountName" autofocus="" value="${accountMasterInstance?.accountName}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'address', 'error')} ">
            <td><label for="address">
                <g:message code="accountMaster.address.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Address"/>

            </label></td>
            <td><g:textArea name="address" ng-model="address"  value="${accountMasterInstance?.address}"/></td>
        </div>


    </tr>
    <tr>
        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'billType', 'error')} ">
            <td><label for="accountName">
                <g:message code="accountMaster.billType.label" default="Billing Type"/>

            </label></td>
            <td><g:select id="billType" name="billType.id" from="${BillingTypeMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${accountMasterInstance?.billType?.id}" class="many-to-one"/></td>
        </div>
    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'state', 'error')} required">
            <td><label for="state">
                <g:message code="accountMaster.state.label" default="State"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="state" name="state.id" from="${com.master.States.findAllByIsActive(true)}" optionKey="id" required="" value="${accountMasterInstance?.state?.id}" class="many-to-one"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'city', 'error')} required">
            <td><label for="city">
                <g:message code="accountMaster.city.label" default="&nbsp;&nbsp;&nbsp;&nbsp;City"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="city" name="city.id" from="${com.master.CityMaster.findAllByIsActive(true)}" optionKey="id" required="" value="${accountMasterInstance?.city?.id}" class="many-to-one"/></td>
        </div>



    </tr>
    

    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'phoneNo', 'error')} ">
            <td><label for="phoneNo">
                <g:message code="accountMaster.phoneNo.label" default="Phone No"/>

            </label></td>
            <td><g:textField name="phoneNo" ng-model="phoneNo" ng-change="phoneNo=isNumber(phoneNo)" value="${accountMasterInstance?.phoneNo}" /></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'mobileNo', 'error')} ">
            <td><label for="mobileNo">
                <g:message code="accountMaster.mobileNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Mobile No"/>
                
            </label></td>
            <td><g:textField name="mobileNo" ng-model="mobileNo" ng-change="mobileNo=isNumber(mobileNo)" value="${accountMasterInstance?.mobileNo}"/></td>
        </div>



    </tr>
    

    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'pinCode', 'error')} ">
            <td><label for="pinCode">
                <g:message code="accountMaster.pinCode.label" default="Pin Code"/>

            </label></td>
            <td><g:textField name="pinCode" ng-model="pinCode" ng-change="pinCode=isNumber(pinCode)" value="${accountMasterInstance?.pinCode}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'email', 'error')} ">
            <td><label for="email">
                <g:message code="accountMaster.email.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Email"/>
                
            </label></td>
            <td><g:textField name="email" value="${accountMasterInstance?.email}"/></td>
        </div>



    </tr>
    

    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'contactPerson', 'error')} ">
            <td><label for="contactPerson">
                <g:message code="accountMaster.contactPerson.label" default="Contact Person"/>

            </label></td>
            <td><g:textField name="contactPerson" value="${accountMasterInstance?.contactPerson}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'contactMobile', 'error')} ">
            <td><label for="contactMobile">
                <g:message code="accountMaster.contactMobile.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Contact Person Mobile"/>
                
            </label></td>
            <td><g:textField name="contactMobile" ng-model="contactMobile" ng-change="contactMobile=isNumber(contactMobile)"   value="${accountMasterInstance?.contactMobile}"/></td>

        </div>
    </tr>

        <tr>
            <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'contactEmail', 'error')} ">
                <td><label for="contactEmail">
                    <g:message code="accountMaster.contactEmail.label" default="Contact Email"/>

                </label></td>
                <td><g:textField name="contactEmail" value="${accountMasterInstance?.contactEmail}"/></td>
            </div>
        </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'tinNo', 'error')} ">
            <td><label for="tinNo">
                <g:message code="accountMaster.tinNo.label" default="Tin No"/>

            </label></td>
            <td><g:textField name="tinNo" value="${accountMasterInstance?.tinNo}"/></td>
        </div>

        <div class="fieldcontain ${hasErrors(bean: accountMasterInstance, field: 'cstNo', 'error')} ">
            <td><label for="cstNo">
                <g:message code="accountMaster.cstNo.label" default="&nbsp;&nbsp;&nbsp;&nbsp;Cst No"/>
                
            </label></td>
            <td><g:textField name="cstNo" value="${accountMasterInstance?.cstNo}"/></td>
        </div>
    </tr>

</table>
</div>