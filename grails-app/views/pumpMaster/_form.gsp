<%@ page import="com.master.PumpMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: pumpMasterInstance, field: 'pumpName', 'error')} ">
            <td><label for="pumpName">
                <g:message code="pumpMaster.pumpName.label" default="Pump Name"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="pumpName" value="${pumpMasterInstance?.pumpName}" required=""/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: pumpMasterInstance, field: 'dieselRate', 'error')} required">
            <td><label for="dieselRate">
                <g:message code="pumpMaster.dieselRate.label" default="Diesel Rate"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="dieselRate" value="${fieldValue(bean: pumpMasterInstance, field: 'dieselRate')}" required=""/></td>
        </div>

    </tr>
    
</table>