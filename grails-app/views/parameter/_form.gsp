<%@ page import="com.master.Parameter" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parameterInstance, field: 'name', 'error')} ">
            <td><label for="name">
                <g:message code="parameter.name.label" default="Name"/>
                
            </label></td>
            <td><g:textField name="name" value="${parameterInstance?.name}" required=""/></td>
        </div>

    </tr>
    
</table>