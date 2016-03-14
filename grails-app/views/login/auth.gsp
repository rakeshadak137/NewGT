<%@ page import="com.master.BranchMaster; com.master.FinancialYear" %>
<html>
<head>
    %{--<script src="../js/angular/1.0.7/angular.js"></script>--}%
    %{--<title><g:message code="springSecurity.login.title"/></title>--}%
    %{--<style type='text/css' media='screen'>--}%
    %{--#login {--}%
    %{--margin: 15px 0px;--}%
    %{--padding: 0px;--}%
    %{--text-align: center;--}%
    %{--}--}%
    %{--#login .inner {--}%
    %{--width: 340px;--}%
    %{--padding-bottom: 6px;--}%
    %{--margin: 60px auto;--}%
    %{--text-align: left;--}%
    %{--border: 1px solid #aab;--}%
    %{--background-color: #f0f0fa;--}%
    %{---moz-box-shadow: 2px 2px 2px #eee;--}%
    %{---webkit-box-shadow: 2px 2px 2px #eee;--}%
    %{---khtml-box-shadow: 2px 2px 2px #eee;--}%
    %{--box-shadow: 2px 2px 2px #eee;--}%
    %{--}--}%

    %{--#login .inner .fheader {--}%
    %{--padding: 18px 26px 14px 26px;--}%
    %{--background-color: #f7f7ff;--}%
    %{--margin: 0px 0 14px 0;--}%
    %{--color: #2e3741;--}%
    %{--font-size: 18px;--}%
    %{--font-weight: bold;--}%
    %{--}--}%

    %{--#login .inner .cssform p {--}%
    %{--clear: left;--}%
    %{--margin: 0;--}%
    %{--padding: 4px 0 3px 0;--}%
    %{--padding-left: 105px;--}%
    %{--margin-bottom: 20px;--}%
    %{--height: 1%;--}%
    %{--}--}%

    %{--#login .inner .cssform input[type='text'] {--}%
    %{--width: 120px;--}%
    %{--}--}%

    %{--#login .inner .cssform label {--}%
    %{--font-weight: bold;--}%
    %{--float: left;--}%
    %{--text-align: right;--}%
    %{--margin-left: -105px;--}%
    %{--width: 110px;--}%
    %{--padding-top: 3px;--}%
    %{--padding-right: 10px;--}%
    %{--}--}%

    %{--#login #remember_me_holder {--}%
    %{--padding-left: 120px;--}%
    %{--}--}%

    %{--#login #submit {--}%
    %{--margin-left: 15px;--}%
    %{--}--}%

    %{--#login #remember_me_holder label {--}%
    %{--float: none;--}%
    %{--margin-left: 0;--}%
    %{--text-align: left;--}%
    %{--width: 200px--}%
    %{--}--}%

    %{--#login .inner .login_message {--}%
    %{--padding: 6px 25px 20px 25px;--}%
    %{--color: #c33;--}%
    %{--}--}%

    %{--#login .inner .text_ {--}%
    %{--width: 120px;--}%
    %{--}--}%

    %{--#login .inner .chk {--}%
    %{--height: 12px;--}%
    %{--}--}%
    %{--</style>--}%
    <link href="/${grailsApplication.config.erpName}/assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome.min.css"/>

    <!--[if IE 7]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->

    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300"/>

    <!-- ace styles -->

    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace.min.css"/>
    <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-rtl.min.css"/>

    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="/${grailsApplication.config.erpName}/assets/css/ace-ie.min.css" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
		<script src="/${grailsApplication.config.erpName}/assets/js/html5shiv.js"></script>
		<script src="/${grailsApplication.config.erpName}/assets/js/respond.min.js"></script>
		<![endif]-->
    <script>
        function AuthController($scope, $http) {


            $scope.doSubmit = function () {
                debugger;
                var windowLocation = window.location.origin;
                %{--window.location.href='${postUrl}?j_username='+document.getElementById('username').value+'&j_password='+document.getElementById('password').value;--}%
                // init server ajax call to get auth from Spring
                //$http.post('
                %{--${postUrl}--}%
                %{--? j_username = '+document.getElementById('username').value+' & j_password = '+document.getElementById('password').value)--}%

                $http.post('${request.contextPath}/j_spring_security_check?j_username=' + document.getElementById('username').value + '&j_password=' + document.getElementById('password').value + "&isLogin=true")
                        .success(function (data) {
                            debugger;
                            if (data.sucess && data.sucess == true) {
                                window.location = windowLocation + "/${grailsApplication.config.erpName}/main/index?year=" + document.getElementById('year').value + "&isLogin=true";
                            }
                        })

            }
        }
    </script>
</head>


%{--<div ng-app="">--}%
%{----}%
%{--<div ng-controller="AuthController">--}%
<body class="login-layout">
%{--<script>--}%
%{--function request(){--}%
%{--debugger;--}%
%{--var valid;--}%
%{--$.post("/${grailsApplication.config.erpName}/bomDetails/checkFinancialYear?year="+document.getElementById("year").value--}%
%{--+"&username="+document.getElementById("username").value,function(data,status){--}%
%{--debugger;--}%
%{--valid= data;--}%
%{--});--}%
%{--return valid;--}%
%{--}--}%
%{--</script>--}%
<div class="main-container">
<div class="main-content">
<div class="row">
<div class="col-sm-10 col-sm-offset-1">
<div class="login-container">


<br>
<br>
<br>
<br>
<br>

<div class="center">
    <h1>
        %{--<span class="red">ABR CREATIONS</span><br>--}%
        %{--<img src="/${grailsApplication.config.erpName}/images/final2.jpg">--}%
        <img src="/${grailsApplication.config.erpName}/images/AssiduousLogo.png">
        %{--<i class="icon-truck"></i>--}%
        %{--<small>--}%
        %{--<span class="RED" style="">CREATIONS</span>--}%
    %{--</small>--}%
    </h1>
    %{--<h4 class="blue">&copy; Balaji Enterprises</h4>--}%
</div>

<div class="space-6"></div>

<div class="position-relative">
<div id="login-box" class="login-box visible widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header blue lighter bigger">
                <i class="icon-coffee green"></i>
                Please Enter Your Login
            </h4>

            <div class='inner'>
                %{--<div class='fheader'><g:message code="springSecurity.login.header"/></div>--}%
                <div class="space-6"></div>
                <g:if test='${flash.message}'>
                    <div style="color: red">${flash.message}</div>
                </g:if>

                <g:form controller="login" id="loginForm">%{--action='${postUrl}'--}%
                    <fieldset>

                        %{--<input type="hidden" value="${targetUrl}" name="targetUrl"/>--}%
                    %{--<label class="block clearfix">--}%
                        %{--<span class="block input-icon input-icon-right">--}%
                        %{--<g:select name="branch" from="${BranchMaster.findAllByIsActive(true)}" id="branch"--}%
                                  %{--noSelection="['': '-Branch Name-']"/>--}%
                        %{--<i class="icon-user"></i>--}%
                        %{--</span>--}%
                    %{--</label>--}%
                        <label class="block clearfix">
                            %{--<span class="block input-icon input-icon-right">--}%
                            <g:select name="year" from="${FinancialYear.list().sort(false) {-it.id}}" id="year"
                                      autofocus=""/>
                            %{--<i class="icon-user"></i>--}%
                            %{--</span>--}%
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="text" name='j_username' id='username' class="form-control"
                                       placeholder="Username" style="width: 310px;"/>
                                <i class="icon-user"></i>
                            </span>
                        </label>

                        <label class="block clearfix">
                            <span class="block input-icon input-icon-right">
                                <input type="password" name='j_password' id='password' class="form-control"
                                       placeholder="Password" style="width: 310px;"/>
                                <i class="icon-lock"></i>
                            </span>
                        </label>

                        <div class="space"></div>

                        <div class="clearfix">
                            %{--<label class="inline">--}%
                            %{--<input type="checkbox" class="ace" />--}%
                            %{--<span class="lbl"> Remember Me</span>--}%
                            %{--</label>--}%
                             <g:actionSubmit action="validateUser" value="Login"  class="width-35 pull-right btn btn-sm btn-primary"></g:actionSubmit>
                            %{--<button type="submit" name="Login" class="width-35 pull-right btn btn-sm btn-primary">--}%
                                %{--<i class="icon-key"></i>--}%
                                %{--Login--}%
                            %{--</button>--}%
                        </div>

                        <div class="space-4"></div>
                    </fieldset>
                </g:form>
            </div>

        </div><!-- /widget-main -->

        <div class="toolbar clearfix">
            <div>
                <a href="#" onclick="show_box('forgot-box');
                return false;" class="forgot-password-link">
                    %{--<i class="icon-arrow-left"></i>--}%
                    %{--I forgot my password--}%
                </a>
            </div>

            <div>
                <a href="#" onclick="show_box('signup-box');
                return false;" class="user-signup-link">
                    %{--I want to register--}%
                    %{--<i class="icon-arrow-right"></i>--}%
                </a>
            </div>
        </div>
    </div><!-- /widget-body -->
</div><!-- /login-box -->

<div id="forgot-box" class="forgot-box widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header red lighter bigger">
                <i class="icon-key"></i>
                Retrieve Password
            </h4>

            <div class="space-6"></div>

            <p>
                Enter your email and to receive instructions
            </p>

            <form>
                <fieldset>
                    <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="email" class="form-control" placeholder="Email"/>
                            <i class="icon-envelope"></i>
                        </span>
                    </label>

                    <div class="clearfix">
                        <button type="button" class="width-35 pull-right btn btn-sm btn-danger">
                            <i class="icon-lightbulb"></i>
                            Send Me!
                        </button>
                    </div>
                </fieldset>
            </form>
        </div><!-- /widget-main -->

        <div class="toolbar center">
            <a href="#" onclick="show_box('login-box');
            return false;" class="back-to-login-link">
                Back to login
                <i class="icon-arrow-right"></i>
            </a>
        </div>
    </div><!-- /widget-body -->
</div><!-- /forgot-box -->

<div id="signup-box" class="signup-box widget-box no-border">
    <div class="widget-body">
        <div class="widget-main">
            <h4 class="header green lighter bigger">
                <i class="icon-group blue"></i>
                New User Registration
            </h4>

            <div class="space-6"></div>

            <p>Enter your details to begin:</p>

            <form>
                <fieldset>
                    <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="email" class="form-control" placeholder="Email"/>
                            <i class="icon-envelope"></i>
                        </span>
                    </label>

                    <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="text" class="form-control" placeholder="Username"/>
                            <i class="icon-user"></i>
                        </span>
                    </label>

                    <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="password" class="form-control" placeholder="Password"/>
                            <i class="icon-lock"></i>
                        </span>
                    </label>

                    <label class="block clearfix">
                        <span class="block input-icon input-icon-right">
                            <input type="password" class="form-control" placeholder="Repeat password"/>
                            <i class="icon-retweet"></i>
                        </span>
                    </label>

                    <label class="block">
                        <input type="checkbox" class="ace"/>
                        <span class="lbl">
                            I accept the
                            <a href="#">User Agreement</a>
                        </span>
                    </label>

                    <div class="space-24"></div>

                    <div class="clearfix">
                        <button type="reset" class="width-30 pull-left btn btn-sm">
                            <i class="icon-refresh"></i>
                            Reset
                        </button>

                        <button type="button" class="width-65 pull-right btn btn-sm btn-success">
                            Register
                            <i class="icon-arrow-right icon-on-right"></i>
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>

        <div class="toolbar center">
            <a href="#" onclick="show_box('login-box');
            return false;" class="back-to-login-link">
                <i class="icon-arrow-left"></i>
                Back to login
            </a>
        </div>
    </div><!-- /widget-body -->
</div><!-- /signup-box -->
</div><!-- /position-relative -->
</div>
</div><!-- /.col -->
</div><!-- /.row -->
</div>
</div><!-- /.main-container -->

<!-- basic scripts -->

<!--[if !IE]> -->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

<!-- <![endif]-->

<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

<!--[if !IE]> -->

<script type="text/javascript">
    window.jQuery || document.write("<script src='/${grailsApplication.config.erpName}/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='/${grailsApplication.config.erpName}/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<script type="text/javascript">
    if ("ontouchend" in document) document.write("<script src='/${grailsApplication.config.erpName}/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
</script>

<!-- inline scripts related to this page -->

<script type="text/javascript">
    function show_box(id) {
        jQuery('.widget-box.visible').removeClass('visible');
        jQuery('#' + id).addClass('visible');
    }
</script>
<script type='text/javascript'>
    <!--
    (function () {
        document.forms['loginForm'].elements['year'].focus();
    })();
    // -->
</script>
</body>
</div>
</div>

<!-- Mirrored from 192.69.216.111/themes/preview/ace/login.html by HTTrack Website Copier/3.x [XR&CO'2013], Sun, 06 Oct 2013 11:29:02 GMT -->
0
</html>
