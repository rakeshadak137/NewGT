package com.ui

import com.system.Screen

class ScreenService {

    def getScreenById(String id) {
        Screen.get(id)
    }
}
