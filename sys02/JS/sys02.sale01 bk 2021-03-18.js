//import { format } from "util";

var serverAJAXpath = "../Server/sys02.aspx";
/*<Control variable> */
var ctrl_txt_sale_id = $("#txt_sale_id");
var ctrl_txt_staff_uid = $("#txt_staff_uid");
var ctrl_txt_sale_date = $("#txt_sale_date");
var ctrl_txt_sale_hospital = $("#txt_sale_hospital");
var ctrl_txt_txt_sale_department = $("#txt_sale_department");
var ctrl_sel_brand_name = $("#sel_brand_name");
var ctrl_sel_product_name = $("#sel_product_name");

var ctrl_txt_sale_product_model_name = $("#txt_sale_product_model_name");
var ctrl_txt_sale_unit_price = $("#txt_sale_unit_price");
var ctrl_txt_sale_qty = $("#txt_sale_qty");
var ctrl_txt_sale_total_price = $("#txt_sale_total_price");
var ctrl_sel_custstate_name = $("#sel_custstate_name");
var ctrl_sel_orderstate_name = $("#sel_orderstate_name");
var ctrl_txt_sale_estimate_in = $("#txt_sale_estimate_in");
var ctrl_sel_ordertype_name = $("#sel_ordertype_name");
var ctrl_sel_sale_order_year = $("#sel_sale_order_year");
var ctrl_sel_sale_order_month = $("#sel_sale_order_month");
var ctrl_sel_orderprob_name = $("#sel_orderprob_name");
var ctrl_sel_budgettype_name = $("#sel_budgettype_name");
var ctrl_txt_staff_id = $("#txt_staff_id");
var ctrl_txt_staff_name = $("#txt_staff_name");
var ctrl_txt_bm_name = $("#txt_bm_name");
var ctrl_txt_bm_id = $("#txt_bm_id");
var ctrl_sel_am_name = $("#sel_am_name");
var ctrl_txt_sale_remark = $("#txt_sale_remark");

var ctrl_bt_save = $("#bt_save");
var ctrl_bt_clear = $("#bt_clear");
var ctrl_bt_delete = $("#bt_delete");
var ctrl_txt_user_name = $("#txt_user_name");

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
            feature: "save_sale"
            , ctrl_txt_sale_date: ctrl_txt_sale_date.val()
            , ctrl_txt_sale_hospital: ctrl_txt_sale_hospital.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_txt_sale_department: ctrl_txt_txt_sale_department.val().replace("'", "|").replace('"', '^')
            , ctrl_sel_brand_name: ctrl_sel_brand_name.val()
            , ctrl_sel_product_name: ctrl_sel_product_name.val()
            , ctrl_txt_sale_id: ctrl_txt_sale_id.val()
            , ctrl_txt_staff_uid: ctrl_txt_staff_uid.val()
            , ctrl_sel_sale_product_model_id: ctrl_txt_sale_product_model_name.val()
            , ctrl_txt_sale_product_model_name: ctrl_txt_sale_product_model_name.val()
            , ctrl_txt_sale_unit_price: ctrl_txt_sale_unit_price.val().replaceAll(",","")
            , ctrl_txt_sale_qty: ctrl_txt_sale_qty.val().replaceAll(",", "")
            , ctrl_txt_sale_total_price: ctrl_txt_sale_total_price.val().replaceAll(",", "")
            , ctrl_sel_custstate_name: ctrl_sel_custstate_name.val()
            , ctrl_sel_orderstate_name: ctrl_sel_orderstate_name.val()
            , ctrl_txt_sale_estimate_in: ctrl_txt_sale_estimate_in.val()
            , ctrl_sel_ordertype_name: ctrl_sel_ordertype_name.val()
            , ctrl_sel_sale_order_year: ctrl_sel_sale_order_year.val()
            , ctrl_sel_sale_order_month: ctrl_sel_sale_order_month.val()
            , ctrl_sel_orderprob_name: ctrl_sel_orderprob_name.val()
            , ctrl_sel_budgettype_name: ctrl_sel_budgettype_name.val()
            , ctrl_txt_staff_id: ctrl_txt_staff_id.val()
            , ctrl_txt_staff_name: ctrl_txt_staff_name.val()
            , ctrl_txt_bm_name: ctrl_txt_bm_name.val()
            , ctrl_txt_bm_id: ctrl_txt_bm_id.val()
            , ctrl_sel_am_name: ctrl_sel_am_name.val()
            , ctrl_txt_user_name : ctrl_txt_user_name.val()
            , ctrl_txt_sale_remark: ctrl_txt_sale_remark.val().replace("'", "|").replace('"', '^')
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
    clear_form();
});

ctrl_bt_delete.click(function () {
    if (validate_delete()) {
        if (confirm("ท่านต้องการลบรายการนี้ใช่หรือไม่")) {
            $.post(serverAJAXpath, {
                feature: "delete_sale_order"
                , ctrl_txt_id: ctrl_txt_id.val()
                , ctrl_txt_user_name : ctrl_txt_user_name.val()
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

ctrl_sel_brand_name.on('change', function () {
    ctrl_sel_product_name.empty();
    ctrl_sel_product_name.append('<option value="">เลือก สินค้า</option>');


    for (i = 0; i < PRODUCT_DATA.length; i++) {
        if (ctrl_sel_brand_name.val() === PRODUCT_DATA[i][1]) {
            ctrl_sel_product_name.append("<option value='" + PRODUCT_DATA[i][0] + "'>" + PRODUCT_DATA[i][2] + "</option>");
        }
    }
});

ctrl_sel_product_name.on('change', function () {
    ctrl_txt_bm_id.val('');
    ctrl_txt_bm_name.val('');
    var bm_id = "";

    for (i = 0; i < PRODUCT_DATA.length; i++) {
        if (PRODUCT_DATA[i][0] === ctrl_sel_product_name.val()) {
            bm_id = PRODUCT_DATA[i][4];
        }
    }

    for (i = 0; i < BM_DATA.length; i++) {
        if (BM_DATA[i][0] === bm_id) {
            ctrl_txt_bm_id.val(BM_DATA[i][0]);
            ctrl_txt_bm_name.val(BM_DATA[i][1]);
        }
    }
    
});

ctrl_txt_staff_id.on("keyup", function () {
    ctrl_txt_staff_name.val('');
    if ($(this).val().length > 4) {
        for (i = 0; i < STAFF_DATA.length; i++) {
            if ($(this).val() === STAFF_DATA[i][0]) {
                ctrl_txt_staff_name.val(STAFF_DATA[i][1]);
            }
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

    ctrl_txt_sale_id.val(JOB_DATA[sel_row][0]);
    ctrl_txt_sale_date.val(JOB_DATA[sel_row][1]);
    ctrl_txt_sale_hospital.val(JOB_DATA[sel_row][2]);
    ctrl_txt_txt_sale_department.val(JOB_DATA[sel_row][3]);
    ctrl_sel_brand_name.val(JOB_DATA[sel_row][39]);

    ctrl_sel_product_name.empty();
    ctrl_sel_product_name.append('<option value="' + JOB_DATA[sel_row][4] + '" selected="selected">' + JOB_DATA[sel_row][6] + '</option>');
    ctrl_sel_product_name.val(JOB_DATA[sel_row][4]);

    ctrl_txt_sale_product_model_name.val(JOB_DATA[sel_row][5]);
    ctrl_txt_sale_unit_price.val(numberWithCommas(JOB_DATA[sel_row][8]));
    ctrl_txt_sale_qty.val(numberWithCommas(JOB_DATA[sel_row][9]));
    ctrl_txt_sale_total_price.val(numberWithCommas(JOB_DATA[sel_row][10]));
    ctrl_sel_custstate_name.val(JOB_DATA[sel_row][11]);
    ctrl_sel_orderstate_name.val(JOB_DATA[sel_row][13]);
    ctrl_txt_sale_estimate_in.val(JOB_DATA[sel_row][15]);
    ctrl_sel_ordertype_name.val(JOB_DATA[sel_row][20]);
    ctrl_sel_sale_order_year.val(JOB_DATA[sel_row][22]);
    ctrl_sel_sale_order_month.val(JOB_DATA[sel_row][23]);
    ctrl_sel_orderprob_name.val(JOB_DATA[sel_row][24]);
    ctrl_sel_budgettype_name.val(JOB_DATA[sel_row][26]);
    ctrl_txt_staff_id.val(JOB_DATA[sel_row][28]);
    ctrl_txt_staff_name.val(JOB_DATA[sel_row][29]);
    ctrl_txt_bm_name.val(JOB_DATA[sel_row][31]);
    ctrl_txt_bm_id.val(JOB_DATA[sel_row][30]);
    ctrl_sel_am_name.val(JOB_DATA[sel_row][32]);
    ctrl_txt_sale_remark.val(JOB_DATA[sel_row][34]);


    //ctrl_txt_user_name.val(JOB_DATA[sel_row][0]);
    //ctrl_txt_staff_uid.val(JOB_DATA[sel_row][0]);

    try { ctrl_sel_brand_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_product_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_custstate_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_orderstate_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_sale_order_year.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_sale_order_month.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_am_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_budgettype_name.selectmenu("refresh", true); } catch (error) { }
    try { ctrl_sel_orderprob_name.selectmenu("refresh", true); } catch (error) { }



}

function validate_submit() {
    if (ctrl_txt_sale_hospital.val().length < 2) {
        set_warning(ctrl_txt_sale_hospital,"โรงพยาบาล");
        return false;
    }

    if (ctrl_sel_brand_name.val() === "") {
        set_warning(ctrl_sel_brand_name, "แบรนด์สินค้า");
        return false;
    }

    if (ctrl_sel_product_name.val() === "") {
        set_warning(ctrl_sel_product_name, "สินค้า");
        return false;
    }

    if (ctrl_txt_sale_product_model_name.val() === "") {
        set_warning(ctrl_txt_sale_product_model_name, "โมเดลสินค้า");
        return false;
    }

    if (ctrl_txt_sale_unit_price.val().length < 1) {
        set_warning(ctrl_txt_sale_unit_price, "ราคา/หน่วย");
        return false;
    }

    if (ctrl_txt_sale_qty.val().length < 1) {
        set_warning(ctrl_txt_sale_qty, "จำนวนขาย");
        return false;
    }

    if (ctrl_txt_sale_total_price.val().length < 1) {
        set_warning(ctrl_txt_sale_total_price, "ราคารวม Vat");
        return false;
    }

    if (ctrl_sel_custstate_name.val() === "") {
        set_warning(ctrl_sel_custstate_name, "สถานะลูกค้า");
        return false;
    }

    if (ctrl_sel_sale_order_year.val() === "") {
        set_warning(ctrl_sel_sale_order_year, "ปีของ Order");
        return false;
    }

    if (ctrl_sel_sale_order_month.val() === "") {
        set_warning(ctrl_sel_sale_order_month, "เดือนของ Order");
        return false;
    }

    if (ctrl_sel_orderprob_name.val() === "") {
        set_warning(ctrl_sel_orderprob_name, "ความน่าจะเป็น");
        return false;
    }

    /*
    if (ctrl_sel_budgettype_name.val() === "") {
        set_warning(ctrl_sel_budgettype_name, "ประเภทงบ");
        return false;
    }
    */

    if (ctrl_txt_staff_id.val().length < 1) {
        set_warning(ctrl_txt_staff_id, "รหัสพนักงานขาย");
        return false;
    }

    if (ctrl_txt_staff_name.val().length < 1) {
        set_warning(ctrl_txt_staff_name, "ชื่อพนักงานขาย");
        return false;
    }

    if (ctrl_sel_am_name.val() === "") {
        set_warning(ctrl_sel_am_name, "AM");
        return false;
    }

    if (ctrl_txt_bm_name.val() === "") {
        set_warning(ctrl_txt_bm_name, "BM");
        return false;
    }
    return true;
}

function validate_delete() {
    if (ctrl_txt_sale_id.val() === "") {
        set_warning(ctrl_txt_sale_id, "ข้อมูลขาย");
        return false;
    }
    return true;
}

function set_warning(ctrl_, msg_) {
    alert("กรุณาตรวจสอบ " + msg_ + " ที่ท่านทำรายการ");
    ctrl_.focus();
}

function clear_form() {
    ctrl_txt_sale_id.val("");
    ctrl_txt_sale_date.val("");
    ctrl_txt_sale_date.val("");
    ctrl_txt_sale_hospital.val("");
    ctrl_txt_txt_sale_department.val("");
    ctrl_sel_brand_name.val("");
    ctrl_sel_product_name.val("");
    ctrl_txt_sale_product_model_name.val("");
    ctrl_txt_sale_unit_price.val("");
    ctrl_txt_sale_qty.val("");
    ctrl_txt_sale_total_price.val("");
    ctrl_sel_custstate_name.val("");
    ctrl_sel_orderstate_name.val("");
    ctrl_txt_sale_estimate_in.val("");
    ctrl_sel_ordertype_name.val("");

    var tmp_year = (new Date).getFullYear();
    if (tmp_year < 2560) { tmp_year = tmp_year + 543;}

    ctrl_sel_sale_order_year.val(tmp_year);
    ctrl_sel_sale_order_month.val((new Date).getMonth() + 1);
    ctrl_sel_orderprob_name.val("");
    ctrl_sel_budgettype_name.val("");
    ctrl_txt_staff_id.val("");
    ctrl_txt_staff_name.val("");
    ctrl_txt_bm_name.val("");
    ctrl_sel_am_name.val("");
    ctrl_txt_sale_remark.val("");

    ctrl_sel_product_name.empty();
    ctrl_sel_product_name.append('<option value="">เลือก สินค้า</option>');

    ctrl_txt_staff_id.val(ctrl_txt_staff_uid.val());
    ctrl_txt_staff_name.val(ctrl_txt_user_name.val());


    try { ctrl_sel_brand_name.selectmenu("refresh", true); } catch (ex) { }

    try { ctrl_sel_custstate_name.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_orderstate_name.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_ordertype_name.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_sale_order_year.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_sale_order_month.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_orderprob_name.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_budgettype_name.selectmenu("refresh", true); } catch (ex) { }
    try { ctrl_sel_am_name.selectmenu("refresh", true); } catch (ex) { }
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}        

function log_out() {
    var deletingAll = browser.history.deleteAll();
    url.reload("log_out.aspx");
}

function sel_hospital_data(HOS) {
    ctrl_txt_sale_hospital.val(HOS);
}

/*</Custom Function>*/

