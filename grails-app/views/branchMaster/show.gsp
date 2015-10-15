
<%@ page import="com.master.BranchMaster" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'branchMaster.label', default: 'BranchMaster')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="main-content">
    <g:render template="/shared/viewHeader"/>

    <div class="span12" style="width: 95%;margin-top: 15px;">
        %{--<h2 class="header smaller lighter blue"><g:message code="default.list.label" args="[entityName]"/></h2>--}%


        <div id="show-branchMaster" class="content scaffold-show" role="main">
            <div class="table-header">
                <g:message code="default.show.label" args="[entityName]"/>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="list" params="${[scrid:session['activeScreen'].id]}"><i
                        class="icon-ok bigger-50"></i> List</g:link>
                <g:link class="btn btn-info btn-small pull-right" style="margin-right: 5px;margin-top: 3px"
                        action="create" params="${[scrid:session['activeScreen'].id]}">
                    <i class="icon-pencil bigger-50"></i>New
                </g:link>

            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div style="margin-left: 50px; margin-right: 50px;" class="widget-main padding-8">
                <ol class="property-list branchMaster">
                    
                    <g:if test="${branchMasterInstance?.branchName}">
                        <li class="fieldcontain">
                            <span id="branchName-label" class="property-label"><g:message
                                    code="branchMaster.branchName.label"
                                    default="Branch Name"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branchName-label"><g:fieldValue
                                    bean="${branchMasterInstance}" field="branchName"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${branchMasterInstance?.branchAddress}">
                        <li class="fieldcontain">
                            <span id="branchAddress-label" class="property-label"><g:message
                                    code="branchMaster.branchAddress.label"
                                    default="Branch Address"/></span> :-
                        
                            <span class="property-value" aria-labelledby="branchAddress-label"><g:fieldValue
                                    bean="${branchMasterInstance}" field="branchAddress"/></span>
                            
                        </li>
                    </g:if>
                    
                    <g:if test="${branchMasterInstance?.isActive}">
                        <li class="fieldcontain">
                            <span id="isActive-label" class="property-label"><g:message
                                    code="branchMaster.isActive.label"
                                    default="Is Active"/></span> :-
                        
                            <span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean
                                    boolean="${branchMasterInstance?.isActive}"/></span>
                            
                        </li>
                    </g:if>
                    
                </ol>
                <g:form>
                    <fieldset class="buttons" style="margin-left: 50px; margin-right: 50px;">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:hiddenField name="id" value="${branchMasterInstance?.id}"/>
                        <g:link class="btn btn-info btn-small" action="edit" id="${branchMasterInstance?.id}"><g:message
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
