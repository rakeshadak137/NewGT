<%@ page import="com.system.User" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'branch', 'error')} required">
            <td><label for="branch">
                <g:message code="user.branch.label" default="Branch"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="branch" name="branch.id" from="${com.master.BranchMaster.list()}" optionKey="id" required="" value="${userInstance?.branch?.id}" class="many-to-one"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
            <td><label for="username">
                <g:message code="user.username.label" default="Username"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="username" required="" value="${userInstance?.username}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
            <td><label for="password">
                <g:message code="user.password.label" default="Password"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="password" required="" value="${userInstance?.password}"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'admin', 'error')} ">
            <td><label for="admin">
                <g:message code="user.admin.label" default="Admin"/>
                
            </label></td>
            <td><g:checkBox name="admin" value="${userInstance?.admin}" /><span class="lbl"></span></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'client', 'error')} ">
            <td><label for="client">
                <g:message code="user.client.label" default="Client"/>
                
            </label></td>
            <td><g:checkBox name="client" value="${userInstance?.client}" /><span class="lbl"></span> </td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userInstance, field: 'enable', 'error')} ">
            <td><label for="enable">
                <g:message code="user.enable.label" default="Enable"/>
                
            </label></td>
            <td><g:checkBox name="enable" value="${userInstance?.enable}" /><span class="lbl"></span></td>
        </div>

    </tr>
    
</table>