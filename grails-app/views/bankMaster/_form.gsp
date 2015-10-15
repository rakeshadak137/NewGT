<%@ page import="com.master.BankMaster" %>

<table>

    <div ng-controller="bankController">
    <tr>

        <div class="fieldcontain ${hasErrors(bean: bankMasterInstance, field: 'bankName', 'error')} ">
            <td><label for="bankName">
                <g:message code="bankMaster.bankName.label" default="Bank Name"/>
                
            </label></td>
            <td><g:textField name="bankName" value="${bankMasterInstance?.bankName}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: bankMasterInstance, field: 'accountNo', 'error')} ">
            <td><label for="accountNo">
                <g:message code="bankMaster.accountNo.label" default="Account No"/>
                
            </label></td>
            <td><g:textField name="accountNo" value="${bankMasterInstance?.accountNo}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: bankMasterInstance, field: 'address', 'error')} ">
            <td><label for="address">
                <g:message code="bankMaster.address.label" default="Address"/>
                
            </label></td>
            <td><g:textField name="address" value="${bankMasterInstance?.address}"/></td>
        </div>

    </tr>

    </div>
</table>