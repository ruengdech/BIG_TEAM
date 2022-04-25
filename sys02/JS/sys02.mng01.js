//import { format } from "util";

var serverAJAXpath = "../Server/sys02.aspx";
/*<Control variable> */
var ctrl_txt_id = $("#txt_id");
var ctrl_txt_name = $("#txt_name");
var ctrl_txt_status = $("#txt_status");
var ctrl_bt_save = $("#bt_save");
var ctrl_bt_clear = $("#bt_clear");
var ctrl_bt_delete = $("#bt_delete");
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
            feature: "save_customer_status"
            , ctrl_txt_id: ctrl_txt_id.val()
            , ctrl_txt_name: ctrl_txt_name.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_status: ctrl_txt_status.val()
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
    ctrl_txt_id.val("");
    ctrl_txt_name.val("");
    ctrl_txt_status.val("");
});

ctrl_bt_delete.click(function () {
    if (validate_submit()) {
        if (confirm("ท่านต้องการลบรายการนี้ใช่หรือไม่")) {
            $.post(serverAJAXpath, {
                feature: "save_customer_status"
                , ctrl_txt_id: ctrl_txt_id.val()
                , ctrl_txt_name: ctrl_txt_name.val().replace("'", "|").replace('"', '^')
                , ctrl_txt_status: 'INACTIVE'
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
    }
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

    ctrl_txt_id.val(JOB_DATA[sel_row][0]);
    ctrl_txt_name.val(JOB_DATA[sel_row][1]);
    ctrl_txt_status.val(JOB_DATA[sel_row][2]);

}

function validate_submit() {
    if (ctrl_txt_name.val().length < 2) {
        alert("กรุณาตรวจสอบข้อมูลที่ท่านต้องการทำรายการ");
        return false;
    }
    return true;
}
/*</Custom Function>*/

