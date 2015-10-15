<%@ page import="com.system.Parameters" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'lrPrefix', 'error')} ">
            <td><label for="lrPrefix">
                <g:message code="parameters.lrPrefix.label" default="Lr Prefix"/>
                
            </label></td>
            <td><g:textField name="lrPrefix" value="${parametersInstance?.lrPrefix}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'lrPostfix', 'error')} ">
            <td><label for="lrPostfix">
                <g:message code="parameters.lrPostfix.label" default="Lr Postfix"/>
                
            </label></td>
            <td><g:textField name="lrPostfix" value="${parametersInstance?.lrPostfix}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'lastLRNo', 'error')} ">
            <td><label for="lastLRNo">
                <g:message code="parameters.lastLRNo.label" default="Last LRN o"/>
                
            </label></td>
            <td><g:field name="lastLRNo" type="number" value="${parametersInstance.lastLRNo}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'lastSMAutoBillNo', 'error')} ">
            <td><label for="lastSMAutoBillNo">
                <g:message code="parameters.lastSMAutoBillNo.label" default="Last SMA uto Bill No"/>
                
            </label></td>
            <td><g:field name="lastSMAutoBillNo" type="number" value="${parametersInstance.lastSMAutoBillNo}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'lastOthersBillNo', 'error')} ">
            <td><label for="lastOthersBillNo">
                <g:message code="parameters.lastOthersBillNo.label" default="Last Others Bill No"/>
                
            </label></td>
            <td><g:field name="lastOthersBillNo" type="number" value="${parametersInstance.lastOthersBillNo}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'sMAutoBillNoPrefix', 'error')} ">
            <td><label for="sMAutoBillNoPrefix">
                <g:message code="parameters.sMAutoBillNoPrefix.label" default="SMA uto Bill No Prefix"/>
                
            </label></td>
            <td><g:textField name="sMAutoBillNoPrefix" value="${parametersInstance?.sMAutoBillNoPrefix}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'sMAutoBillNoPostfix', 'error')} ">
            <td><label for="sMAutoBillNoPostfix">
                <g:message code="parameters.sMAutoBillNoPostfix.label" default="SMA uto Bill No Postfix"/>
                
            </label></td>
            <td><g:textField name="sMAutoBillNoPostfix" value="${parametersInstance?.sMAutoBillNoPostfix}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'othersBillNoPrefix', 'error')} ">
            <td><label for="othersBillNoPrefix">
                <g:message code="parameters.othersBillNoPrefix.label" default="Others Bill No Prefix"/>
                
            </label></td>
            <td><g:textField name="othersBillNoPrefix" value="${parametersInstance?.othersBillNoPrefix}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: parametersInstance, field: 'othersBillNoPostfix', 'error')} ">
            <td><label for="othersBillNoPostfix">
                <g:message code="parameters.othersBillNoPostfix.label" default="Others Bill No Postfix"/>
                
            </label></td>
            <td><g:textField name="othersBillNoPostfix" value="${parametersInstance?.othersBillNoPostfix}"/></td>
        </div>

    </tr>
    
</table>