<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'billAgainstLR.label', default: 'Bill Related Report')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>


    <script>
        $(function () {
            debugger;
            $("#tabs").tabs();
        });
        function BillAgainstLR($scope, $http) {

            init();

            function init() {
            }
        }
    </script>
</head>

<body>
<div ng-app="">
<%= newId %>
<div ng-controller="BillAgainstLR">

<div class="main-content">

    <div class="row-fluid" style="margin-left:30px; width:95%; margin-top: 15px;">

        <div id="list-examSchedule" class="content scaffold-list" role="main">

            <div class="table-header">
                <h5>BILL RELATED REPORT</h5>
            </div>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div id="tabs">

                <ul>
                    <li><a href="#tabs-1">Bill</a></li>
                    <li><a href="#tabs-2">LR</a></li>
                    <li><a href="#tabs-3">LR Summary</a></li>
                    <li><a href="#tabs-4">LR Details</a></li>

                </ul>


                <div id="tabs-1">
                    <g:jasperForm controller="BillAgainstLR"
                                  action="billPrint"
                                  jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                        <input type="hidden" name="id" value="${newId}">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-info btn-small"
                                        text="Bill Print"/>

                    </g:jasperForm>

                </div>

                <div id="tabs-2">
                    <g:jasperForm controller="BillAgainstLR"
                                  action="LRPrint"
                                  jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                        <input type="hidden" name="id" value="${newId}">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-info btn-small"
                                        text="LR Print"/>

                    </g:jasperForm>

                </div>

                <div id="tabs-3">

                    <g:jasperForm controller="BillAgainstLR"
                                  action="LRSummary"
                                  jasper="../reports/inward_reports/bookPurchaseSupplierWise">

                        <input type="hidden" name="id" value="${newId}">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-info btn-small"
                                        text="LR Summary"/>

                    </g:jasperForm>

                </div>

                <div id="tabs-4">

                    <g:jasperForm controller="BillAgainstLR"
                                  action="LRDetails"
                                  jasper="../reports/inward_reports/bookPurchaseDatewiseSummary">

                        <input type="hidden" name="id" value="${newId}">
                        <g:hiddenField name="scrid" value="${session['activeScreen'].id}"/>
                        <g:jasperButton format="pdf" jasper="jasper-test" class="btn btn-info btn-small"
                                        text="LR Details"/>

                    </g:jasperForm>

                </div>

            </div>

        </div>
    </div>
</div>
</div>
</div>
</div>
</body>
</html>
</html>