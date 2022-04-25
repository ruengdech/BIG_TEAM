//import { format } from "util";

var serverAJAXpath = "../Server/sys02.aspx";
/*<Control variable> */
var ctrl_txt_uuid = $("#txt_uuid");
var ctrl_txt_id = $("#txt_id");
var ctrl_txt_name = $("#txt_name");
var ctrl_txt_priviled = $("#txt_priviled");

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
//ctrl_bt_save.click(function () {
//    if (validate_submit()) {
//        $.post(serverAJAXpath, {
//            feature: "save_staff"
//            , ctrl_txt_uuid: ctrl_txt_uuid.val()
//            , ctrl_txt_id: ctrl_txt_id.val()
//            , ctrl_txt_name: ctrl_txt_name.val().replaceAll(",", "^").replaceAll("\"", "|")
//            , ctrl_txt_login: ctrl_txt_login.val()
//            , ctrl_txt_pass: ctrl_txt_pass.val()
//            , ctrl_txt_bossid: ctrl_txt_bossid.val()
//            , ctrl_txt_bossname: ctrl_txt_bossname.val()
//            , ctrl_sel_type: ctrl_sel_type.val()
//            , ctrl_txt_role: ctrl_txt_role.val().replaceAll(",", "^").replaceAll("\"", "|")
//            , ctrl_txt_remark: ctrl_txt_remark.val().replaceAll(",", "^").replaceAll("\"","|")
//            , ctrl_sel_status: ctrl_sel_status.val()
//        }).done(function (data) {
//            if (data.indexOf("SUCCESS") !== -1) {
//                if (confirm("บันทึกสำเร็จ")) {
//                    location.reload();
//                } else {
//                    location.reload();
//                }
//            } else {
//                alert("เกิดข้อผิดพลาดในระบบ");
//            }
//        });
//    }
//});

ctrl_bt_clear.click(function () {
    ctrl_txt_uuid.val('');
    ctrl_txt_id.val('');
    ctrl_txt_name.val('');
    ctrl_txt_priviled.val("0");
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
}

function priviled_add() {
    PRIVILED += 1;
    var STR_TMP = "";
    var BRAND = "";
    var end_quote = "";

    STR_TMP = STR_TMP + "<td>";
    STR_TMP = STR_TMP + "<select id=\"txt_staffno" + (PRIVILED - 1) + "\" name =\"txt_staffno" + (PRIVILED - 1) + "\" data-placeholder=\"เลื่อกเฉพาะพนักงานที่มีสิทธิ์ดูข้อมูล\" class=\"chosen-select\" multiple >";
    STR_TMP = STR_TMP + "<option value=\"999999999\">พนักงานทั้งหมด</option>";
    for (i = 0; i < JOB_DATA.length; i++) {
        STR_TMP = STR_TMP + "<option value=\"" + JOB_DATA[i][0]  + "\">" + JOB_DATA[i][2] + "</option>";
    }
    STR_TMP = STR_TMP + "</select>";
    STR_TMP = STR_TMP + "</td>";

    STR_TMP = STR_TMP + "<td>";
    STR_TMP = STR_TMP + "<select id=\"txt_producno" + (PRIVILED - 1) + "\" name =\"txt_producno" + (PRIVILED - 1) + "\" data-placeholder=\"เลื่อกเฉพาะสินค้าที่มีสิทธิ์ดูได้\" class=\"chosen-select\" multiple >";
    STR_TMP = STR_TMP + "<option value=\"\"></option>";
    STR_TMP = STR_TMP + "<option value=\"999999999\">สินค้าทั้งหมด</option>";
    for (j = 0; j < PRODUCTS.length; j++) {
        if (BRAND.length < 2) {
            STR_TMP = STR_TMP + "<optgroup label='" + PRODUCTS[j][1] + "'>";
            STR_TMP = STR_TMP + "<option value=\"" + PRODUCTS[j][0] + "\">" + PRODUCTS[j][2] + "</option>";
            BRAND = PRODUCTS[j][1];
        }
        else if (BRAND !== PRODUCTS[j][1]) {
            STR_TMP = STR_TMP + "</optgroup>";
            STR_TMP = STR_TMP + "<optgroup label='" + PRODUCTS[j][1] + "'>";
            STR_TMP = STR_TMP + "<option value=\"" + PRODUCTS[j][0] + "\">" + PRODUCTS[j][2] + "</option>";
        } else {
            STR_TMP = STR_TMP + "<option value=\"" + PRODUCTS[j][0] + "\">" + PRODUCTS[j][2] + "</option>";
        }
    }
    STR_TMP = STR_TMP + "</optgroup>";
    STR_TMP = STR_TMP + "</select>";
    STR_TMP = STR_TMP + "</td>";

    STR_TMP = STR_TMP + "<td><img src=\"../RESOURCE/themes/images/set02/078-remove.png\" style=\"margin-top: 5px!important; width:30px; cursor:pointer\" onclick=\"priviled_delete();\" /></td>";

    STR_TMP = STR_TMP + "";

    var tableRef = document.getElementById('tb_priviled').getElementsByTagName('tbody')[0];

    
    tableRef.insertRow().innerHTML = STR_TMP;

    $('#txt_producno' + (PRIVILED - 1)).multiSelect({
        selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='try \"12\"'>",
        selectionHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='try \"4\"'>",
        afterInit: function (ms) {
            var that = this,
                $selectableSearch = that.$selectableUl.prev(),
                $selectionSearch = that.$selectionUl.prev(),
                selectableSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selectable:not(.ms-selected)',
                selectionSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selection.ms-selected';

            that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
                .on('keydown', function (e) {
                    if (e.which === 40) {
                        that.$selectableUl.focus();
                        return false;
                    }
                });

            that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
                .on('keydown', function (e) {
                    if (e.which == 40) {
                        that.$selectionUl.focus();
                        return false;
                    }
                });
        },
        afterSelect: function () {
            this.qs1.cache();
            this.qs2.cache();
        },
        afterDeselect: function () {
            this.qs1.cache();
            this.qs2.cache();
        }
    });


    $('#txt_staffno' + (PRIVILED - 1)).multiSelect({
        selectableHeader: "<div class='custom-header'>เลือกพนักงานสิทธิ์เข้าถึง</div>",
        selectionHeader: "<div class='custom-header'>ข้อมูลพนักงานที่มีสิทธิ์เข้าถึง</div>",
    });

}

//function validate_submit() {
//    if (ctrl_txt_id.val().length < 2) {
//        alert("กรุณาตรวจสอบรหัสพนักงาน");
//        ctrl_txt_id.focus()
//        return false;
//    }
//    if (ctrl_txt_name.val().length < 2) {
//        alert("กรุณาตรวจสอบชื่อพนักงาน");
//        ctrl_txt_name.focus()
//        return false;
//    }
//    if (ctrl_txt_login.val().length < 2) {
//        alert("กรุณาตรวจสอบ Login ของพนักงาน");
//        ctrl_txt_login.focus()
//        return false;
//    }
//    if (ctrl_txt_pass.val().length < 2) {
//        alert("กรุณาตรวจสอบ รหัสผ่าน ของพนักงาน");
//        ctrl_txt_pass.focus()
//        return false;
//    }
//    if (ctrl_sel_type.val().length < 2) {
//        alert("กรุณาตรวจสอบ ประเภท ของพนักงาน");
//        ctrl_sel_type.focus()
//        return false;
//    }
//    return true;
//}
/*</Custom Function>*/

