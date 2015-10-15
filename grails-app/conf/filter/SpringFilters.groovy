package filter

class SpringFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {

                if (!request.xhr && !params.isRedirected) {

                    println('Log 1');
                    def user = session['activeUser'];

                    if (!user) {
                        if (controllerName != "login") {
                            params['isRedirected'] = true;
                            println 'springFilter.redirect.login'
                            redirect(controller: 'login', action: 'auth', params: params);
                            return false;
                        }
                    }
//                     //  Applying add,update,delete,view,print security
                    else if ((controllerName.equals("main") && actionName.equals("index")) || controllerName.equals("login") || controllerName.equals("report") || actionName.equals("renderImage") || actionName.equals("print_action") || actionName.equals("uploadFile") || actionName.equals("download") || actionName.equals("report") || actionName.equals("generateReport") || actionName.equals("page") || actionName.equals("generateResponse") || actionName.equals("print_action1") || actionName.equals("print_action2") || actionName.equals("print_action3") || actionName.equals("print_action4") || actionName.equals("print_action5") || actionName.equals("print_action6") || actionName.equals("print_action7") || actionName.equals("print_action8") || actionName.equals("print_action9") || actionName.equals("print_action10") || actionName.equals("print_action11") || actionName.equals("print_action12") || actionName.equals("print_action13") || actionName.equals("print_action14") || actionName.equals("print_action15") || actionName.equals("print_action16") || actionName.equals("print_action17") || actionName.equals("print_action18")) {

                    } else {
                        def screenId = params['scrid'];
                        if (!screenId) {

                            redirect controller: 'login', action: 'auth', params: params
                            return false;


                        }  // screen id not found
                        // pull role rights from session
                        //session['screenRole'] = loginService.screenRole(currentUser.id);
                        else {
                            if (actionName.equals("show") || actionName.equals("saveOrUpdate") || actionName.equals("closeOpBalance") || controllerName.equals("logout") || actionName.equals("sendPartyMail") || actionName.equals("exportData")|| actionName.equals("remainingStock")) {
                                return;
                            }
                            def roleRights = session['screenRole'].find { p -> p.screenId.toString().equals(screenId) };
                            if (!roleRights) {
                                redirect controller: 'login', action: 'auth', params: params
                            }   // screen id not found
                            else {
                                switch (actionName) {
                                    case "create":
                                    case "save":
                                        if (!roleRights.canAdd) redirect controller: 'login', action: 'auth', params: params
                                        break;
                                    case "edit":
                                    case "update":
                                        if (!roleRights.canEdit) redirect controller: 'login', action: 'auth', params: params
                                        break;
                                    case "delete":
                                        if (!roleRights.canDelete) redirect controller: 'login', action: 'auth', params: params
                                        break;
                                    case "print":
                                        if (!roleRights.canPrint) redirect controller: 'login', action: 'auth', params: params
                                        break;
                                    case "index":
                                    case "list":
                                        if (!roleRights.canView) redirect controller: 'login', action: 'auth', params: params
                                        break;
                                    default:
                                        redirect controller: 'login', action: 'auth', params: params
                                        break;
                                }
                            }
                        }
                    } // end

                }
            }
        }


    }
}
