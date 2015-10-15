%{--<!DOCTYPE html>--}%
%{--<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->--}%
%{--<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->--}%
%{--<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->--}%
%{--<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->--}%
%{--<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->--}%
%{--<head>--}%
%{--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--}%
%{--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--}%
%{--<title><g:layoutTitle default="Grails"/></title>--}%
%{--<meta name="viewport" content="width=device-width, initial-scale=1.0">--}%
%{--<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">--}%
%{--<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">--}%
%{--<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">--}%
%{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">--}%
%{--<g:layoutHead/>--}%
%{--<r:layoutResources />--}%
%{--</head>--}%
%{--<body>--}%
%{--<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>--}%
%{--<g:layoutBody/>--}%
%{--<div class="footer" role="contentinfo"></div>--}%
%{--<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>--}%
%{--<g:javascript library="application"/>--}%
%{--<r:layoutResources />--}%
%{--</body>--}%
%{--</html>--}%
%{--=================================================================== OLD MAin Template=============================================================--}%
%{--
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>
		<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>
		<g:layoutBody/>
		<div class="footer" role="contentinfo"></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
--}%


<%@ page import="com.system.Screen" %>
<!DOCTYPE html >
<html lang="en" ng-app="app">
<head>
    <meta charset="utf-8"/>
    <title><g:layoutTitle default="Grails"/></title>

    <meta name="description" content="Common Buttons &amp; Icons"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!--basic styles-->
    <!-- basic styles -->

    <link href="/${grailsApplication.config.erpName}/assets/css/bootstrap.min.css" rel="stylesheet"/>

    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/angular-treeRepeat-master/app/css/app.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/css/angular.treeview.css"/>

    <script src="/${grailsApplication.config.erpName}/assets/js/jquery-1.10.2.js"></script>
    <script src="/${grailsApplication.config.erpName}/js/focus.js" type="text/javascript" data-main="js/main"
            defer></script>

    <script src="/${grailsApplication.config.erpName}/js/ngAutocomplete.js" type="text/javascript" data-main="js/main"
            defer></script>
    <script src="/${grailsApplication.config.erpName}/angular-treeRepeat-master/app/lib/angular/angular-animate.js" type="text/javascript" data-main="js/main"
            defer></script>
    <script src="/${grailsApplication.config.erpName}/angular-treeRepeat-master/app/js/directives.js" type="text/javascript" data-main="js/main"
            defer></script>
    %{--<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"></script>--}%

    %{--<script src="/${grailsApplication.config.erpName}/js/focus1.js" type="text/javascript" data-main="js/main"  defer></script>--}%

    <!--[if IE 7]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

    <!-- page specific plugin styles -->
    %{--<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>--}%
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/jquery-ui-1.10.3.full.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/css/hmenu.css"/>
    %{--<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>--}%
    <script src="/${grailsApplication.config.erpName}/assets/js/jquery-ui-1.10.3.full.min.js"></script>

    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/datepicker.css"/>
    %{--<link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ui.jqgrid.css"/>--}%

    <!-- fonts -->

    %{--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300"/>--}%

    <!-- ace styles -->

    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace.min.css"/>
    %{--<link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-rtl.min.css"/>--}%
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-skins.min.css"/>

    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-ie.min.css" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->

    <script src="/${grailsApplication.config.erpName}/assets/js/ace-extra.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/bootstrap.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/typeahead-bs2.min.js"></script>

    <!-- ace scripts -->

    <script src="/${grailsApplication.config.erpName}/assets/js/ace-elements.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/ace.min.js"></script>


    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
		<script src="/${grailsApplication.config.erpName}/assets/js/html5shiv.js"></script>
		<script src="/${grailsApplication.config.erpName}/assets/js/respond.min.js"></script>
      <![endif]-->



    <link href="/${grailsApplication.config.erpName}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/${grailsApplication.config.erpName}/assets/css/bootstrap-responsive.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome.min.css"/>




    <!--[if IE 7]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

    <!--page specific plugin styles-->

    <!--fonts-->

    %{--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300"/>--}%

    <!--ace styles-->

    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-responsive.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/jquery-ui.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/bootstrap-datepicker.css"/>

    %{--<script src="/${grailsApplication.config.erpName}/assets/js/jqGrid/jquery.jqGrid.min.js"></script>--}%
    <script src="/${grailsApplication.config.erpName}/assets/js/jqGrid/i18n/grid.locale-en.js"></script>


    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-ie.min.css" />
		<![endif]-->

    <!-- Auto complete Combobox-->
    <script src="/${grailsApplication.config.erpName}/js/jquery-migrate-1.2.1.js"></script>
    <script src="/${grailsApplication.config.erpName}/js/jquery.searchabledropdown.js"></script>
    <!-- end auto complete Combobox-->

    <!--inline styles related to this page-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <g:javascript library="angularJs"></g:javascript>
    <g:javascript library="lodash"></g:javascript>
    %{--<g:javascript library="jquery9"></g:javascript>--}%
    %{--<g:javascript library="jqueryUI"></g:javascript>--}%
    <g:javascript library="DatePicker"></g:javascript>
    <g:layoutHead/>
    <r:layoutResources/>

    <script src="/${grailsApplication.config.erpName}/assets/js/date-time/bootstrap-datepicker.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/date-time/bootstrap-timepicker.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/date-time/moment.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/date-time/daterangepicker.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/bootstrap-colorpicker.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/jquery.knob.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/jquery.autosize.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/jquery.maskedinput.min.js"></script>
    <script src="/${grailsApplication.config.erpName}/assets/js/bootstrap-tag.min.js"></script>

</head>

<body>
<div class="navbar">
<div class="navbar-inner">
<div class="container-fluid">
<a href="#" class="brand">
    <small>
        <i class="icon-truck"></i>
        Ganesh Transport
    </small>
</a><!--/.brand-->
%{--<ul class="nav nav-pills">--}%
%{--<li class="active">--}%
    %{--<% def userScreenRights1 = session['screenRole']?:[] %>--}%
    %{--<g:each var="c" in="${Screen.findAllByController(null)}">--}%
        %{--<li class="${session?.activeScreen?.id == c.id ? '' : session?.activeScreen?.parentScreen?.id == c.id ? 'active' : ''}">--}%
            %{--<g:remoteLink controller="main" action="getSubMenu" update="newCheck"--}%
                          %{--params="[scrid: c.id, sid: c.id]" class="dropdown-toggle">--}%

            %{--<i class="icon-bar-chart"></i>--}%
                %{--<span class="menu-text">${c.name}</span>--}%

            %{--</g:remoteLink>--}%

        %{--</li>--}%
    %{--</g:each>--}%
%{--</li>--}%

%{--</ul>--}%
<ul class="nav ace-nav pull-right">
%{--<li class="grey">--}%
%{--<a data-toggle="dropdown" class="dropdown-toggle" href="#">--}%
%{--<i class="icon-tasks"></i>--}%
%{--<span class="badge badge-grey">4</span>--}%
%{--</a>--}%

%{--<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">--}%
%{--<li class="nav-header">--}%
%{--<i class="icon-ok"></i>--}%
%{--4 Tasks to complete--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">Software Update</span>--}%
%{--<span class="pull-right">65%</span>--}%
%{--</div>--}%

%{--<div class="progress progress-mini ">--}%
%{--<div style="width:65%" class="bar"></div>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">Hardware Upgrade</span>--}%
%{--<span class="pull-right">35%</span>--}%
%{--</div>--}%

%{--<div class="progress progress-mini progress-danger">--}%
%{--<div style="width:35%" class="bar"></div>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">Unit Testing</span>--}%
%{--<span class="pull-right">15%</span>--}%
%{--</div>--}%

%{--<div class="progress progress-mini progress-warning">--}%
%{--<div style="width:15%" class="bar"></div>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">Bug Fixes</span>--}%
%{--<span class="pull-right">90%</span>--}%
%{--</div>--}%

%{--<div class="progress progress-mini progress-success progress-striped active">--}%
%{--<div style="width:90%" class="bar"></div>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--See tasks with details--}%
%{--<i class="icon-arrow-right"></i>--}%
%{--</a>--}%
%{--</li>--}%
%{--</ul>--}%
%{--</li>--}%

%{--<li class="purple">--}%
%{--<a data-toggle="dropdown" class="dropdown-toggle" href="#">--}%
%{--<i class="icon-bell-alt icon-animated-bell"></i>--}%
%{--<span class="badge badge-important">8</span>--}%
%{--</a>--}%

%{--<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-closer">--}%
%{--<li class="nav-header">--}%
%{--<i class="icon-warning-sign"></i>--}%
%{--8 Notifications--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">--}%
%{--<i class="btn btn-mini no-hover btn-pink icon-comment"></i>--}%
%{--New Comments--}%
%{--</span>--}%
%{--<span class="pull-right badge badge-info">+12</span>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<i class="btn btn-mini btn-primary icon-user"></i>--}%
%{--Bob just signed up as an editor ...--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">--}%
%{--<i class="btn btn-mini no-hover btn-success icon-shopping-cart"></i>--}%
%{--New Orders--}%
%{--</span>--}%
%{--<span class="pull-right badge badge-success">+8</span>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<div class="clearfix">--}%
%{--<span class="pull-left">--}%
%{--<i class="btn btn-mini no-hover btn-info icon-twitter"></i>--}%
%{--Followers--}%
%{--</span>--}%
%{--<span class="pull-right badge badge-info">+11</span>--}%
%{--</div>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--See all notifications--}%
%{--<i class="icon-arrow-right"></i>--}%
%{--</a>--}%
%{--</li>--}%
%{--</ul>--}%
%{--</li>--}%

%{--<li class="green">--}%
%{--<a data-toggle="dropdown" class="dropdown-toggle" href="#">--}%
%{--<i class="icon-envelope icon-animated-vertical"></i>--}%
%{--<span class="badge badge-success">5</span>--}%
%{--</a>--}%

%{--<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-closer">--}%
%{--<li class="nav-header">--}%
%{--<i class="icon-envelope-alt"></i>--}%
%{--5 Messages--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<img src="/${grailsApplication.config.erpName}/assets/avatars/avatar.png" class="msg-photo"--}%
%{--alt="Alex's Avatar"/>--}%
%{--<span class="msg-body">--}%
%{--<span class="msg-title">--}%
%{--<span class="blue">Alex:</span>--}%
%{--Ciao sociis natoque penatibus et auctor ...--}%
%{--</span>--}%

%{--<span class="msg-time">--}%
%{--<i class="icon-time"></i>--}%
%{--<span>a moment ago</span>--}%
%{--</span>--}%
%{--</span>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<img src="/${grailsApplication.config.erpName}/assets/avatars/avatar3.png" class="msg-photo"--}%
%{--alt="Susan's Avatar"/>--}%
%{--<span class="msg-body">--}%
%{--<span class="msg-title">--}%
%{--<span class="blue">Susan:</span>--}%
%{--Vestibulum id ligula porta felis euismod ...--}%
%{--</span>--}%

%{--<span class="msg-time">--}%
%{--<i class="icon-time"></i>--}%
%{--<span>20 minutes ago</span>--}%
%{--</span>--}%
%{--</span>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--<img src="/${grailsApplication.config.erpName}/assets/avatars/avatar4.png" class="msg-photo"--}%
%{--alt="Bob's Avatar"/>--}%
%{--<span class="msg-body">--}%
%{--<span class="msg-title">--}%
%{--<span class="blue">Bob:</span>--}%
%{--Nullam quis risus eget urna mollis ornare ...--}%
%{--</span>--}%

%{--<span class="msg-time">--}%
%{--<i class="icon-time"></i>--}%
%{--<span>3:15 pm</span>--}%
%{--</span>--}%
%{--</span>--}%
%{--</a>--}%
%{--</li>--}%

%{--<li>--}%
%{--<a href="#">--}%
%{--See all messages--}%
%{--<i class="icon-arrow-right"></i>--}%
%{--</a>--}%
%{--</li>--}%
%{--</ul>--}%
%{--</li>--}%

<li>
    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
        %{--<img class="nav-user-photo" src="/${grailsApplication.config.erpName}/assets/avatars/user.jpg"--}%
        %{--alt="Jason's Photo"/>--}%
        <span class="user-info">
            <small>Welcome</small>
            GT
        </span>
    </a>

    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
        <li>
            <a href="#">
                <i class="icon-cog"></i>
                Settings
            </a>
        </li>

        <li>
            <a href="#">
                <i class="icon-user"></i>
                Profile
            </a>
        </li>

        <li class="divider"></li>

        <li>
            <a href="#">
                <i class="icon-off"></i>
                Logout
            </a>
        </li>
    </ul>
</li>
<li>
    <g:form controller="logout">
        <input type="image" value="submit" src="/${grailsApplication.config.erpName}/assets/avatars/logout.png"
               alt="submit Button">
    %{--<g:actionSubmit  value="Logout" action="index">    --}%%{--data-toggle="dropdown" href="#" class="dropdown-toggle"--}%
    %{--<img class="nav-user-photo" src="/${grailsApplication.config.erpName}/assets/avatars/logout2.jpg"--}%
    %{--alt="Jason's Photo"/>--}%
    %{--</g:actionSubmit>--}%
    </g:form>
</li>
</ul><!--/.ace-nav-->
</div><!--/.container-fluid-->
</div><!--/.navbar-inner-->
<div class="container">
    <ul id="navhmenu">
    %{--<li class="active">--}%
    %{--<% def userScreenRights1 = session['screenRole']?:[] %>--}%
    %{--<g:each var="c" in="${session["activeModule"]}">--}%
    %{--<li class="${session?.activeScreen?.id == c.id ? '' : session?.activeScreen?.parentScreen?.id == c.id ? 'active' : ''}">--}%
    %{--<g:remoteLink controller="main" action="getSubMenu" update="newCheck"--}%
    %{--params="[scrid: c.id, sid: c.id]">--}%

    %{--<i class="icon-bar-chart"></i>--}%
    %{--${c.name}--}%

    %{--</g:remoteLink>--}%

    %{--</li>--}%
    %{--</g:each>--}%



                <% def userModule = session['screenModule']%>
        <g:each var="c" in="${userModule}">
            <li class="${session['activeScreen']?.parentScreen?.id == c.id ? 'active' : session?.activeScreen?.parentScreen?.parentScreen?.id == c.id ? 'active' : ''}">
                <g:remoteLink controller="main" action="getSubMenu" update="newCheck"
                              params="[scrid: c.id, sid: c.id]" class="dropdown-toggle">

                %{--<i class="icon-bar-chart"></i>--}%
                    ${c.name}

                </g:remoteLink>

            </li>
        </g:each>
    %{--</li>--}%

    </ul>
</div>
</div>

<div class="main-container container-fluid">
    <a class="menu-toggler" id="menu-toggler" href="#">
        <span class="menu-text"></span>
    </a>

    <div class="sidebar" id="sidebar">
        %{--<div class="sidebar-shortcuts" id="sidebar-shortcuts">--}%
        %{--<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">--}%

        %{--</div>--}%

        %{--<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">--}%
        %{--<span class="btn btn-success"></span>--}%

        %{--<span class="btn btn-info"></span>--}%

        %{--<span class="btn btn-warning"></span>--}%

        %{--<span class="btn btn-danger"></span>--}%
        %{--</div>--}%
        %{--</div><!--#sidebar-shortcuts-->--}%


        <div ng-controller="mainController">
            <ul id="newCheck" class="nav nav-list">

                <g:if test='${session["activeSubModule"]}'>

                    <li>
                    <% def d1 = session["activeSubModule"] %>
                    <g:each var="a" in='${d1}'>
                        <li class="${session?.activeScreen?.id == a.id ? 'active' : session?.activeScreen?.parentScreen?.id == a.id ? 'active open' : ''}">
                    %{--<li class="${session?.activeScreen?.id == c.id ? 'active' : session?.activeScreen?.parentScreen?.id == c.id ? 'active open' : ''}">--}%
                    %{--<li class="${session.activeScreen?.id == a.id ? 'active' : ''}">--}%
                        %{--<li class="${session.activeModule?.subMenuId == a.id ? 'active' : ''}">--}%

                            <g:link controller="${a.controller}" params="${[scrid: a.id]}"
                                    class="dropdown-toggle">
                                <i class="icon-desktop"></i>
                                <span class="menu-text">${a.subMenu}</span>
                                <b class="arrow icon-angle-down"></b>

                            </g:link>
                            <ul class="submenu">
                            %{--<li onclick="validation">--}%
                                <g:each var="c" in="${a.childs}">

                                    <li class="${session.activeScreen?.id == c.id ? 'active' : 'open'}">
                                        <g:link controller="${c.controller}" params="${[scrid: c.id]}">
                                            <i class="icon-double-angle-right"></i>

                                            ${c.domainName}
                                        </g:link>
                                    </li>

                                </g:each>

                            </ul>
                        </li>
                    </g:each>

                    </li>

                </g:if>

            </ul><!--/.nav-list-->
        </div><!--/.nav-list-->

        <div class="sidebar-collapse" id="sidebar-collapse">
            <i class="icon-double-angle-left"></i>
        </div>
    </div>
    <g:layoutBody/>

</div><!--/.page-header-->

<div class="row-fluid">
    <div class="span12">
        <!--PAGE CONTENT BEGINS-->





        <!--PAGE CONTENT ENDS-->
    </div><!--/.span-->
</div><!--/.row-fluid-->
</div><!--/.page-content-->


</div><!--/.main-content-->
</div><!--/.main-container-->

<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only bigger-110"></i>
</a>

<!--basic scripts-->

<!--[if !IE]>-->


%{--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>--}%

<!--<![endif]-->

<!--[if IE]>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
<![endif]-->

<!--[if !IE]>-->

<script type="text/javascript">
    window.jQuery || document.write("<script src='/${grailsApplication.config.erpName}/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>

<!--<![endif]-->

<!--[if IE]>
<![endif]-->

<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='/${grailsApplication.config.erpName}/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>
<script src="/${grailsApplication.config.erpName}/assets/js/bootstrap.min.js"></script>

<!--page specific plugin scripts-->


<!--inline scripts related to this page-->

<script type="text/javascript">
    $(function () {
        $('#loading-btn').on(ace.click_event, function () {
            var btn = $(this);
            btn.button('loading')
            setTimeout(function () {
                btn.button('reset')
            }, 2000)
        });

        $('#id-button-borders').attr('checked', 'checked').on('click', function () {
            $('#default-buttons .btn').toggleClass('no-border');
        });
    })

    function mainController($scope) {
        debugger;
        <g:if test="${session["activeModule"]}">
        $scope.sessionModule =
        ${session["activeModule"] as grails.converters.JSON}


        </g:if>

    }
</script>

<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources/>
</body>
</html>
