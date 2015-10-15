<div class="breadcrumbs" id="breadcrumbs">
    <ul class="breadcrumb">
        <li>
            <i class="icon-home home-icon"></i>
            %{--<a href="http://localhost:8081/${grailsApplication.config.erpName}">Home</a>--}%
            <a href="${request.getContextPath()}/main/index">Home</a>
            %{--Home--}%
            <span class="divider">
                <i class="icon-angle-right arrow-icon"></i>
            </span>
        </li>

        <g:if test="${session.activeScreen?.parentScreen}">
            <li>
                %{--<a href="http://localhost:8080/myerp2/">${session.activeScreen?.parentScreen.name}</a>--}%
                <span>${session.activeScreen?.parentScreen?.parentScreen?.name}</span>
                <span class="divider">
                    <i class="icon-angle-right arrow-icon"></i>
                </span>
            </li>

            <li>
                %{--<a href="http://localhost:8080/myerp2/">${session.activeScreen?.parentScreen.name}</a>--}%
                <span>${session.activeScreen?.parentScreen?.filter}</span>
                <span class="divider">
                    <i class="icon-angle-right arrow-icon"></i>
                </span>
            </li>
        </g:if>


        <li class="active">${session.activeScreen?.domainName}</li>
    </ul>
    <!--.breadcrumb-->


    %{--<div class="nav-search" id="nav-search">--}%
    %{--<form class="form-search"/>--}%
    %{--<span class="input-icon">--}%
    %{--<input type="text" placeholder="Search ..." class="input-small nav-search-input" id="nav-search-input"--}%
    %{--autocomplete="off"/>--}%
    %{--<i class="icon-search nav-search-icon"></i>--}%
    %{--</span>--}%
    %{--</form>--}%
    %{--</div><!--#nav-search-->--}%
</div>

%{--<div class="row-fluid pull-right">--}%
%{--<div class="btn-toolbar pull-right" style="margin-right: 50px">--}%

%{--<g:link class="btn btn-primary" action="create">--}%
%{--<i class="icon-pencil bigger-50"></i>New--}%
%{-- <g:message code="default.new.label" args="[entityName]" />--}%

%{--</g:link>--}%
%{--<g:link class="btn btn-success" action="list" id="${organizationInstance?.id}"><i--}%
%{--class="icon-ok bigger-50"></i> List</g:link>--}%
%{--<g:link class="btn btn-danger" action="delete"--}%
%{--value="${message(code: 'default.button.delete.label', default: 'Delete')}"--}%
%{--onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"><i--}%
%{--class="icon-trash icon-2x icon-only"></i>Delete</g:link>--}%


%{--<button class="btn btn-grey"><i class="icon-beaker bigger-125"></i> Import</button>--}%
%{--<button class="btn btn-light"><i class="icon-reply icon-only"></i> Export</button>--}%
%{--<button class="btn btn-purple">--}%
%{--<g:link class="btn btn-purple" action="print">--}%
%{--<i class="icon-print  bigger-125 icon-on-right"></i>--}%
%{--Print--}%
%{--</g:link>--}%

%{--</div>--}%
%{--</div>--}%