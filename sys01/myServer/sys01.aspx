<%@ Page Language="VB" %>

<script runat="server">

    '<2021-08-07 CSI FORM New Project>
    Function SEND_CSI_FORM(UUID As String) As String
        Dim clsSQL As New MY_CLASS_MSSQL()
        clsSQL.strSql = "SELECT " &
                                " req_installmobile " &
                           "FROM SYS01_TS_REQUEST WHERE (uid = " & UUID & ")"
        clsSQL.func_SetDataSet(clsSQL.strSql, "A_JOB")
        If clsSQL.ds.Tables("A_JOB").Rows.Count > 0 Then
            With clsSQL.ds.Tables("A_JOB").Rows(0)
                Dim CONTACT_MOB As String = ""
                CONTACT_MOB = .Item("req_installmobile").ToString()
                Dim URL As String = "https://saintmed.dyndns.biz/net/sys04/csi.aspx?r1=" & UUID & "&r2=" & UUID
                Dim SMS As New SMS_NEW()
                Dim MSG_SMS As String = "ขอบพระคุณที่ใช้บริการทีมงาน Technical บริษัท SAINTMED " & vbNewLine & vbNewLine & "เพื่อพัฒนาบริการให้ท่านดียิ่งๆขึ้น ขอความกรุณาให้ข้อมูลความพึงพอใจ คลิก " & vbNewLine & URL
                Dim res As String = SMS.SEND_SMS(CONTACT_MOB, MSG_SMS)
                Return res
            End With
        Else
            Return "Error: JOB ID Not found"
        End If
    End Function
    '</2021-08-07 CSI FORM New Project>


    Function req_BM_approve_function(require_date As String) As String
        Dim start_date As DateTime = Date.Now
        Dim arr_date() As String = require_date.Split("-")
        Dim yy As Integer = CInt(arr_date(0))
        If yy > 2500 Then
            yy = yy - 543
            arr_date(0) = yy.ToString
        End If
        Dim req_date As DateTime = DateTime.Parse(arr_date(0) & "-" & arr_date(1) & "-" & arr_date(2))
        Dim total_working_day As Integer = Weekdays(start_date, req_date)
        If total_working_day <= 3 Then
            Dim ret As String = ""
            ret = "<tr><th colspan='2'>วันที่ร้องขอ/วันที่ต้องการงานเสร็จ มีเวลาน้อยกว่า 3 วันทำการ กรุณาอนุมัติ</th></tr>" &
                    "<tr><th bgcolor='green'><a href='http://saintmed.dyndns.biz/net/sys01/bm_approve.aspx?res=approve&id=$$$#page_detail'>คลิกเพื่อ อนุมัติ</a></th>" &
                        "<th bgcolor='yellow'><a href='http://saintmed.dyndns.biz/net/sys01/bm_approve.aspx?res=reject&id=$$$#page_detail'>คลิกเพื่อ ไม่อนุมัติ</th></tr>"
            Return ret
        Else
            Return ""
        End If
    End Function


    Public Shared Function Weekdays(startDate As Date, endDate As Date) As Integer
        Dim numWeekdays As Integer
        Dim totalDays As Integer
        Dim WeekendDays As Integer
        numWeekdays = 0
        WeekendDays = 0

        totalDays = DateDiff(DateInterval.Day, startDate, endDate) + 1

        For i As Integer = 1 To totalDays

            If DatePart(DateInterval.Weekday, startDate) = 1 Then
                WeekendDays = WeekendDays + 1
            End If
            If DatePart(DateInterval.Weekday, startDate) = 7 Then
                WeekendDays = WeekendDays + 1
            End If
            startDate = DateAdd("d", 1, startDate)
        Next

        numWeekdays = totalDays - WeekendDays

        Return numWeekdays
    End Function

</script>


<% 
    Dim cls As New MY_CLASS
    Dim clsSQL As New MY_CLASS_MSSQL
    Dim feature As String = Request.Form("feature")
    Dim EMAIL_TO_LIST() As String = {""}
    Dim URL_FOR_EMAIL_REQUESTER As String = "http://saintmed.dyndns.biz/net/sys01/index.aspx?id=" 'NEED UID of REQ
    Dim URL_FOR_EMAIL_SUPERVISOR As String = "http://saintmed.dyndns.biz/net/sys01/admin/index.aspx#page_main"
    Dim URL_FOR_EMAIL_ENGINEER As String = "http://saintmed.dyndns.biz/net/sys01/engineer/index.aspx?id="  'NEED UID of REQ
    'Dim EMAIL_SUPERVISOR As String = "warathon@saintmed.com,service@saintmed.com,phichairak@saintmed.com" '"prapot@saintmed.com,noppanan@saintmed.com,anucha@saintmed.com,surawat@saintmed.com,service@saintmed.com,metha@saintmed.com,piyapong@saintmed.com,warathon@saintmed.com,sathit.k19@gmail.com,phichairak@saintmed.com,Taveesak@saintmed.com";


    Select Case feature
        Case "getStaffByID"
            Try
                Dim user_id As String = Request.Form("id")
                cls.strSql = "SELECT " &
                                "employee2.UID, employee2.name, employee2.lastname, employee2.mobile, employee2.emloffice   " &
                            "FROM  " &
                                "employee2 " &
                            "WHERE (((employee2.uid)=" & user_id & ") );"
                cls.func_SetDataSet(cls.strSql, "LOGIN")
                If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                    With cls.ds.Tables("LOGIN").Rows(0)
                        Response.Write("SUCCESS|" & .Item("UID").ToString & "|" & .Item("name").ToString & "|" & .Item("lastname").ToString & "|" & .Item("mobile").ToString & "|" & .Item("emloffice").ToString)
                    End With
                Else
                    Response.Write("FAIL|0|0|0|0")
                End If
            Catch ex As Exception

            End Try
        Case "getStaffByLogin"
            Try
                Dim user_login As String = Request.Form("login")
                cls.strSql = "SELECT " &
                                "employee2.UID, users.username, users.pswd, employee2.name, employee2.lastname, employee2.mobile, employee2.emloffice  " &
                            "FROM  " &
                                "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                                "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                            "WHERE (((users.login)=" & user_login & ") );"
                cls.func_SetDataSet(cls.strSql, "LOGIN")
                If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                    With cls.ds.Tables("LOGIN").Rows(0)
                        Response.Write("SUCCESS|" & .Item("UID").ToString & "|" & .Item("name").ToString & "|" & .Item("lastname").ToString & "|" & .Item("mobile").ToString & "|" & .Item("emloffice").ToString)
                    End With
                Else
                    Response.Write("FAIL|0|0|0|0")
                End If
            Catch ex As Exception

            End Try
        Case "getAM"
            Try
                clsSQL.strSql = "SELECT " &
                                "STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_EMAIL, STAFF_MOBILE  " &
                            "FROM  " &
                                "SYS01_MS_STAFF " &
                            "WHERE  (STAFF_TYPE LIKE '%AREAMANAGER%') " &
                            "ORDER BY  STAFF_NAME "
                clsSQL.func_SetDataSet(clsSQL.strSql, "LOGIN")
                If clsSQL.ds.Tables("LOGIN").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("LOGIN").Rows.Count - 1
                        With clsSQL.ds.Tables("LOGIN").Rows(i)
                            RESPONSES &= "SUCCESS|" & .Item("STAFF_ID").ToString & "|" & .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString & "^"
                        End With
                    Next
                    Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getBM"
            Try
                clsSQL.strSql = "SELECT " &
                                "STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_EMAIL, STAFF_MOBILE  " &
                            "FROM  " &
                                "SYS01_MS_STAFF " &
                            "WHERE  (STAFF_TYPE LIKE '%BRANDMANAGER%') " &
                            "ORDER BY  STAFF_NAME "
                clsSQL.func_SetDataSet(clsSQL.strSql, "LOGIN")
                If clsSQL.ds.Tables("LOGIN").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("LOGIN").Rows.Count - 1
                        With clsSQL.ds.Tables("LOGIN").Rows(i)
                            RESPONSES &= "SUCCESS|" & .Item("STAFF_ID").ToString & "|" & .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString & "^"
                        End With
                    Next
                    Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getENGINEER"
            Try
                clsSQL.strSql = "SELECT " &
                                "STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_EMAIL, STAFF_MOBILE  " &
                            "FROM  " &
                                "SYS01_MS_STAFF " &
                            "WHERE  (STAFF_TYPE LIKE '%ENGINEER%') " &
                            "ORDER BY  STAFF_NAME "
                clsSQL.func_SetDataSet(clsSQL.strSql, "LOGIN")
                If clsSQL.ds.Tables("LOGIN").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("LOGIN").Rows.Count - 1
                        With clsSQL.ds.Tables("LOGIN").Rows(i)
                            RESPONSES &= "SUCCESS|" & .Item("STAFF_ID").ToString & "|" & .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString & "^"
                        End With
                    Next
                    Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequest"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                Dim STAFF_ID As String = ""
                Dim PAGE_REQUEST As String = ""
                id = Request.Form("id")
                STAFF_ID = Request.Form("STAFF_ID")
                PAGE_REQUEST = Request.Form("PAGE_REQUEST")

                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If

                If STAFF_ID <> Nothing And PAGE_REQUEST <> Nothing Then
                    If PAGE_REQUEST = "STAFF" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก REQUESTER / AM / BM
                        conditions &= " AND (req_amid = " & STAFF_ID & " OR req_bmid = " & STAFF_ID & " OR staff_id = " & STAFF_ID & ")  "
                    ElseIf PAGE_REQUEST = "ENGINEER" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก ENGINEER
                        conditions &= " AND (req_staffid1 = " & STAFF_ID & " OR req_staffid2 = " & STAFF_ID & " OR req_staffid3 = " & STAFF_ID & " OR req_staffid4 = " & STAFF_ID & " )  "
                    End If
                End If

                clsSQL.strSql = "SELECT " &
                                    "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                                    ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                                    ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                                    ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                                    ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                                    ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                                    ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                                    ", req_mwhen, req_cname, req_mname  " &
                                    ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                                    ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                                    ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                                    ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                                    ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                                    ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail, engineer_job_reason " &
                                    ", CASE WHEN req_status = 'new' then 0 else (case when req_status ='plan' then 1 else (case when req_status = 'assigned' then 2 else (case when req_status = 'start' then 3 else 4 end) end)  end)  end as FOR_SORT " &
                                    ", (select count(UID) from SYS04_TS_CSIRESULT where C_REFERENCE = SYS01_TS_REQUEST.UID) as IS_CSI_DONE " &
                                    ", req_bm_approve " &
                                 "FROM SYS01_TS_REQUEST " &
                                 "WHERE (1=1) " & conditions &
                                 "ORDER BY FOR_SORT, UID ASC" 'req_installdate DESC"  [new,assigned,plan,start,finish,complete]
                'Total = 75 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)
                            For j = 0 To 74
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(75).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                Response.Write(.Item(75).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "createJOB"
            Try
                Dim ctrl_txt_staffId As String = Request.Form("ctrl_txt_staffId")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_lname As String = Request.Form("ctrl_txt_lname")
                Dim ctrl_txt_mobile As String = Request.Form("ctrl_txt_mobile")
                Dim ctrl_txt_email As String = Request.Form("ctrl_txt_email")
                Dim ctrl_sel_am As String = Request.Form("ctrl_sel_am")
                Dim ctrl_sel_bm As String = Request.Form("ctrl_sel_bm")
                Dim ctrl_txt_location As String = Request.Form("ctrl_txt_location")
                Dim ctrl_txt_dept As String = Request.Form("ctrl_txt_dept")
                Dim ctrl_txt_contact As String = Request.Form("ctrl_txt_contact")
                Dim ctrl_txt_contactTel As String = Request.Form("ctrl_txt_contactTel")
                Dim ctrl_txt_date As String = Request.Form("ctrl_txt_date")
                Dim ctrl_txt_time As String = Request.Form("ctrl_txt_time")
                Dim ctrl_txt_contract As String = Request.Form("ctrl_txt_contract")
                Dim ctrl_sel_pm As String = Request.Form("ctrl_sel_pm")
                Dim ctrl_sel_waranteen As String = Request.Form("ctrl_sel_waranteen")
                Dim ctrl_sel_job1 As String = Request.Form("ctrl_sel_job1")
                Dim ctrl_sel_job2 As String = Request.Form("ctrl_sel_job2")
                Dim ctrl_sel_job3 As String = Request.Form("ctrl_sel_job3")
                Dim ctrl_txt_job1 As String = Request.Form("ctrl_txt_job1")
                Dim ctrl_txt_job2 As String = Request.Form("ctrl_txt_job2")
                Dim ctrl_txt_job3 As String = Request.Form("ctrl_txt_job3")

                Dim am_name, am_email, bm_name, bm_email As String

                Dim req_bm As String = req_BM_approve_function(ctrl_txt_date)
                Dim req_bm_approve As String = ""
                If req_bm.ToString.Length > 3 Then
                    req_bm_approve = "WAIT FOR APPROVE"
                End If
                Dim job_type As String = "00"
                If ctrl_sel_job1.ToString = "แจ้งซ่อม" Then
                    job_type = "01"
                End If


                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_am & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "AM")
                If clsSQL.ds.Tables("AM").Rows.Count > 0 Then
                    am_name = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_LNAME").ToString
                    am_email = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_EMAIL").ToString
                End If

                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_bm & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "BM")
                If clsSQL.ds.Tables("BM").Rows.Count > 0 Then
                    bm_name = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_LNAME").ToString
                    bm_email = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_EMAIL").ToString
                End If

                clsSQL.strSql = "INSERT INTO SYS01_TS_REQUEST " &
                                "(req_date, staff_id, staff_name" &
                                ", staff_surname, staff_mobile, staff_email" &
                                ", req_amid , req_amname, req_amemail" &
                                ", req_bmid, req_bmname, req_bmemail" &
                                ", req_installlocation, req_installdept, req_installcontact" &
                                ", req_installmobile, req_installdate, req_installtime " &
                                ", req_contact, req_pmround, req_warantee" &
                                ", req_jobtype1, req_jobtype2, req_jobtype3" &
                                ", req_job1, req_job2, req_job3, req_bm_approve, req_group)  " &
                            "VALUES ( " &
                                "GETDATE(), " & ctrl_txt_staffId & ", '" & ctrl_txt_name & "'" &
                                ", '" & ctrl_txt_lname & "', '" & ctrl_txt_mobile & "', '" & ctrl_txt_email & "'" &
                                ", " & ctrl_sel_am & ", '" & am_name & "', '" & am_email & "'" &
                                ", " & ctrl_sel_bm & ", '" & bm_name & "', '" & bm_email & "'" &
                                ", '" & ctrl_txt_location & "', '" & ctrl_txt_dept & "', '" & ctrl_txt_contact & "'" &
                                ", '" & ctrl_txt_contactTel & "', CONVERT(DATETIME, '" & ctrl_txt_date & " 00:00:00', 102), '" & ctrl_txt_time & "'" &
                                ", '" & ctrl_txt_contract & "', " & ctrl_sel_pm & ", " & ctrl_sel_waranteen & " " &
                                ", '" & ctrl_sel_job1 & "', '" & ctrl_sel_job2 & "', '" & ctrl_sel_job3 & "'" &
                                ", '" & ctrl_txt_job1 & "', '" & ctrl_txt_job2 & "', '" & ctrl_txt_job3 & "'" &
                                ", '" & req_bm_approve & "' " &
                                ", '" & job_type & "' " &
                                ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")

                    Try
                        clsSQL.strSql = "update SYS01_TS_REQUEST set req_bm_approve = '' where dbo.fn_GetTotalWorkingDays(req_date,req_installdate) > 3"
                        clsSQL.func_execute(clsSQL.strSql)
                    Catch ex As Exception

                    End Try

                    Dim date2 As Date = Date.Now
                    Dim date1 As Date = Date.Now
                    Dim days As Long = 1
                    clsSQL.strSql = "SELECT TOP 1 UID FROM SYS01_TS_REQUEST WHERE STAFF_ID =" & ctrl_txt_staffId & " ORDER BY UID DESC "
                    clsSQL.func_SetDataSet(clsSQL.strSql, "DATA")

                    URL_FOR_EMAIL_REQUESTER &= clsSQL.ds.Tables("DATA").Rows(0).Item(0) & "#page_detail"
                    Dim URLS2_ As String = "http://saintmed.dyndns.biz/net/sys01/index.aspx#page_assignlist"

                    If req_bm.ToString.Length > 2 Then
                        req_bm = req_bm.Replace("$$$", clsSQL.ds.Tables("DATA").Rows(0).Item(0).ToString)
                    End If


                    Try
                        date2 = Date.Parse(ctrl_txt_date)
                        days += DateDiff(DateInterval.Day, date1, date2) ' REMOVE 2022-04-14 Change with next line (Compute working day instead of date diff)
                        'days = Weekdays(date1, date2) ' ADD 2022-04-14 from Upper line reason 

                    Catch ex As Exception

                    End Try

                    Dim MSG As String = "<html lang=''en''> <head> <meta content=''text/html; charset=utf-8'' http-equiv=''Content-Type''> <title> Saint Med JOB Request </title> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <body>"
                    Dim pre_ As String = "<tr><th>"
                    Dim pre2_ As String = "<tr style='background-color: #f7f9fa;'><th>"
                    Dim mid_ As String = "</th><td>"
                    Dim post_ As String = "</td></tr>"
                    MSG &= "<center><H3>พนักงานร้องขอรับบริการงานช่างดังนี้</H3>"
                    MSG &= "<table width = '450px'>"
                    MSG &= pre_ & "ห้วข้องาน : " & mid_ & ctrl_txt_job1 & post_
                    MSG &= pre2_ & "สถานที่ : " & mid_ & ctrl_txt_location & "  " & ctrl_txt_dept & post_
                    MSG &= pre_ & "แจ้งโดย : " & mid_ & ctrl_txt_name & " " & ctrl_txt_lname & post_
                    MSG &= pre2_ & "Email : " & mid_ & ctrl_txt_email & " <b>Tel</b> " & ctrl_txt_mobile & post_
                    MSG &= pre_ & "วันที่แจ้ง : " & mid_ & Date.Now.ToString("dd/MM/yyyy HH:mm:ss") & post_

                    MSG &= pre2_ & "AM : " & mid_ & am_name & post_
                    MSG &= pre_ & "BM : " & mid_ & bm_name & post_
                    MSG &= pre2_ & "วันเวลาที่ต้องการให้ติดตั้ง : " & mid_ & ctrl_txt_date & "  " & ctrl_txt_time & post_
                    MSG &= pre_ & "ผู้ติดต่อ : " & mid_ & ctrl_txt_contact & "  โทร " & ctrl_txt_contactTel & post_
                    MSG &= pre2_ & "เลขที่สัญญา : " & mid_ & ctrl_txt_contract & post_
                    MSG &= pre_ & "รอบ PM (ครั้ง/ปี) : " & mid_ & ctrl_sel_pm & post_
                    MSG &= pre2_ & "ระยะเวลารับประกัน (ปี) : " & mid_ & ctrl_sel_waranteen & post_
                    MSG &= pre_ & "ประเภทของงาน (1) : " & mid_ & ctrl_sel_job1 & " <b>" & ctrl_txt_job1 & "</b>" & post_
                    MSG &= pre2_ & "ประเภทของงาน (2) : " & mid_ & ctrl_sel_job2 & " <b>" & ctrl_txt_job2 & "</b>" & post_
                    MSG &= pre_ & "ประเภทของงาน (3) : " & mid_ & ctrl_sel_job3 & " <b>" & ctrl_txt_job3 & "</b>" & post_
                    MSG &= pre2_ & "จำนวนวันทำงาน (ตาม Request): " & mid_ & days & post_

                    '<EMAIL TO AM>
                    Dim MSG_AMBM As String = MSG
                    MSG_AMBM &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_REQUESTER & clsSQL.ds.Tables("DATA").Rows(0).Item(0) & "#page_detail" & "'> คลิกเพื่อดูรายละเอียด</a></th></tr>"
                    MSG_AMBM &= "</table></center></body></html>"

                    ReDim EMAIL_TO_LIST(5)
                    EMAIL_TO_LIST(0) = ctrl_txt_email
                    EMAIL_TO_LIST(1) = am_email ' "ruengdech@gmai.com" ' 
                    'EMAIL_TO_LIST(2) = bm_email
                    'EMAIL_TO_LIST(3) = "warathon@saintmed.com"
                    'EMAIL_TO_LIST(4) = "ruengdech@gmail.com"

                    'ReDim EMAIL_TO_LIST(1)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(1) = "ruengdech.la@bnh.co.th" 'TEST REMOVE THIS LINE 3  (ABOVE IS WORK) PLEASE DELETE

                    clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_AMBM, "New JOB " & ctrl_txt_job1)
                    '</EMAIL TO AM,BM>

                    '<EMAIL TO BM>
                    Dim MSG_BM As String = MSG
                    MSG_BM &= req_bm
                    MSG_BM &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_REQUESTER & clsSQL.ds.Tables("DATA").Rows(0).Item(0) & "#page_detail" & "'> คลิกเพื่อดูรายละเอียด</a></th></tr>"
                    MSG_BM &= "</table></center></body></html>"

                    ReDim EMAIL_TO_LIST(5)
                    'EMAIL_TO_LIST(0) = ctrl_txt_email
                    'EMAIL_TO_LIST(1) = am_email
                    EMAIL_TO_LIST(0) = bm_email ' "ruengdech@gmail.com" '
                    EMAIL_TO_LIST(1) = "warathon@saintmed.com" ' "ruengdech@gmail.com" '
                    'EMAIL_TO_LIST(2) = "ruengdech@gmail.com"

                    'ReDim EMAIL_TO_LIST(1)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(1) = "ruengdech.la@bnh.co.th" 'TEST REMOVE THIS LINE 3  (ABOVE IS WORK) PLEASE DELETE

                    clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_BM, "NEW JOB (BM) " & ctrl_txt_job1)
                    '</EMAIL TO BM>

                    '<EMAIL TO SUPERVISOR>

                    Array.Clear(EMAIL_TO_LIST, 0, EMAIL_TO_LIST.Length)
                    clsSQL.strSql = "SELECT STAFF_EMAIL, STAFF_MOBILE FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%SUPERVISOR%') "
                    clsSQL.func_SetDataSet(clsSQL.strSql, "SUPERVISOR")
                    Dim STR_TMP_EMAIL As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("SUPERVISOR").Rows.Count - 1
                        If clsSQL.ds.Tables("SUPERVISOR").Rows(i).Item(0).ToString().Length > 5 Then STR_TMP_EMAIL &= clsSQL.ds.Tables("SUPERVISOR").Rows(i).Item(0).ToString() & "|"
                    Next

                    'ReDim EMAIL_TO_LIST(0)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE
                    Dim xx As String() = STR_TMP_EMAIL.Split("|")

                    ReDim EMAIL_TO_LIST(xx.Length - 1)

                    EMAIL_TO_LIST = xx

                    Dim MSG_SUP As String = MSG
                    MSG_SUP &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_SUPERVISOR & "'> คลิกเพื่อมอบหมายงาน</a></th></tr>"
                    MSG_SUP &= "</table></center></body></html>"
                    clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_SUP, "(NEW) " & ctrl_txt_job1) 'TEST REMOVE THIS LINE 1  (ENABLE LINE 2 ข้างล่าง)
                    'clsSQL.sendEmail(STR_TMP_EMAIL.Split("|"), "ruengdech@saintmed.com", MSG_SUP, "(NEW) มีการร้องขอรับบริการงานช่าง") 'TEST REMOVE THIS LINE 2  (ENABLE หลัง DISABLE LINE 1)

                    '</EMAIL TO SUPERVISOR>

                    Response.Write(" AND COMPLETED EMAIL ")

                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "assignJOB"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim ctrl_sel_am As String = Request.Form("ctrl_sel_am")
                Dim ctrl_sel_bm As String = Request.Form("ctrl_sel_am")
                Dim ctrl_txt_location As String = Request.Form("ctrl_txt_location")
                Dim ctrl_txt_dept As String = Request.Form("ctrl_txt_dept")
                Dim ctrl_txt_contact As String = Request.Form("ctrl_txt_contact")
                Dim ctrl_txt_contactTel As String = Request.Form("ctrl_txt_contactTel")
                Dim ctrl_txt_date As String = Request.Form("ctrl_txt_date")
                Dim ctrl_txt_time As String = Request.Form("ctrl_txt_time")
                Dim ctrl_txt_contract As String = Request.Form("ctrl_txt_contract")
                Dim ctrl_sel_pm As String = Request.Form("ctrl_sel_pm")
                Dim ctrl_sel_waranteen As String = Request.Form("ctrl_sel_waranteen")
                Dim ctrl_sel_job1 As String = Request.Form("ctrl_sel_job1")
                Dim ctrl_sel_job2 As String = Request.Form("ctrl_sel_job2")
                Dim ctrl_sel_job3 As String = Request.Form("ctrl_sel_job3")
                Dim ctrl_txt_job1 As String = Request.Form("ctrl_txt_job1")
                Dim ctrl_txt_job2 As String = Request.Form("ctrl_txt_job2")
                Dim ctrl_txt_job3 As String = Request.Form("ctrl_txt_job3")

                Dim p_assign_sel_staff As String = Request.Form("p_assign_sel_staff")
                Dim p_assign_sel_staff1 As String = Request.Form("p_assign_sel_staff1")
                Dim p_assign_sel_staff2 As String = Request.Form("p_assign_sel_staff2")
                Dim p_assign_sel_staff3 As String = Request.Form("p_assign_sel_staff3")
                Dim p_assign_sel_staff4 As String = Request.Form("p_assign_sel_staff4")
                Dim p_assign_txt_assignid As String = Request.Form("p_assign_txt_assignid")
                Dim p_assign_txt_assignname As String = Request.Form("p_assign_txt_assignname")

                Dim am_name, am_email, bm_name, bm_email, staff_name1, staff_name2, staff_name3, staff_name4, staff_mail1, staff_mail2, staff_mail3, staff_mail4 As String

                If p_assign_sel_staff1.Length < 3 Then p_assign_sel_staff1 = "0"
                If p_assign_sel_staff2.Length < 3 Then p_assign_sel_staff2 = "0"
                If p_assign_sel_staff3.Length < 3 Then p_assign_sel_staff3 = "0"
                If p_assign_sel_staff4.Length < 3 Then p_assign_sel_staff4 = "0"

                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_am & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "AM")
                If clsSQL.ds.Tables("AM").Rows.Count > 0 Then
                    am_name = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_LNAME").ToString
                    am_email = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_EMAIL").ToString
                End If

                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_bm & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "BM")
                If clsSQL.ds.Tables("BM").Rows.Count > 0 Then
                    bm_name = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_LNAME").ToString
                    bm_email = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_EMAIL").ToString
                End If

                clsSQL.strSql = "SELECT STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%ENGINEER%')"
                clsSQL.func_SetDataSet(clsSQL.strSql, "ENGINEER")
                If clsSQL.ds.Tables("ENGINEER").Rows.Count > 0 Then
                    For i As Integer = 0 To clsSQL.ds.Tables("ENGINEER").Rows.Count - 1
                        With clsSQL.ds.Tables("ENGINEER").Rows(i)
                            If (.Item("STAFF_ID").ToString = p_assign_sel_staff1) Then
                                staff_name1 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail1 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = p_assign_sel_staff2) Then
                                staff_name2 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail2 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = p_assign_sel_staff3) Then
                                staff_name3 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail3 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = p_assign_sel_staff4) Then
                                staff_name4 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail4 = .Item("STAFF_EMAIL").ToString
                            End If
                        End With
                    Next
                End If

                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_amid = 00, req_amname = '00', req_amemail = '00', req_bmid = 00, req_bmname = '00', req_bmemail = '00', req_installlocation = '00', req_installdept = '00', req_installcontact = '00', req_installmobile = '00', req_installdate = 00, req_installtime = '00', req_contact = '00', req_pmround = 00, req_warantee = 00, req_jobtype1 = '00', req_jobtype2 = '00', req_jobtype3 = '00', req_job1 = '00', req_job2 = '00', req_job3 = '00', req_assignid = 00, req_assignname = '00', req_assigndate = 00, req_numberofstaff = 00, req_staffid1 = 00, req_staffid2 = 00, req_staffid3 = 00, req_staffid4 = 00, req_staffname1 = '00', req_staffname2 = '00', req_staffname3 = '00', req_staffname4 = '00', req_staffemail1 = '00', req_staffemail2 = '00', req_staffemail3 = '00', req_staffemail4 = '00', req_mwhen = GETDATE(), req_mname = '00' WHERE (uid = 111)"
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET " &
                                    " req_amid = " & ctrl_sel_am & "" &
                                    " , req_amname = '" & am_name & "'" &
                                    " , req_amemail = '" & am_email & "'" &
                                    " , req_bmid = " & ctrl_sel_bm & "" &
                                    " , req_bmname = '" & bm_name & "'" &
                                    " , req_bmemail = '" & bm_email & "'" &
                                    " , req_installlocation = '" & ctrl_txt_location & "'" &
                                    " , req_installdept = '" & ctrl_txt_dept & "'" &
                                    " , req_installcontact = '" & ctrl_txt_contact & "'" &
                                    " , req_installmobile = '" & ctrl_txt_contactTel & "'" &
                                    " , req_installdate = CONVERT(DATETIME, '" & ctrl_txt_date & " 00:00:00', 102)" &
                                    " , req_installtime = '" & ctrl_txt_time & "'" &
                                    " , req_contact = '" & ctrl_txt_contract & "'" &
                                    " , req_pmround = " & ctrl_sel_pm & "" &
                                    " , req_warantee = " & ctrl_sel_waranteen & "" &
                                    " , req_jobtype1 = '" & ctrl_sel_job1 & "'" &
                                    " , req_jobtype2 = '" & ctrl_sel_job2 & "'" &
                                    " , req_jobtype3 = '" & ctrl_sel_job3 & "'" &
                                    " , req_job1 = '" & ctrl_txt_job1 & "'" &
                                    " , req_job2 = '" & ctrl_txt_job2 & "'" &
                                    " , req_job3 = '" & ctrl_txt_job3 & "'" &
                                    " , req_assignid = " & p_assign_txt_assignid & "" &
                                    " , req_assignname = '" & p_assign_txt_assignname & "'" &
                                    " , req_assigndate = GETDATE() " &
                                    " , req_numberofstaff = " & p_assign_sel_staff & "" &
                                    " , req_staffid1 = " & p_assign_sel_staff1 & "" &
                                    " , req_staffid2 = " & p_assign_sel_staff2 & "" &
                                    " , req_staffid3 = " & p_assign_sel_staff3 & "" &
                                    " , req_staffid4 = " & p_assign_sel_staff4 & "" &
                                    " , req_staffname1 = '" & staff_name1 & "'" &
                                    " , req_staffname2 = '" & staff_name2 & "'" &
                                    " , req_staffname3 = '" & staff_name3 & "'" &
                                    " , req_staffname4 = '" & staff_name4 & "'" &
                                    " , req_staffemail1 = '" & staff_mail1 & "'" &
                                    " , req_staffemail2 = '" & staff_mail2 & "'" &
                                    " , req_staffemail3 = '" & staff_mail3 & "'" &
                                    " , req_staffemail4 = '" & staff_mail4 & "'" &
                                    " , req_mwhen = GETDATE() " &
                                    " , req_status = 'assign' " &
                                    " , req_mname = '" & p_assign_txt_assignname & "' " &
                                " WHERE (uid = " & job_id & ")"

                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")

                    Dim date2 As Date = Date.Now
                    Dim date1 As Date = Date.Now
                    Dim days As Long = 1
                    clsSQL.strSql = "SELECT " &
                            "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                            ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                            ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                            ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                            ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                            ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                            ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                            ", req_mwhen, req_cname, req_mname  " &
                            ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                            ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                            ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                            ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                            ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                            ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment " &
                            "  " &
                         "FROM SYS01_TS_REQUEST  WHERE UID =" & job_id & "  "
                    clsSQL.func_SetDataSet(clsSQL.strSql, "DATA")

                    Dim URLS_ As String = "http://saintmed.dyndns.biz/net/sys01/index.aspx?id=" & clsSQL.ds.Tables("DATA").Rows(0).Item(0) & "#page_detail"
                    Dim URLS2_ As String = "http://saintmed.dyndns.biz/net/sys01/index.aspx#page_job_list"

                    With clsSQL.ds.Tables("DATA").Rows(0)
                        Try
                            date2 = Date.Parse(ctrl_txt_date)
                            days += DateDiff(DateInterval.Day, date1, date2)

                        Catch ex As Exception

                        End Try

                        Dim MSG As String = "<html lang=''en''> <head> <meta content=''text/html; charset=utf-8'' http-equiv=''Content-Type''> <title> Saint Med JOB Request </title> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <body>"
                        Dim pre_ As String = "<tr><th>"
                        Dim pre2_ As String = "<tr style='background-color: #f7f9fa;'><th>"
                        Dim mid_ As String = "</th><td>"
                        Dim post_ As String = "</td></tr>"
                        MSG &= "<center><H3>พนักงานร้องขอรับบริการงานช่างดังนี้</H3>"
                        MSG &= "<table width = '450px'>"
                        MSG &= pre_ & "ห้วข้องาน : " & mid_ & .Item("req_job1").ToString() & post_
                        MSG &= pre2_ & "สถานที่ : " & mid_ & .Item("req_installlocation").ToString() & "  " & .Item("req_installdept").ToString() & post_
                        MSG &= pre_ & "แจ้งโดย : " & mid_ & .Item("staff_name").ToString() & " " & .Item("staff_surname").ToString() & post_
                        MSG &= pre2_ & "Email : " & mid_ & .Item("staff_email").ToString() & " <b>Tel</b> " & .Item("staff_mobile").ToString() & post_
                        MSG &= pre_ & "วันที่แจ้ง : " & mid_ & .Item("req_cwhen").ToString() & post_

                        MSG &= pre2_ & "AM : " & mid_ & .Item("req_amname").ToString() & post_
                        MSG &= pre_ & "BM : " & mid_ & .Item("req_bmname").ToString() & post_
                        MSG &= pre2_ & "วันเวลาที่ต้องการให้ติดตั้ง : " & mid_ & .Item("req_installdate").ToString() & "  " & .Item("req_installtime").ToString() & post_
                        MSG &= pre_ & "ผู้ติดต่อ : " & mid_ & .Item("req_installcontact").ToString() & "  โทร " & .Item("req_installmobile").ToString() & post_
                        MSG &= pre2_ & "เลขที่สัญญา : " & mid_ & .Item("req_contact").ToString() & post_
                        MSG &= pre_ & "รอบ PM (ครั้ง/ปี) : " & mid_ & .Item("req_pmround").ToString() & post_
                        MSG &= pre2_ & "ระยะเวลารับประกัน (ปี) : " & mid_ & .Item("req_warantee").ToString() & post_
                        MSG &= pre_ & "ประเภทของงาน (1) : " & mid_ & .Item("req_jobtype1").ToString() & " <b>" & .Item("req_job1").ToString() & "</b>" & post_
                        MSG &= pre2_ & "ประเภทของงาน (2) : " & mid_ & .Item("req_jobtype2").ToString() & " <b>" & .Item("req_job2").ToString() & "</b>" & post_
                        MSG &= pre_ & "ประเภทของงาน (3) : " & mid_ & .Item("req_jobtype3").ToString() & " <b>" & .Item("req_job3").ToString() & "</b>" & post_
                        MSG &= pre2_ & "วันที่ Assign : " & mid_ & .Item("req_assigndate").ToString() & " โดย " & .Item("req_assignname").ToString() & " " & post_
                        MSG &= pre_ & "ช่างผู้ได้รับ Assign (1) : " & mid_ & .Item("req_staffname1").ToString() & " " & post_
                        MSG &= pre_ & "ช่างผู้ได้รับ Assign (2) : " & mid_ & .Item("req_staffname2").ToString() & " " & post_
                        MSG &= pre_ & "ช่างผู้ได้รับ Assign (3) : " & mid_ & .Item("req_staffname3").ToString() & " " & post_
                        MSG &= pre_ & "ช่างผู้ได้รับ Assign (4) : " & mid_ & .Item("req_staffname4").ToString() & " " & post_


                        ''<EMAIL TO AM,BM,REQUESTER>
                        'Dim MSG_AMBM As String = MSG
                        'MSG_AMBM &= "<tr><th colspan='2'><a href='" & URLS_ & "'> คลิกเพื่อดูรายละเอียด</a></th></tr>"
                        'MSG_AMBM &= "</table></center></body></html>"

                        'clsSQL.sendEmail("ruengdech@gmail.com", "ruengdech@saintmed.com", MSG_AMBM, "(TEST AM/BM/Staff)ASSIGNED JOB REQUEST")
                        ''</EMAIL TO AM,BM>

                        '<EMAIL TO ENGINEER>
                        ReDim EMAIL_TO_LIST(3)
                        EMAIL_TO_LIST(0) = staff_mail1
                        EMAIL_TO_LIST(1) = staff_mail2 '"ruengdech@gmail.com" 'staff_mail2
                        EMAIL_TO_LIST(2) = staff_mail3
                        EMAIL_TO_LIST(3) = staff_mail4

                        Dim MSG_SUP As String = MSG
                        MSG_SUP &= "<tr><th colspan='2'><a href='" & URLS2_ & "'> คลิกเพื่อดูรายการงานที่ได้รับมอบหมาย</a></th></tr>"
                        MSG_SUP &= "</table></center></body></html>"
                        clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_SUP, "ASSIGNED JOB " & .Item("req_job1").ToString())
                        '</EMAIL TO ENGINEER>

                        Response.Write(" AND COMPLETED EMAIL ")

                    End With

                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "rateJOB"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim score As String = Request.Form("job_score")
                Dim comment_ As String = Request.Form("comment_")

                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET requst_score = " & score & ",reques_score_comment='" & comment_ & "', reques_score_date = GETDATE() WHERE (uid = " & job_id & ")"

                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")

                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequestWaitForAssign"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                id = Request.Form("id")
                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If

                clsSQL.strSql = "SELECT " &
                            "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                            ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                            ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                            ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                            ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                            ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                            ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                            ", req_mwhen, req_cname, req_mname  " &
                            ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                            ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                            ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                            ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                            ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                            ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail " &
                            ", req_bm_approve " &
                         "FROM SYS01_TS_REQUEST " &
                         "WHERE (req_status ='new') " & conditions &
                         "ORDER BY req_installdate ASC "
                'Total = 72 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)
                            For j = 0 To 71
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(j).ToString.Replace("|", "'").Replace("^", """") & "|" 
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                            'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(72).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                                Response.Write(.Item(72).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequestWaitForApprove"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                id = Request.Form("id")
                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If

                clsSQL.strSql = "SELECT " &
                            "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                            ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                            ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                            ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                            ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                            ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                            ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                            ", req_mwhen, req_cname, req_mname  " &
                            ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                            ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                            ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                            ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                            ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                            ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                            ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail " &
                         "FROM SYS01_TS_REQUEST " &
                         "WHERE (req_status ='plan') AND (plan_status = '') " & conditions &
                         "ORDER BY plan_start_date ASC "
                'Total = 71 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)
                            For j = 0 To 70
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(j).ToString.Replace("|", "'").Replace("^", """") & "|" 
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                            'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequestWaitForPlan"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                Dim STAFF_ID As String = ""
                Dim PAGE_REQUEST As String = ""
                id = Request.Form("id")
                STAFF_ID = Request.Form("STAFF_ID")
                PAGE_REQUEST = Request.Form("PAGE_REQUEST")
                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If

                If STAFF_ID <> Nothing And PAGE_REQUEST <> Nothing Then
                    If PAGE_REQUEST = "STAFF" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก REQUESTER / AM / BM
                        conditions &= " AND (req_amid = " & STAFF_ID & " OR req_bmid = " & STAFF_ID & " OR staff_id = " & STAFF_ID & ")  "
                    ElseIf PAGE_REQUEST = "ENGINEER" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก ENGINEER
                        conditions &= " AND (req_staffid1 = " & STAFF_ID & " OR req_staffid2 = " & STAFF_ID & " OR req_staffid3 = " & STAFF_ID & " OR req_staffid4 = " & STAFF_ID & " )  "
                    End If
                End If

                clsSQL.strSql = "SELECT " &
                                    "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                                    ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                                    ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                                    ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                                    ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                                    ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                                    ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                                    ", req_mwhen, req_cname, req_mname  " &
                                    ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                                    ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                                    ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                                    ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                                    ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                                    ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail " &
                                 "FROM SYS01_TS_REQUEST " &
                                 "WHERE (req_status ='assigned') " & conditions &
                                 "ORDER BY req_installdate ASC "
                'Total = 71 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)

                            For j = 0 To 70
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(j).ToString.Replace("|", "'").Replace("^", """") & "|" 
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                            'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequestWaitForClose"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                Dim STAFF_ID As String = ""
                Dim PAGE_REQUEST As String = ""
                id = Request.Form("id")
                STAFF_ID = Request.Form("STAFF_ID")
                PAGE_REQUEST = Request.Form("PAGE_REQUEST")
                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If
                If STAFF_ID <> Nothing And PAGE_REQUEST <> Nothing Then
                    If PAGE_REQUEST = "STAFF" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก REQUESTER / AM / BM
                        conditions &= " AND (req_amid = " & STAFF_ID & " OR req_bmid = " & STAFF_ID & " OR staff_id = " & STAFF_ID & ")  "
                    ElseIf PAGE_REQUEST = "ENGINEER" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก ENGINEER
                        conditions &= " AND (req_staffid1 = " & STAFF_ID & " OR req_staffid2 = " & STAFF_ID & " OR req_staffid3 = " & STAFF_ID & " OR req_staffid4 = " & STAFF_ID & " )  "
                    End If
                End If

                clsSQL.strSql = "SELECT " &
                                    "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                                    ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                                    ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                                    ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                                    ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                                    ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                                    ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                                    ", req_mwhen, req_cname, req_mname  " &
                                    ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                                    ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                                    ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                                    ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                                    ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                                    ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail " &
                                 "FROM SYS01_TS_REQUEST " &
                                 "WHERE (req_status in ('plan','start')) " & conditions &
                                 "ORDER BY req_installdate ASC "
                'Total = 71 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)
                            For j = 0 To 70
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(j).ToString.Replace("|", "'").Replace("^", """") & "|" 
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                            'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "getRequestClosed"
            Try
                Dim id As String = ""
                Dim conditions As String = ""
                Dim STAFF_ID As String = ""
                Dim PAGE_REQUEST As String = ""
                id = Request.Form("id")
                STAFF_ID = Request.Form("STAFF_ID")
                PAGE_REQUEST = Request.Form("PAGE_REQUEST")
                If id = Nothing Then
                    conditions = ""
                Else
                    conditions = " AND UID =  " & id & " "
                End If

                If STAFF_ID <> Nothing And PAGE_REQUEST <> Nothing Then
                    If PAGE_REQUEST = "STAFF" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก REQUESTER / AM / BM
                        conditions &= " AND (req_amid = " & STAFF_ID & " OR req_bmid = " & STAFF_ID & " OR staff_id = " & STAFF_ID & ")  "
                    ElseIf PAGE_REQUEST = "ENGINEER" Then
                        'ดึงเฉพาะข้อมูลที่เกี่ยวกับตนเอง จาก ENGINEER
                        conditions &= " AND (req_staffid1 = " & STAFF_ID & " OR req_staffid2 = " & STAFF_ID & " OR req_staffid3 = " & STAFF_ID & " OR req_staffid4 = " & STAFF_ID & " )  "
                    End If
                End If

                clsSQL.strSql = "SELECT " &
                                    "uid, convert(varchar, req_date, 20), staff_id, staff_name, staff_surname, staff_mobile, staff_email " &
                                    ", req_amid, req_amname, req_amemail, req_bmid, req_bmname, req_bmemail, req_installlocation " &
                                    ", req_installdept, req_installcontact, req_installmobile, convert(varchar, req_installdate, 23) as req_installdate, req_installtime, req_contact, req_pmround " &
                                    ", req_warantee, req_jobtype1, req_jobtype2, req_jobtype3, req_job1, req_job2, req_job3 " &
                                    ", job_piority, req_assignid, req_assignname, convert(varchar, req_assigndate, 23) as req_assigndate, req_numberofstaff, req_staffid1, req_staffid2 " &
                                    ", req_staffid3, req_staffid4, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobsdatestart, 23) " &
                                    ", convert(varchar, req_jobdatefinish, 23), req_attached1, req_attached2, req_attached3, req_attached4, req_status, convert(varchar, req_cwhen, 23) as req_cwhen " &
                                    ", req_mwhen, req_cname, req_mname  " &
                                    ", DATEDIFF(day, req_date, req_installdate) AS DAY_submitTOreqfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_submitTOjobfinish " &
                                    ", DATEDIFF(day, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END, CASE WHEN REQ_JOBDATEFINISH IS NULL THEN GETDATE() ELSE req_jobdatefinish END) AS DAY_jobstartTOjobfinish " &
                                    ", DATEDIFF(day, req_date, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END) AS DAY_submitTOjobassign " &
                                    ", DATEDIFF(day, CASE WHEN req_assigndate IS NULL THEN GETDATE() ELSE req_assigndate END, CASE WHEN req_jobsdatestart IS NULL THEN GETDATE() ELSE req_jobsdatestart END) AS DAY_assignTOstart " &
                                    ", convert(varchar, plan_start_date,20) as plan_start_date, convert(varchar, plan_finish_date,20) as plan_finish_date, plan_by, convert(varchar, plan_date,23) as plan_date, plan_status, plan_approve_by " &
                                    ", convert(varchar, plan_approve_date,23) as plan_approve_date, plan_approve_comment, requst_score, convert(varchar, reques_score_date,23) as reques_score_date , reques_score_comment, customer_score " &
                                    ", convert(varchar, customer_score_date,23) as customer_score_date, customer_score_comment, engineer_job_detail " &
                                 "FROM SYS01_TS_REQUEST " &
                                 "WHERE (req_status in ('finish','complete')) " & conditions &
                                 "ORDER BY req_installdate ASC "
                'Total = 71 Columns
                clsSQL.func_SetDataSet(clsSQL.strSql, "REQUEST")
                If clsSQL.ds.Tables("REQUEST").Rows.Count > 0 Then
                    Dim RESPONSES As String = ""
                    For i As Integer = 0 To clsSQL.ds.Tables("REQUEST").Rows.Count - 1
                        With clsSQL.ds.Tables("REQUEST").Rows(i)
                            For j = 0 To 70
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(j).ToString.Replace("|", "'").Replace("^", """") & "|" 
                                Response.Write(.Item(j).ToString.Replace("|", "'").Replace("^", """") & "|")
                            Next
                            'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                            'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                            If i = clsSQL.ds.Tables("REQUEST").Rows.Count - 1 Then
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """"))
                            Else
                                'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                                'RESPONSES &= .Item(71).ToString.Replace("|", "'").Replace("^", """") & "^"
                                Response.Write(.Item(71).ToString.Replace("|", "'").Replace("^", """") & "^")
                            End If
                        End With
                    Next
                    'เอาบรรทัดนี้ออกเพราะ Performance ต่ำ (2021-07-20)
                    'Response.Write(Left(RESPONSES, RESPONSES.Length - 1))
                Else
                    Response.Write("FAIL")
                End If
            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "adminEditJOB"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim ctrl_txt_staffId As String = Request.Form("ctrl_txt_staffId")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_lname As String = Request.Form("ctrl_txt_lname")
                Dim ctrl_txt_mobile As String = Request.Form("ctrl_txt_mobile")
                Dim ctrl_txt_email As String = Request.Form("ctrl_txt_email")
                Dim ctrl_sel_am As String = Request.Form("ctrl_sel_am")
                Dim ctrl_sel_bm As String = Request.Form("ctrl_sel_bm")
                Dim ctrl_txt_location As String = Request.Form("ctrl_txt_location")
                Dim ctrl_txt_dept As String = Request.Form("ctrl_txt_dept")
                Dim ctrl_txt_contact As String = Request.Form("ctrl_txt_contact")
                Dim ctrl_txt_contactTel As String = Request.Form("ctrl_txt_contactTel")
                Dim ctrl_txt_date As String = Request.Form("ctrl_txt_date")
                Dim ctrl_txt_time As String = Request.Form("ctrl_txt_time")
                Dim ctrl_txt_contract As String = Request.Form("ctrl_txt_contract")
                Dim ctrl_sel_pm As String = Request.Form("ctrl_sel_pm")
                Dim ctrl_sel_waranteen As String = Request.Form("ctrl_sel_waranteen")
                Dim ctrl_sel_job1 As String = Request.Form("ctrl_sel_job1")
                Dim ctrl_sel_job2 As String = Request.Form("ctrl_sel_job2")
                Dim ctrl_sel_job3 As String = Request.Form("ctrl_sel_job3")
                Dim ctrl_txt_job1 As String = Request.Form("ctrl_txt_job1")
                Dim ctrl_txt_job2 As String = Request.Form("ctrl_txt_job2")
                Dim ctrl_txt_job3 As String = Request.Form("ctrl_txt_job3")
                Dim ctrl_txt_job_status As String = Request.Form("ctrl_txt_job_status")

                Dim ctrl_txt_remark As String = Request.Form("ctrl_txt_remark")
                Dim ctrl_req_isfinish As String = Request.Form("ctrl_req_isfinish")


                Dim ctrl_sel_staff As String = Request.Form("ctrl_sel_staff")
                Dim ctrl_sel_staff1 As String = Request.Form("ctrl_sel_staff1")
                Dim ctrl_sel_staff2 As String = Request.Form("ctrl_sel_staff2")
                Dim ctrl_sel_staff3 As String = Request.Form("ctrl_sel_staff3")
                Dim ctrl_sel_staff4 As String = Request.Form("ctrl_sel_staff4")
                Dim ctrl_txt_assign_date As String = Request.Form("ctrl_txt_assign_date")
                Dim ctrl_txt_assignid As String = Request.Form("ctrl_txt_assignid")
                Dim ctrl_txt_assignname As String = Request.Form("ctrl_txt_assignname")

                Dim ctrl_txt_plan_start As String = Request.Form("ctrl_txt_plan_start")
                Dim ctrl_txt_plan_end As String = Request.Form("ctrl_txt_plan_end")
                Dim ctrl_txt_planid As String = Request.Form("ctrl_txt_planid")
                Dim ctrl_txt_planname As String = Request.Form("ctrl_txt_planname")
                Dim ctrl_sel_plan_result As String = Request.Form("ctrl_sel_plan_result")
                Dim ctrl_txt_plan_comment As String = Request.Form("ctrl_txt_plan_comment")
                Dim ctrl_txt_plan_approveid As String = Request.Form("ctrl_txt_plan_approveid")
                Dim ctrl_txt_plan_approvename As String = Request.Form("ctrl_txt_plan_approvename")

                Dim ctrl_txt_date_start As String = Request.Form("ctrl_txt_date_start")
                Dim ctrl_txt_date_end As String = Request.Form("ctrl_txt_date_end")
                Dim ctrl_txt_job_detail As String = Request.Form("ctrl_txt_job_detail")


                Dim am_name, am_email, bm_name, bm_email, staff_name1, staff_name2, staff_name3, staff_name4, staff_mail1, staff_mail2, staff_mail3, staff_mail4 As String


                Dim job_type As String = "00"
                If ctrl_sel_job1.ToString = "แจ้งซ่อม" Then
                    job_type = "01"
                End If

                '<GET AM>
                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_am & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "AM")
                If clsSQL.ds.Tables("AM").Rows.Count > 0 Then
                    am_name = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_LNAME").ToString
                    am_email = clsSQL.ds.Tables("AM").Rows(0).Item("STAFF_EMAIL").ToString
                End If
                '<GET BM>
                clsSQL.strSql = "SELECT STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_ID = " & ctrl_sel_bm & ")"
                clsSQL.func_SetDataSet(clsSQL.strSql, "BM")
                If clsSQL.ds.Tables("BM").Rows.Count > 0 Then
                    bm_name = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_NAME").ToString & " " & clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_LNAME").ToString
                    bm_email = clsSQL.ds.Tables("BM").Rows(0).Item("STAFF_EMAIL").ToString
                End If
                '<GET ENGINEER>
                If ctrl_sel_staff1.Length < 3 Then ctrl_sel_staff1 = "0"
                If ctrl_sel_staff2.Length < 3 Then ctrl_sel_staff2 = "0"
                If ctrl_sel_staff3.Length < 3 Then ctrl_sel_staff3 = "0"
                If ctrl_sel_staff4.Length < 3 Then ctrl_sel_staff4 = "0"

                clsSQL.strSql = "SELECT STAFF_ID, STAFF_NAME, STAFF_LNAME, STAFF_EMAIL FROM SYS01_MS_STAFF WHERE (STAFF_TYPE like '%ENGINEER%')"
                clsSQL.func_SetDataSet(clsSQL.strSql, "ENGINEER")
                If clsSQL.ds.Tables("ENGINEER").Rows.Count > 0 Then
                    For i As Integer = 0 To clsSQL.ds.Tables("ENGINEER").Rows.Count - 1
                        With clsSQL.ds.Tables("ENGINEER").Rows(i)
                            If (.Item("STAFF_ID").ToString = ctrl_sel_staff1) Then
                                staff_name1 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail1 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = ctrl_sel_staff2) Then
                                staff_name2 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail2 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = ctrl_sel_staff3) Then
                                staff_name3 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail3 = .Item("STAFF_EMAIL").ToString
                            ElseIf (.Item("STAFF_ID").ToString = ctrl_sel_staff4) Then
                                staff_name4 = .Item("STAFF_NAME").ToString & " " & .Item("STAFF_LNAME").ToString
                                staff_mail4 = .Item("STAFF_EMAIL").ToString
                            End If
                        End With
                    Next
                End If

                '<UPDATE SQL>
                Dim SQL_EDITS As String = ""

                '<FOR UPDATE ASSIGN>
                If (ctrl_txt_job_status = "new" Or ctrl_txt_job_status = "assigned" Or ctrl_txt_job_status = "plan" Or ctrl_txt_job_status = "start" Or ctrl_txt_job_status = "finish" Or ctrl_txt_job_status = "complete") And ctrl_txt_assignname.Length > 3 Then
                    SQL_EDITS &= " , req_assignid = " & ctrl_txt_assignid & "" &
                                    " , req_assignname = '" & ctrl_txt_assignname & "'" &
                                    " , req_assigndate = CASE WHEN req_assigndate IS NOT NULL THEN req_assigndate ELSE GETDATE() END " &
                                    " , req_numberofstaff = " & ctrl_sel_staff & "" &
                                    " , req_staffid1 = " & ctrl_sel_staff1 & "" &
                                    " , req_staffid2 = " & ctrl_sel_staff2 & "" &
                                    " , req_staffid3 = " & ctrl_sel_staff3 & "" &
                                    " , req_staffid4 = " & ctrl_sel_staff4 & "" &
                                    " , req_staffname1 = '" & staff_name1 & "'" &
                                    " , req_staffname2 = '" & staff_name2 & "'" &
                                    " , req_staffname3 = '" & staff_name3 & "'" &
                                    " , req_staffname4 = '" & staff_name4 & "'" &
                                    " , req_staffemail1 = '" & staff_mail1 & "'" &
                                    " , req_staffemail2 = '" & staff_mail2 & "'" &
                                    " , req_staffemail3 = '" & staff_mail3 & "'" &
                                    " , req_staffemail4 = '" & staff_mail4 & "' "
                End If

                '<FOR UPDATE PLAN APPROVE>
                If (ctrl_txt_job_status = "plan" Or ctrl_txt_job_status = "start" Or ctrl_txt_job_status = "finish" Or ctrl_txt_job_status = "complete") And ctrl_txt_plan_approvename.Length > 3 Then
                    SQL_EDITS &= " , plan_start_date = CONVERT(DATETIME, '" & ctrl_txt_plan_start & " 00:00:00', 102) " &
                                    ", plan_finish_date = CONVERT(DATETIME, '" & ctrl_txt_plan_end & " 00:00:00', 102)" &
                                    ", plan_status = '" & ctrl_sel_plan_result & "'" &
                                    ", plan_approve_by = '" & ctrl_txt_plan_approvename & "'" &
                                    ", plan_approve_date = CASE WHEN plan_approve_date IS NOT NULL THEN plan_approve_date ELSE GETDATE() END " &
                                    ", plan_approve_comment = '" & ctrl_txt_plan_comment & "' "
                End If

                '<FOR UPDATE ENGINEER>
                If ctrl_txt_date_start.Length > 4 Then
                    SQL_EDITS &= " , req_jobsdatestart = CONVERT(DATETIME, '" & ctrl_txt_date_start & " 00:00:00', 102) "
                End If
                If ctrl_txt_date_end.Length > 4 Then
                    SQL_EDITS &= " , req_jobdatefinish = CONVERT(DATETIME, '" & ctrl_txt_date_end & " 00:00:00', 102) "
                End If
                If ctrl_txt_job_detail.Length > 4 Then
                    SQL_EDITS &= " , engineer_job_detail = '" & ctrl_txt_job_detail & "' "
                End If

                '<MARK STATUS AND MODIFY NAME>
                If ctrl_txt_assignname.Length > 3 And ctrl_txt_plan_approvename.Length < 3 And ctrl_txt_job_status <> "plan" Then
                    SQL_EDITS &= " , req_status = 'assigned' " &
                                    " , req_mname = '" & ctrl_txt_assignname & "' "
                ElseIf ctrl_txt_plan_approvename.Length > 3 And ctrl_txt_job_status = "plan" Then
                    SQL_EDITS &= " , req_status = 'plan' " &
                                    " , req_mname = '" & ctrl_txt_plan_approvename & "' "
                Else
                    SQL_EDITS &= " , req_mname = '" & ctrl_txt_plan_approvename & "' "
                End If

                If ctrl_req_isfinish.Length >= 4 Then
                    SQL_EDITS &= " , req_isfinish = '" & ctrl_req_isfinish & "' "
                End If

                If ctrl_txt_remark.Length > 4 Then
                    SQL_EDITS &= " , txt_remark = '" & ctrl_txt_remark & "' "
                End If


                '</MARK STATUS AND MODIFY NAME>

                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_amid = 00, req_amname = '00', req_amemail = '00', req_bmid = 00, req_bmname = '00', req_bmemail = '00', req_installlocation = '00', req_installdept = '00', req_installcontact = '00', req_installmobile = '00', req_installdate = 00, req_installtime = '00', req_contact = '00', req_pmround = 00, req_warantee = 00, req_jobtype1 = '00', req_jobtype2 = '00', req_jobtype3 = '00', req_job1 = '00', req_job2 = '00', req_job3 = '00', req_assignid = 00, req_assignname = '00', req_assigndate = 00, req_numberofstaff = 00, req_staffid1 = 00, req_staffid2 = 00, req_staffid3 = 00, req_staffid4 = 00, req_staffname1 = '00', req_staffname2 = '00', req_staffname3 = '00', req_staffname4 = '00', req_staffemail1 = '00', req_staffemail2 = '00', req_staffemail3 = '00', req_staffemail4 = '00', req_mwhen = GETDATE(), req_mname = '00' WHERE (uid = 111)"
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET " &
                                    " req_amid = " & ctrl_sel_am & "" &
                                    " , req_amname = '" & am_name & "'" &
                                    " , req_amemail = '" & am_email & "'" &
                                    " , req_bmid = " & ctrl_sel_bm & "" &
                                    " , req_bmname = '" & bm_name & "'" &
                                    " , req_bmemail = '" & bm_email & "'" &
                                    " , req_installlocation = '" & ctrl_txt_location & "'" &
                                    " , req_installdept = '" & ctrl_txt_dept & "'" &
                                    " , req_installcontact = '" & ctrl_txt_contact & "'" &
                                    " , req_installmobile = '" & ctrl_txt_contactTel & "'" &
                                    " , req_installdate = CONVERT(DATETIME, '" & ctrl_txt_date & " 00:00:00', 102)" &
                                    " , req_installtime = '" & ctrl_txt_time & "'" &
                                    " , req_contact = '" & ctrl_txt_contract & "'" &
                                    " , req_pmround = " & ctrl_sel_pm & "" &
                                    " , req_warantee = " & ctrl_sel_waranteen & "" &
                                    " , req_jobtype1 = '" & ctrl_sel_job1 & "'" &
                                    " , req_jobtype2 = '" & ctrl_sel_job2 & "'" &
                                    " , req_jobtype3 = '" & ctrl_sel_job3 & "'" &
                                    " , req_job1 = '" & ctrl_txt_job1 & "'" &
                                    " , req_job2 = '" & ctrl_txt_job2 & "'" &
                                    " , req_job3 = '" & ctrl_txt_job3 & "'" &
                                    " , req_mwhen = GETDATE() " &
                                    " , req_group = '" & job_type & "' " &
                SQL_EDITS & " " &
                        " WHERE (uid = " & job_id & ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")


                    '<EMAIL TASK>

                    Dim MSG As String = "<html lang=''en''> <head> <meta content=''text/html; charset=utf-8'' http-equiv=''Content-Type''> <title> Saint Med JOB Request </title> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <body>"
                    Dim pre_ As String = "<tr><th>"
                    Dim pre2_ As String = "<tr style='background-color: #f7f9fa;'><th>"
                    Dim mid_ As String = "</th><td>"
                    Dim post_ As String = "</td></tr>"
                    MSG &= "<center><H3>พนักงานร้องขอรับบริการงานช่างมีข้อมูล Udate ดังนี้</H3>"
                    MSG &= "<table width = '450px'>"
                    MSG &= pre_ & "ห้วข้องาน : " & mid_ & ctrl_txt_job1 & post_
                    MSG &= pre2_ & "สถานที่ : " & mid_ & ctrl_txt_location & "  " & ctrl_txt_dept & post_
                    MSG &= pre_ & "แจ้งโดย : " & mid_ & ctrl_txt_name & " " & ctrl_txt_lname & post_
                    MSG &= pre2_ & "Email : " & mid_ & ctrl_txt_email & " <b>Tel</b> " & ctrl_txt_mobile & post_
                    MSG &= pre_ & "วันที่แจ้ง : " & mid_ & Date.Now.ToString("dd/MM/yyyy HH:mm:ss") & post_

                    MSG &= pre2_ & "AM : " & mid_ & am_name & post_
                    MSG &= pre_ & "BM : " & mid_ & bm_name & post_
                    MSG &= pre2_ & "วันเวลาที่ต้องการให้ติดตั้ง : " & mid_ & ctrl_txt_date & "  " & ctrl_txt_time & post_
                    MSG &= pre_ & "ผู้ติดต่อ : " & mid_ & ctrl_txt_contact & "  โทร " & ctrl_txt_contactTel & post_
                    MSG &= pre2_ & "เลขที่สัญญา : " & mid_ & ctrl_txt_contract & post_
                    MSG &= pre_ & "รอบ PM (ครั้ง/ปี) : " & mid_ & ctrl_sel_pm & post_
                    MSG &= pre2_ & "ระยะเวลารับประกัน (ปี) : " & mid_ & ctrl_sel_waranteen & post_
                    MSG &= pre_ & "ประเภทของงาน (1) : " & mid_ & ctrl_sel_job1 & " <b>" & ctrl_txt_job1 & "</b>" & post_
                    MSG &= pre2_ & "ประเภทของงาน (2) : " & mid_ & ctrl_sel_job2 & " <b>" & ctrl_txt_job2 & "</b>" & post_
                    MSG &= pre_ & "ประเภทของงาน (3) : " & mid_ & ctrl_sel_job3 & " <b>" & ctrl_txt_job3 & "</b>" & post_

                    '<EMAIL TO AM,BM, REQUESTER>
                    Dim MSG_AMBM As String = MSG
                    MSG_AMBM &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_REQUESTER & job_id & "'> คลิกเพื่อดูรายละเอียด</a></th></tr>"
                    MSG_AMBM &= "</table></center></body></html>"

                    ReDim EMAIL_TO_LIST(2)
                    EMAIL_TO_LIST(0) = ctrl_txt_email
                    EMAIL_TO_LIST(1) = am_email
                    EMAIL_TO_LIST(2) = bm_email

                    'ReDim EMAIL_TO_LIST(1)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(1) = "ruengdech.la@bnh.co.th" 'TEST REMOVE THIS LINE 3  (ABOVE IS WORK) PLEASE DELETE

                    clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_AMBM, "(AM/BM)NEW JOB REQUEST " & ctrl_txt_job1)
                    '</EMAIL TO AM,BM, REQUESTER>

                    '<EMAIL TO ENGINEER>
                    ReDim EMAIL_TO_LIST(3)
                    Dim indexcount As Integer = 1
                    EMAIL_TO_LIST(0) = staff_mail1
                    If staff_mail2 <> Nothing Then
                        EMAIL_TO_LIST(indexcount) = staff_mail2
                        indexcount += 1
                    End If
                    If staff_mail3 <> Nothing Then
                        EMAIL_TO_LIST(indexcount) = staff_mail3
                        indexcount += 1
                    End If
                    If staff_mail4 <> Nothing Then
                        EMAIL_TO_LIST(indexcount) = staff_mail4
                        indexcount += 1
                    End If


                    'ReDim EMAIL_TO_LIST(0)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                    'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE

                    Dim MSG_SUP As String = MSG
                    MSG_SUP &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_ENGINEER & job_id & "'> คลิกเพื่อดูรายละเอียด</a></th></tr>"
                    MSG_SUP &= "</table></center></body></html>"
                    clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_SUP, "(" & ctrl_txt_job_status.ToUpper & ") " & ctrl_txt_job1)
                    '</EMAIL TO ENGINEER>

                    Response.Write(" AND COMPLETED EMAIL ")
                    '</EMAIL TASK>
                Else
                    Response.Write("FAIL")
                End If

                '</UPDATE SQL>


            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "adminDeleteJOB"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim delete_staff_id As String = Request.Form("delete_staff_id")
                Dim delete_staff_name As String = Request.Form("delete_staff_name")


                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_amid = 00, req_amname = '00', req_amemail = '00', req_bmid = 00, req_bmname = '00', req_bmemail = '00', req_installlocation = '00', req_installdept = '00', req_installcontact = '00', req_installmobile = '00', req_installdate = 00, req_installtime = '00', req_contact = '00', req_pmround = 00, req_warantee = 00, req_jobtype1 = '00', req_jobtype2 = '00', req_jobtype3 = '00', req_job1 = '00', req_job2 = '00', req_job3 = '00', req_assignid = 00, req_assignname = '00', req_assigndate = 00, req_numberofstaff = 00, req_staffid1 = 00, req_staffid2 = 00, req_staffid3 = 00, req_staffid4 = 00, req_staffname1 = '00', req_staffname2 = '00', req_staffname3 = '00', req_staffname4 = '00', req_staffemail1 = '00', req_staffemail2 = '00', req_staffemail3 = '00', req_staffemail4 = '00', req_mwhen = GETDATE(), req_mname = '00' WHERE (uid = 111)"
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET " &
                                    " req_status = 'INACTIVE' " &
                                    " , req_mwhen = GETDATE() " &
                                    " , req_mname = '" & delete_staff_name & "' " &
                                " WHERE (uid = " & job_id & ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")
                Else
                    Response.Write("FAIL")
                End If

                '</UPDATE SQL>


            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "engineerPlan"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim ctrl_txt_plan_start As String = Request.Form("ctrl_txt_plan_start")
                Dim ctrl_txt_plan_end As String = Request.Form("ctrl_txt_plan_end")
                Dim ctrl_txt_planid As String = Request.Form("ctrl_txt_planid")
                Dim ctrl_txt_planname As String = Request.Form("ctrl_txt_planname")

                '<UPDATE SQL>
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_amid = 00, req_amname = '00', req_amemail = '00', req_bmid = 00, req_bmname = '00', req_bmemail = '00', req_installlocation = '00', req_installdept = '00', req_installcontact = '00', req_installmobile = '00', req_installdate = 00, req_installtime = '00', req_contact = '00', req_pmround = 00, req_warantee = 00, req_jobtype1 = '00', req_jobtype2 = '00', req_jobtype3 = '00', req_job1 = '00', req_job2 = '00', req_job3 = '00', req_assignid = 00, req_assignname = '00', req_assigndate = 00, req_numberofstaff = 00, req_staffid1 = 00, req_staffid2 = 00, req_staffid3 = 00, req_staffid4 = 00, req_staffname1 = '00', req_staffname2 = '00', req_staffname3 = '00', req_staffname4 = '00', req_staffemail1 = '00', req_staffemail2 = '00', req_staffemail3 = '00', req_staffemail4 = '00', req_mwhen = GETDATE(), req_mname = '00' WHERE (uid = 111)"
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET " &
                                   " plan_start_date = CONVERT(DATETIME, '" & ctrl_txt_plan_start & " 00:00:00', 102) " &
                                   ", plan_finish_date = CONVERT(DATETIME, '" & ctrl_txt_plan_end & " 00:00:00', 102)" &
                                   ", plan_status = ''" &
                                   ", plan_by = '" & ctrl_txt_planname & "'" &
                                   ", plan_date = GETDATE() " &
                                   ", req_mwhen = GETDATE() " &
                                   ", req_mname = '" & ctrl_txt_planname & "' " &
                                   ", req_status = 'plan' " &
                                " WHERE (uid = " & job_id & ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")
                Else
                    Response.Write("FAIL")
                End If

                '</UPDATE SQL>


            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "engineerEdit"
            Try
                Dim job_id As String = Request.Form("job_id")

                Dim ctrl_txt_date_start As String = Request.Form("ctrl_txt_date_start")
                Dim ctrl_txt_date_end As String = Request.Form("ctrl_txt_date_end")
                Dim ctrl_txt_job_detail As String = Request.Form("ctrl_txt_job_detail")
                Dim ctrl_sel_job_status As String = Request.Form("ctrl_sel_job_status")
                Dim ctrl_txt_modname As String = Request.Form("ctrl_txt_modname")

                Dim ctrl_file_1 As String = Request.Form("ctrl_file_1")
                Dim ctrl_file_2 As String = Request.Form("ctrl_file_2")
                Dim ctrl_file_3 As String = Request.Form("ctrl_file_3")
                Dim ctrl_file_4 As String = Request.Form("ctrl_file_4")

                Dim isFINISHED As String = Request.Form("is_finished")

                Dim ctrl_req_isfinish As String = Request.Form("ctrl_req_isfinish")
                Dim ctrl_txt_remark As String = Request.Form("ctrl_txt_remark")


                '<UPDATE SQL>
                Dim SQL_EDITS As String = ""



                If ctrl_txt_date_end.Length > 4 Then
                    SQL_EDITS &= " , req_jobdatefinish = CONVERT(DATETIME, '" & ctrl_txt_date_end & " 00:00:00', 102) "
                    If isFINISHED = "FINISH" Then SQL_EDITS &= " , req_status = 'finish'  "
                Else
                    SQL_EDITS &= " , req_status = 'start'  "
                End If
                If ctrl_txt_job_detail.Length > 4 Then
                    SQL_EDITS &= " , engineer_job_detail = '" & ctrl_txt_job_detail & "' "
                End If
                If ctrl_sel_job_status.Length > 4 Then
                    SQL_EDITS &= " , engineer_job_reason = '" & ctrl_sel_job_status & "' "
                End If

                If ctrl_req_isfinish.Length >= 4 Then
                    SQL_EDITS &= " , req_isfinish = '" & ctrl_req_isfinish & "' "
                End If

                If ctrl_txt_remark.Length > 4 Then
                    SQL_EDITS &= " , txt_remark = '" & ctrl_txt_remark & "' "
                End If

                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_amid = 00, req_amname = '00', req_amemail = '00', req_bmid = 00, req_bmname = '00', req_bmemail = '00', req_installlocation = '00', req_installdept = '00', req_installcontact = '00', req_installmobile = '00', req_installdate = 00, req_installtime = '00', req_contact = '00', req_pmround = 00, req_warantee = 00, req_jobtype1 = '00', req_jobtype2 = '00', req_jobtype3 = '00', req_job1 = '00', req_job2 = '00', req_job3 = '00', req_assignid = 00, req_assignname = '00', req_assigndate = 00, req_numberofstaff = 00, req_staffid1 = 00, req_staffid2 = 00, req_staffid3 = 00, req_staffid4 = 00, req_staffname1 = '00', req_staffname2 = '00', req_staffname3 = '00', req_staffname4 = '00', req_staffemail1 = '00', req_staffemail2 = '00', req_staffemail3 = '00', req_staffemail4 = '00', req_mwhen = GETDATE(), req_mname = '00' WHERE (uid = 111)"
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET " &
                                    " req_jobsdatestart = CONVERT(DATETIME, '" & ctrl_txt_date_start & " 00:00:00', 102) " &
                                    SQL_EDITS &
                                    " , req_mwhen = GETDATE() " &
                                    " , req_mname = '" & ctrl_txt_modname & "' " &
                                " WHERE (uid = " & job_id & ")"
                If clsSQL.func_execute(clsSQL.strSql) Then
                    Response.Write("SUCCESS")

                    If isFINISHED = "FINISH" Then


                        '<EMAIL TASK>
                        clsSQL.strSql = "SELECT " &
                                        "staff_email, req_amemail AS AM_EMAIL, req_bmemail AS BM_EMAIL, staff_name + ' ' + staff_surname AS STAFF_NAME, req_installlocation AS LOCATION" &
                                        ", req_job1 AS JOB_NAME, req_staffname1, req_staffname2, req_staffname3, req_staffname4, convert(varchar, req_jobdatefinish,23) as FIN_DATE, engineer_job_detail, req_installmobile " &
                                   "FROM SYS01_TS_REQUEST WHERE (uid = " & job_id & ")"
                        clsSQL.func_SetDataSet(clsSQL.strSql, "A_JOB")
                        If clsSQL.ds.Tables("A_JOB").Rows.Count > 0 Then
                            With clsSQL.ds.Tables("A_JOB").Rows(0)

                                Dim MSG As String = "<html lang=''en''> <head> <meta content=''text/html; charset=utf-8'' http-equiv=''Content-Type''> <title> Saint Med JOB Request </title> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <body>"
                                Dim pre_ As String = "<tr><th>"
                                Dim pre2_ As String = "<tr style='background-color: #f7f9fa;'><th>"
                                Dim mid_ As String = "</th><td>"
                                Dim post_ As String = "</td></tr>"
                                MSG &= "<center><H3>ข้อมูลขอรับบริการงานช่าง มีการแจ้งปิดงาน [กรุณาประเมินความพอใจ]</H3>"
                                MSG &= "<table width = '450px'>"
                                MSG &= pre_ & "ห้วข้องาน : " & mid_ & .Item("JOB_NAME").ToString() & post_
                                MSG &= pre2_ & "สถานที่ : " & mid_ & .Item("LOCATION").ToString() & post_
                                MSG &= pre_ & "แจ้งโดย : " & mid_ & .Item("STAFF_NAME").ToString() & post_

                                MSG &= pre2_ & "วันที่ปิดงาน : " & mid_ & .Item("FIN_DATE").ToString() & post_
                                MSG &= pre_ & "ทีมช่าง : " & mid_ & .Item("req_staffname1").ToString() & " " & .Item("req_staffname2").ToString() & " " & .Item("req_staffname3").ToString() & " " & .Item("req_staffname4").ToString() & post_
                                MSG &= pre2_ & "รายละเอียด : " & mid_ & .Item("engineer_job_detail").ToString() & post_

                                '<EMAIL TO AM,BM, REQUESTER>
                                Dim MSG_AMBM As String = MSG
                                MSG_AMBM &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_REQUESTER & job_id & "'> คลิกเพื่อดูรายละเอียด และประเมินความพอใจ</a></th></tr>"
                                MSG_AMBM &= "</table></center></body></html>"

                                ReDim EMAIL_TO_LIST(5)
                                EMAIL_TO_LIST(0) = .Item("AM_EMAIL").ToString()
                                EMAIL_TO_LIST(1) = .Item("BM_EMAIL").ToString()
                                EMAIL_TO_LIST(2) = .Item("staff_email").ToString()
                                EMAIL_TO_LIST(3) = "warathon@saintmed.com"
                                'EMAIL_TO_LIST(4) = "ruengdech@gmail.com"

                                clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_AMBM, "FINISHED JOB REQUEST " & .Item("JOB_NAME").ToString())
                                '</EMAIL TO AM,BM, REQUESTER>

                                '<EMAIL TO SUPERVISOR>

                                Array.Clear(EMAIL_TO_LIST, 0, EMAIL_TO_LIST.Length)
                                clsSQL.strSql = "SELECT STAFF_EMAIL, STAFF_MOBILE FROM SYS01_MS_STAFF WHERE (STAFF_TYPE LIKE '%SUPERVISOR%') "
                                clsSQL.func_SetDataSet(clsSQL.strSql, "SUPERVISOR")
                                Dim STR_TMP_EMAIL As String = ""
                                For i As Integer = 0 To clsSQL.ds.Tables("SUPERVISOR").Rows.Count - 1
                                    If clsSQL.ds.Tables("SUPERVISOR").Rows(i).Item(0).ToString().Length > 5 Then STR_TMP_EMAIL &= clsSQL.ds.Tables("SUPERVISOR").Rows(i).Item(0).ToString() & "|"
                                Next

                                'ReDim EMAIL_TO_LIST(0)  'TEST REMOVE THIS LINE 1 (ABOVE IS WORK) PLEASE DELETE
                                'EMAIL_TO_LIST(0) = "ruengdech@gmail.com" 'TEST REMOVE THIS LINE 2 (ABOVE IS WORK) PLEASE DELETE
                                Dim xx As String() = STR_TMP_EMAIL.Split("|")

                                ReDim EMAIL_TO_LIST(xx.Length - 1)

                                EMAIL_TO_LIST = xx

                                Dim MSG_SUP As String = MSG
                                'MSG_SUP &= "<tr><th colspan='2'><a href='" & URL_FOR_EMAIL_SUPERVISOR & "'> คลิกเพื่อมอบหมายงาน</a></th></tr>"
                                MSG_SUP &= "</table></center></body></html>"
                                clsSQL.sendEmail(EMAIL_TO_LIST, "ruengdech@saintmed.com", MSG_SUP, "FINISHED JOB REQUEST " & .Item("JOB_NAME").ToString()) 'TEST REMOVE THIS LINE 1  (ENABLE LINE 2 ข้างล่าง)
                                'clsSQL.sendEmail(STR_TMP_EMAIL.Split("|"), "ruengdech@saintmed.com", MSG_SUP, "(NEW) มีการร้องขอรับบริการงานช่าง") 'TEST REMOVE THIS LINE 2  (ENABLE หลัง DISABLE LINE 1)

                                '</EMAIL TO SUPERVISOR>

                            End With


                            ''<2021-08-07 CSI FORM New Project>
                            'Dim URL As String = "https://saintmed.dyndns.biz/net/sys03/csi.aspx?r1=" & job_id & "&r2=" & job_id
                            'Dim SMS As New SMS_NEW()
                            'Dim MSG_SMS As String = "ขอบพระคุณที่ใช้บริการทีมงาน Technical บริษัท Saint Medical " & vbNewLine & vbNewLine & "เพื่อพัฒนาบริการให้ท่านดียิ่งๆขึ้น ขอความกรุณาให้ข้อมูลความพึงพอใจ คลิก " & vbNewLine & URL
                            'SMS.SEND_SMS(CONTACT_MOB, MSG_SMS)
                            ''</2021-08-07 CSI FORM New Project>
                            SEND_CSI_FORM(job_id)
                        End If

                        Response.Write(" AND COMPLETED EMAIL ")
                        '</EMAIL TASK>
                    Else
                        Response.Write("FAIL")
                    End If
                End If
                '</UPDATE SQL>


            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "send_csi"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim ret As String = SEND_CSI_FORM(job_id)
                Response.Write(ret)
            Catch ex As Exception
                Response.Write("Error: UNKNOW03")
            End Try
        Case "bm_confirmJOB"
            Try
                Dim job_id As String = Request.Form("job_id")
                Dim res As String = Request.Form("bm_result")
                clsSQL.strSql = "UPDATE SYS01_TS_REQUEST SET req_bm_approve = '" & res & "' WHERE UID = " & job_id
                clsSQL.func_execute(clsSQL.strSql)
                Response.Write("SUCCESS")
            Catch ex As Exception
                Response.Write("Error: UNKNOW03")
            End Try
    End Select
    '0   uid
    '1   req_date
    '2   staff_id
    '3   staff_name
    '4   staff_surname
    '5   staff_mobile
    '6   staff_email
    '7   req_amid
    '8   req_amname
    '9   req_amemail
    '10  req_bmid
    '11  req_bmname
    '12  req_bmemail
    '13  req_installlocation
    '14  req_installdept
    '15  req_installcontact
    '16  req_installmobile
    '17  req_installdate
    '18  req_installtime
    '19  req_contact
    '20  req_pmround
    '21  req_warantee
    '22  req_jobtype1
    '23  req_jobtype2
    '24  req_jobtype3
    '25  req_job1
    '26  req_job2
    '27  req_job3
    '28  job_piority
    '29  req_assignid
    '30  req_assignname
    '31  req_assigndate
    '32  req_numberofstaff
    '33  req_staffid1
    '34  req_staffid2
    '35  req_staffid3
    '36  req_staffid4
    '37  req_staffname1
    '38  req_staffname2
    '39  req_staffname3
    '40  req_staffname4
    '41  req_jobsdatestart
    '42  req_jobdatefinish
    '43  req_attached1
    '44  req_attached2
    '45  req_attached3
    '46  req_attached4
    '47  req_status [new,assigned,plan,start,finish,complete]
    '48  req_cwhen
    '49  req_mwhen
    '50  req_cname
    '51  req_mname
    '52  DAY_submitTOreqfinish
    '53  DAY_submitTOjobfinish
    '54  DAY_jobstartTOjobfinish
    '55  DAY_submitTOjobassign
    '56  DAY_assignTOstart
    '57	 plan_start_date
    '58	 plan_finish_date
    '59	 plan_by
    '60	 plan_date
    '61	 plan_status ['','APPROVE','EDIT']
    '62	 plan_approve_by
    '63	 plan_approve_date
    '64	 plan_approve_comment
    '65	 requst_score
    '66	 reques_score_date
    '67	 reques_score_comment
    '68	 customer_score
    '69	 customer_score_date
    '70	 customer_score_comment
    '71  engineer_job_detail
    '72  engineer_job_reason ' เก็บสถานของงานช่าง


%>
