<%@ Page Language="VB" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>jQuery Mobile: Theme Download</title>
	<link rel="stylesheet" href="themes/ST_MED.css" />
	<link rel="stylesheet" href="themes/jquery.mobile.icons.min.css" />
    <link href="themes/jquery.mobile.structure-1.4.5.css" rel="stylesheet" />
    <script src="themes/jquery-1.11.1.min.js"></script>
    <script src="themes/jquery.mobile-1.4.5.min.js"></script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css" />
    
    <%
        Session("STAFF_ID") = Nothing
        Session("USER_ID") = Nothing
        Session("USER_NAME") = Nothing
        Session("USER_FNAME") = Nothing
        Session("USER_ABR") = Nothing
        Session("USER_TYPE") = Nothing
        Session("USER_CATEGORY") = Nothing

        %>
    <style>
        #tb_history, .table_job_list {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
          /*width:900px; */
        }

        #tb_history td, #tb_history th , .table_job_list th, .table_job_list td {
          border: 1px solid #ddd;
          padding: 8px;
        }

        #tb_history tr:nth-child(even), .table_job_list tr:nth-child(even) {background-color: #f2f2f2;}

        #tb_history tr:hover, .table_job_list tr:hover  {background-color: #ddd;}

        #tb_history th, .table_job_list th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: #4CAF50;
          color: white;
        }

        .center {
            text-align:center !important;
        }

        .textboxAslabel {
            border:none!important;
            background-color:#FFF!important;
            border-color:#FFF!important;
            }
   </style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<style>
    .fa-star {
        color:#ccc;
        font-size:2.5em;
    }
    /* Hover state of the stars */
    .fa-star:hover{
        color:#FFCC36;
    }

    /* Selected state of the stars */
    .fa-star:active  {
      color:#FF912C;
    }

    /* Selected state of the stars */
    .fa-star-active  {
      color:#FF912C;
      font-size:2.5em;
    }
</style>   
<%
    Response.Write("<SCRIPT>")
    Response.Write("STAFF_ID = '" & Session("STAFF_ID") & "';")
    Response.Write("</SCRIPT>")

%> 
</head>
<body>
<div data-role="page" id="page_main" data-theme="b">
		<div data-role="header" data-position="inline">
			<h2>ระบบ บริการติดตั้ง/ซ่อมบำรุงเครื่องมือแพทย์</h2>
		</div>
		<div data-role="content" data-theme="a">
               
                <div id="request" class="ui-body-d ui-content ui-corner-all">
                    <div class="ui-bar ui-bar-a">
                        <h3>Thank you</h3>
                        
                    </div>
                    
                </div><%--<div id="request" class="ui-body-d ui-content ui-corner-all">--%>
                
		</div>
</div>


</body>
</html>
