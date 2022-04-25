//import { format } from "util";

var serverAJAXpath = "../sys01/myServer/sys01.aspx";
/*<Control variable> */
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
var ctrl_bt_submit = $("#bt_submit");

var MAIN_SCORE = "-1";
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
        $("#tb_history tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        $(".tr_main").show();
    });

    $.post(serverAJAXpath, { feature: "getAM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_am.append("<option value=''> เลือก AM </option>");
        $("#p_assign_sel_am").append("<option value=''> เลือก AM </option>");
        for (i = 0; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_am.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        ctrl_sel_am.selectmenu('refresh', true);
    });

    $.post(serverAJAXpath, { feature: "getBM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_bm.append("<option value=''> เลือก BM </option>");
        for (i = 0; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_bm.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        ctrl_sel_bm.selectmenu('refresh', true);
    });

    $.post(serverAJAXpath, { feature: "getRequest", STAFF_ID: STAFF_ID, PAGE_REQUEST: "STAFF" }).done(function (data) {
        /*BIND ADD REQEST DATA*/
        if (data.indexOf("FAIL") === -1) {
            var TMP = data.split("^");
            for (i = 0; i < TMP.length; i++) {
                var TMP2 = TMP[i].split("|");
                var STR_ = "<tr>";

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
            setTimeout(function () {
                var singleid = getUrlParameter('id');
                try {
                    if (typeof singleid !== 'undefined') {
                        for (i = 0; i < JOB_DATA.length; i++) {
                            if (JOB_DATA[i][0] === singleid) {
                                prepareDetail(i);
                                setTimeout($.mobile.navigate("#page_detail"), 500);
                            }
                        }

                    }
                }
                catch (err) {
                    //DONOTHING
                }
            }, 1000);
        }
    });

    try {
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
    }
    catch (errorss) {

    }

    //setTimeout(goto_detail(), 1000);
    
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

ctrl_bt_submit.click(function () {
    var validCreate = f_validateCreate('new');
    if (validCreate == true) {
        ctrl_bt_submit.hide();
        $.post(serverAJAXpath, {
            feature: "createJOB"
            , ctrl_txt_staffId: ctrl_txt_staffId.val()
            , ctrl_txt_name: ctrl_txt_name.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_lname: ctrl_txt_lname.val()
            , ctrl_txt_mobile: ctrl_txt_mobile.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_email: ctrl_txt_email.val().replace("'", "|").replace('"', '^')
            , ctrl_sel_am: ctrl_sel_am.val()
            , ctrl_sel_bm: ctrl_sel_bm.val()
            , ctrl_txt_location: ctrl_txt_location.val().replace("'", "|").replace('"', '^')
            , ctrl_txt_dept: ctrl_txt_dept.val().replace("'", "|").replace('"', '^')
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
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                ctrl_txt_name.val("");
                ctrl_txt_lname.val("");
                ctrl_txt_mobile.val("");
                ctrl_txt_email.val("");
                $.mobile.changePage("#page_thankyou", { transition: "slideup", changeHash: false });
                ctrl_bt_submit.show();
                REFRESH_DATA();
            } else {
                alert("เกิดข้อผิดพลาดในระบบ");
                ctrl_bt_submit.show();
            }
        });
    }       
});

//ctrl_txt_date.minDate(dateToday);
//ctrl_txt_date.datepicker.minDate(dateToday);


/*</Action>*/

/*<Utility Function>*/
function goto_detail() {
    var uid = '';
    uid = getUrlParameter('id');
    if (uid !== "") {
        for (i = 0; i < JOB_DATA.length; i++) {
            if (JOB_DATA[i][0] == uid) {
                prepareDetail(i);
                setTimeout($.mobile.navigate("#page_detail"), 1000);
            }
        }
    }
}

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

function prepareDetail(row) {

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
    MSG = MSG + pre_ + "วันที่แจ้ง : " + mid_ + JOB_DATA[row][48] + post_;

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
    MSG = MSG + "<tr><th colspan=\"2\"><b>สถานะของงาน</b> [" + JOB_DATA[row][47] + "[</th></tr>";
    MSG = MSG + pre2_ + "วันที่คาดว่าจะดำเนินการ [ปี-เดือน-วัน] : " + mid_ + JOB_DATA[row][57] + " - " + JOB_DATA[row][58] + post_;
    MSG = MSG + pre_ + "วันที่ดำเนินการจริง [ปี-เดือน-วัน] : " + mid_ + JOB_DATA[row][41] + " - " + JOB_DATA[row][42] + post_;
    MSG = MSG + pre2_ + "รายเอียด : " + mid_ + JOB_DATA[row][71] + post_;
    MSG = MSG + pre_ + "ผู้ได้รับมอบหมายงาน : " + mid_ + "1. " + JOB_DATA[row][57] ;
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
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",'1');\" class=\"fa fa-star star1\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",'2');\" class=\"fa fa-star star2\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",'3');\" class=\"fa fa-star star3\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",'4');\" class=\"fa fa-star star4\" ></span>";
        MSG = MSG + "<span onclick =\"rate_job(" + JOB_DATA[row][0] + "," + i + ",'5');\" class=\"fa fa-star star5\" ></span>";
        MSG = MSG + post_;
        //MSG = MSG + "<tr><th colspan='2'> คลิกเพื่อดูรายละเอียด</a></th></tr>";
        MSG = MSG + "<tr><th colspan=\"2\"><textarea cols=\"40\" rows=\"4\" name=\"txt_score_comment\" id=\"txt_score_comment\" >" + JOB_DATA[row][67] + "</textarea></th></tr>";
        MSG = MSG + "<tr><th colspan=\"2\"><button class=\"ui-btn ui-btn-active\" id =\"bt_submit_score\" onclick=\"updateSastisfySubmit(" + JOB_DATA[row][0] + ")\">บันทึกความพึงพอใจ</button></th></tr>";
    } 
    
    MSG = MSG + "</table></center></body></html>";
    $("#div_detail").html(MSG);

    if (JOB_DATA[row][75] != "WAIT FOR APPROVE") {
        $("#bm_approve").hide();
    }
}

function prepareDetailAssign(uid) {
    var row = 0;
    for (i = 0; i < JOB_DATA.length; i++) {
        if (JOB_DATA[i][0] === uid) {
            row = i;
        }
    }
    $("#p_assign_uid").val(uid);
    $("#p_assign_submitDate").val(JOB_DATA[row][48]);
    $("#p_assign_txt_staffId").val(JOB_DATA[row][2]);
    $("#p_assign_txt_name").val(JOB_DATA[row][3]);
    $("#p_assign_txt_lname").val(JOB_DATA[row][4]);
    $("#p_assign_txt_mobile").val(JOB_DATA[row][6]);
    $("#p_assign_txt_email").val(JOB_DATA[row][5]);
    //$('[name=p_assign_sel_am]').val(JOB_DATA[row][7]);
    //$('[name=p_assign_sel_bm]').val(JOB_DATA[row][10]);
    $("#p_assign_txt_location").val(JOB_DATA[row][13]);
    $("#p_assign_txt_dept").val(JOB_DATA[row][14]);
    $("#p_assign_txt_contact").val(JOB_DATA[row][15]);
    $("#p_assign_txt_contactTel").val(JOB_DATA[row][16]);
    $("#p_assign_txt_date").val(JOB_DATA[row][17]);
    $("#p_assign_txt_time").val(JOB_DATA[row][18]);
    $("#p_assign_txt_contract").val(JOB_DATA[row][19]);
    $("#p_assign_txt_job1").val(JOB_DATA[row][25]);
    $("#p_assign_txt_job2").val(JOB_DATA[row][26]);
    $("#p_assign_txt_job3").val(JOB_DATA[row][27]);
    $("#p_assign_txt_assign_date").val(JOB_DATA[row][31]);
    var current = new Date();
    $("#p_assign_txt_assign_date").val(current.toLocaleString());
    $("#p_assign_div_engineer").hide();
    $("#p_assign_sel_staff1").val(JOB_DATA[row][37]).selectmenu('refresh', true);
    $("#p_assign_sel_staff2").val(JOB_DATA[row][38]).selectmenu('refresh', true);
    $("#p_assign_sel_staff3").val(JOB_DATA[row][39]).selectmenu('refresh', true);
    $("#p_assign_sel_staff4").val(JOB_DATA[row][40]).selectmenu('refresh', true);
    $("#p_assign_txt_date_start").hide();
    $("#p_assign_txt_date_end").hide();
    $("#p_assigned_attached").hide();
    /*
    $("#p_assign_txt_date_start").val(JOB_DATA[row][41]);
    $("#p_assign_txt_date_end").val(JOB_DATA[row][42]);
    $("#p_assigned_attached").html(JOB_DATA[row][2]);
    */

    $("#p_assign_sel_am").val(JOB_DATA[row][7]).selectmenu('refresh',true);
    $("#p_assign_sel_bm").val(JOB_DATA[row][10]).selectmenu('refresh', true);
    $("#p_assign_sel_pm").val(JOB_DATA[row][20]).selectmenu('refresh', true);
    $("#p_assign_sel_warantee").val(JOB_DATA[row][21]).selectmenu('refresh', true);
    $("#p_assign_sel_job1").val(JOB_DATA[row][22]).selectmenu('refresh', true);
    $("#p_assign_sel_job2").val(JOB_DATA[row][23]).selectmenu('refresh', true);
    $("#p_assign_sel_job3").val(JOB_DATA[row][24]).selectmenu('refresh', true);
    $("#p_assign_sel_staff").val(JOB_DATA[row][32]).selectmenu('refresh', true);
    $("#p_assign_sel_staff").val(JOB_DATA[row][32]).selectmenu('refresh', true);

}

function REFRESH_DATA() {
    $('#tb_history').find("tr:gt(0)").remove();
    JOB_DATA = [];

    $.post(serverAJAXpath, { feature: "getRequest", STAFF_ID: STAFF_ID, PAGE_REQUEST: "STAFF"  }).done(function (data) {
        /*BIND ADD REQEST DATA*/
        var TMP = data.split("^");
        for (i = 0; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            var STR_ = "<tr>";

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
    });
}

function rate_job(jid, rows, jscore) {   
    MAIN_SCORE = jscore;
    $(".star1").removeClass("fa-star-active");
    $(".star2").removeClass("fa-star-active");
    $(".star3").removeClass("fa-star-active");
    $(".star4").removeClass("fa-star-active");
    $(".star5").removeClass("fa-star-active");
    if (jscore === '5') {
        $(".star1").addClass("fa-star-active");
        $(".star2").addClass("fa-star-active");
        $(".star3").addClass("fa-star-active");
        $(".star4").addClass("fa-star-active");
        $(".star5").addClass("fa-star-active");
    }
    if (jscore === '4') {
        $(".star1").addClass("fa-star-active");
        $(".star2").addClass("fa-star-active");
        $(".star3").addClass("fa-star-active");
        $(".star4").addClass("fa-star-active");
    }
    if (jscore === '3') {
        $(".star1").addClass("fa-star-active");
        $(".star2").addClass("fa-star-active");
        $(".star3").addClass("fa-star-active");
    }
    if (jscore === '2') {
        $(".star1").addClass("fa-star-active");
        $(".star2").addClass("fa-star-active");
    }
    if (jscore === '1') {
        $(".star1").addClass("fa-star-active");
    }
}

function updateSastisfySubmit(jid) {
    var comment_ = $("#txt_score_comment").val().replace("'", "|").replace('"', '^');
    $.post(serverAJAXpath, { feature: "rateJOB", job_id: jid, job_score: MAIN_SCORE, comment_: comment_ }).done(function (data) {
        if (data.indexOf("SUCCESS") !== -1) {
            REFRESH_DATA();
            confirm("ขอบพระคุณสำหรับการให้คะแนนความพึงพอใจ\nเราสัญญาว่าเราจะพัฒนาไม่หยุด");
            $.mobile.changePage("#page_thankyou", { transition: "slideup", changeHash: false });
        } else {
            alert("เกิดข้อผิดพลาดในระบบ");
        }
    });
}

function confirm_bm(res, jid) {
    $.post(serverAJAXpath, { feature: "bm_confirmJOB", job_id: jid, bm_result: res }).done(function (data) {
        if (data.indexOf("SUCCESS") !== -1) {
            REFRESH_DATA();
            goto_detail();
            confirm("ขอบคุณสำหรับการยืนยัน");
            location.reload();
            //$.mobile.changePage("#page_thankyou", { transition: "slideup", changeHash: false });
        } else {
            alert("เกิดข้อผิดพลาดในระบบ");
        }
    });
}


/*</Utility Function>*/

//}