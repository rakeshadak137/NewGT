function isNumberString(val) {
    ///if (!val) return false;
    // var regX = new RegExp('\d');
    return new RegExp('^\d*').test(val);
};

function isNumberKey(val) {
    debugger;

    if (val) {
        debugger;
        // var nop = val.match(/[\d\.]+/);
        val = val.replace(/^0+/, '')
        var nop = val.match(/^[\-]?[\d]{0,9}[\.]{0,1}[\d]{0,4}/);
        //var nop = val.match(/^-?[0-9]*\.?[0-9]+$/)
        if (nop[0]) {

            return nop + "";
            //return parseInt(nop + "", 10);
        }
        else {
            return 0;
        }


    } else {
        return 0;

    }

};

function isNumberQuan(val) {
    debugger;

    if (val) {
        debugger;
        // var nop = val.match(/[\d\.]+/);
        val = val.replace(/^0+/, '')
        var nop = val.match(/[\d]{0,9}[\.]{0,1}[\d]{0,2}/);
        //var nop = val.match(/^-?[0-9]*\.?[0-9]+$/)
        if (nop[0]) {

            return nop + "";
            //return parseInt(nop + "", 10);
        }


    } else {
        return 0;

    }

};

function isNumberInt(val) {
    debugger;

    if (val) {
        debugger;
        // var nop = val.match(/[\d\.]+/);
        val = val.replace(/^0+/, '')
        var nop = val.match(/[\d]{0,9}/);
        //var nop = val.match(/^-?[0-9]*\.?[0-9]+$/)
        if (nop[0]) {

            return nop + "";
            //return parseInt(nop + "", 10);
        }


    } else {
        return 0;

    }

};

function isMobileNo(val) {
    debugger;

    if (val) {
        debugger;
        var nop = /\d{3,5}[\-\d]{6,10}/.test(val);
        //var nop = val.match(/^-?[0-9]*\.?[0-9]+$/)
        if (nop[0]) {
            return nop;
            //return parseInt(nop + "", 10);
        }
        else {
            return nop;
        }

    } else {
        return 0;

    }

};


//function isAlreadyExist(a, id) {
//
//
//    if (a) {
//        debugger;
//        $http.get("/${grailsApplication.config.erpName}/exportEnum/isAlready?class1=ExportEnum&data=" + a)
//            .success(function (data) {
//                if (data != 1) {
//                    alert(data);
//                    return $("#" + id).focus();
//                }
//            });
//    }
//    else {
//        return $("#" + id).focus();
//    }
//}

