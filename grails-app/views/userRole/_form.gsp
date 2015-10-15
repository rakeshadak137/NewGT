<%@ page import="com.system.UserRole" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'user', 'error')} required">
            <td><label for="user">
                <g:message code="userRole.user.label" default="User"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="user" name="user.id" from="${com.system.User.list()}" optionKey="id" required="" value="${userRoleInstance?.user?.id}" class="many-to-one"/></td>
        </div>

    </tr>
    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: userRoleInstance, field: 'role', 'error')} required">
            <td><label for="role">
                <g:message code="userRole.role.label" default="Role"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:select id="role" name="role.id" from="${com.system.Role.list()}" optionKey="id" required="" value="${userRoleInstance?.role?.id}" class="many-to-one"/></td>
        </div>

    </tr>
    
</table>