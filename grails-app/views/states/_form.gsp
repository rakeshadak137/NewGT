<%@ page import="com.master.States" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: statesInstance, field: 'stateName', 'error')} ">
            <td><label for="stateName">
                <g:message code="states.stateName.label" default="State Name"/>
                
            </label></td>
            <td><g:textField name="stateName" id="stateName" autofocus="" value="${statesInstance?.stateName}"/></td>
        </div>

    </tr>
    
</table>