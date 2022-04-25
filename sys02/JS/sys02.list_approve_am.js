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

    ///*Initial BM*/
    //for (i = 0; i < BM_DATA.length; i++) {
    //    ctrl_sel_BM_only.append("<option value='" + BM_DATA[i][0] + "' >" + BM_DATA[i][1] + "</option>");
    //}

    /*FILTER DATA*/
    filter_data();
    
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
                , ctrl_txt_sale_id: ctrl_txt_sale_id.val()
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

//ctrl_sel_BM_only.on('change', function () {
    // //Wait for Coding
    //for (i = 0; i < PRODUCT_DATA.length; i++) {
    //    if (ctrl_sel_brand_name.val() === PRODUCT_DATA[i][1]) {
    //        ctrl_sel_product_name.append("<option value='" + PRODUCT_DATA[i][0] + "'>" + PRODUCT_DATA[i][2] + "</option>");
    //    }
    //}
//});

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

function check_filter(e) {
    var enterKey = 13;
    if (e.which == enterKey) {
        filter_data();
    }
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

function filter_data() {
    

    /*DATA LOOP HERE*/

    $("#tb_list").find("tr:gt(0)").remove();
    var sum_amt = 0;
    var sum_item = 0;
    var TMP_ROW = "";
    /*start แยก เดือนปี*/
    var s_year = "";
    var s_month = "";
    try {
        var TMP = $("#s_month").val().split("/");
        s_year = TMP[0].replaceAll(" ","");
        s_month = TMP[1].replaceAll(" ", "");
    }
    catch (error) { }
    /*end แยก เดือนปี*/


    for (i = 0; i < JOB_DATA.length; i++) {
        //if ((JOB_DATA[i][1].indexOf($("#s_date").val()) !== -1) && (JOB_DATA[i][2].toLowerCase().indexOf($("#s_hospital").val().toLowerCase()) !== -1) && (JOB_DATA[i][7].toLowerCase().indexOf($("#s_brand").val().toLowerCase()) !== -1) && ((JOB_DATA[i][6].toLowerCase() + JOB_DATA[i][5].toLowerCase()).indexOf($("#s_product").val().toLowerCase()) !== -1) && (JOB_DATA[i][8].indexOf($("#s_price").val()) !== -1) && (JOB_DATA[i][9].indexOf($("#s_qty").val()) !== -1) && (JOB_DATA[i][10].indexOf($("#s_total").val()) !== -1) && ((JOB_DATA[i][12].toLowerCase() + JOB_DATA[i][14].toLowerCase()).indexOf($("#s_status").val().toLowerCase()) !== -1) && (JOB_DATA[i][15].toLowerCase().indexOf($("#s_productin").val().toLowerCase()) !== -1) && (JOB_DATA[i][23].indexOf($("#s_month").val()) !== -1) && (JOB_DATA[i][25].toLowerCase().indexOf($("#s_prob").val().toLowerCase()) !== -1) && (JOB_DATA[i][27].toLowerCase().indexOf($("#s_budget").val().toLowerCase()) !== -1) && (JOB_DATA[i][29].indexOf($("#s_sale").val()) !== -1) && (JOB_DATA[i][33].indexOf($("#s_am").val()) !== -1) && (JOB_DATA[i][31].indexOf($("#s_bm").val()) !== -1)) {
        if ((JOB_DATA[i][1].indexOf($("#s_date").val()) !== -1) && (JOB_DATA[i][2].toLowerCase().indexOf($("#s_hospital").val().toLowerCase()) !== -1) && (JOB_DATA[i][7].toLowerCase().indexOf($("#s_brand").val().toLowerCase()) !== -1) && ((JOB_DATA[i][6].toLowerCase() + JOB_DATA[i][5].toLowerCase()).indexOf($("#s_product").val().toLowerCase()) !== -1) && (JOB_DATA[i][8].indexOf($("#s_price").val()) !== -1) && (JOB_DATA[i][9].indexOf($("#s_qty").val()) !== -1) && (JOB_DATA[i][10].indexOf($("#s_total").val()) !== -1) && ((JOB_DATA[i][12].toLowerCase() + JOB_DATA[i][14].toLowerCase()).indexOf($("#s_status").val().toLowerCase()) !== -1) && (JOB_DATA[i][15].toLowerCase().indexOf($("#s_productin").val().toLowerCase()) !== -1) && (JOB_DATA[i][22].indexOf(s_year) !== -1) && (JOB_DATA[i][23].indexOf(s_month) !== -1) && (JOB_DATA[i][27].toLowerCase().indexOf($("#s_budget").val().toLowerCase()) !== -1) && (JOB_DATA[i][29].indexOf($("#s_sale").val()) !== -1) && (JOB_DATA[i][33].indexOf($("#s_am").val()) !== -1) && (JOB_DATA[i][31].indexOf($("#s_bm").val()) !== -1) && (JOB_DATA[i][42].indexOf($("#s_approve_status").val()) !== -1)) {

            TMP_ROW = "<tr>";

            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][1] + "</td>";
            TMP_ROW = TMP_ROW + "<td onclick = \"set_detail('" + JOB_DATA[i][0] + "')\"><a href='#page_detail'>" + JOB_DATA[i][2] + "</a></td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][7] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][6] + " | " + JOB_DATA[i][5] + "</td>";
            TMP_ROW = TMP_ROW + "<td style='text-align:right'>" + numberWithCommas(JOB_DATA[i][8]) + "</td>";
            TMP_ROW = TMP_ROW + "<td style='text-align:right'>" + numberWithCommas(JOB_DATA[i][9]) + "</td>";
            TMP_ROW = TMP_ROW + "<td style='text-align:right'>" + numberWithCommas(JOB_DATA[i][10]) + "</td>";
            TMP_ROW = TMP_ROW + "<td> ลูกค้า : " + JOB_DATA[i][12] + "<br /> สินค้า : " + JOB_DATA[i][14] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][15] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][22] + " / " + JOB_DATA[i][23] + "</td>";
            //TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][25] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][27] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][29] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][33] + "</td>";
            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][31] + "</td>";
            //TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][34] + "</td>";
            
            

            TMP_ROW = TMP_ROW + "<td><a onclick=\"submit_approve('" + JOB_DATA[i][0] + "','APPROVEAM')\" href='#'>อนุมัติ</a> | <a onclick=\"submit_approve('" + JOB_DATA[i][0] + "','REJECTAM')\" href='#'>ไม่อนุมัติ</a></td>";
            JOB_DATA[i][42] = 'อนุมัติ | ไม่อนุมัติ'



            TMP_ROW = TMP_ROW + "<td>" + JOB_DATA[i][38] + "<br />" + JOB_DATA[i][36] + "</td>";

            TMP_ROW = TMP_ROW + "</tr>";
            $("#tb_list tbody").append(TMP_ROW);
            sum_item = sum_item + 1;
            sum_amt = sum_amt + parseInt(JOB_DATA[i][10]);

        }
    }

    $("#rowcount").text(sum_item);
    $("#sum_amout").text(numberWithCommas(sum_amt));


    //'0	UID	
    //'1	SALE_DATE	วันที่ยื่นซอง
    //'2	SALE_HOSPITAL	โรงพยาบาล
    //'3	SALE_DEPARTMENT	หน่วยงาน
    //'4	SALE_PRODUCT_ID	
    //'5	SALE_PRODUCT_MODEL_NAME	โมเดล
    //'6	PRODUCT_NAME	สินค้า
    //'7	BRAND_NAME	แบรนด์
    //'8	SALE_UNIT_PRICE	ราคา/หน่วย
    //'9	SALE_QTY	จำนวน
    //'10	SALE_TOTAL_PRICE	ราคารวม Vat
    //'11	SALE_CUSTSTATE_ID	
    //'12	CUSTSTATE_NAME	สถานะลูกค้า
    //'13	SALE_ORDERSTATE_ID	
    //'14	ORDERSTATE_NAME	สถานะสินค้า
    //'15	SALE_ESTIMATE_IN	คาดการณ์สินค้าเข้า
    //'16	SALE_STAFF_ID	
    //'17	SALE_STAFF_AM_ID	
    //'18	SALE_STAFF_BM_ID	
    //'19	SALE_STAFF_SUP_ID	
    //'20	SALE_ORDER_TYPE	
    //'21	ORDERTYPE_NAME	B2
    //'22	SALE_ORDER_YEAR	ปี
    //'23	SALE_ORDER_MONTH	เดือน
    //'24	SALE_PROB_ID	
    //'25	ORDERPROB_NAME	ความน่าจะเป็น
    //'26	SALE_BUDGET_ID	
    //'27	BUDGETTYPE_NAME	ประเภทงบ
    //'28	STAFF_ID	
    //'29	STAFF_NAME	พนักงานขาย
    //'30	BM_ID	
    //'31	BM_NAME	BM
    //'32	AM_ID	
    //'33	AM_NAME	AM
    //'34	SALE_REMARK	หมายเหตุ
    //'35	SALE_CWHEN	
    //'36	SALE_MWHEN	
    //'37	SALE_CNAME	
    //'38	SALE_MNAME	
    //'39	BRAND_ID
    //'40 SALE_REQUEST_ID
    //'41 SALE_PROJECT_ID

    //1     <tr class="filters">
    //2     <th><input id="s_date" type="text" class="form-control" placeholder="วันที่ยื่นซอง" /></th>
    //3     <th><input id="s_hospital" type="text" class="form-control" placeholder="โรงพยาบาล" /></th>
    //7     <th><input id="s_brand" type="text" class="form-control" placeholder="แบรนด์" /></th>
    //6|5   <th><input id="s_product" type="text" class="form-control" placeholder="สินค้า | โมเดล" /></th>
    //8     <th><input id="s_price" type="text" class="form-control" placeholder="ราคา/หน่วย" /></th>
    //9     <th><input id="s_qty" type="text" class="form-control" placeholder="จำนวน" /></th>
    //10    <th><input id="s_total" type="text" class="form-control" placeholder="ราคารวม Vat" /></th>
    //12/14    <th><input id="s_status" type="text" class="form-control" placeholder="สถานะ" /></th>
    //15    <th><input id="s_productin" type="text" class="form-control" placeholder="คาดการณ์สินค้าเข้า" /></th>
    //22/23    <th><input id="s_month" type="text" class="form-control" placeholder="ปี / เดือน" /></th>
    //25    <th><input id="s_prob" type="text" class="form-control" placeholder="ความน่าจะเป็น" /></th>
    //27    <th><input id="s_budget" type="text" class="form-control" placeholder="ประเภทงบ" /></th>
    //29    <th><input id="s_sale" type="text" class="form-control" placeholder="พนักงานขาย" /></th>
    //33    <th><input id="s_am" type="text" class="form-control" placeholder="AM" /></th>
    //31    <th><input id="s_bm" type="text" class="form-control" placeholder="BM" /></th>
    //34    <th><input id="s_remark" type="text" class="form-control" placeholder="หมายเหตุ" /></th>
    //36    <th><input id="s_mdate" type="text" class="form-control" placeholder="แก้ไขล่าสุด" /></th>
}

function submit_approve(job_id_, APPROVE_) {
    var MSG = "ท่านยืนยันที่จะ อนุมัติ ใช่หรือไม่";
    if (APPROVE_ == 'REJECTAM') {
        MSG = "ท่านยืนยันที่จะ ไม่อนุมัติ ใช่หรือไม่";
    }
    if (confirm(MSG)) {

        $.post(serverAJAXpath, {
            feature: "save_approve"
            , ctrl_txt_id: job_id_
            , state: APPROVE_
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
/*</Custom Function>*/


