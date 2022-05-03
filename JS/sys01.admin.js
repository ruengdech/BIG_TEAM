 
var serverAJAXpath = "../myServer/sys01.aspx"; //123
/*<Control variable> */
var ctrl_txt_id = $("#txt_id");
var ctrl_txt_job_date = $("#txt_job_date");
var ctrl_txt_staffId = $("#txt_staffId");
var ctrl_txt_name = $("#txt_name");
var ctrl_txt_lname = $("#txt_lname");
var ctrl_txt_mobile = $("#txt_mobile");
var ctrl_txt_email = $("#txt_email");
var ctrl_sel_am = $("#sel_am");
var ctrl_sel_bm = $("#sel_bm");
var ctrl_txt_location = $("#txt_location");
var ctrl_txt_dept = $("#txt_dept");
var ctrl_txt_contact = $("#txt_contact");
var ctrl_txt_contactTel = $("#txt_contactTel");
var ctrl_txt_date = $("#txt_date");
var ctrl_txt_time = $("#txt_time");
var ctrl_txt_contract = $("#txt_contract");
var ctrl_sel_pm = $("#sel_pm");
var ctrl_sel_waranteen = $("#sel_warantee");
var ctrl_sel_job1 = $("#sel_job1");
var ctrl_sel_job2 = $("#sel_job2");
var ctrl_sel_job3 = $("#sel_job3");
var ctrl_txt_job1 = $("#txt_job1");
var ctrl_txt_job2 = $("#txt_job2");
var ctrl_txt_job3 = $("#txt_job3");
var ctrl_txt_job_status = $("#txt_job_status");

//ข้อมูลมอบหมาย
var ctrl_sel_staff = $("#sel_staff");
var ctrl_sel_staff1 = $("#sel_staff1");
var ctrl_sel_staff2 = $("#sel_staff2");
var ctrl_sel_staff3 = $("#sel_staff3");
var ctrl_sel_staff4 = $("#sel_staff4");
var ctrl_txt_assign_date = $("#txt_assign_date");
var ctrl_txt_assignid = $("#txt_assignid");
var ctrl_txt_assignname = $("#txt_assignname");

//ข้อมูลแผนงาน
var ctrl_txt_plan_start = $("#txt_plan_start");
var ctrl_txt_plan_end = $("#txt_plan_end");
var ctrl_txt_planid = $("#txt_planid");
var ctrl_txt_planname = $("#txt_planname");
var ctrl_sel_plan_result = $("#sel_plan_result");
var ctrl_txt_plan_comment = $("#txt_plan_comment");
var ctrl_txt_plan_approveid = $("#txt_plan_approveid");
var ctrl_txt_plan_approvename = $("#txt_plan_approvename");

//ข้อมูลปฏิบัติงานจริง
var ctrl_txt_date_start = $("#txt_date_start");
var ctrl_txt_date_end = $("#txt_date_end");
var ctrl_txt_job_detail = $("#txt_job_detail");
var ctrl_sel_job_status = $("#sel_job_status");

var ctrl_bt_submit = $("#bt_submit");
var ctrl_bt_delete = $("#bt_delete");
/*</Control variable> */


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
        $("#tb_assign tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        $(".tr_main").show();
    });
    $("#myInput2").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#tb_approve tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        $(".tr_main").show();
    });
    $("#myInput3").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#tb_history tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        $(".tr_main").show();
    });

    $.post(serverAJAXpath, { feature: "getAM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_am.append("<option value=''> เลือก AM </option>");
        for (i = 0; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_am.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        //ctrl_sel_am.selectmenu('refresh', true);
    });

    $.post(serverAJAXpath, { feature: "getBM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_bm.append("<option value=''> เลือก BM </option>");
        for (i = 0; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_bm.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        //ctrl_sel_bm.selectmenu('refresh', true);
    });

    $.post(serverAJAXpath, { feature: "getENGINEER" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_staff1.append("<option value='0'> เลือกช่าง 1 </option>");
        ctrl_sel_staff2.append("<option value='0'> เลือกช่าง 2 </option>");
        ctrl_sel_staff3.append("<option value='0'> เลือกช่าง 3 </option>");
        ctrl_sel_staff4.append("<option value='0'> เลือกช่าง 4 </option>");
        for (i = 1; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_staff1.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            ctrl_sel_staff2.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            ctrl_sel_staff3.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            ctrl_sel_staff4.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }

        ctrl_sel_staff1.selectmenu('refresh', true);
        ctrl_sel_staff2.selectmenu('refresh', true);
        ctrl_sel_staff3.selectmenu('refresh', true);
        ctrl_sel_staff4.selectmenu('refresh', true);
    });

    try {  ctrl_sel_am.selectmenu().selectmenu('refresh', true);} catch (err) { }
    try { ctrl_sel_bm.selectmenu().selectmenu('refresh', true);} catch (err) { }
    try { ctrl_sel_staff1.selectmenu().selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff2.selectmenu().selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff3.selectmenu().selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff4.selectmenu().selectmenu('refresh', true); } catch (err) { }
   
    
    
    get_request("ALL");

    get_request("WAITFORASSIGN");

    get_request("WAITFORAPPROVE");   
      
});

/*</Initial Load>*/


/*<Action>*/

ctrl_txt_staffId.keyup(function () {
    var thisval = $("#txt_staffId").val();
    if (thisval.length > 4) {
        $.post(serverAJAXpath, { feature: "getStaffByID", id: thisval }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");
                ctrl_txt_name.val(TMP[2]);
                ctrl_txt_lname.val(TMP[3]);
                ctrl_txt_mobile.val(TMP[4]);
                ctrl_txt_email.val(TMP[5]);
            } else {
                ctrl_txt_name.val("");
                ctrl_txt_lname.val("");
                ctrl_txt_mobile.val("");
                ctrl_txt_email.val("");
            }

        });
    } else {
        var x;
    }
});
ctrl_txt_assignid.keyup(function () {
    var thisval = ctrl_txt_assignid.val();
    if (thisval.length > 4) {
        $.post(serverAJAXpath, { feature: "getStaffByID", id: thisval }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");
                ctrl_txt_assignname.val(TMP[2] + " " + TMP[3]) ;
            } else {
                ctrl_txt_assignname.val("");
            }

        });
    } else {
        var x;
    }
});
ctrl_txt_plan_approveid.keyup(function () {
    var thisval = ctrl_txt_plan_approveid.val();
    if (thisval.length > 4) {
        $.post(serverAJAXpath, { feature: "getStaffByID", id: thisval }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");
                ctrl_txt_plan_approvename.val(TMP[2] + " " + TMP[3]);
            } else {
                ctrl_txt_plan_approvename.val("");
            }

        });
    } else {
        var x;
    }
});

ctrl_bt_submit.click(function () {
    var validCreate = f_validateCreate('new');
    if (validCreate == true) {
        $.post(serverAJAXpath, {
            feature: "adminEditJOB"
            , job_id: ctrl_txt_id.val()
            , ctrl_txt_staffId: ctrl_txt_staffId.val()
            , ctrl_txt_name: ctrl_txt_name.val()
            , ctrl_txt_lname: ctrl_txt_lname.val()
            , ctrl_txt_mobile: ctrl_txt_mobile.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_email: ctrl_txt_email.val().replace("'", "|").replace('"', '^')
            , ctrl_sel_am: ctrl_sel_am.val()
            , ctrl_sel_bm: ctrl_sel_bm.val()
            , ctrl_txt_location: ctrl_txt_location.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_dept: ctrl_txt_dept.val()
            , ctrl_txt_contact: ctrl_txt_contact.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_contactTel: ctrl_txt_contactTel.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_date: ctrl_txt_date.val()
            , ctrl_txt_time: ctrl_txt_time.val()
            , ctrl_txt_contract: ctrl_txt_contract.val().replace("'", "|").replace('"', '^')
            , ctrl_sel_pm: ctrl_sel_pm.val()
            , ctrl_sel_waranteen: ctrl_sel_waranteen.val()
            , ctrl_sel_job1: ctrl_sel_job1.val()
            , ctrl_sel_job2: ctrl_sel_job2.val()
            , ctrl_sel_job3: ctrl_sel_job3.val()
            , ctrl_txt_job1: ctrl_txt_job1.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_job2: ctrl_txt_job2.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_job3: ctrl_txt_job3.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_job_status: ctrl_txt_job_status.val()

            , ctrl_sel_staff: ctrl_sel_staff.val()
            , ctrl_sel_staff1: ctrl_sel_staff1.val()
            , ctrl_sel_staff2: ctrl_sel_staff2.val()
            , ctrl_sel_staff3: ctrl_sel_staff3.val()
            , ctrl_sel_staff4: ctrl_sel_staff4.val()
            , ctrl_txt_assign_date: ctrl_txt_assign_date.val()
            , ctrl_txt_assignid: ctrl_txt_assignid.val()
            , ctrl_txt_assignname: ctrl_txt_assignname.val()

            , ctrl_txt_plan_start: ctrl_txt_plan_start.val()
            , ctrl_txt_plan_end: ctrl_txt_plan_end.val()
            , ctrl_txt_planid: ctrl_txt_planid.val()
            , ctrl_txt_planname: ctrl_txt_planname.val()
            , ctrl_sel_plan_result: ctrl_sel_plan_result.val()
            , ctrl_txt_plan_comment: ctrl_txt_plan_comment.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_plan_approveid: ctrl_txt_plan_approveid.val()
            , ctrl_txt_plan_approvename: ctrl_txt_plan_approvename.val()

            , ctrl_txt_date_start: ctrl_txt_date_start.val()
            , ctrl_txt_date_end: ctrl_txt_date_end.val()
            , ctrl_txt_job_detail: ctrl_txt_job_detail.val().replace("'", "|").replace('"', '^')
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                confirm("บันทึกการ UPDATE งานเรียบร้อย");
                $.mobile.navigate("#page_main", { info: "info about the #foo hash" });
                location.reload();
            } else {
                alert("เกิดข้อผิดพลาดในระบบ");
            }
        });
    }       
});


ctrl_bt_delete.click(function () {
    var is_cf  = confirm("ท่านต้องการยืนยันลบรายการใช่หรือไม่");
    if (is_cf) {
    /*Start Submit Delete*/
        $.post(serverAJAXpath, {
            feature: "adminDeleteJOB"
            , job_id: ctrl_txt_id.val()
            , delete_staff_id: STAFF_ID
            , delete_staff_name: STAFF_NAME
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                confirm("ทำการลบงานเรียบร้อย");
                $.mobile.navigate("#page_main", { info: "info about the #foo hash" });
                location.reload();
            } else {
                alert("เกิดข้อผิดพลาดในระบบ");
            }
        });
    /*End Submit Delete*/
    }


});


/*</Action>*/

/* <FOR ERROR SEL REFRESH>  */

ctrl_sel_am.ready(function () { ctrl_sel_am.selectmenu().selectmenu('refresh', true); });
ctrl_sel_bm.ready(function () { ctrl_sel_bm.selectmenu().selectmenu('refresh', true); });
ctrl_sel_pm.ready(function () { ctrl_sel_pm.selectmenu().selectmenu('refresh', true); });
ctrl_sel_waranteen.ready(function () { ctrl_sel_waranteen.selectmenu().selectmenu('refresh', true); });
ctrl_sel_job1.ready(function () { ctrl_sel_job1.selectmenu().selectmenu('refresh', true); });
ctrl_sel_job2.ready(function () { ctrl_sel_job2.selectmenu().selectmenu('refresh', true); });
ctrl_sel_job3.ready(function () { ctrl_sel_job3.selectmenu().selectmenu('refresh', true); });
ctrl_sel_staff.ready(function () { ctrl_sel_staff.selectmenu().selectmenu('refresh', true); });
ctrl_sel_staff1.ready(function () { ctrl_sel_staff1.selectmenu().selectmenu('refresh', true); });
ctrl_sel_staff2.ready(function () { ctrl_sel_staff2.selectmenu().selectmenu('refresh', true); });
ctrl_sel_staff3.ready(function () { ctrl_sel_staff3.selectmenu().selectmenu('refresh', true); });
ctrl_sel_staff4.ready(function () { ctrl_sel_staff4.selectmenu().selectmenu('refresh', true); });
ctrl_sel_plan_result.ready(function () { ctrl_sel_plan_result.selectmenu().selectmenu('refresh', true); });

/* </FOR ERROR SEL REFRESH>  */

/*<Utility Function>*/
function f_validateCreate(stage) {
    if (stage === 'new') {

        if (ctrl_txt_date.val().indexOf("256") !== -1 && ctrl_txt_date.val().indexOf("257") !== -1) {
            ctrl_txt_date.focus();
            alert("กรุณาระบุวันที่ต้องการให้ติดตั้ง โดยเลือกเป็นปี ค.ศ");
            return false;
        }

        if (ctrl_txt_staffId.val().length < 3 || ctrl_txt_name.val().length < 3 || ctrl_txt_lname.val().length < 3) {
            ctrl_txt_staffId.focus();
            alert("กรุณากรอกข้อมูลพนักงานผู้แจ้งเรื่อง");
            return false;
        }

        if (ctrl_txt_mobile.val().length < 3 || ctrl_txt_email.val().length < 3) {
            ctrl_txt_mobile.focus();
            alert("กรุณากรอก มือถือ/Email พนักงานผู้แจ้งเรื่อง");
            return false;
        }

        if (ctrl_sel_am.val() === "0") {
            ctrl_sel_am.focus();
            alert("กรุณาเลือก AM");
            return false;
        } else if (ctrl_sel_bm.val() === "0") {
            ctrl_sel_bm.focus();
            alert("กรุณาเลือก BM");
            return false;
        }

        if (ctrl_txt_location.val().length < 3) {
            ctrl_txt_location.focus();
            alert("กรุณาระบุสถานที่ติดตั้ง");
            return false;
        } else if (ctrl_txt_contact.val().length < 3) {
            ctrl_txt_contact.focus();
            alert("กรุณาระบุผู้ติดต่อ");
            return false;
        } else if (ctrl_txt_contactTel.val().length < 3) {
            ctrl_txt_contactTel.focus();
            alert("กรุณาระบุเบอร์โทรผู้ติดต่อ");
            return false;
        }

        if (ctrl_txt_date.val().length < 3) {
            ctrl_txt_date.focus();
            alert("กรุณาระบุวันที่ต้องการให้ติดตั้ง");
            return false;
        } else if (ctrl_txt_time.val().length < 2) {
            ctrl_txt_time.focus();
            alert("กรุณาระบุเวลาที่ต้องการให้ติดตั้ง");
            return false;
        } else if (ctrl_txt_job1.val().length < 3) {
            ctrl_txt_job1.focus();
            alert("กรุณาระบุงาน");
            return false;
        } else if (ctrl_sel_job1.val() === "") {
            ctrl_sel_job1.focus();
            alert("กรุณาระบุประเภทของงาน");
            return false;
        }
    } 

    return true;
}

function prepareDetail(uid, TYPE) {
    var row = 0;
    for (i = 0; i < JOB_DATA.length; i++) {
        if (parseInt(JOB_DATA[i][0]) === uid) {
            row = i;
        }
    }


    var MSG = "<style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> ";
    var pre_ = "<tr><th>";
    var pre2_ = "<tr style='background-color: #f7f9fa;'><th>";
    var mid_ = "</th><td>";
    var post_ = "</td></tr>";
    MSG = MSG + "<center><H3>พนักงานร้องขอรับบริการงานช่างดังนี้</H3>";
    MSG = MSG + "<table width = '450px'>";
    MSG = MSG + pre_ + "ห้วข้องาน : " + mid_ + JOB_DATA[row][25] + post_;
    MSG = MSG + pre2_ + "สถานที่ : " + mid_ + JOB_DATA[row][13] + ": " + JOB_DATA[row][14]  + post_;
    MSG = MSG + pre_ + "แจ้งโดย : " + mid_ + JOB_DATA[row][3] + " " + JOB_DATA[row][4] + post_;
    MSG = MSG + pre2_ + "Email : " + mid_ + JOB_DATA[row][6] + " <b>Tel</b> " + JOB_DATA[row][5] + post_;
    MSG = MSG + pre_ + "วันที่แจ้ง [ปี-เดือน-วัน] : " + mid_ + JOB_DATA[row][48] + post_;

    MSG = MSG + pre2_ + "AM : " + mid_ + JOB_DATA[row][8] + post_;
    MSG = MSG + pre_ + "BM : " + mid_ + JOB_DATA[row][11] + post_;
    MSG = MSG + pre2_ + "วันเวลาที่ต้องการให้ติดตั้ง [ปี-เดือน-วัน] : " + mid_ + JOB_DATA[row][17] + "  " + JOB_DATA[row][18] + post_;
    MSG = MSG + pre_ + "ผู้ติดต่อ : " + mid_ + JOB_DATA[row][15] + "  โทร " + JOB_DATA[row][16] + post_;
    MSG = MSG + pre2_ + "เลขที่สัญญา : " + mid_ + JOB_DATA[row][19] + post_;
    MSG = MSG + pre_ + "รอบ PM (ครั้ง/ปี) : " + mid_ + JOB_DATA[row][20] + post_;
    MSG = MSG + pre2_ + "ระยะเวลารับประกัน (ปี) : " + mid_ + JOB_DATA[row][21] + post_;
    MSG = MSG + pre_ + "ประเภทของงาน (1) : " + mid_ + JOB_DATA[row][22] + " <b>" + JOB_DATA[row][25] + "</b>" + post_;
    MSG = MSG + pre2_ + "ประเภทของงาน (2) : " + mid_ + JOB_DATA[row][23] + " <b>" + JOB_DATA[row][26] + "</b>" + post_;
    MSG = MSG + pre_ + "ประเภทของงาน (3) : " + mid_ + JOB_DATA[row][24] + " <b>" + JOB_DATA[row][27] + "</b>" + post_;
    MSG = MSG + pre2_ + "จำนวนวันทำงาน (ตาม Request): " + mid_ + JOB_DATA[row][52] + post_;

    MSG = MSG + pre2_ + "สถานะ BM อนุมัติ (วันทำงาน <=3): " + mid_ + JOB_DATA[row][75] + post_;
    // ข้อมูลจากทีมช่าง
    MSG = MSG + "<tr><th colspan=\"2\"><b>สถานะของงาน [<u>" + JOB_DATA[row][47] + "</u>]</b> </th></tr>";
    MSG = MSG + pre2_ + "วันที่คาดว่าจะดำเนินการ [ปี-เดือน-วัน] : " + mid_ + JOB_DATA[row][57] + " - " + JOB_DATA[row][58] + post_;
    MSG = MSG + pre_ + "วันที่ดำเนินการจริง [ปี-เดือน-วัน]: " + mid_ + JOB_DATA[row][41] + " - " + JOB_DATA[row][42] + post_;
    MSG = MSG + pre2_ + "รายเอียด : " + mid_ + JOB_DATA[row][71] + post_;
    MSG = MSG + pre_ + "ผู้ได้รับมอบหมายงาน : " + mid_ + "1. " + JOB_DATA[row][37] ;
    if (JOB_DATA[row][38].length > 3) { MSG = MSG + "<br />2.  " + JOB_DATA[row][38]; }
    if (JOB_DATA[row][39].length > 3) { MSG = MSG + "<br />3.  " + JOB_DATA[row][39]; }
    if (JOB_DATA[row][40].length > 3) { MSG = MSG + "<br />4.  " + JOB_DATA[row][40]; }
    MSG = MSG + post_;

    MSG = MSG + pre2_ + "สถานะงานของช่าง : " + mid_ + JOB_DATA[row][72] + post_;
    MSG = MSG + pre2_ + "รูปงาน : " + mid_ + "1. <a href=\"../uploads/" + JOB_DATA[row][43] + "\" rel=\"external\" target=\"_blank\">" + JOB_DATA[row][43] + " </a>";
    if (JOB_DATA[row][44].length > 3) { MSG = MSG + "<br />2. <a href=\"../uploads/" + JOB_DATA[row][44] + "\" rel=\"external\" target=\"_blank\"> " + JOB_DATA[row][44] + " </a>"; }
    if (JOB_DATA[row][45].length > 3) { MSG = MSG + "<br />3. <a href=\"../uploads/" + JOB_DATA[row][45] + "\" rel=\"external\" target=\"_blank\"> " + JOB_DATA[row][45] + " </a>"; }
    if (JOB_DATA[row][46].length > 3) { MSG = MSG + "<br />4. <a href=\"../uploads/" + JOB_DATA[row][46] + "\" rel=\"external\" target=\"_blank\"> " + JOB_DATA[row][46] + " </a>"; }
    MSG = MSG + post_;

    //ประเมินความพึงพอใจ
    MSG = MSG + "<tr><th colspan=\"2\"><b>ประเมินความพึงพอใจ</b></th></tr>";
    if (JOB_DATA[row][65] === "1") {
        MSG = MSG + pre2_ + "คะแนนความพอใจ : " + mid_;
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + post_;
        MSG = MSG + "<tr><th><b>Comment</b></th><td>" + JOB_DATA[row][67] + "</td></tr>";
    } else if(JOB_DATA[row][65] === "2") {
        MSG = MSG + pre2_ + "คะแนนความพอใจ : " + mid_;
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + post_;
        MSG = MSG + "<tr><th><b>Comment</b></th><td>" + JOB_DATA[row][67] + "</td></tr>";
    } else if (JOB_DATA[row][65] === "3") {
        MSG = MSG + pre2_ + "คะแนนความพอใจ : " + mid_;
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + post_;
        MSG = MSG + "<tr><th><b>Comment</b></th><td>" + JOB_DATA[row][67] + "</td></tr>";
    } else if (JOB_DATA[row][65] === "4") {
        MSG = MSG + pre2_ + "คะแนนความพอใจ : " + mid_;
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star\" ></span>";
        MSG = MSG + post_;
        MSG = MSG + "<tr><th><b>Comment</b></th><td>" + JOB_DATA[row][67] + "</td></tr>";
    } else if (JOB_DATA[row][65] === "5") {
        MSG = MSG + pre2_ + "คะแนนความพอใจ : " + mid_;
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + "<span class=\"fa fa-star fa-star-active\" ></span>";
        MSG = MSG + post_;
        MSG = MSG + "<tr><th><b>Comment</b></th><td>" + JOB_DATA[row][67] + "</td></tr>";
    } else if (JOB_DATA[row][65] === "-1" && JOB_DATA[row][42].length > 4 ) {
        MSG = MSG + pre2_ + "ประเมินความพอใจ : " + mid_;
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",1);\" class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",2);\" class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",3);\" class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",4);\" class=\"fa fa-star\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",5);\" class=\"fa fa-star\" ></span>";
        MSG = MSG + post_;
    } 
    
    //MSG = MSG + "<tr><th colspan='2'> คลิกเพื่อดูรายละเอียด</a></th></tr>";
    MSG = MSG + "</table></center></body></html>";
    $("#div_detail").html(MSG);

/*BIND DATA FOR CONTROL*/

    ctrl_txt_id.val(uid);
    ctrl_txt_staffId.val(JOB_DATA[row][2]);
    ctrl_txt_name.val(JOB_DATA[row][3]);
    ctrl_txt_lname.val(JOB_DATA[row][4]);
    ctrl_txt_mobile.val(JOB_DATA[row][5]);
    ctrl_txt_email.val(JOB_DATA[row][6]);
    ctrl_sel_am.val(JOB_DATA[row][7]);
    ctrl_sel_bm.val(JOB_DATA[row][10]);
    ctrl_txt_location.val(JOB_DATA[row][13]);
    ctrl_txt_dept.val(JOB_DATA[row][14]);
    ctrl_txt_contact.val(JOB_DATA[row][15]);
    ctrl_txt_contactTel.val(JOB_DATA[row][16]);
    ctrl_txt_date.val(JOB_DATA[row][17]);
    ctrl_txt_time.val(JOB_DATA[row][18]);
    ctrl_txt_contract.val(JOB_DATA[row][19]);
    ctrl_sel_pm.val(JOB_DATA[row][20]);
    ctrl_sel_waranteen.val(JOB_DATA[row][21]);
    ctrl_sel_job1.val(JOB_DATA[row][22]);
    ctrl_sel_job2.val(JOB_DATA[row][23]);
    ctrl_sel_job3.val(JOB_DATA[row][24]);
    ctrl_txt_job1.val(JOB_DATA[row][25]);
    ctrl_txt_job2.val(JOB_DATA[row][26]);
    ctrl_txt_job3.val(JOB_DATA[row][27]);
    ctrl_txt_job_status.val(JOB_DATA[row][47]);
    ctrl_txt_job_date.val(JOB_DATA[row][48]);

    //ข้อมูลมอบหมาย
    ctrl_sel_staff.val(JOB_DATA[row][32]);
    ctrl_sel_staff1.val(JOB_DATA[row][33]);
    ctrl_sel_staff2.val(JOB_DATA[row][34]);
    ctrl_sel_staff3.val(JOB_DATA[row][35]);
    ctrl_sel_staff4.val(JOB_DATA[row][36]);

    if (JOB_DATA[row][31].length > 5) {
        ctrl_txt_assign_date.val(JOB_DATA[row][31]);
    } else {
        var current = new Date();
        ctrl_txt_assign_date.val(current.toLocaleString());
    }
    ctrl_txt_assignid.val(JOB_DATA[row][29]);
    ctrl_txt_assignname.val(JOB_DATA[row][30]);

    //ข้อมูลแผนงาน
    ctrl_txt_plan_start.val(JOB_DATA[row][57]);
    ctrl_txt_plan_end.val(JOB_DATA[row][58]);
    ctrl_txt_planid.val("");
    ctrl_txt_planname.val(JOB_DATA[row][59]);
    ctrl_sel_plan_result.val(JOB_DATA[row][61]);
    ctrl_txt_plan_comment.val(JOB_DATA[row][64]);
    ctrl_txt_plan_approveid.val("");
    ctrl_txt_plan_approvename.val(JOB_DATA[row][62]);
    
    //ข้อมูลปฏิบัติงานจริง
    ctrl_txt_date_start.val(JOB_DATA[row][41]);
    ctrl_txt_date_end.val(JOB_DATA[row][42]);
    ctrl_txt_job_detail.val(JOB_DATA[row][71]);
    ctrl_sel_job_status.val(JOB_DATA[row][72]);

    //$("#submitDate").val(JOB_DATA[row][48]);
    //$("#div_engineer").hide();
    //$("#txt_date_start").hide();
    //$("#txt_date_end").hide();
    //$("#p_assigned_attached").hide();

    if (JOB_DATA[row][47] == "new") {
        $("#div_plan").hide();
        $("#div_engineer").hide();
        $("#head_edit").text("ASSIGN JOB");
    }
    if (JOB_DATA[row][47] == "plan") {
        $("#div_plan").show();
        $("#div_engineer").hide();
        $("#head_edit").text("APPROVE PLAN");
    }
    if (JOB_DATA[row][47] == "start" || JOB_DATA[row][47] == "finish" || JOB_DATA[row][47] == "complete") {
        $("#div_plan").show();
        $("#div_engineer").show();
        $("#head_edit").text("EDIT DATA");
    }

    //BM APPROVE
    $("#bm_approve").text("สถานะการอนุมัติงานของ BM : " + JOB_DATA[row][75]);

    if (JOB_DATA[row][75] == "WAIT FOR APPROVE") {
        $("#bt_submit").hide();
    } else {
        $("#bt_submit").show();
    }

    // Load EVENT for SEL
    

    try { ctrl_sel_am.selectmenu().selectmenu('refresh', true); } catch(err) { }
    try { ctrl_sel_bm.selectmenu('refresh', true); } catch (err) { }

    try { ctrl_sel_pm.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_waranteen.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_job1.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_job2.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_job3.selectmenu('refresh', true); } catch (err) { }

    try { ctrl_sel_staff.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff1.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff2.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff3.selectmenu('refresh', true); } catch (err) { }
    try { ctrl_sel_staff4.selectmenu('refresh', true); } catch (err) { }

    try { ctrl_sel_plan_result.selectmenu('refresh', true); } catch (err) { }
    
}




function REFRESH_DATA() {
    $('#tb_history').find("tr:gt(0)").remove();
    JOB_DATA = [];

    $.post(serverAJAXpath, { feature: "getRequest", STAFF_ID: STAFF_ID, PAGE_REQUEST: "ADMIN" }).done(function (data) {
        if (data.indexOf("FAIL") === -1) {
            /*BIND ADD REQEST DATA*/
            var TMP = data.split("^");
            for (i = 0; i < TMP.length; i++) {
                var TMP2 = TMP[i].split("|");
                var STR_ = "<tr style=\"background-color:#81ecec\">";
                if (parseInt(TMP2[52]) <= 3) {
                    STR_ = "<tr style=\"background-color:#fab1a0\">";
                } else if (parseInt(TMP2[52]) <= 6) {
                    STR_ = "<tr style=\"background-color:#ffeaa7\">";
                }

                STR_ = STR_ + "<td>" + TMP2[0] + "</td>";
                STR_ = STR_ + "<td>" + TMP2[1] + "<br/>" + TMP2[3] + " " + TMP2[4] + "</td>";
                STR_ = STR_ + "<td><a href='#page_detail' data-transition='slidefade' onclick='prepareDetail(" + i + ");'><strong>" + TMP2[23] + "</strong><br/>" + TMP2[25] + "</a></td>";
                STR_ = STR_ + "<td><strong>" + TMP2[13] + "</strong><br />" + TMP2[14] + "</td>";
                STR_ = STR_ + "<td>AM: " + TMP2[8] + "<br />BM: " + TMP2[11] + "</td>";
                STR_ = STR_ + "<td>" + TMP2[47] + "</td>";

                STR_ = STR_ + "</tr>";

                $('#tb_history tr:last').after(STR_);
                JOB_DATA.push(TMP2);
            }
            /*END BIND ADD REQEST DATA*/     
        }   
    });
}

function get_request(TYPE) {
    $("#myInput").val('');
    $("#myInput2").val('');
    $("#myInput3").val('');
    if (TYPE === "ALL") {
        JOB_DATA = [];
        $.post(serverAJAXpath, { feature: "getRequest", STAFF_ID: STAFF_ID, PAGE_REQUEST: "ADMIN" }).done(function (data) {
            if (data.indexOf("FAIL") === -1) {
                /*BIND ALL REQUEST DATA*/
                var TMP = data.split("^");
                for (i = 0; i < TMP.length; i++) {
                    var TMP2 = TMP[i].split("|");
                    var STR_ = "<tr style=\"background-color:#81ecec\">";
                    if (parseInt(TMP2[52]) <= 3) {
                        STR_ = "<tr style=\"background-color:#fab1a0\">";
                    } else if (parseInt(TMP2[52]) <= 6) {
                        STR_ = "<tr style=\"background-color:#ffeaa7\">";
                    }

                    var engineers = " - " + TMP2[37];
                    if (TMP2[38].length > 3) { engineers = engineers + "<br /> - " + TMP2[38] }
                    if (TMP2[39].length > 3) { engineers = engineers + "<br /> - " + TMP2[39] }
                    if (TMP2[40].length > 3) { engineers = engineers + "<br /> - " + TMP2[40] }


                    STR_ = STR_ + "<td>" + TMP2[0] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[1] + "<br/>" + TMP2[3] + " " + TMP2[4] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[17] + "</td>";
                    STR_ = STR_ + "<td><a href='#page_detail' data-transition='slidefade' onclick='prepareDetail(" + TMP2[0] + ",\"DETAIL\");'><strong>" + TMP2[23] + "</strong><br/>" + TMP2[25] + "</a></td>";
                    STR_ = STR_ + "<td><strong>" + TMP2[13] + "</strong><br />" + TMP2[14] + "</td>";
                    STR_ = STR_ + "<td>AM: " + TMP2[8] + "<br />BM: " + TMP2[11] + "</td>";
                    STR_ = STR_ + "<td>" + engineers + "</td>";
                    
                    if (TMP2[47] == "assigned" || TMP2[47] == "start" || TMP2[47] == "plan") {
                        STR_ = STR_ + "<td><center>" + TMP2[47] + "<br /><a href='#page_edit' data-transition='slidefade' onclick=\"setTimeout(prepareDetail(" + TMP2[0] + ",'ASSIGN'),1000);\" >แก้ไขช่าง</a></center></td>";
                    } else {
                        if (parseInt(TMP2[74]) == 0 && TMP2[47] != "new") {
                            //ยังไม่เคยประเมิน
                            STR_ = STR_ + "<td><center>" + TMP2[47] + "<a href='#' onclick=\"send_csi('" + TMP2[0] + "');\" ><br />CSI Request</a></center></td>";
                        } else {
                            //มีประเมินแล้ว
                            STR_ = STR_ + "<td><center>" + TMP2[47] + "<a href='../../SYS04/admin_s.aspx?j=" + TMP2[0] + "' target = '_blank' ><br />ดูคะแนน CSI</a></center></td>";
                        }
                    }

                    STR_ = STR_ + "</tr>";
                    $('#tb_history tr:last').after(STR_);
                    JOB_DATA.push(TMP2);
                }
                /*END BIND ADD REQEST DATA*/
            }
        });
    }
    if (TYPE === "WAITFORASSIGN") {
        $.post(serverAJAXpath, { feature: "getRequestWaitForAssign", STAFF_ID: STAFF_ID, PAGE_REQUEST: "ADMIN" }).done(function (data) {
            if (data.indexOf("FAIL") === -1) {
                /*BIND REQUEST DATA WAIT FOR ASSIGN*/
                var TMP = data.split("^");
                for (i = 0; i < TMP.length; i++) {
                    var TMP2 = TMP[i].split("|");
                    var STR_ = "<tr style=\"background-color:#81ecec\">";
                    if (parseInt(TMP2[52]) <= 3) {
                        STR_ = "<tr style=\"background-color:#fab1a0\">";
                    } else if (parseInt(TMP2[52]) <= 6) {
                        STR_ = "<tr style=\"background-color:#ffeaa7\">";
                    }

                    STR_ = STR_ + "<td>" + TMP2[0] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[1] + "<br/>" + TMP2[3] + " " + TMP2[4] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[17] + "</td>";
                    //STR_ = STR_ + "<td><a href='#page_edit' data-transition='slidefade' onclick='prepareDetail(" + TMP2[0] + ",\"ASSIGN\");'><strong>" + TMP2[23] + "</strong><br/>" + TMP2[25] + "</a></td>";
                    STR_ = STR_ + "<td><a href='#page_edit' data-transition='slidefade' onclick=\"setTimeout(prepareDetail(" + TMP2[0] + ",'ASSIGN'),1000);\" ><strong>" + TMP2[23] + "</strong><br/>" + TMP2[25] + "</a></td>";
                    STR_ = STR_ + "<td><strong>" + TMP2[13] + "</strong><br />" + TMP2[14] + "</td>";
                    STR_ = STR_ + "<td>AM: " + TMP2[8] + "<br />BM: " + TMP2[11] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[47] + "</td>";

                    STR_ = STR_ + "</tr>";
                    $('#tb_assign tr:last').after(STR_);

                }
                /*BIND REQUEST DATA WAIT FOR ASSIGN*/
            }
        });
    }
    if (TYPE === "WAITFORAPPROVE") {
        $.post(serverAJAXpath, { feature: "getRequestWaitForApprove", STAFF_ID: STAFF_ID, PAGE_REQUEST: "ADMIN" }).done(function (data) {
            if (data.indexOf("FAIL") === -1) {
                /*BIND REQUEST DATA WAIT FOR APPROE*/
                var TMP = data.split("^");
                for (i = 0; i < TMP.length; i++) {
                    var TMP2 = TMP[i].split("|");
                    var STR_ = "<tr style=\"background-color:#81ecec\">";
                    if (parseInt(TMP2[52]) <= 3) {
                        STR_ = "<tr style=\"background-color:#fab1a0\">";
                    } else if (parseInt(TMP2[52]) <= 6) {
                        STR_ = "<tr style=\"background-color:#ffeaa7\">";
                    }

                    var engineers = " - " + TMP2[37];
                    if (TMP2[38].length > 3) { engineers = engineers + "<br /> - " + TMP2[38] }
                    if (TMP2[39].length > 3) { engineers = engineers + "<br /> - " + TMP2[39] }
                    if (TMP2[40].length > 3) { engineers = engineers + "<br /> - " + TMP2[40] }

                    STR_ = STR_ + "<td>" + TMP2[0] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[1] + "<br/>" + TMP2[3] + " " + TMP2[4] + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[17] + "</td>";
                    STR_ = STR_ + "<td><a href='#page_edit' data-transition='slidefade' onclick='prepareDetail(" + TMP2[0] + ",\"APPROVE\");'><strong>" + TMP2[23] + "</strong><br/>" + TMP2[25] + "</a></td>";
                    STR_ = STR_ + "<td><strong>" + TMP2[13] + "</strong><br />" + TMP2[14] + "</td>";
                    STR_ = STR_ + "<td>AM: " + TMP2[8] + "<br />BM: " + TMP2[11] + "</td>";
                    STR_ = STR_ + "<td>" + engineers + "</td>";
                    STR_ = STR_ + "<td>" + TMP2[47] + "</td>";

                    STR_ = STR_ + "</tr>";
                    $('#tb_approve tr:last').after(STR_);
                }
                /*END BIND ADD REQEST DATA*/
            }
        });
    }
}


function send_csi(jid) {
    if (confirm('ท่านต้องการส่ง SMS แจ้งให้ลูกค้าประเมินความพึงพอใจ ใช่หรือไม่')) {
        $.post(serverAJAXpath, { feature: "send_csi", job_id: jid }).done(function (data) {
            alert(data);
        });
    }
}

/*</Utility Function>*/
//}