//import { format } from "util";

var serverAJAXpath = "Server/sys04.aspx";
/*<Control variable> */
var ctrl_csi_1_1 = $("#csi_1_1");
var ctrl_csi_1_2 = $("#csi_1_2");
var ctrl_csi_1_3 = $("#csi_1_3");

var ctrl_csi_2_1 = $("#csi_2_1");
var ctrl_csi_2_2 = $("#csi_2_2");
var ctrl_csi_2_3 = $("#csi_2_3");

var ctrl_csi_3_1 = $("#csi_3_1");
var ctrl_csi_3_2 = $("#csi_3_2");
var ctrl_csi_3_3 = $("#csi_3_3");

var ctrl_csi_4_1 = $("#csi_4_1");
var ctrl_csi_4_2 = $("#csi_4_2");
var ctrl_csi_4_3 = $("#csi_4_3");
var ctrl_csi_4_4 = $("#csi_4_4");

var ctrl_csi_5_1 = $("#csi_5_1");
var ctrl_csi_5_2 = $("#csi_5_2");

var ctrl_txt_date = $("#txt_date");
var ctrl_txt_dept = $("#txt_dept");
var ctrl_txt_hospital = $("#txt_hospital");
var ctrl_txt_ref1 = $("#txt_ref1");
var ctrl_txt_ref2 = $("#txt_ref2");
var ctrl_csi_suggestion = $("#csi_suggestion");

var ctrl_bt_save = $("#bt_save");
var ctrl_bt_clear = $("#bt_clear");

/*</Control variable> */

//MAIN ARRAY DATA
//0   = CUSTSTATE_ID;
//1   = CUSTSTATE_NAME;
//2   = CUSTSTATE_STATUS;

/*<Initial Load>*/

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
};

$(document).ready(function () {
    ctrl_txt_ref1.val(getUrlParameter("r1"));
    ctrl_txt_ref2.val(getUrlParameter("r2"));
});


/*</Initial Load>*/


/*<Action>*/
ctrl_bt_save.click(function () {
    if (validate_submit()) {
        $.post(serverAJAXpath, {
            feature: "save_csi"
            , ctrl_csi_1_1: ctrl_csi_1_1.val()
            , ctrl_csi_1_2: ctrl_csi_1_2.val()
            , ctrl_csi_1_3: ctrl_csi_1_3.val()
            , ctrl_csi_2_1: ctrl_csi_2_1.val()
            , ctrl_csi_2_2: ctrl_csi_2_2.val()
            , ctrl_csi_2_3: ctrl_csi_2_3.val()
            , ctrl_csi_3_1: ctrl_csi_3_1.val()
            , ctrl_csi_3_2: ctrl_csi_3_2.val()
            , ctrl_csi_3_3: ctrl_csi_3_3.val()
            , ctrl_csi_4_1: ctrl_csi_4_1.val()
            , ctrl_csi_4_2: ctrl_csi_4_2.val()
            , ctrl_csi_4_3: ctrl_csi_4_3.val()
            , ctrl_csi_4_4: ctrl_csi_4_4.val()
            , ctrl_csi_5_1: ctrl_csi_5_1.val()
            , ctrl_csi_5_2: ctrl_csi_5_2.val()
            , ctrl_txt_date: ctrl_txt_date.val()
            , ctrl_txt_dept: ctrl_txt_dept.val()
            , ctrl_txt_hospital: ctrl_txt_hospital.val()
            , ctrl_txt_ref1: ctrl_txt_ref1.val()
            , ctrl_txt_ref2: ctrl_txt_ref2.val()
            , ctrl_csi_suggestion: ctrl_csi_suggestion.val().replace("'", "|").replace('"', '^')
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                if (confirm("บันทึกสำเร็จ")) {
                    location.reload();
                } else {
                    location.reload();
                }
            } else {
                alert("เกิดข้อผิดพลาดในระบบ");
            }
        });
    }
});

function validate_submit() {
    //Validate nothing
    return true;
}

ctrl_bt_clear.click(function () {
    clear_form();
});

/*</Action>*/

function set_warning(ctrl_, msg_) {
    alert("กรุณาตรวจสอบ " + msg_ + " ที่ท่านทำรายการ");
    ctrl_.focus();
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}        


/*</Custom Function>*/