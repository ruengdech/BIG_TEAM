
Imports MY_CLASS
Partial Class services_dashboard
    Inherits System.Web.UI.Page
    Dim cls As New MY_CLASS

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        '<การนับ DATE MIN, MAX, AVG>
        'Close, All นับถึงวันที่ Update Date
        'Pending, WaitPO นับถึงวันปัจจุบัน
        '
        '
        '</การนับ DATE MIN, MAX, AVG>


        Try
            If IsNothing(Session("USER_TYPE")) Then
                If Request.QueryString("user_id") <> Nothing Then
                    cls.strSql = "SELECT " &
                                    "users.ID, users.username, users.pswd, employee2.name, employee2.lastname, employee2.abr, NEW_USER_MAPPING.USER_TYPE  " &
                                "FROM  " &
                                    "(users INNER JOIN employee2 ON users.sales_code = employee2.abr)  " &
                                    "LEFT JOIN NEW_USER_MAPPING ON users.ID = NEW_USER_MAPPING.OLD_ID  " &
                                "WHERE (((users.ID)=" & Request.QueryString("user_id") & ") );"
                    cls.func_SetDataSet(cls.strSql, "LOGIN")
                    If cls.ds.Tables("LOGIN").Rows.Count > 0 Then
                        With cls.ds.Tables("LOGIN").Rows(0)
                            Session("USER_ID") = .Item("ID").ToString
                            Session("USER_NAME") = .Item("username").ToString
                            Session("USER_FNAME") = .Item("name").ToString
                            Session("USER_ABR") = .Item("abr").ToString
                            Session("USER_TYPE") = .Item("USER_TYPE").ToString
                        End With
                    Else
                        Response.Redirect("authentication/login.aspx")
                    End If

                Else
                    Response.Redirect("authentication/login.aspx")
                End If
            Else
                'DO NOTHING
            End If
        Catch ex As Exception
            Response.Redirect("authentication/login.aspx")
        End Try

        Try
            Dim MSG As String = ""

            If Not Page.IsPostBack Then
                '<FOR DROPDOWNLIST>
                cls.strSql = "SELECT YY FROM RUENGDECH_SERVICE_SUM_YEAR ORDER BY YY ASC"
                cls.func_SetDataSet(cls.strSql, "YY")
                ddl_year.DataSource = cls.ds.Tables("YY")
                ddl_year.DataTextField = "YY"
                ddl_year.DataValueField = "YY"
                ddl_year.DataBind()

                Try
                    ddl_year.SelectedIndex = ddl_year.Items.Count - 1
                Catch ex As Exception
                End Try
                '</FOR DROPDOWNLIST>

                '<FOR MAIN>
                'cls.strSql = "SELECT * FROM RUENGDECH_SERVICE_SUM_YEAR ORDER BY YY ASC"
                cls.strSql = "SELECT " &
                                "RUENGDECH_SERVICE_SUM_YEAR.YY, Format([RUENGDECH_SERVICE_SUM_YEAR].[ALL],'#,##0') AS [# of ALL] " &
                                ", Format([RUENGDECH_SERVICE_SUM_YEAR].[Closed],'#,##0') AS [# of Closed] " &
                                ", Format(RUENGDECH_SERVICE_SUM_YEAR.PENDING,'#,##0') AS [# of PENDING] " &
                                ", Format(RUENGDECH_SERVICE_SUM_YEAR.Wait_PO,'#,##0') AS [# of WAIT_PO] " &
                                ", ' [  ' & iif([RUENGDECH_SERVICE_SUM_YEAR].[ALL_MIN] = 0, 1,[RUENGDECH_SERVICE_SUM_YEAR].[ALL_MIN]) & '   |   ' & Format([RUENGDECH_SERVICE_SUM_YEAR].[ALL_AVG],'#,##0') & '   |   ' & [RUENGDECH_SERVICE_SUM_YEAR].[ALL_MAX] & ' ]' AS [All  Min | Avg | Max (day)] " &
                                ", ' [  ' & iif([RUENGDECH_SERVICE_SUM_YEAR].[CLOSED_MIN] = 0, 1,[RUENGDECH_SERVICE_SUM_YEAR].[CLOSED_MIN]) & '   |   ' & Format([RUENGDECH_SERVICE_SUM_YEAR].[CLOSED_AVG],'#,##0') & '   |   ' & [RUENGDECH_SERVICE_SUM_YEAR].[CLOSED_MAX] & ' ]' AS [Closed  Min | Avg | Max (day)] " &
                                ", ' [  ' & iif([RUENGDECH_SERVICE_SUM_YEAR].[PENDING_MIN] = 0, 1,[RUENGDECH_SERVICE_SUM_YEAR].[PENDING_MIN]) & '   |   ' & Format([RUENGDECH_SERVICE_SUM_YEAR].[PENDING_AVG],'#,##0') & '   |   ' & [RUENGDECH_SERVICE_SUM_YEAR].[PENDING_MAX] & ' ]' AS [PENDING  Min | Avg | Max (day)] " &
                                ", ' [  ' & iif([RUENGDECH_SERVICE_SUM_YEAR].[WAIT_MIN] = 0, 1,[RUENGDECH_SERVICE_SUM_YEAR].[WAIT_MIN]) & '   |   ' & Format([RUENGDECH_SERVICE_SUM_YEAR].[WAIT_AVG],'#,##0') & '   |   ' & [RUENGDECH_SERVICE_SUM_YEAR].[WAIT_MAX] & ' ]' AS [WAIT_PO  Min | Avg | Max (day)] " &
                             "FROM RUENGDECH_SERVICE_SUM_YEAR  " &
                             "ORDER BY RUENGDECH_SERVICE_SUM_YEAR.YY ;"
                cls.func_SetDataSet(cls.strSql, "MAIN")
                gv_all.DataSource = cls.ds.Tables("MAIN")
                gv_all.DataBind()
                '</FOR MAIN>

                '<FOR AM>
                cls.strSql = "Select *, ('services_listam.aspx?am=' & AM & '&YYY=' & YY ) as LINK_AM  FROM RUENGDECH_SERVICE_SUM_AM " &
                            "WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY AM ASC"
                cls.func_SetDataSet(cls.strSql, "AM")
                gv_am.DataSource = cls.ds.Tables("AM")
                gv_am.DataBind()
                '</FOR AM>

                '<FOR BM>
                cls.strSql = "SELECT * ,('services_listbm.aspx?am=' & BM & '&YYY=' & YY ) as LINK_BM FROM RUENGDECH_SERVICE_SUM_BM " &
                            "WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY BM ASC"
                cls.func_SetDataSet(cls.strSql, "BM")
                gv_bm.DataSource = cls.ds.Tables("BM")
                gv_bm.DataBind()
                '</FOR BM>

                '<FOR HEAD>
                cls.strSql = "SELECT *, ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY ) as LINK_HEAD  FROM RUENGDECH_SERVICE_SUM_HEAD " &
                            " WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY HEAD_ENGINEER ASC"
                cls.func_SetDataSet(cls.strSql, "HEAD")
                gv_head.DataSource = cls.ds.Tables("HEAD")
                gv_head.DataBind()

                MSG &= "|HEAD DONE " & cls.ds.Tables("HEAD").Rows.Count
                '</FOR HEAD>

                lb_error.Text = MSG
            End If
        Catch ex As Exception
            lb_error.Text = ex.ToString
        End Try
    End Sub

    Protected Sub ddl_year_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_year.SelectedIndexChanged

        '<FOR AM>
        cls.strSql = "Select *, ('services_listam.aspx?am=' & AM & '&YYY=' & YY ) as LINK_AM  FROM RUENGDECH_SERVICE_SUM_AM " &
                            "WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY AM ASC"
        cls.func_SetDataSet(cls.strSql, "AM")
        gv_am.DataSource = cls.ds.Tables("AM")
        gv_am.DataBind()
        '</FOR AM>

        '<FOR BM>
        cls.strSql = "SELECT *,('services_listbm.aspx?am=' & trim(BM) & '&YYY=' & YY ) as LINK_BM  FROM RUENGDECH_SERVICE_SUM_BM WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY BM ASC"
        cls.func_SetDataSet(cls.strSql, "BM")
        gv_bm.DataSource = cls.ds.Tables("BM")
        gv_bm.DataBind()
        '</FOR BM>

        '<FOR HEAD> 
        cls.strSql = "SELECT *, ('services_listhead.aspx?am=' & HEAD_ENGINEER & '&YYY=' & YY ) as LINK_HEAD  FROM RUENGDECH_SERVICE_SUM_HEAD " &
                            " WHERE YY = " & ddl_year.SelectedValue.ToString & " ORDER BY HEAD_ENGINEER ASC"
        cls.func_SetDataSet(cls.strSql, "HEAD")
        gv_head.DataSource = cls.ds.Tables("HEAD")
        gv_head.DataBind()
        '</FOR HEAD>
    End Sub
End Class
