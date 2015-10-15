<%@ page import="grails.converters.JSON; com.template.TemplateSubject; com.template.Template" %>
<script>
//    $(document).ready(function () {
//
//        $("#subject").searchable();
//
//    });

    function templateController($scope,$http){
             init();

             function init(){
                 $http.get("/${grailsApplication.config.erpName}/template/getTemplate")
                         .success(function(data){
                             $scope.templateList=data;
                         })

                 %{--$scope.templateList = ${TemplateSubject.list() as JSON}--}%
                var details=[];
                 $scope.editableItem={ }
                 $scope.value=false
                 $scope.templateDetails=details;

             }

             $scope.addTemplate=function(){
                 debugger;
                 if(!$scope.templateName){
                     $("#templateName").focus();
                     return
                 }if(!$scope.description){
                     $("#description").focus();
                     return
                 }

                     var dataIndex = $scope.templateName;
                     $scope.tempData = _.find($scope.templateList, {id: dataIndex});
                     if (isAlreadyExists(dataIndex, $scope.templateDetails)) {
                         debugger;
                         alert($scope.templateName + "  is Already Exists")
                         return;
                     }

                  $scope.templateDetails.push({
                      templateName:$scope.templateName,
                      description: $scope.description
                  })
             }


             $scope.remove = function (index) {
                 $scope.value = false;
                 $scope.templateDetails.splice(index, 1);
                 validLength = $scope.templateDetails.length;
             };

             $scope.edit = function (index) {
                 debugger;
                 $scope.value = true;
                 $scope.editableItem = $scope.templateDetails[index];
                 $scope.templateName = $scope.editableItem.templateName;
                 $scope.description = $scope.editableItem.description;
                 $scope.indexNo = index;
             };

             $scope.update = function () {
                 $scope.value = false;
                 // $scope.isItem = _.find($scope.bomDetails,{childItemId:$scope.selectItem})
                 if ($scope.templateName == $scope.editableItem.templateName) {

                     $scope.templateDetails[ $scope.indexNo].templateName = $scope.templateName;
                     $scope.templateDetails[ $scope.indexNo].description = $scope.description;
                 }
//                 else {
//                     alert("you can't change the Template");
//                     $scope.templateName = $scope.editableItem.templateName
//                     return;
//                 }
             };

             function isAlreadyExists(index, childs) {
                 var returncheck = _.findIndex(childs, function (element) {
                     debugger;
                     return element.templateName == index;

                 });
                 debugger;
                 return  returncheck != -1;

             };

             $scope.getChild = function () {

                 $http.get("/${grailsApplication.config.erpName}/template/childFind?id=" + $scope.selectedSubject)
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
         }
</script>
<div ng-app="">
    <div ng-controller="templateController">

        <input type="hidden" value="{{templateDetails}}" name="childJSON"/>
        <input type="hidden" value="{{selectedSubject}}" name="subject.id"/>
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
                <select id="subject"  ng-model="selectedSubject" ng-change="getChild()" required=""
                        ng-options="r.id as r.name for r in templateList"></select>
            </td>

            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<g:link controller="templateSubject"  action="create" class="btn btn-small btn-info">Create New Subject</g:link>
        </div>

    </tr>

</table>
        <br>
<table>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: smsTemplateInstance, field: 'templateName', 'error')} ">
            <td><label for="templateName">
                <g:message code="smsTemplate.templateName.label" default="Template Name"/>

            </label></td>
            <td><g:textField id="templateName" name="templateName" ng-model="templateName" value="${smsTemplateInstance?.templateName}"/></td>
        </div>

    </tr>

    <tr>

        <div class="fieldcontain ${hasErrors(bean: smsTemplateInstance, field: 'description', 'error')} ">
            <td><label for="description">
                <g:message code="smsTemplate.description.label" default="Description (max 160 characters):"/>

            </label></td>
            <td><g:textArea  id="description" name="description" maxlength="160" onkeypress="return isNumberKey(event)"
                             ng-model="description" value="${smsTemplateInstance?.description}"/></td>
        </div>

    </tr>
    <tr>
        <td>

            <button type="button" class="btn btn-small btn-info" ng-click="addTemplate()">Add</button>

            <button type="button" class="btn btn-small btn-info" ng-click="update()"
                    ng-show="value">Update Template</button>

        </td>
    </tr>

</table>

</table>
<div role="grid" class="dataTables_wrapper" id="sample-table-2_wrapper">
    <table class="table table-striped table-bordered table-hover dataTable" id="sample-table-2"
           aria-describedby="sample-table-2_info">
        <thead>
        <tr>
            %{--<td>Select</td>--}%

            <td >Action</td>
            <td> Template Name </td>

            <td style="width: 400px;">Description</td>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="bm in templateDetails | filter : searchItem | filter:new_search">

            <td>
                %{--<td><button type="button" class="btn btn-small btn-default"--}%
                %{--ng-click="remove($index)">Delete</button>--}%
                %{--<button type="button" class="btn btn-small btn-default" ng-click="edit($index)">Edit</button>--}%

                <button type="button" ng-click="edit($index)" style="border: none; background: transparent; color: #08c">
                    <i class="icon-pencil bigger-130"></i>
                </button>
                <button type="button" value="delete" ng-click="remove($index)" style="border: none; background: transparent"><img src="${resource(dir: 'assets/avatars',file: 'delete1.png')}">  </button>
            </td>
            <td>{{bm.templateName}}</td>

            <td style="width: 400px">{{bm.description}}</td>

        </tr>
        </tbody>
    </table>
</div>
    </div>
</div>