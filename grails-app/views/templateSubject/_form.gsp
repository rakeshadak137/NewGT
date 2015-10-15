<%@ page import="com.template.TemplateSubject" %>

<table>

    
    <tr>

        <div class="fieldcontain ${hasErrors(bean: templateSubjectInstance, field: 'name', 'error')} required">
            <td><label for="name">
                <g:message code="templateSubject.name.label" default="Subject"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td><g:textField name="name" required="" value="${templateSubjectInstance?.name}"/></td>
        </div>

    </tr>
    
</table>