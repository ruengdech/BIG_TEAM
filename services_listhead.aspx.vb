
Partial Class services_listhead
    Inherits System.Web.UI.Page
    Dim AM As String = ""
    Dim YEARS As Integer = Date.Now.Year
    Dim cls As New MY_CLASS
    Dim SALE As String = ""
    Dim TYPE_ As String = ""
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            pan_dashboard.Visible = True
            pan_warning.Visible = False
            Try
                If (Session("USER_TYPE") = "ALL") Or (Session("USER_TYPE") = "EN_ALL") Then
                    'DO NOTHING ผ่านสบาย
                ElseIf (Session("USER_TYPE") = "AM_ALL") And (Session("USER_FNAME") = Request("am")) Then
                    'DO NOTHING ผ่านสบาย
                Else
                    pan_dashboard.Visible = False
                    pan_warning.Visible = True
                    Exit Sub
                End If
            Catch ex As Exception
                pan_dashboard.Visible = False
                pan_warning.Visible = True
                Exit Sub
            End Try

            AM = Request("am")
            YEARS = Request("yyy")
            lb_year.Text = YEARS
            lb_am.Text = AM

            '<FOR HEAD>
            cls.strSql = "SELECT * FROM RUENGDECH_SERVICE_SUM_HEAD WHERE YY = " & YEARS & " AND HEAD_ENGINEER = '" & AM & "' "
            cls.func_SetDataSet(cls.strSql, "HEAD")
            gv_head.DataSource = cls.ds.Tables("HEAD")
            gv_head.DataBind()
            '</FOR HEAD>



            '<FOR ENGINEER>
            cls.strSql = "SELECT ENGINEER, [ALL], CLOSED, PENDING, WAIT , ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY & '&SALE=' & ENGINEER & '&s=all') as SALE_LINK_ALL " &
                                ", ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY & '&SALE=' & ENGINEER & '&s=closed') as SALE_LINK_CLOSE " &
                                ", ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY & '&SALE=' & ENGINEER & '&s=pending') as SALE_LINK_PEND " &
                                ", ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY & '&SALE=' & ENGINEER & '&s=wait') as SALE_LINK_WAIT " &
                        " FROM RUENGDECH_SERVICE_SUM_HEAD_ENGINEER WHERE YY = " & YEARS & " AND HEAD_ENGINEER = '" & lb_am.Text & "'  ORDER BY ENGINEER ASC"
            cls.func_SetDataSet(cls.strSql, "ENGINEER")
            gv_engineer.DataSource = cls.ds.Tables("ENGINEER")
            gv_engineer.DataBind()
            '</FOR ENGINEER>

            Try
                SALE = Request("SALE")
                TYPE_ = Request("S")
                lb_sale.Text = SALE
            Catch ex As Exception

            End Try

            If TYPE_ <> "" Then
                Dim extendSQL As String = ""
                Select Case TYPE_.ToUpper
                    Case "ALL"
                    Case "CLOSED"
                        extendSQL = " AND CLOSE_JOB = 'YES' "
                    Case "WAIT"
                        extendSQL = " AND WAIT_PO = 'YES' "
                    Case "PENDING"
                        extendSQL = " AND CLOSE_JOB = 'NO' AND WAIT_PO = 'NO' "
                End Select


                '<FOR DETAIL>
                cls.strSql = "SELECT RUENGDECH_SERVICE_JOB.job_code AS [NO], RUENGDECH_SERVICE_JOB.date_created as JOB_DATE, RUENGDECH_SERVICE_JOB.job_name as [NAME], RUENGDECH_SERVICE_JOB.model as MODEL" &
                            ", RUENGDECH_SERVICE_JOB.serial1 as [SERIAL NO], RUENGDECH_SERVICE_JOB.Customer as [Customer], RUENGDECH_SERVICE_JOB.currepairStatus, RUENGDECH_SERVICE_JOB.LAST_STATUS_DATE" &
                            ", RUENGDECH_SERVICE_JOB.desc as STATUS, IIF(reservm = 1,'Yes','NO') as [Have Spare]  " &
                        "FROM RUENGDECH_SERVICE_JOB " &
                        "WHERE HEAD_ENGINEER= '" & lb_am.Text & "' AND YY = " & YEARS & " AND ENGINEER = '" & SALE & "' " & extendSQL &
                        "ORDER BY HEAD_ENGINEER ASC"
                cls.func_SetDataSet(cls.strSql, "DT")
                gv_detail.DataSource = cls.ds.Tables("DT")
                gv_detail.DataBind()
                '</FOR DETAIL>
            End If

        End If
    End Sub

    Protected Sub gv_sale_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim tmp As String = e.CommandName.ToString.ToUpper
        Dim extendSQL As String = ""
        If e.CommandName.ToString.ToUpper = "SELECT" Then
            'ALL Do Nothing
            extendSQL = " ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "EDIT" Then
            'Wait
            extendSQL = " AND WAIT_PO = 'YES'  ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "DELETE" Then
            'PENDING
            extendSQL = " AND CLOSE_JOB = 'NO'  AND WAIT_PO = 'NO'  ORDER BY date_created ASC "
        ElseIf e.CommandName.ToString.ToUpper = "NEW" Then
            'CLOSE
            extendSQL = " AND CLOSE_JOB = 'YES'  ORDER BY LAST_STATUS_DATE DESC "
        End If




        'lb_sale.Text = gv_sale.Rows(rowIndex).Cells(1).Text
        '<FOR DETAIL>
        cls.strSql = "SELECT RUENGDECH_SERVICE_JOB.job_code AS [NO], RUENGDECH_SERVICE_JOB.date_created as JOB_DATE, RUENGDECH_SERVICE_JOB.job_name as [NAME], RUENGDECH_SERVICE_JOB.model as MODEL" &
                            ", RUENGDECH_SERVICE_JOB.serial1 as [SERIAL NO], RUENGDECH_SERVICE_JOB.Customer as [Customer], RUENGDECH_SERVICE_JOB.currepairStatus, RUENGDECH_SERVICE_JOB.LAST_STATUS_DATE" &
                            ", RUENGDECH_SERVICE_JOB.desc as STATUS, IIF(reservm = 1,'Yes','NO') as [Have Spare]  " &
                        "FROM RUENGDECH_SERVICE_JOB " &
                        "WHERE AM= '" & lb_am.Text & "' AND YY = " & lb_year.Text & " AND SALE = '" & lb_sale.Text & "' " & extendSQL &
        cls.func_SetDataSet(cls.strSql, "HEAD")
        gv_detail.DataSource = cls.ds.Tables("HEAD")
        gv_detail.DataBind()
        '</FOR HEAD>

    End Sub


End Class
