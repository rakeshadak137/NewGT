<%@ page import="com.template.Template" %>
<!DOCTYPE html>
<html>
<head>

    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'template.label', default: 'Template')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>
    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.create.label" args="[entityName]"/></h2>--}%
        <div class="row-fluid">
            <div class="span9">
                <div id="create-template" class="content scaffold-create" role="main">
                    <div class="table-header">
                        <g:message code="default.create.label" args="[entityName]"/>
                        %{--<g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"--}%
                        %{--action="list"><i--}%
                        %{--class="icon-ok bigger-50"></i> List</g:link>--}%
                    </div>
                %{--<g:if test="${flash.message}">--}%
                %{--<div class="message" role="status">${flash.message}</div>--}%
                %{--</g:if>--}%
                %{--<g:hasErrors bean="${templateInstance}">--}%
                %{--<ul class="errors" role="alert">--}%
                %{--<g:eachError bean="${templateInstance}" var="error">--}%
                %{--<li> <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message--}%
                %{--error="${error}"/></li>--}%
                %{--</g:eachError>--}%
                %{--</ul>--}%
                %{--</g:hasErrors>--}%
                    <g:form action="saveOrUpdate" >
                        <fieldset class="form">
                            <div class="widget-main padding-8" style="margin-left: 50px; margin-right: 50px;"><g:render
                                    template="form"/></div>
                        </fieldset>
                        <fieldset class="buttons" style="margin-left: 100px; margin-right: 50px;">
                            <g:submitButton name="create" class="btn btn-info btn-small"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </fieldset>
                    </g:form>
                </div>




            </div>
            <div class="span3">
                <g:render template="/template/table"/>
            </div>
        </div>



        <g:render template="/shared/viewFooter"/>
    </div>
</div>
</body>
</html>
