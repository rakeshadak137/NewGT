modules = {
    application {
        resource url: 'js/application.js'
        resource url: 'js/yogiCommon.js'
        resource url: 'js/focus.js'
        resource url: 'js/moment-js/2.4.0/moment.min.js'
        resource url: 'js/moment-js/2.4.0/moment-with-langs.js'
    }

    angularJs {
//        resource url: 'js/angular/1.0.7/angular.js'
        resource url: 'angular-treeRepeat-master/app/lib/angular/angular.js'
        resource url: 'angular-treeRepeat-master/app/lib/angular/angular-animate.js'
//        resource url: 'angular-treeRepeat-master/app/js/controllers.js'
        resource url: 'angular-treeRepeat-master/app/js/directives.js'
    }

    lodash {

        resource url: 'js/lodash.js'

    }

    jquery9 {

        resource url: 'js/jquery-1.9.1.js'
        resource url: 'js/jquery.min.js'
    }

    jqueryUI {

        resource url: 'js/jquery-ui.js'
    }

    DatePicker {
        resource url: 'js/bootstrap-datepicker.js'
    }
    commonJS {
        dependsOn(['angularJs', 'jquery9', 'jqueryUI', 'DatePicker', 'lodash',])
    }
}
