<%@ page import="com.master.UnitMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: unitMasterInstance, field: 'unitName', 'error')} ">
            <td><label for="unitName">
                <g:message code="unitMaster.unitName.label" default="Unit Name"/>
                
            </label></td>
            <td><g:textField name="unitName" id="unitName" autofocus="" value="${unitMasterInstance?.unitName}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: unitMasterInstance, field: 'unitType', 'error')} ">
            <td><label for="unitType">
                <g:message code="unitMaster.unitType.label" default="Unit Type"/>
                
            </label></td>
            <td><g:textField name="unitType" value="${unitMasterInstance?.unitType}"/></td>
        </div>

    </tr>
    
</table>