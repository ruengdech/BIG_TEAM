<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />

    <link href="../sys01/themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../sys01/themes/jquery-1.11.1.min.js"></script>
    <script src="../sys01/themes/jquery.mobile-1.4.5.min.js"></script>
	<style>
	    .center {
		  margin: auto !important;
		  text-align: center !important;
            top: 0px;
            left: 0px;
        }	 
	    .auto-style1 {
            width: 641px;
            height: 437px;
        }	 
	</style>
</head>
<body>
	<div data-role="page" id="page_main">		
		<div data-role="header" style="background-color:#1294A6!important;border-color:#43bf79!important;text-shadow:none;">
			<center>
			<div style="min-height:50px;display:inline;">
				<img class="auto-style1" src="../img/header.PNG" style="display:inline; vertical-align:middle;  width:100%; height:90%"/>
            </div>
			</center>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
			<div class="ui-grid-solo ui-responsive">
				<div class="ui-bar ui-bar-d center">
						<h3>ลงทะเบียนพนักงาน</h3>
				</div>
				<div class="ui-grid-a ui-responsive">
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_id">รหัสพนักงาน:</label>
                            <input type="text" name="txt_id" id="txt_id" placeholder="Staff ID"/>
							<a href="#" class="ui-btn" onclick="staff_check()">ตรวจสอบ</a>
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_line">LINE ID</label>
							<input type="text" name="txt_line" id="txt_line" readonly="readonly"/>
					</div>
				</div>
				<div class="ui-grid-a ui-responsive" id="div_staff">
                    
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_name">ชื่อ:</label>
                            <input type="text" name="txt_name" id="txt_name" readonly="readonly"/>
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_lname">นามสกุล:</label>
                            <input type="text" name="txt_lname" id="txt_lname" readonly="readonly"/>
					</div>
                    
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_email">Email:</label>
                            <input type="text" name="txt_email" id="txt_email" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_mob">เบอร์มือถือ:</label>
                            <input type="text" name="txt_mob" id="txt_mob"  readonly="readonly"/>
					</div>
                    
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_position">ตำแหน่ง:</label>
                            <input type="text" name="txt_position" id="txt_position"  readonly="readonly"/>
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_otp">OTP:</label>
                            <input type="text" name="txt_otp" id="txt_otp" />
                            <input type="text" name="txt_sotp" id="txt_sotp"  style="display:none;"/>
					</div>

					<div class="ui-grid-solo ui-responsive">
						<a href="#" class="ui-btn" onclick="bt_otp_click()" id="bt_otp">ส่ง OTP เพื่อยืนยัน</a>
						<a href="#" class="ui-btn" onclick="bt_save_click()" id="bt_save">ยืนยัน</a>
						<a href="#" class="ui-btn" onclick="bt_clear_click()" id="bt_clear">ล้างข้อมูล</a>
					</div>
				</div>
			</div>
				
		
		</div><!-- /content -->
	</div><!-- /page -->
</body>
</html>
<script src="../JS/sys05.staff.js"></script>
