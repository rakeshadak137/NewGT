<%@ page import="grails.converters.JSON; com.template.SendMail" %>
<script xmlns="http://www.w3.org/1999/html">

    var flag = false;
    var flag2 = false;
    var flag3 = false;

    $(document).ready(function () {
        $("#selectedDepartment").searchable();
        $("#selectedSubject").searchable();
//        $("#subject").searchable();
    });

    var flag = false;
    function studentController($scope, $http) {
        init();
        function init() {
            var details = [];
            var parentDetails = [];
            $scope.value = false
            $scope.studentDetails = details;
            $scope.mailDetails = parentDetails;
            %{--$scope.deptList = ${Department.list() as  JSON};--}%
            $scope.text1 = "";
            $http.get("/${grailsApplication.config.erpName}/sendMail/getDept")
                    .success(function (data) {
                        $scope.deptList = data
                    })

            $http.get("/${grailsApplication.config.erpName}/sendMail/getSubject")
                    .success(function (data) {
                        $scope.subList = data;
                    })
        }

        $scope.getDetails = function (id) {
            debugger;
//            if (yid && did) {
                $http.get("/${grailsApplication.config.erpName}/sendMail/studDetails?id="+id)
                        .success(function (data) {
                            debugger;
                            $scope.childList = data;
                            $scope.studentDetails = data.details;

                            if (!$scope.studentDetails) {
                                $scope.studentDetails = [];
                            }
//                             validLength = $scope.templateDetails.length;
                        });
//            }

        }

        %{--$scope.change = function (id) {--}%
            %{--debugger;--}%
%{--//                 var id = $scope.selectedDepartment;--}%
            %{--$http.get("/${grailsApplication.config.erpName}/sendMail/deptList?id=" + id)--}%
                    %{--.success(function (data) {--}%
                        %{--debugger;--}%
                        %{--$scope.classList = data;--}%
                        %{--debugger;--}%
                    %{--});--}%
        %{--};--}%

        $scope.getChild = function (id) {

            $http.get("/${grailsApplication.config.erpName}/template/childFind?id="+id)
                    .success(function (data) {
                        debugger;
                        $scope.childList = data;
                        $scope.templateDetails = data.details;

                        if (!$scope.templateDetails) {
                            $scope.templateDetails = [];
                        }
                        validLength = $scope.templateDetails.length;
                    });
        };

        $scope.SelectDeselect = function (b) {
            if ($scope.studentDetails.length) {
                for (var i = 0; i < $scope.studentDetails.length; i++) {
                    $scope.studentDetails[i].bool = b;
                }
            }
        }

        $scope.showText = function (tName, desc, index) {
            debugger;
            if (tName) {
                $scope.showTextArea = true;
                $scope.text1 = desc
                $scope.mailDetails = [];
                $scope.mailDetails.push({
                    templateName: tName,
                    description: desc
                })
                for (var i = 0; i < $scope.templateDetails.length; i++) {
                    $scope.templateDetails[i].bool = false
                }
                $scope.templateDetails[index].bool = true

                for (var i = 0; i < $scope.templateDetails.length; i++) {
                    if ($scope.templateDetails[i].bool == true) {
                        flag3 = true;
                    }
                }


                debugger;
            }
        }

        $scope.checkFlag = function () {
            if ($scope.onlyMail || $scope.onlySms) {
//                         alert("Please Select Atleast One Sending Method");
                flag = true;
            }
        }
        $scope.checkBlank = function () {
            for (var i = 0; i < $scope.studentDetails.length; i++) {
                if ($scope.studentDetails[i].bool == true) {
                    flag2 = true;
                }

            }
        }
//             $scope.moreAttachment=function(){
//                 debugger;
//                 $scope.showAttach=true;
//                 debugger;
//             }

    }
</script>

<div ng-controller="studentController">

<table>
    <input type="hidden" value="{{mailDetails}}" name="parentData"/>
    <input type="hidden" value="{{studentDetails}}" name="mailData"/>
    <input type="hidden" value="{{text1}}" name="extraDescription"/>
    <input type="hidden" value="{{selectedDepartment}}" name="dId"/>
    <input type="hidden" value="{{yearAndClass}}" name="cId"/>
    <input type="hidden" value="{{onlyMail}}" name="mailCheck"/>
    <input type="hidden" value="{{onlySms}}" name="smsCheck"/>
    <tr>

        <div class="fieldcontain ${hasErrors(bean: sendMailInstance, field: 'department', 'error')} required">
            <td><label for="department">
                <g:message code="sendMail.department.label" default="Account"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td>
                <select class="many-to-one" ng-model="selectedDepartment" id="selectedDepartment"
                        name="selectedDepartment"
                        ng-change="getDetails(selectedDepartment)"
                        ng-options="r.id as r.name for r in deptList"><option value="">-- choose Account --</option>
                </select>
            </td>
        </div>

    </tr>
    %{--<tr>--}%

        %{--<div class="fieldcontain ${hasErrors(bean: sendMailInstance, field: 'classOnly', 'error')} required">--}%
            %{--<td><label for="yearAndClass">--}%
                %{--<g:message code="sendMail.yearAndClass.label" default="Year And Class"/>--}%
                %{--<span class="required-indicator">*</span>--}%
            %{--</label></td>--}%
            %{--<td>--}%
                %{--<select required="" class="many-to-one" ng-model="yearAndClass" name="yearAndClass" id="yearAndClass"--}%
                        %{--ng-change="getDetails(yearAndClass,selectedDepartment)"--}%
                        %{--ng-options="c.id as c.yrClass for c in classList"><option value="">-- choose class --</option>--}%
                %{--</select>--}%
            %{--</td>--}%
        %{--</div>--}%
    %{--</tr>--}%

    <tr>
        <div class="checkbox">
            <label>
                <td>
                    <input id="chkSelectDeselectAll" name="chkSelectDeselectAll" type="checkbox"
                           ng-model="chkSelectDeselectAll" ng-change="SelectDeselect(chkSelectDeselectAll)"/>
                    <span class="lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select All</span>

                </td>

            </label>
            <td></td>

        </div>
    </tr>

</table>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-3"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Select</td>

            <td>Student Name</td>

            <td>Parent Name</td>

            <td>Parent Mobile No.</td>

            <td>Parent E-mail</td>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="bm in studentDetails | filter : searchItem | filter:new_search">

            <td><input type="checkbox" ng-model="bm.bool" ng-change="checkBlank()"> <span class="lbl"></span></td>

            <td>{{bm.name}}</td>

            <td>{{bm.parentName}}</td>

            <td>{{bm.mobileNo}}</td>

            <td>{{bm.email}}</td>

        </tr>
        </tbody>
    </table>
</div>
<br>
<br>
<span class="btn btn-small">Select Template</span>
%{--Select Template--}%
<br><br>
<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'subject', 'error')} required">
            <td><label for="subject">
                <g:message code="template.subject.label" default="Subject"/>
                <span class="required-indicator">*</span>
            </label></td>
            <td>
                %{--<g:select id="subject" name="subject.id" from="${com.template.TemplateSubject.list()}"--}%
                %{--ng-model="selectedSubject" ng-change="getChild()" optionKey="id"--}%
                %{--required="" value="${templateInstance?.subject?.id}" class="many-to-one"/>--}%
                <select id="selectedSubject" name="selectedSubject" ng-model="selectedSubject"
                        ng-options="r.id as r.name for r in subList"
                        ng-change="getChild(selectedSubject)" required=""><option value="">-- choose subject --</option></select>
            </td>
        </div>

    </tr>

</table>

<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">

    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            <td>Select</td>

            <td>Template Name</td>

            <td>Description</td>

        </tr>
        </thead>
        <tbody ng-repeat="tm in templateDetails">
        <tr>

            <td><input type="checkbox" ng-model="tm.bool"
                       ng-change="showText(tm.templateName,tm.description,$index)"> <span class="lbl"></span></td>

            <td>{{tm.templateName}}</td>

            <td>{{tm.description}}</td>

        </tr>
        </tbody>
    </table>

    <br>
    <br>
    <table ng-show="showTextArea">
        <tr>
            <td>
                Enter Extra Description (max 160 characters) :
            </td>
            <td>
                <g:textArea type="text" id="text1" name="text1" ng-model="text1" maxlength="160"
                            onkeypress="return isNumberKey(event)"> </g:textArea>
            </td>
        </tr>
        <tr>
            <div class="fieldcontain ${hasErrors(bean: sendMailInstance, field: 'attachment', 'error')} ">
                <td>
                    <label for="attachment">
                        <g:message code="newAdmission.attachment.label" default="Attach File :"/>
                    </label>
                </td>
                <td>
                    <input type="file" name="attachment" accept="image/*" ng-model="attachment"
                           />
                </td>
            </div>
            %{--</td>--}%
        </tr>
        %{--<tr>--}%
        %{--<td>--}%
        %{--Attach More Files :--}%
        %{--</td>--}%
        %{--<td>--}%
        %{--<input type="file" name="MoreAttachment" accept="image/*" ng-model="MoreAttachment"/>--}%
        %{--</td>--}%
        %{--</tr>--}%

    </table>
    <br>
    <table>
        <tr>
            <td>
                <input type="checkbox" name="onlyMail" id="onlyMail" ng-model="onlyMail" ng-change="checkFlag()"><span
                    class="lbl">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Send Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
            </td>
            %{--<td>--}%
                %{--<input type="checkbox" name="onlySms" id="onlySms" ng-model="onlySms" ng-change="checkFlag()"><span--}%
                    %{--class="lbl">--}%
                %{--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Send SMS</span>--}%
            %{--</td>--}%
        </tr>
        <tr>

        </tr>
    </table>
</div>
<br>
</div>
