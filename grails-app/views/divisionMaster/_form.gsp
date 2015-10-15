<%@ page import="com.master.DivisionMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: divisionMasterInstance, field: 'divisionName', 'error')} ">
            <td><label for="divisionName">
                <g:message code="divisionMaster.divisionName.label" default="Division Name"/>
                
            </label></td>
            <td><g:textField name="divisionName" id="divisionName" autofocus="" value="${divisionMasterInstance?.divisionName}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: divisionMasterInstance, field: 'description', 'error')} ">
            <td><label for="description">
                <g:message code="divisionMaster.description.label" default="Description"/>
                
            </label></td>
            <td><g:textArea name="description" value="${divisionMasterInstance?.description}"/></td>
        </div>

    </tr>
    
</table>