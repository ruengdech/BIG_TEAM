var serverAJAXpath = "Server/sys05.aspx";
/*<Control variable> */
var ctrl_txt_id = $("#txt_id");
var ctrl_txt_name = $("#txt_name");
var ctrl_txt_lname = $("#txt_lname");
var ctrl_txt_line = $("#txt_line");
var ctrl_txt_mob = $("#txt_mob");
var ctrl_txt_email = $("#txt_email");
var ctrl_txt_position = $("#txt_position");
var ctrl_txt_otp = $("#txt_otp");
var ctrl_txt_sotp = $("#txt_sotp");

//var ctrl_bt_save = $("#bt_save");
//var ctrl_bt_otp = $("#bt_otp");
//var ctrl_bt_clear = $("#bt_clear");
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
    ctrl_txt_line.val(getUrlParameter("line"));
    clear_form();
});

ctrl_txt_id.change(function () {
    staff_check();
});

function staff_check() {
    /*Even on txt Change*/
    if (ctrl_txt_id.val().length > 4) {
        $.post(serverAJAXpath, {
            feature: "staff_search"
            , ctrl_txt_id: ctrl_txt_id.val()
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                var TMP = data.split("|");

                ctrl_txt_name.val(TMP[2]);
                ctrl_txt_lname.val(TMP[3]);
                ctrl_txt_mob.val(TMP[4].replaceAll("-",""));
                ctrl_txt_email.val(TMP[5]);
                ctrl_txt_position.val(TMP[6]);

                show_form();
            } else {
                /*ไม่พบข้อมูล*/
                clear_form();
            }
        });
        /*
        Response.Write("SUCCESS")
        Response.Write("|" & .Item("uid").ToString())
        Response.Write("|" & .Item("name").ToString())
        Response.Write("|" & .Item("lastname").ToString())
        Response.Write("|" & .Item("mobile").ToString())
        Response.Write("|" & .Item("emloffice").ToString())
        Response.Write("|" & .Item("positions").ToString())
        */
    } else {
        clear_form();
    }
}

/*</Initial Load>*/


/*<Action>*/
function bt_save_click () {
    if (validate_submit()) {
        if (ctrl_txt_otp.val() == ctrl_txt_sotp.val()) {
            /*Validate OTP Match*/
                $.post(serverAJAXpath, {
                    feature: "save_staff"
                    , ctrl_txt_id: ctrl_txt_id.val().replace("'", "|").replace('"', '^')
                    , ctrl_txt_line: ctrl_txt_line.val().replace("'", "|").replace('"', '^')
                }).done(function (data) {
                    if (data.indexOf("SUCCESS") !== -1) {
                        if (confirm("บันทึกสำเร็จ เชิญเข้าสู่ LINE SMD")) {
                            window.location = "https://saintmed.dyndns.biz/line/img/main.aspx?msg=STAFF&line=saintmed";
                            //location.reload();
                        } else {
                            location.reload();
                        }
                    } else {
                        alert("เกิดข้อผิดพลาดในระบบ");
                    }
                });
            /* /Validate OTP Match*/
        } else {
            alert("รหัส OTP ไม่ถูกต้องกรุณาตรวจสอบ");
        }
    }
}
function bt_otp_click () {
    if (validate_submit()) {
        $.post(serverAJAXpath, {
            feature: "send_otp"
            , ctrl_txt_id: ctrl_txt_id.val().replaceAll("'", "|").replaceAll('"', '^')
            , ctrl_txt_mob: ctrl_txt_mob.val().replaceAll("'", "|").replaceAll(' ', '').replaceAll('-', '')
        }).done(function (data) {
            if (data.indexOf("SUCCESS") !== -1) {
                alert("กรุณาตรวจสอบ OTP ที่ SMS มือถือเบอร์ " + ctrl_txt_mob.val().replace("'", "|").replace('"', '^') + "\n\nเพื่อนำมากรอกในช่อง OTP")
                TMP = data.split("|");                
                ctrl_txt_sotp.val(TMP[1]);
                ctrl_txt_otp.focus();
                $("#bt_otp").hide();
                $("#bt_save").show();
                $("#bt_clear").show();
            } else {
                alert("เกิดข้อผิดพลาดในระบบ ไม่สามารถส่ง SMS ไปยัง " + ctrl_txt_mob.val() + " ได้สำเร็จ");
                ctrl_bt_clear.show();
            }
        });
    }
}
function bt_clear_click() {
    clear_form();
    
}

function validate_submit() {
    //Validate nothing
    if (ctrl_txt_name.val().length < 2) {
        alert("กรุณากรอกรหัสพนักงานให้ถูกต้อง")
        ctrl_txt_id.focus()
        return false;
    }

    if (ctrl_txt_mob.val().length < 2) {
        alert("กรุณากรอกเบอร์มือถือ")
        ctrl_txt_mob.focus()
        return false;
    }

    if (ctrl_txt_email.val().length < 2) {
        alert("กรุณากรอกอีเมล์")
        ctrl_txt_email.focus()
        return false;
    }
    return true;
}
function clear_form() {
    ctrl_txt_name.val('');
    ctrl_txt_lname.val('');
    ctrl_txt_mob.val('');
    ctrl_txt_email.val('');
    ctrl_txt_position.val('');

    $("#div_staff").hide();
    $("#bt_otp").hide();
    $("#bt_save").hide();
    $("#bt_clear").hide();
}

function show_form() {
    $("#bt_otp").show();
    $("#bt_clear").show();
    $("#div_staff").show();
}
/*</Custom Function>*/