package com.master

class BranchMaster {

    String branchName
    String branchAddress
    Boolean isActive = true

    static constraints = {
        branchName nullable: false
        branchAddress nullable: false
        isActive display:false
    }

    String toString(){
        branchName
    }
}
