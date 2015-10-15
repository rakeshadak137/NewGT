package com.systemService

import annotation.ParentScreen
import com.system.Screen

class ScreenDataFeedService {
    def grailsApplication

    def screen() {
        def result = Screen.list();
        if (!result) {

            def fullName;
            def underName;
            def controllers = grailsApplication.controllerClasses.sort { it.fullName };
            List<Screen> screenList = new ArrayList<Screen>();
            for (scr in grailsApplication.controllerClasses.sort { it.fullName }) {
                //            String screenName="";
                //            if(scr){
                //
                //            String capital   = Character.toString(scr.logicalPropertyName.charAt(0)).toUpperCase()+ scr.logicalPropertyName.substring(1);
                //            String[] x =capital.split("(?=[A-Z])");
                //            for(int i =0; i<x.length; i++){
                //                screenName = screenName+x[i]+" ";
                //            }
                //            }
                if (scr.getClazz().isAnnotationPresent(ParentScreen)) {
                    if (scr.getClazz().getAnnotation(ParentScreen).fullName()) {
                        fullName = scr.getClazz().getAnnotation(ParentScreen).fullName();
                        underName = scr.getClazz().getAnnotation(ParentScreen).subUnder();
                    } else {
                        fullName = "";
                    }
                }

                Screen screen = new Screen(name: scr.fullName, controller: scr.logicalPropertyName, domainName: fullName)
                //domainName: screenName
                if (scr.getClazz().isAnnotationPresent(ParentScreen)) {
                    def parentScreenName = scr.getClazz().getAnnotation(ParentScreen).name();
                    def parentScreen = Screen.findByName(parentScreenName);
                    if (!parentScreen) {
                        parentScreen = new Screen(name: parentScreenName);
                        parentScreen.save();
                    }
                    //screen.parentScreen = parentScreen;
                    def parentScreenfilter = scr.getClazz().getAnnotation(ParentScreen).subUnder();
                    def parentScreenf = Screen.findByFilterAndParentScreen(parentScreenfilter,Screen.findById(parentScreen?.id));
                    if (!parentScreenf) {
                        parentScreenf = new Screen(filter: parentScreenfilter,parentScreen:parentScreen?.id?Screen.findById(parentScreen.id):null);
                        parentScreenf.save();
                    }
                    screen.parentScreen = parentScreenf;
                    print scr.logicalPropertyName
                }
                screenList.add(screen)
            }
            Screen.saveAll(screenList);
        }
    }
}
