<%@ page import="com.template.Template" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'template.label', default: 'Template')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-template" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px" params="${[scrid:session['activeScreen'].id]}"
                        action="list"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px" params="${[scrid:session['activeScreen'].id]}"
                        action="create">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list template">

                    <g:if test="${templateInstance?.subject}">
                        <li class="fieldcontain">
                            <span id="subject-label" class="property-label"><g:message
                                    code="template.subject.label"
                                    default="Subject"/></span> :-

                            <span class="property-value" aria-labelledby="subject-label">
                                ${templateInstance?.subject?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${templateInstance?.childs}">
                        <li class="fieldcontain">
                            <span id="childs-label" class="property-label"><g:message
                                    code="template.childs.label"
                                    default="Childs"/></span> :-

                            <g:each in="${templateInstance.childs}" var="c">
                                <span class="property-value" aria-labelledby="childs-label">
                                    ${c?.encodeAsHTML()}
                                </span>
                            </g:each>

                        </li>
                    </g:if>

                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${templateInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${templateInstance?.id}"><g:message params="${[scrid:session['activeScreen'].id]}"
                                code="default.button.edit.label" default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-info btn-small" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </fieldset>
                </g:form>
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>

</body>
</html>
