<%@ Page Language="VB" %>

<!DOCTYPE html>

<script runat="server">
    Dim USER_STAFF_ID As String = "314001"
    Dim USER_STAFF_NAME As String = "RUENGDECH LA-ORPONGAISAN"


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%
        Session("STAFF_ID") = Nothing
        Session("USER_ID") = Nothing
        Session("USER_NAME") = Nothing
        Session("USER_FNAME") = Nothing
        Session("USER_ABR") = Nothing
        Session("USER_TYPE") = Nothing
        Session("USER_CATEGORY") = Nothing

        %>
    <title>[ADMIN] SAINTMED SALE FUNNEL </title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../RESOURCE/themes/ruengdech.css" rel="stylesheet" />
    <link href="../RESOURCE/themes/jquery.mobile.icons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" /> 
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 
    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>     
	<style>
	 .center {
		  margin: auto !important;
		  text-align: center !important;
	 }
	 
     .table_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
     }
     .table_list th, .table_list td {
          border: 1px solid #ddd;
          /*padding: 8px;*/
     }
     .table_list tr:nth-child(even) {background-color: #f2f2f2;}
     .table_list tr:hover  {background-color: #ddd;}
     .table_list th {
          padding-top: 1px;
          padding-bottom: 1px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
     }
     /*.container {margin:150px auto;}*/
	   
	</style>
    <script type="text/javascript" >
        var JOB_DATA = [];
        var PRODUCT_DATA = [];
        var MODEL_DATA = [];
        var STAFF_ID = "";
        var BM_DATA = [];
        var STAFF_DATA = [];
    </script>
    <link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css" />
    <link href="../RESOURCE/table_filter/Filter.css" rel="stylesheet" />
    <script src="../RESOURCE/table_filter/Filter.js"></script>
</head>

<body>
	<div data-role="page" id="page_main">
		
		<div data-role="header" style="background-color:#43bf79!important;border-color:#43bf79!important;text-shadow:none;">
			<div style="min-height:50px;display:inline;"><img src="../../img/SM_LOGO.gif" style="display:inline; vertical-align:middle; margin: 10px 10px 10px 20px; width:130px"/><p class="lb_account" style="display:inline;vertical-align:middle" >[Data] SAINTMED SALE FUNNEL</p></div>
		</div><!-- /header -->

		<div data-role="content" class="ui-content" data-theme="c">
            <div class="ui-bar ui-bar-a center">
                <h3>Thank you</h3>
            </div>

            
		</div><!-- /content -->        

	</div><!-- /page -->
</body>
<script src="../JS/sys02.sale01.js"></script>
</html>
<%-- $.mobile.silentScroll($('#wopwop').get(0).offsetTop);    --%>