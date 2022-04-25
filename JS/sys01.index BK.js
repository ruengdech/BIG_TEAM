
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
/*</Control variable> */


/*<Initial Load>*/

$.post(serverAJAXpath, { feature: "getRequest" }).done(function (data) {
    /*Bind History Data*/
    var TMP = data.split("^");    
    for (i = 0; i < TMP.length; i++) {
        var TMP2 = TMP[i].split("|");
        var STR_ = "<tr>";

        STR_ = STR_ + "<td>" + TMP2[0] + "</td>";
        STR_ = STR_ + "<td>" + TMP2[1] + "<br/>" + TMP2[3] + " " + TMP2[4] + "</td>";
        STR_ = STR_ + "<td><a href='#page_detail' data-transition='slidefade' onclick='prepareDetail(" + i + ");'><strong>" + TMP2[23] + "</strong><br/>" +  TMP2[25] + "</a></td>";
        STR_ = STR_ + "<td><strong>" + TMP2[13] + "</strong><br />" + TMP2[14] + "</td>";
        STR_ = STR_ + "<td>AM: " + TMP2[8] + "<br />BM: " + TMP2[11] + "</td>";
        STR_ = STR_ + "<td>" + TMP2[47]  + "</td>";

        STR_ = STR_ + "</tr>";

        $('#tb_history tr:last').after(STR_);
        JOB_DATA.push(TMP2);
    }
    //BIND WAIT FOR ASSIGN
    for (j = 0; j < JOB_DATA.length; j++) {
        if (JOB_DATA[j][47] === "new") {
            var STR_ = "<tr>";

            STR_ = STR_ + "<td>" + JOB_DATA[j][0] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][1] + "<br/>" + JOB_DATA[j][3] + " " + JOB_DATA[j][4] + "</td>";
            STR_ = STR_ + "<td><a href='#page_assigndetail' data-transition='pop' onclick=\"prepareDetailAssign('" + JOB_DATA[j][0] + "');\"><strong>" + JOB_DATA[j][23] + "</strong><br/>" + JOB_DATA[j][25] + "</a></td>";
            STR_ = STR_ + "<td><strong>" + JOB_DATA[j][13] + "</strong><br />" + JOB_DATA[j][14] + "</td>";
            STR_ = STR_ + "<td>AM: " + JOB_DATA[j][8] + "<br />BM: " + JOB_DATA[j][11] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][47] + "</td>";

            STR_ = STR_ + "</tr>";

            $('#tb_list_waitassign tr:last').after(STR_);
        } else {
            var STR_ = "<tr>";

            STR_ = STR_ + "<td>" + JOB_DATA[j][0] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][1] + "<br/>" + JOB_DATA[j][3] + " " + JOB_DATA[j][4] + "</td>";
            STR_ = STR_ + "<td><a href='#page_assigndetail' data-transition='pop' onclick=\"prepareDetailAssign('" + JOB_DATA[j][0] + "');\"><strong>" + JOB_DATA[j][23] + "</strong><br/>" + JOB_DATA[j][25] + "</a></td>";
            STR_ = STR_ + "<td><strong>" + JOB_DATA[j][13] + "</strong><br />" + JOB_DATA[j][14] + "</td>";
            STR_ = STR_ + "<td>AM: " + JOB_DATA[j][8] + "<br />BM: " + JOB_DATA[j][11] + "</td>";
            STR_ = STR_ + "<td>1.  " + JOB_DATA[j][37] + "</td>";
            if (JOB_DATA[j][38].length > 3) { STR_ = STR_ + "<br />2.  " + JOB_DATA[j][38]; }
            if (JOB_DATA[j][39].length > 3) { STR_ = STR_ + "<br />3.  " + JOB_DATA[j][39]; }
            if (JOB_DATA[j][40].length > 3) { STR_ = STR_ + "<br />4.  " + JOB_DATA[j][40]; }
            STR_ = STR_ + "<td>" + JOB_DATA[j][47] + "</td>";

            STR_ = STR_ + "</tr>";

            $('#tb_list_assigned tr:last').after(STR_);
        }
    }


    //BIND ENGINEER LIST
    for (j = 0; j < JOB_DATA.length; j++) {
        if (JOB_DATA[j][47] === "assign") {
            var STR_ = "<tr>";

            STR_ = STR_ + "<td>" + JOB_DATA[j][0] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][1] + "<br/>" + JOB_DATA[j][3] + " " + JOB_DATA[j][4] + "</td>";
            STR_ = STR_ + "<td><a href='#page_assigndetail' data-transition='pop' onclick=\"prepareDetailAssign('" + JOB_DATA[j][0] + "');\"><strong>" + JOB_DATA[j][23] + "</strong><br/>" + JOB_DATA[j][25] + "</a></td>";
            STR_ = STR_ + "<td><strong>" + JOB_DATA[j][13] + "</strong><br />" + JOB_DATA[j][14] + "</td>";
            STR_ = STR_ + "<td>AM: " + JOB_DATA[j][8] + "<br />BM: " + JOB_DATA[j][11] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][47] + "</td>";

            STR_ = STR_ + "</tr>";

            $('#tb_list_waitstart tr:last').after(STR_);
        } else if (JOB_DATA[j][47] !== "new") {
            var STR_ = "<tr>";

            STR_ = STR_ + "<td>" + JOB_DATA[j][0] + "</td>";
            STR_ = STR_ + "<td>" + JOB_DATA[j][1] + "<br/>" + JOB_DATA[j][3] + " " + JOB_DATA[j][4] + "</td>";
            STR_ = STR_ + "<td><a href='#page_assigndetail' data-transition='pop' onclick=\"prepareDetailAssign('" + JOB_DATA[j][0] + "');\"><strong>" + JOB_DATA[j][23] + "</strong><br/>" + JOB_DATA[j][25] + "</a></td>";
            STR_ = STR_ + "<td><strong>" + JOB_DATA[j][13] + "</strong><br />" + JOB_DATA[j][14] + "</td>";
            STR_ = STR_ + "<td>AM: " + JOB_DATA[j][8] + "<br />BM: " + JOB_DATA[j][11] + "</td>";
            STR_ = STR_ + "<td>1.  " + JOB_DATA[j][37] + "</td>";
            if (JOB_DATA[j][38].length > 3) { STR_ = STR_ + "<br />2.  " + JOB_DATA[j][38]; }
            if (JOB_DATA[j][39].length > 3) { STR_ = STR_ + "<br />3.  " + JOB_DATA[j][39]; }
            if (JOB_DATA[j][40].length > 3) { STR_ = STR_ + "<br />4.  " + JOB_DATA[j][40]; }
            STR_ = STR_ + "<td>" + JOB_DATA[j][47] + "</td>";

            STR_ = STR_ + "</tr>";

            $('#tb_list_engineer tr:last').after(STR_);
        }
    }
    /*END Bind History Data*/

    var singleid = getUrlParameter('id');
    try {
        if (typeof singleid !== 'undefined') {
            for (i = 0; i < JOB_DATA.length; i++) {
                if (JOB_DATA[i][0] === singleid) {
                    prepareDetail(i);
                }
            }

        }
    }
    catch (err) {
        //DONOTHING
    }
});


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
    });

    $("#txt_search_assigned").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#tb_list_assigned tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });


    $.post(serverAJAXpath, { feature: "getAM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_am.append("<option value=''> เลือก AM </option>");
        $("#p_assign_sel_am").append("<option value=''> เลือก AM </option>");
        for (i = 1; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_am.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            $("#p_assign_sel_am").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        ctrl_sel_am.selectmenu('refresh', true);
        $("#p_assign_sel_am").selectmenu('refresh', true);

    });

    $.post(serverAJAXpath, { feature: "getBM" }).done(function (data) {
        var TMP = data.split("^");
        ctrl_sel_bm.append("<option value=''> เลือก BM </option>");
        $("#p_assign_sel_bm").append("<option value=''> เลือก BM </option>");
        for (i = 1; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            ctrl_sel_bm.append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            $("#p_assign_sel_bm").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
        ctrl_sel_bm.selectmenu('refresh', true);
        $("#p_assign_sel_bm").selectmenu('refresh', true);
    });

    $.post(serverAJAXpath, { feature: "getENGINEER" }).done(function (data) {
        var TMP = data.split("^");
        $("#p_assign_sel_staff1").append("<option value='0'> เลือกช่าง </option>");
        $("#p_assign_sel_staff2").append("<option value='0'> เลือกช่าง </option>");
        $("#p_assign_sel_staff3").append("<option value='0'> เลือกช่าง </option>");
        $("#p_assign_sel_staff4").append("<option value='0'> เลือกช่าง </option>");
        for (i = 1; i < TMP.length; i++) {
            var TMP2 = TMP[i].split("|");
            $("#p_assign_sel_staff1").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            $("#p_assign_sel_staff2").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            $("#p_assign_sel_staff3").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
            $("#p_assign_sel_staff4").append("<option value='" + TMP2[1] + "'> " + TMP2[2] + " </option>");
        }
    });
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

$("#p_assign_txt_assignid").keyup(function () {
    var thisval = $("#p_assign_txt_assignid").val();
    if (thisval.length > 4) {
        $.post(serverAJAXpath, { feature: "getStaffByID", id: thisval }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");
                $("#p_assign_txt_assignname").val(TMP[2] + " " + TMP[3]);
            } else {
                $("#p_assign_txt_assignname").val("");
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
            feature: "createJOB"
            , ctrl_txt_staffId: ctrl_txt_staffId.val()
            , ctrl_txt_name: ctrl_txt_name.val()
            , ctrl_txt_lname: ctrl_txt_lname.val()
            , ctrl_txt_mobile: ctrl_txt_mobile.val()
            , ctrl_txt_email: ctrl_txt_email.val()
            , ctrl_sel_am: ctrl_sel_am.val()
            , ctrl_sel_bm: ctrl_sel_bm.val()
            , ctrl_txt_location: ctrl_txt_location.val()
            , ctrl_txt_dept: ctrl_txt_dept.val()
            , ctrl_txt_contact: ctrl_txt_contact.val()
            , ctrl_txt_contactTel: ctrl_txt_contactTel.val()
            , ctrl_txt_date: ctrl_txt_date.val()
            , ctrl_txt_time: ctrl_txt_time.val()
            , ctrl_txt_contract: ctrl_txt_contract.val()
            , ctrl_sel_pm: ctrl_sel_pm.val()
            , ctrl_sel_waranteen: ctrl_sel_waranteen.val()
            , ctrl_sel_job1: ctrl_sel_job1.val()
            , ctrl_sel_job2: ctrl_sel_job2.val()
            , ctrl_sel_job3: ctrl_sel_job3.val()
            , ctrl_txt_job1: ctrl_txt_job1.val()
            , ctrl_txt_job2: ctrl_txt_job2.val()
            , ctrl_txt_job3: ctrl_txt_job3.val()
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");
                ctrl_txt_name.val(TMP[1]);
                ctrl_txt_lname.val(TMP[2]);
                ctrl_txt_mobile.val(TMP[3]);
                ctrl_txt_email.val(TMP[4]);
            } else {
                ctrl_txt_name.val("");
                ctrl_txt_lname.val("");
                ctrl_txt_mobile.val("");
                ctrl_txt_email.val("");
            }
        });
    }       
});

$("#p_assign_bt_save").click(function () {
    var validCreate = f_validateCreate('assign');
    if (validCreate === true) {
        $.post(serverAJAXpath, {
            feature: "assignJOB"
            , job_id: $("#p_assign_uid").val()
            , ctrl_sel_am: $("#p_assign_sel_am").val()
            , ctrl_sel_bm: $("#p_assign_sel_bm").val()
            , ctrl_txt_location: $("#p_assign_txt_location").val()
            , ctrl_txt_dept: $("#p_assign_txt_dept").val()
            , ctrl_txt_contact: $("#p_assign_txt_contact").val()
            , ctrl_txt_contactTel: $("#p_assign_txt_contactTel").val()
            , ctrl_txt_date: $("#p_assign_txt_date").val()
            , ctrl_txt_time: $("#p_assign_txt_time").val()
            , ctrl_txt_contract: $("#p_assign_txt_contract").val()
            , ctrl_sel_pm: $("#p_assign_sel_pm").val()
            , ctrl_sel_waranteen: $("#p_assign_sel_warantee").val()
            , ctrl_sel_job1: $("#p_assign_sel_job1").val()
            , ctrl_sel_job2: $("#p_assign_sel_job2").val()
            , ctrl_sel_job3: $("#p_assign_sel_job3").val()
            , ctrl_txt_job1: $("#p_assign_txt_job1").val()
            , ctrl_txt_job2: $("#p_assign_txt_job2").val()
            , ctrl_txt_job3: $("#p_assign_txt_job3").val()
            , p_assign_sel_staff: $("#p_assign_sel_staff").val()
            , p_assign_sel_staff1: $("#p_assign_sel_staff1").val()
            , p_assign_sel_staff2: $("#p_assign_sel_staff2").val()
            , p_assign_sel_staff3: $("#p_assign_sel_staff3").val()
            , p_assign_sel_staff4: $("#p_assign_sel_staff4").val()
            , p_assign_txt_assignid: $("#p_assign_txt_assignid").val()
            , p_assign_txt_assignname: $("#p_assign_txt_assignname").val()
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                alert("SUCCESS");
            } else {
                alert("FAIL");
            }
        });
    }
});
/*</Action>*/

/*<Utility Function>*/
function f_validateCreate(stage) {
    if (stage === 'new') {
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
    } else if (stage === 'assign') {
        if ($("#p_assign_uid").val().length < 1 ) {
            alert("กรุณาเลือกรายการที่ต้องการแก้ไข");
            return false;
        }

        if ($("#p_assign_txt_assignid").val().length < 3 || $("#p_assign_txt_assignname").val().length < 3 ) {
            $("#p_assign_txt_assignid").focus();
            alert("กรุณากรอกข้อมูลพนักงานผู้ Assign งาน");
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
    MSG = MSG + pre2_ + "วันเวลาที่ต้องการให้ติดตั้ง : " + mid_ + JOB_DATA[row][17] + "  " + JOB_DATA[row][18] + post_;
    MSG = MSG + pre_ + "ผู้ติดต่อ : " + mid_ + JOB_DATA[row][15] + "  โทร " + JOB_DATA[row][16] + post_;
    MSG = MSG + pre2_ + "เลขที่สัญญา : " + mid_ + JOB_DATA[row][19] + post_;
    MSG = MSG + pre_ + "รอบ PM (ครั้ง/ปี) : " + mid_ + JOB_DATA[row][20] + post_;
    MSG = MSG + pre2_ + "ระยะเวลารับประกัน (ปี) : " + mid_ + JOB_DATA[row][21] + post_;
    MSG = MSG + pre_ + "ประเภทของงาน (1) : " + mid_ + JOB_DATA[row][22] + " <b>" + JOB_DATA[row][25] + "</b>" + post_;
    MSG = MSG + pre2_ + "ประเภทของงาน (2) : " + mid_ + JOB_DATA[row][23] + " <b>" + JOB_DATA[row][26] + "</b>" + post_;
    MSG = MSG + pre_ + "ประเภทของงาน (3) : " + mid_ + JOB_DATA[row][24] + " <b>" + JOB_DATA[row][27] + "</b>" + post_;
    MSG = MSG + pre2_ + "จำนวนวันทำงาน (ตาม Request): " + mid_ + JOB_DATA[row][52] + post_;

    
    //MSG = MSG + "<tr><th colspan='2'> คลิกเพื่อดูรายละเอียด</a></th></tr>";
    MSG = MSG + "</table></center></body></html>";
    $("#div_detail").html(MSG);
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

}


/*</Utility Function>*/

//}