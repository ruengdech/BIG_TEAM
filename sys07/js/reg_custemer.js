var api_url = "../api.aspx";
var prov = [];
var dist = [];
var sdist = [];


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

$("#txt_zip").keyup(function () {
    if ($("#txt_zip").val().length >= 5) {
        $.post(api_url, { param: "get_data_from_postcode", post: $("#txt_zip").val() }).done(function (data) {
            my_data = JSON.parse(data);
            jQuery.each(my_data, function () {
                $("#txt_province").val(this.PROVINCENAME);
                $("#txt_district").val(this.DISTRICTNAME);
                $("#txt_sdistrict").val(this.SUBDISTRICTNAME);
                sdist.push(this.SUBDISTRICTNAME);
            });
            $("#txt_sdistrict").autocomplete({source:sdist});
        });
    }
    
});


$("#txt_id").keyup(function () {
    check_customer();
});

function check_customer() {
    if ($("#txt_id").val().length >= 10) {
        $.post(api_url, { param: "get_customer_from_id", tax: $("#txt_id").val() }).done(function (data) {
            my_data = JSON.parse(data);
            jQuery.each(my_data, function () {
                var CUSTOMER = JSON.parse(data);
                jQuery.each(CUSTOMER, function () {
                    if (this.SAP == 'TRUE' && this.SYS03 == 'TRUE') {
                        //Have data both SAP and SYS03
                        //UID, CardCode, TAXID, LINEID, CUSTOMER_NAME, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, STATUS
                        $("#txt_name").val(this.CUSTOMER_NAME);
                        $("#txt_email").val(this.C_EMAIL);
                        $("#txt_mob1").val(this.CUSTOMER_MOB);
                        $("#txt_mob2").val(this.CUSTOMER_MOB2);
                        $("#txt_addr1").val(this.C_Address1);
                        $("#txt_addr2").val(this.C_Address2);
                        $("#txt_zip").val(this.C_ZIP);
                        $("#txt_province").val(this.C_PROVINCE);
                        $("#txt_district").val(this.C_DISTRICT);
                        $("#txt_sdistrict").val(this.C_SUBDISTRICT);
                        $("#sap_id").val(this.CardCode);
                        $("#sys_id").val(this.UID);
                        return;
                    } else if (this.SAP == 'TRUE' && this.SYS03 == 'FALSE') {
                        //Have data in SAP only
                        //CardCode, CardName, GlblLocNum, Phone1, Phone2, Building, Address2, Address3, Street, Block, ZipCode, City, County, Country , province
                        $("#txt_name").val(this.CardName);
                        $("#txt_email").val("");
                        $("#txt_mob1").val(this.Phone1);
                        $("#txt_mob2").val(this.Phone2);
                        $("#txt_addr1").val(this.Building);
                        $("#txt_addr2").val(this.Address2);
                        $("#txt_zip").val(this.ZipCode);
                        $("#txt_province").val(this.province);
                        $("#txt_district").val(this.County);
                        $("#txt_sdistrict").val(this.City);
                        $("#sap_id").val(this.CardCode);
                        $("#sys_id").val("");
                        return;
                    } else if (this.SAP == 'FALSE' && this.SYS03 == 'TRUE') {
                        //Have data in SYS03 only
                        //UID, CardCode, TAXID, LINEID, CUSTOMER_NAME, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, STATUS
                        $("#txt_name").val(this.CUSTOMER_NAME);
                        $("#txt_email").val(this.C_EMAIL);
                        $("#txt_mob1").val(this.CUSTOMER_MOB);
                        $("#txt_mob2").val(this.CUSTOMER_MOB2);
                        $("#txt_addr1").val(this.C_Address1);
                        $("#txt_addr2").val(this.C_Address2);
                        $("#txt_zip").val(this.C_ZIP);
                        $("#txt_province").val(this.C_PROVINCE);
                        $("#txt_district").val(this.C_DISTRICT);
                        $("#txt_sdistrict").val(this.C_SUBDISTRICT);
                        $("#sap_id").val(this.CardCode);
                        $("#sys_id").val(this.UID);
                        return;
                    } else {
                        //Have either data in both SAP and SYS03
                        //Do nothing
                        return;
                    }

                });
            });
        });
    }
}

function bt_clear_click() {
    $("#txt_name").val("");
    $("#txt_email").val("");
    $("#txt_mob1").val("");
    $("#txt_mob2").val("");
    $("#txt_addr1").val("");
    $("#txt_addr2").val("");
    $("#txt_zip").val("");
    $("#txt_province").val("");
    $("#txt_district").val("");
    $("#txt_sdistrict").val("");
    $("#sap_id").val("");
    $("#sys_id").val("");
    $("#txt_id").val("");
}

function bt_save_click() {
    if (validate_form()) {
        $.post(api_url, {
            param: "set_customer"
            , txt_id: $("#txt_id").val()
            , txt_line: $("#txt_line").val()
            , txt_name: $("#txt_name").val()
            , txt_email: $("#txt_email").val()
            , txt_mob1: $("#txt_mob1").val()
            , txt_mob2: $("#txt_mob2").val()
            , txt_addr1: $("#txt_addr1").val()
            , txt_addr2: $("#txt_addr2").val()
            , txt_zip: $("#txt_zip").val()
            , txt_province: $("#txt_province").val()
            , txt_district: $("#txt_district").val()
            , txt_sdistrict: $("#txt_sdistrict").val()
            , sap_id: $("#sap_id").val()
            , sys_id: $("#sys_id").val()

        }).done(function (data) {
            var res = data.split(":");
            if (res[0] == "SUCCESS") {
                //Success
                if (confirm("ขอบคุณสำหรับการลงทะเบียน") == true) {
                    //https://www.w3schools.com/js/js_cookies.asp
                    window.location.href = "view_customer.aspx?hash=" + $("#txt_id").val() + "c" + create_UUID();
                    //window.location(window.location.hostname + "/sys07/view_customer.aspx?hash=" + $("#txt_id").val() + "c" + create_UUID());
                } else {
                    //window.location(window.location.hostname + "/sys07/view_customer.aspx?hash=" + $("#txt_id").val() + "c" + create_UUID());
                    window.location.href = "view_customer.aspx?hash=" + $("#txt_id").val() + "c" + create_UUID();
                }
            } else {
                //Fail
                alert(res[1] + " ไม่สามารถทำได้ กรุณาลองใหม่");
            }
            
        });
    }
}

function validate_form() {

    if ($("#txt_id").val().length < 10) {
        alert("กรุณาระบุเลขบัตร/เลขที่เสียภาษี");
        $("#txt_id").focus();
        return false;
    } else if ($("#txt_name").val().length < 3) {
        alert("กรุณาระบุชื่อ/ชื่อบริษัทของท่าน");
        $("#txt_name").focus();
        return false;
    } else if ($("#txt_mob1").val().length < 9) {
        alert("กรุณาระบุเบอร์มือถือของท่าน");
        $("#txt_mob1").focus();
        return false;
    } else if ($("#txt_addr1").val().length < 2) {
        alert("กรุณาระบุที่อยู่ของท่าน");
        $("#txt_addr1").focus();
        return false;
    }

    return true;
}


function setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    let name = cname + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function create_UUID() {
    var dt = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (dt + Math.random() * 16) % 16 | 0;
        dt = Math.floor(dt / 16);
        return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
}


function prepare_view(type_) {
    if (type_ == "view") {
        var id = de(getUrlParameter("hash"));
        $("#txt_id").val(id);
        check_customer();
        $("#sap_id").hide();
        $("#sys_id").hide();
        $("#txt_line").hide();

        $("#bt_save").hide();
        $("#bt_clear").hide();
        $("#bt_edit").show();

        set_readonly(true);

    } else if (type_ == "insert") {
        var id = getUrlParameter("lid");
        $("#txt_line").val(id);
        $("#txt_line").hide();
    }
}


function de(str_in) {
    var tmp = str_in.substring(0, str_in.indexOf("c"));
    return tmp;
}

function bt_edit_click() {
    set_readonly(false);

    $("#bt_save").show();
    $("#bt_clear").show();
    $("#bt_edit").hide();
}

function bt_cancel_click() {
    set_readonly(true);

    $("#bt_save").hide();
    $("#bt_clear").hide();
    $("#bt_edit").show();
}

function set_readonly(is_true) {
    $("#txt_name").prop("readonly", is_true);
    $("#txt_email").prop("readonly", is_true);
    $("#txt_mob1").prop("readonly", is_true);
    $("#txt_mob2").prop("readonly", is_true);
    $("#txt_addr1").prop("readonly", is_true);
    $("#txt_addr2").prop("readonly", is_true);
    $("#txt_zip").prop("readonly", is_true);
    $("#txt_province").prop("readonly", is_true);
    $("#txt_district").prop("readonly", is_true);
    $("#txt_sdistrict").prop("readonly", is_true);
}