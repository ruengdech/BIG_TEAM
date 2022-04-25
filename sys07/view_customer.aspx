<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CUSTOMER REGISTER</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../sys05/RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="../sys05/RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />

    <link href="../sys01/themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="../sys01/themes/jquery-1.11.1.min.js"></script>
    <%--<script src="../sys01/themes/jquery.mobile-1.4.5.min.js"></script>--%>
	<script src="../sys01/themes/jquery.mobile-1.4.5.js"></script>
    <script src="../JS/jquery-ui.js"></script>
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
						<h3>ลงทะเบียนลูกค้า</h3>
				</div>
				<div class="ui-grid-a ui-responsive">
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px; padding-top:10px;">
							<label for="txt_id">เลขที่บัตรประชาชน / เลขเสียภาษี:</label>
                            <input type="text" name="txt_id" id="txt_id" readonly="readonly"/>
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_line">LINE ID</label>
							<input type="text" name="txt_line" id="txt_line" readonly="readonly"/>
							<input type="text" name="txt_line" id="sap_id" style="display:none" readonly="readonly"/>
							<input type="text" name="txt_line" id="sys_id" style="display:none" readonly="readonly"/>
					</div>
				</div>
				<div class="ui-grid-a ui-responsive" id="div_staff">
                    
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_name">ชื่อ:</label>
                            <input type="text" name="txt_name" id="txt_name" />
					</div>
                    
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_email">Email:</label>
                            <input type="text" name="txt_email" id="txt_email" />
					</div>
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_mob1">เบอร์มือถือ 1:</label>
                            <input type="number" name="txt_mob1" id="txt_mob1" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_mob2">เบอร์มือถือ 2:</label>
                            <input type="number" name="txt_mob2" id="txt_mob2" />
					</div>
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_addr1">หมู่บ้าน/โครงการ/ซอย</label>
                            <input type="text" name="txt_addr1" id="txt_addr1" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_addr2">บ้านเลขที่:</label>
                            <input type="text" name="txt_addr2" id="txt_addr2"/>
					</div>
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_zip">รหัสไปรษณีย์:</label>
                            <input type="number" name="txt_zip" id="txt_zip" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_province">จังหวัด:</label>
                            <input type="text" name="txt_province" id="txt_province" />
					</div>
					<div class="ui-block-a" style="padding-left:10px; padding-right:10px">
							<label for="txt_district">เขต:</label>
                            <input type="text" name="txt_district" id="txt_district" />
					</div>
					<div class="ui-block-b" style="padding-left:10px; padding-right:10px">
							<label for="txt_sdistrict">แขวง:</label>
                            <input type="text" name="txt_sdistrict" id="txt_sdistrict" />
					</div>
				</div>

					<div class="ui-grid-solo ui-responsive">
						<a href="#" class="ui-btn" onclick="bt_edit_click()" id="bt_edit">แก้ไขข้อมูล</a>
						<a href="#" class="ui-btn" onclick="bt_save_click()" id="bt_save">ยืนยัน</a>
						<a href="#" class="ui-btn" onclick="bt_cancel_click()" id="bt_clear">ยกเลิก</a>
						<a href="https://line.me/ti/p/%40ndb8157o" class="ui-btn" >กลับไปยัง LINE</a>
					</div>
			</div>
				
		
		</div><!-- /content -->
	</div><!-- /page -->
</body>
</html>
<script src="js/reg_custemer.js"></script>
<script> 
    $(document).ready(function () {
		prepare_view("view");
    });    
</script>
