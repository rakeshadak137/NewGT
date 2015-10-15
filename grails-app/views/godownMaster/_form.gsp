<%@ page import="com.master.GodownMaster" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: godownMasterInstance, field: 'godownName', 'error')} ">
            <td><label for="godownName">
                <g:message code="godownMaster.godownName.label" default="Godown Name"/>
                
            </label></td>
            <td><g:textField name="godownName" id="godownName" autofocus="" value="${godownMasterInstance?.godownName}"/></td>
        </div>

    </tr>
    
</table>