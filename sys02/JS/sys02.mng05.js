//import { format } from "util";

var serverAJAXpath = "../Server/sys02.aspx";
/*<Control variable> */
var ctrl_txt_uuid = $("#txt_uuid");
var ctrl_txt_id = $("#txt_id");
var ctrl_txt_name = $("#txt_name");
var ctrl_txt_login = $("#txt_login");
var ctrl_txt_pass = $("#txt_pass");
var ctrl_txt_bossid = $("#txt_bossid");
var ctrl_txt_bossname = $("#txt_bossname");
var ctrl_sel_type = $("#sel_type");
var ctrl_txt_role = $("#txt_role");
var ctrl_txt_remark = $("#txt_remark");
var ctrl_sel_status = $("#sel_status");

var ctrl_bt_save = $("#bt_save");
var ctrl_bt_clear = $("#bt_clear");
/*</Control variable> */

//MAIN ARRAY DATA
//0	    UID
//1	    STAFF_ID
//2	    STAFF_NAME
//3	    STAFF_LOGIN
//4	    STAFF_PASSWORD
//5	    STAFF_BOSSID
//6	    STAFF_BOSSNAME
//7	    STAFF_SALE_CATEGORY
//8	    STAFF_ROLE
//9	    STAFF_STATUS
//10	STAFF_CWHEN 
//11	STAFF_REMARK

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

    $("#myInput").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#tb_list tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        $(".tr_main").show();
    });
});


/*</Initial Load>*/


/*<Action>*/
ctrl_bt_save.click(function () {
    if (validate_submit()) {
        $.post(serverAJAXpath, {
            feature: "save_staff"
            , ctrl_txt_uuid: ctrl_txt_uuid.val()
            , ctrl_txt_id: ctrl_txt_id.val()
            , ctrl_txt_name: ctrl_txt_name.val().replaceAll(",", "^").replaceAll("\"", "|")
            , ctrl_txt_login: ctrl_txt_login.val()
            , ctrl_txt_pass: ctrl_txt_pass.val()
            , ctrl_txt_bossid: ctrl_txt_bossid.val()
            , ctrl_txt_bossname: ctrl_txt_bossname.val()
            , ctrl_sel_type: ctrl_sel_type.val()
            , ctrl_txt_role: ctrl_txt_role.val().replaceAll(",", "^").replaceAll("\"", "|")
            , ctrl_txt_remark: ctrl_txt_remark.val().replaceAll(",", "^").replaceAll("\"","|")
            , ctrl_sel_status: ctrl_sel_status.val()
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

ctrl_bt_clear.click(function () {
    ctrl_txt_uuid.val('');
    ctrl_txt_id.val('');
    ctrl_txt_name.val('');
    ctrl_txt_login.val('');
    ctrl_txt_pass.val('');
    ctrl_txt_bossid.val('');
    ctrl_txt_bossname.val('');
    ctrl_txt_role.val('');
    ctrl_txt_remark.val('');

    try { ctrl_sel_type.selectmenu('refresh'); } catch (error) { }
    try { ctrl_sel_status.selectmenu('refresh'); } catch (error) { }
});


/*</Action>*/

/*<Custom Function>*/
function set_detail(ids) {
    var sel_row = -1;
    for (i = 0; i < JOB_DATA.length; i++) {
        if (JOB_DATA[i][0] === ids) {
            sel_row = i;
        }
    }

    ctrl_txt_uuid.val(JOB_DATA[sel_row][0]);
    ctrl_txt_id.val(JOB_DATA[sel_row][1]);
    ctrl_txt_name.val(JOB_DATA[sel_row][2]);
    ctrl_txt_login.val(JOB_DATA[sel_row][3]);
    ctrl_txt_pass.val(JOB_DATA[sel_row][4]);
    ctrl_txt_bossid.val(JOB_DATA[sel_row][5]);
    ctrl_txt_bossname.val(JOB_DATA[sel_row][6]);
    ctrl_sel_type.val(JOB_DATA[sel_row][7]);
    ctrl_txt_role.val(JOB_DATA[sel_row][8]);
    ctrl_sel_status.val(JOB_DATA[sel_row][9]);
    ctrl_txt_remark.val(JOB_DATA[sel_row][11]);

    try { ctrl_sel_type.selectmenu('refresh'); } catch (error) { }
    try { ctrl_sel_status.selectmenu('refresh'); } catch (error) { }

}

function validate_submit() {
    if (ctrl_txt_id.val().length < 2) {
        alert("กรุณาตรวจสอบรหัสพนักงาน");
        ctrl_txt_id.focus()
        return false;
    }
    if (ctrl_txt_name.val().length < 2) {
        alert("กรุณาตรวจสอบชื่อพนักงาน");
        ctrl_txt_name.focus()
        return false;
    }
    if (ctrl_txt_login.val().length < 2) {
        alert("กรุณาตรวจสอบ Login ของพนักงาน");
        ctrl_txt_login.focus()
        return false;
    }
    if (ctrl_txt_pass.val().length < 2) {
        alert("กรุณาตรวจสอบ รหัสผ่าน ของพนักงาน");
        ctrl_txt_pass.focus()
        return false;
    }
    if (ctrl_sel_type.val().length < 2) {
        alert("กรุณาตรวจสอบ ประเภท ของพนักงาน");
        ctrl_sel_type.focus()
        return false;
    }
    return true;
}
/*</Custom Function>*/

