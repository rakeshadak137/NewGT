package com.system

import com.master.BranchMaster


/**
 * Created by Akshay on 2/7/14.
 */
class User {

    String username
    String password
    BranchMaster branch


    boolean enable,admin,client

    static constraints = {

        branch()
        username nullable: false, unique: true, blank: false
        password nullable: false, widget: "password", blank: false
    }

    static mapping = {

        branch lazy: false

    }

    String toString() {
        username
    }
}
