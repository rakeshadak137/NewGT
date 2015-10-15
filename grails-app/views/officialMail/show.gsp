<%@ page import="com.template.OfficialMail" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'officialMail.label', default: 'OfficialMail')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-officialMail" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="list" params="${[scrid: session['activeScreen'].id]}">
                    <i class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create" params="${[scrid: session['activeScreen'].id]}">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list officialMail">

                    <g:if test="${officialMailInstance?.assignBy}">
                        <li class="fieldcontain">
                            <span id="assignBy-label" class="property-label"><g:message
                                    code="officialMail.assignBy.label"
                                    default="Assign By"/></span> :-

                            <span class="property-value" aria-labelledby="assignBy-label">
                                ${officialMailInstance?.assignBy?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.publishDate}">
                        <li class="fieldcontain">
                            <span id="publishDate-label" class="property-label"><g:message
                                    code="officialMail.publishDate.label"
                                    default="Publish Date"/></span> :-

                            <span class="property-value" aria-labelledby="publishDate-label"><g:formatDate
                                    date="${officialMailInstance?.publishDate}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.publishEndDate}">
                        <li class="fieldcontain">
                            <span id="publishEndDate-label" class="property-label"><g:message
                                    code="officialMail.publishEndDate.label"
                                    default="Publish End Date"/></span> :-

                            <span class="property-value" aria-labelledby="publishEndDate-label"><g:formatDate
                                    date="${officialMailInstance?.publishEndDate}"/></span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.assignTo}">
                        <li class="fieldcontain">
                            <span id="assignTo-label" class="property-label"><g:message
                                    code="officialMail.assignTo.label"
                                    default="Assign To"/></span> :-

                            <span class="property-value" aria-labelledby="assignTo-label">
                                ${officialMailInstance?.assignTo?.encodeAsHTML()}</span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.subject}">
                        <li class="fieldcontain">
                            <span id="subject-label" class="property-label"><g:message
                                    code="officialMail.subject.label"
                                    default="Subject"/></span> :-

                            <span class="property-value" aria-labelledby="subject-label"><g:fieldValue
                                    bean="${officialMailInstance}" field="subject"/></span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.description}">
                        <li class="fieldcontain">
                            <span id="description-label" class="property-label"><g:message
                                    code="officialMail.description.label"
                                    default="Description"/></span> :-

                            <span class="property-value" aria-labelledby="description-label"><g:fieldValue
                                    bean="${officialMailInstance}" field="description"/></span>

                        </li>
                    </g:if>

                    <g:if test="${officialMailInstance?.attachment}">
                        <li class="fieldcontain">
                            <span id="attachment-label" class="property-label"><g:message
                                    code="officialMail.attachment.label"
                                    default="Attachment"/></span> :-

                            <span class="property-value" aria-labelledby="attachment-label"><g:fieldValue
                                    bean="${officialMailInstance}" field="attachment"/></span>

                        </li>
                    </g:if>

                </ol>
                %{--<g:form>--}%
                %{--<fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">--}%
                %{--<g:hiddenField name="id" value="${officialMailInstance?.id}"/>--}%
                %{--<g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>--}%
                %{--<g:link class="btn btn-info btn-small" action="edit" id="${officialMailInstance?.id}"--}%
                %{--params="${[scrid: session['activeScreen'].id]}">--}%
                %{--<g:message--}%
                %{--code="default.button.edit.label" default="Edit"/></g:link>--}%
                %{--<g:actionSubmit class="btn btn-info btn-small" action="delete"--}%
                %{--value="${message(code: 'default.button.delete.label', default: 'Delete')}"--}%
                %{--onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>--}%
                %{--</fieldset>--}%
                %{--</g:form>--}%
            </div>
        </div>
        <g:render template="/shared/viewFooter"/>
    </div>
</div>

</body>
</html>
