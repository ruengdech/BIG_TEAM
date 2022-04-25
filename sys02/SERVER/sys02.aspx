<%@ Page Language="VB" %>

<% 
    Dim cls As New MY_CLASS
    Dim clsSQL As New MY_CLASS_MSSQL
    Dim feature As String = Request.Form("feature")



    Select Case feature
        Case "save_customer_status"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_CUSTOMER_STATE (CUSTSTATE_NAME, CUSTSTATE_STATUS) VALUES ('" & ctrl_txt_name & "', 'ACTIVE')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_CUSTOMER_STATE SET CUSTSTATE_NAME = '111', CUSTSTATE_STATUS = '111', MWHEN = GETDATE() WHERE (CUSTSTATE_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_CUSTOMER_STATE SET " &
                                        "CUSTSTATE_NAME = '" & ctrl_txt_name & "'" &
                                        ", CUSTSTATE_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (CUSTSTATE_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_order_status"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_ORDER_STATE (ORDERSTATE_NAME, ORDERSTATE_STATUS) VALUES ('" & ctrl_txt_name & "', 'ACTIVE')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_ORDER_STATE SET ORDERSTATE_NAME = '111', ORDERSTATE_STATUS = '111', MWHEN = GETDATE() WHERE (ORDERSTATE_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_ORDER_STATE SET " &
                                        "ORDERSTATE_NAME = '" & ctrl_txt_name & "'" &
                                        ", ORDERSTATE_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (ORDERSTATE_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_prob_status"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_ORDER_PROB (ORDERPROB_NAME, ORDERPROB_STATUS) VALUES ('" & ctrl_txt_name & "', 'ACTIVE')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_ORDER_PROB SET ORDERPROB_NAME = '111', ORDERPROB_STATUS = '111', MWHEN = GETDATE() WHERE (ORDERPROB_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_ORDER_PROB SET " &
                                        "ORDERPROB_NAME = '" & ctrl_txt_name & "'" &
                                        ", ORDERPROB_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (ORDERPROB_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_brand"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_BRAND (BRAND_NAME, BRAND_STATUS) VALUES ('" & ctrl_txt_name & "', 'ACTIVE')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_BRAND SET BRAND_NAME = '111', BRAND_STATUS = '111', MWHEN = GETDATE() WHERE (BRAND_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_BRAND SET " &
                                        "BRAND_NAME = '" & ctrl_txt_name & "'" &
                                        ", BRAND_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (BRAND_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_product"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_sel_brand As String = Request.Form("ctrl_sel_brand")
                Dim ctrl_sel_staff As String = Request.Form("ctrl_sel_staff")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_PRODUCT (PRODUCT_BRAND_ID, PRODUCT_STAFF_ID, PRODUCT_NAME) VALUES (" & ctrl_sel_brand & ", " & ctrl_sel_staff & ", '" & ctrl_txt_name & "')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_PRODUCT SET BRAND_NAME = '111', BRAND_STATUS = '111', MWHEN = GETDATE() WHERE (BRAND_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_PRODUCT SET " &
                                        "PRODUCT_BRAND_ID = " & ctrl_sel_brand & " " &
                                        ", PRODUCT_STAFF_ID = " & ctrl_sel_staff & " " &
                                        ", PRODUCT_NAME = '" & ctrl_txt_name & "'" &
                                        ", PRODUCT_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (PRODUCT_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_budget_type"
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_status As String = Request.Form("ctrl_txt_status")

                If ctrl_txt_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_BUDGET_TYPE (BUDGETTYPE_NAME, BUDGETTYPE_STATUS) VALUES ('" & ctrl_txt_name & "', 'ACTIVE')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_BUDGET_TYPE SET BUDGETTYPE_NAME = '111', BUDGETTYPE_STATUS = '111', MWHEN = GETDATE() WHERE (BUDGETTYPE_ID = 111)"
                    clsSQL.strSql = "UPDATE SYS02_MS_BUDGET_TYPE SET " &
                                        "BUDGETTYPE_NAME = '" & ctrl_txt_name & "'" &
                                        ", BUDGETTYPE_STATUS = '" & ctrl_txt_status & "'" &
                                        ", MWHEN = GETDATE() " &
                                    "WHERE (BUDGETTYPE_ID = " & ctrl_txt_id & ")"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_staff"
            Try
                Dim ctrl_txt_uuid As String = Request.Form("ctrl_txt_uuid")
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim ctrl_txt_name As String = Request.Form("ctrl_txt_name")
                Dim ctrl_txt_login As String = Request.Form("ctrl_txt_login")
                Dim ctrl_txt_pass As String = Request.Form("ctrl_txt_pass")
                Dim ctrl_txt_bossid As String = Request.Form("ctrl_txt_bossid")
                Dim ctrl_txt_bossname As String = Request.Form("ctrl_txt_bossname")
                Dim ctrl_sel_type As String = Request.Form("ctrl_sel_type")
                Dim ctrl_txt_role As String = Request.Form("ctrl_txt_role")
                Dim ctrl_txt_remark As String = Request.Form("ctrl_txt_remark")
                Dim ctrl_sel_status As String = Request.Form("ctrl_sel_status")

                If ctrl_txt_uuid.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_MS_STAFF (STAFF_ID, STAFF_NAME, STAFF_LOGIN, STAFF_PASSWORD, STAFF_BOSSID, STAFF_BOSSNAME, STAFF_SALE_CATEGORY, STAFF_ROLE, STAFF_STATUS, STAFF_CWHEN, STAFF_REMARK) VALUES ('123', '123', '123', '123', '123', '123', '123', '123', 'ACTIVE', GETDATE(), '123')"
                    clsSQL.strSql = "INSERT INTO SYS02_MS_STAFF " &
                                        "(STAFF_ID, STAFF_NAME, STAFF_LOGIN" &
                                        ", STAFF_PASSWORD, STAFF_BOSSID, STAFF_BOSSNAME" &
                                        ", STAFF_SALE_CATEGORY, STAFF_ROLE, STAFF_STATUS" &
                                        ", STAFF_CWHEN, STAFF_REMARK) " &
                                    "VALUES " &
                                        "('" & ctrl_txt_id & "', '" & ctrl_txt_name & "', '" & ctrl_txt_login & "'" &
                                        ", '" & ctrl_txt_pass & "', '" & ctrl_txt_bossid & "', '" & ctrl_txt_bossname & "'" &
                                        ", '" & ctrl_sel_type & "', '" & ctrl_txt_role & "', 'ACTIVE'" &
                                        ", GETDATE(), '" & ctrl_txt_remark & "')"
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_STAFF SET STAFF_ID = '123', STAFF_NAME = '123', STAFF_LOGIN = '456', STAFF_PASSWORD = '123', STAFF_BOSSID = '456', STAFF_BOSSNAME = '123', STAFF_SALE_CATEGORY = '456', STAFF_ROLE = '123', STAFF_STATUS = '456', STAFF_REMARK = '123', STAFF_MWHEN = GETDATE() WHERE (UID = 11)"
                    clsSQL.strSql = "UPDATE SYS02_MS_STAFF SET " &
                                        "STAFF_ID = '" & ctrl_txt_id & "', STAFF_NAME = '" & ctrl_txt_name & "', STAFF_LOGIN = '" & ctrl_txt_login & "'" &
                                        ", STAFF_PASSWORD = '" & ctrl_txt_pass & "', STAFF_BOSSID = '" & ctrl_txt_bossid & "', STAFF_BOSSNAME = '" & ctrl_txt_bossname & "'" &
                                        ", STAFF_SALE_CATEGORY = '" & ctrl_sel_type & "', STAFF_ROLE = '" & ctrl_txt_role & "', STAFF_STATUS = '" & ctrl_sel_status & "'" &
                                        ", STAFF_REMARK = '" & ctrl_txt_remark & "', STAFF_MWHEN = GETDATE() " &
                                    "WHERE (UID = " & ctrl_txt_uuid & ")"

                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_sale"
            Try
                Dim ctrl_txt_sale_id As String = Request.Form("ctrl_txt_sale_id")
                Dim ctrl_txt_sale_date As String = Request.Form("ctrl_txt_sale_date")
                Dim ctrl_txt_sale_hospital As String = Request.Form("ctrl_txt_sale_hospital")
                Dim ctrl_txt_txt_sale_department As String = Request.Form("ctrl_txt_txt_sale_department")
                Dim ctrl_sel_brand_name As String = Request.Form("ctrl_sel_brand_name")
                Dim ctrl_sel_product_name As String = Request.Form("ctrl_sel_product_name")
                Dim ctrl_sel_sale_product_model_id As String = Request.Form("ctrl_sel_sale_product_model_id")
                Dim ctrl_txt_sale_product_model_name As String = Request.Form("ctrl_txt_sale_product_model_name")
                Dim ctrl_txt_sale_unit_price As String = Request.Form("ctrl_txt_sale_unit_price")
                Dim ctrl_txt_sale_qty As String = Request.Form("ctrl_txt_sale_qty")
                Dim ctrl_txt_sale_total_price As String = Request.Form("ctrl_txt_sale_total_price")
                Dim ctrl_sel_custstate_name As String = Request.Form("ctrl_sel_custstate_name")
                Dim ctrl_sel_orderstate_name As String = Request.Form("ctrl_sel_orderstate_name")
                Dim ctrl_txt_sale_estimate_in As String = Request.Form("ctrl_txt_sale_estimate_in")
                Dim ctrl_sel_ordertype_name As String = Request.Form("ctrl_sel_ordertype_name")
                Dim ctrl_sel_sale_order_year As String = Request.Form("ctrl_sel_sale_order_year")
                Dim ctrl_sel_sale_order_month As String = Request.Form("ctrl_sel_sale_order_month")
                Dim ctrl_sel_orderprob_name As String = Request.Form("ctrl_sel_orderprob_name")
                Dim ctrl_sel_budgettype_name As String = Request.Form("ctrl_sel_budgettype_name")
                Dim ctrl_txt_staff_id As String = Request.Form("ctrl_txt_staff_id")
                Dim ctrl_txt_staff_uid As String = Request.Form("ctrl_txt_staff_uid")
                Dim ctrl_txt_staff_name As String = Request.Form("ctrl_txt_staff_name")
                Dim ctrl_txt_bm_name As String = Request.Form("ctrl_txt_bm_name")
                Dim ctrl_txt_bm_id As String = Request.Form("ctrl_txt_bm_id")
                Dim ctrl_sel_am_name As String = Request.Form("ctrl_sel_am_name")
                Dim ctrl_txt_sale_remark As String = Request.Form("ctrl_txt_sale_remark")
                Dim ctrl_txt_user_name As String = Request.Form("ctrl_txt_user_name")

                If ctrl_sel_budgettype_name = "" Then ctrl_sel_budgettype_name = "0"
                If ctrl_sel_ordertype_name = "" Then ctrl_sel_ordertype_name = "0"
                If ctrl_sel_orderstate_name = "" Then ctrl_sel_orderstate_name = "0"


                If ctrl_txt_sale_id.Length < 1 Then
                    '<ADD NEW>
                    clsSQL.strSql = "INSERT INTO SYS02_TS_SALE (SALE_DATE, SALE_HOSPITAL, SALE_DEPARTMENT, SALE_PRODUCT_MODEL_ID, SALE_PRODUCT_MODEL_NAME, SALE_UNIT_PRICE, SALE_QTY, SALE_TOTAL_PRICE, SALE_CUSTSTATE_ID, SALE_ORDERSTATE_ID, SALE_ESTIMATE_IN, SALE_STAFF_ID, SALE_STAFF_AM_ID, SALE_STAFF_BM_ID, SALE_ORDER_TYPE, SALE_ORDER_YEAR, SALE_ORDER_MONTH, SALE_PROB_ID, SALE_BUDGET_ID, SALE_REMARK, SALE_CWHEN, SALE_CNAME) VALUES (123, '12', '123', 12, '123', 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, 123, '123', 123, '123123')"
                    If ctrl_txt_sale_date.Length < 5 Then
                        clsSQL.strSql = "INSERT INTO SYS02_TS_SALE (" &
                                    "SALE_HOSPITAL, SALE_DEPARTMENT" &
                                    ", SALE_PRODUCT_ID, SALE_PRODUCT_MODEL_NAME, SALE_UNIT_PRICE" &
                                    ", SALE_QTY, SALE_TOTAL_PRICE, SALE_CUSTSTATE_ID" &
                                    ", SALE_ORDERSTATE_ID, SALE_ESTIMATE_IN, SALE_STAFF_ID" &
                                    ", SALE_STAFF_AM_ID, SALE_STAFF_BM_ID, SALE_ORDER_TYPE" &
                                    ", SALE_ORDER_YEAR, SALE_ORDER_MONTH, SALE_PROB_ID" &
                                    ", SALE_BUDGET_ID, SALE_REMARK, SALE_CWHEN" &
                                    ", SALE_CNAME" &
                                  ")" &
                                  " VALUES (" &
                                    "'" & ctrl_txt_sale_hospital & "', '" & ctrl_txt_txt_sale_department & "'" &
                                    ", " & ctrl_sel_product_name & ", '" & ctrl_txt_sale_product_model_name & "', " & ctrl_txt_sale_unit_price & "" &
                                    ", " & ctrl_txt_sale_qty & ", " & ctrl_txt_sale_total_price & ", " & ctrl_sel_custstate_name & "" &
                                    ", " & ctrl_sel_orderstate_name & ", '" & ctrl_txt_sale_estimate_in & "', '" & ctrl_txt_staff_uid & "'" &
                                    ", '" & ctrl_sel_am_name & "', '" & ctrl_txt_bm_id & "', " & ctrl_sel_ordertype_name & "" &
                                    ", " & ctrl_sel_sale_order_year & ", " & ctrl_sel_sale_order_month & ", " & ctrl_sel_orderprob_name & "" &
                                    ", " & ctrl_sel_budgettype_name & ", '" & ctrl_txt_sale_remark & "', GETDATE()" &
                                    ", '" & ctrl_txt_user_name & "')"
                    Else
                        clsSQL.strSql = "INSERT INTO SYS02_TS_SALE (" &
                                    "SALE_DATE, SALE_HOSPITAL, SALE_DEPARTMENT" &
                                    ", SALE_PRODUCT_ID, SALE_PRODUCT_MODEL_NAME, SALE_UNIT_PRICE" &
                                    ", SALE_QTY, SALE_TOTAL_PRICE, SALE_CUSTSTATE_ID" &
                                    ", SALE_ORDERSTATE_ID, SALE_ESTIMATE_IN, SALE_STAFF_ID" &
                                    ", SALE_STAFF_AM_ID, SALE_STAFF_BM_ID, SALE_ORDER_TYPE" &
                                    ", SALE_ORDER_YEAR, SALE_ORDER_MONTH, SALE_PROB_ID" &
                                    ", SALE_BUDGET_ID, SALE_REMARK, SALE_CWHEN" &
                                    ", SALE_CNAME" &
                                  ")" &
                                  " VALUES (" &
                                    "'" & ctrl_txt_sale_date & "', '" & ctrl_txt_sale_hospital & "', '" & ctrl_txt_txt_sale_department & "'" &
                                    ", " & ctrl_sel_product_name & ", '" & ctrl_txt_sale_product_model_name & "', " & ctrl_txt_sale_unit_price & "" &
                                    ", " & ctrl_txt_sale_qty & ", " & ctrl_txt_sale_total_price & ", " & ctrl_sel_custstate_name & "" &
                                    ", " & ctrl_sel_orderstate_name & ", '" & ctrl_txt_sale_estimate_in & "', '" & ctrl_txt_staff_uid & "'" &
                                    ", '" & ctrl_sel_am_name & "', '" & ctrl_txt_bm_id & "', " & ctrl_sel_ordertype_name & "" &
                                    ", " & ctrl_sel_sale_order_year & ", " & ctrl_sel_sale_order_month & ", " & ctrl_sel_orderprob_name & "" &
                                    ", " & ctrl_sel_budgettype_name & ", '" & ctrl_txt_sale_remark & "', GETDATE()" &
                                    ", '" & ctrl_txt_user_name & "')"

                    End If
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_STAFF SET STAFF_ID = '123', STAFF_NAME = '123', STAFF_LOGIN = '456', STAFF_PASSWORD = '123', STAFF_BOSSID = '456', STAFF_BOSSNAME = '123', STAFF_SALE_CATEGORY = '456', STAFF_ROLE = '123', STAFF_STATUS = '456', STAFF_REMARK = '123', STAFF_MWHEN = GETDATE() WHERE (UID = 11)"
                    If ctrl_txt_sale_date.Length < 5 Then
                        clsSQL.strSql = "UPDATE SYS02_TS_SALE SET  " &
                                    "SALE_HOSPITAL = '" & ctrl_txt_sale_hospital & "' " &
                                    ", SALE_DEPARTMENT = '" & ctrl_txt_txt_sale_department & "', SALE_PRODUCT_MODEL_NAME = '" & ctrl_txt_sale_product_model_name & "' " &
                                    ", SALE_UNIT_PRICE = " & ctrl_txt_sale_unit_price & ", SALE_QTY = " & ctrl_txt_sale_qty & " " &
                                    ", SALE_TOTAL_PRICE = " & ctrl_txt_sale_total_price & ", SALE_CUSTSTATE_ID = " & ctrl_sel_custstate_name & " " &
                                    ", SALE_ORDERSTATE_ID = " & ctrl_sel_orderstate_name & ", SALE_ESTIMATE_IN = '" & ctrl_txt_sale_estimate_in & "' " &
                                    ", SALE_STAFF_ID = '" & ctrl_txt_staff_id & "', SALE_STAFF_AM_ID = '" & ctrl_sel_am_name & "' " &
                                    ", SALE_STAFF_BM_ID = '" & ctrl_txt_bm_id & "', SALE_ORDER_TYPE = " & ctrl_sel_ordertype_name & " " &
                                    ", SALE_ORDER_YEAR = " & ctrl_sel_sale_order_year & ", SALE_ORDER_MONTH = " & ctrl_sel_sale_order_month & " " &
                                    ", SALE_PROB_ID = " & ctrl_sel_orderprob_name & ", SALE_BUDGET_ID = " & ctrl_sel_budgettype_name & " " &
                                    ", SALE_REMARK = '" & ctrl_txt_sale_remark & "', SALE_MWHEN = GETDATE() " &
                                    ", SALE_MNAME = '" & ctrl_txt_user_name & "', SALE_PRODUCT_ID = " & ctrl_sel_product_name & "  " &
                                "WHERE (UID = " & ctrl_txt_sale_id & ") "
                    Else
                        clsSQL.strSql = "UPDATE SYS02_TS_SALE SET  " &
                                    "SALE_DATE = '" & ctrl_txt_sale_date & "', SALE_HOSPITAL = '" & ctrl_txt_sale_hospital & "' " &
                                    ", SALE_DEPARTMENT = '" & ctrl_txt_txt_sale_department & "', SALE_PRODUCT_MODEL_NAME = '" & ctrl_txt_sale_product_model_name & "' " &
                                    ", SALE_UNIT_PRICE = " & ctrl_txt_sale_unit_price & ", SALE_QTY = " & ctrl_txt_sale_qty & " " &
                                    ", SALE_TOTAL_PRICE = " & ctrl_txt_sale_total_price & ", SALE_CUSTSTATE_ID = " & ctrl_sel_custstate_name & " " &
                                    ", SALE_ORDERSTATE_ID = " & ctrl_sel_orderstate_name & ", SALE_ESTIMATE_IN = '" & ctrl_txt_sale_estimate_in & "' " &
                                    ", SALE_STAFF_ID = '" & ctrl_txt_staff_id & "', SALE_STAFF_AM_ID = '" & ctrl_sel_am_name & "' " &
                                    ", SALE_STAFF_BM_ID = '" & ctrl_txt_bm_id & "', SALE_ORDER_TYPE = " & ctrl_sel_ordertype_name & " " &
                                    ", SALE_ORDER_YEAR = " & ctrl_sel_sale_order_year & ", SALE_ORDER_MONTH = " & ctrl_sel_sale_order_month & " " &
                                    ", SALE_PROB_ID = " & ctrl_sel_orderprob_name & ", SALE_BUDGET_ID = " & ctrl_sel_budgettype_name & " " &
                                    ", SALE_REMARK = '" & ctrl_txt_sale_remark & "', SALE_MWHEN = GETDATE() " &
                                    ", SALE_MNAME = '" & ctrl_txt_user_name & "', SALE_PRODUCT_ID = " & ctrl_sel_product_name & "  " &
                                "WHERE (UID = " & ctrl_txt_sale_id & ") "
                    End If
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "delete_sale_order"
            Try
                Dim ctrl_txt_sale_id As String = Request.Form("ctrl_txt_sale_id")
                Dim ctrl_txt_user_name As String = Request.Form("ctrl_txt_user_name")

                If ctrl_txt_sale_id.Length < 1 Then
                    Response.Write("FAIL SQL=" & clsSQL.strSql)
                Else
                    clsSQL.strSql = "UPDATE SYS02_MS_STAFF SET STAFF_ID = '123', STAFF_NAME = '123', STAFF_LOGIN = '456', STAFF_PASSWORD = '123', STAFF_BOSSID = '456', STAFF_BOSSNAME = '123', STAFF_SALE_CATEGORY = '456', STAFF_ROLE = '123', STAFF_STATUS = '456', STAFF_REMARK = '123', STAFF_MWHEN = GETDATE() WHERE (UID = 11)"

                    clsSQL.strSql = "UPDATE SYS02_TS_SALE SET SALE_STATUS = 'INACTIVE', SALE_MWHEN = GETDATE() , SALE_MNAME = '" & ctrl_txt_user_name & "'  " &
                                    "WHERE (UID = " & ctrl_txt_sale_id & ") "
                    If clsSQL.func_execute(clsSQL.strSql) Then
                        Response.Write("SUCCESS")
                    Else
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try
        Case "save_approve"
            '#2021-06-29 For Submit data to Project database in ACCESS for MAN Applicaiton
            Try
                Dim ctrl_txt_id As String = Request.Form("ctrl_txt_id")
                Dim STATE As String = Request.Form("state")

                If ctrl_txt_id.Length < 1 Then
                    Response.Write("FAIL SQL=" & clsSQL.strSql)
                Else

                    clsSQL.strSql = "SELECT " &
                                        "UID, SALE_UNIT_PRICE, SALE_QTY, SALE_TOTAL_PRICE, BRAND_NAME, PRODUCT_NAME, SALE_PRODUCT_MODEL_NAME, SALE_HOSPITAL, SALE_STAFF_ID " &
                                    "FROM " &
                                        "SYS02_TS_SALE INNER JOIN SYS02_MS_PRODUCT ON SYS02_TS_SALE.SALE_PRODUCT_ID = SYS02_MS_PRODUCT.PRODUCT_ID" &
                                        " INNER JOIN SYS02_MS_BRAND ON SYS02_MS_PRODUCT.PRODUCT_BRAND_ID = SYS02_MS_BRAND.BRAND_ID " &
                                    "WHERE (SYS02_TS_SALE.UID = " & ctrl_txt_id & ") "
                    clsSQL.func_SetDataSet(clsSQL.strSql, "DATA")





                    If clsSQL.ds.Tables("DATA").Rows.Count = 0 Then
                        Response.Write("FAIL SQL=" & clsSQL.strSql)
                    Else
                        Select Case STATE
                            Case "WAITAM"
                                clsSQL.strSql = "UPDATE SYS02_TS_SALE SET SALE_REQUEST_ID = '" & STATE & "' WHERE (SYS02_TS_SALE.UID = " & ctrl_txt_id & ") "
                                clsSQL.func_execute(clsSQL.strSql)
                                Response.Write("SUCCESS")
                            Case "APPROVEAM"
                                With clsSQL.ds.Tables("DATA").Rows(0)
                                    Dim _staff_id As String = ""
                                    cls.strSql = "select top 1 id from employee2 where uid = " & .Item("SALE_STAFF_ID").ToString
                                    cls.func_SetDataSet(cls.strSql, "EMP_ID")
                                    _staff_id = cls.ds.Tables("EMP_ID").Rows(0).Item(0).ToString()


                                    cls.strSql = "insert into projects_pre (funnel_id, cl, project_desc, unitnum, unitprice, pro_value, employee_id_fk ,ap_status ) " &
                                                " values " &
                                                        "(" &
                                                            "'" & ctrl_txt_id & "'" &
                                                            ",'" & Left(.Item("SALE_HOSPITAL").ToString, 254) & "'" &
                                                            ",'" & Right((.Item("BRAND_NAME").ToString & .Item("PRODUCT_NAME").ToString & .Item("SALE_PRODUCT_MODEL_NAME").ToString), 254) & "'" &
                                                            "," & .Item("SALE_QTY").ToString &
                                                            "," & .Item("SALE_UNIT_PRICE").ToString &
                                                            "," & .Item("SALE_TOTAL_PRICE").ToString &
                                                            "," & _staff_id &
                                                            ",15 " &
                                                        ") "
                                    If cls.func_execute(cls.strSql) Then
                                        clsSQL.strSql = "UPDATE SYS02_TS_SALE SET SALE_REQUEST_ID = '" & STATE & "' WHERE (SYS02_TS_SALE.UID = " & ctrl_txt_id & ") "
                                        clsSQL.func_execute(clsSQL.strSql)
                                        Response.Write("SUCCESS")
                                    Else
                                        Response.Write("FAIL (ACCESS)SQL=" & cls.strSql)
                                    End If
                                End With
                            Case "REJECTAM"
                                With clsSQL.ds.Tables("DATA").Rows(0)
                                    Dim _staff_id As String = ""
                                    cls.strSql = "select top 1 id from employee2 where uid = " & .Item("SALE_STAFF_ID").ToString
                                    cls.func_SetDataSet(cls.strSql, "EMP_ID")
                                    _staff_id = cls.ds.Tables("EMP_ID").Rows(0).Item(0).ToString()


                                    cls.strSql = "delete from projects_pre where funnel_id = '" & ctrl_txt_id & "' "
                                    If cls.func_execute(cls.strSql) Then
                                        clsSQL.strSql = "UPDATE SYS02_TS_SALE SET SALE_REQUEST_ID = '' WHERE (SYS02_TS_SALE.UID = " & ctrl_txt_id & ") "
                                        clsSQL.func_execute(clsSQL.strSql)
                                        Response.Write("SUCCESS")
                                    Else
                                        Response.Write("FAIL (ACCESS)SQL=" & cls.strSql)
                                    End If
                                End With
                        End Select

                    End If
                    '<UPDATE>
                End If

            Catch ex As Exception
                Response.Write("FAIL")
                Response.Write(ex.ToString)
            End Try

    End Select

    ''#Region "TRICKER UPDATE"
    '<#UPDATE SALE FUNNEL FROM PROJECT OF MAN>
    Try
        cls.strSql = "SELECT TOP 50 ID, project_code1, pro_value, funnel_id " &
             " FROM projects " &
             " WHERE (projects.funnel_id <> '') " &
             " Order by ID DESC "
        If cls.func_SetDataSet(cls.strSql, "PROJECT_DATA") Then
            If cls.ds.Tables("PROJECT_DATA").Rows.Count > 0 Then
                For i As Integer = 0 To cls.ds.Tables("PROJECT_DATA").Rows.Count - 1
                    With cls.ds.Tables("PROJECT_DATA").Rows(i)
                        clsSQL.strSql = "UPDATE SYS02_TS_SALE SET " &
                                            " SALE_TOTAL_PRICE = " & .Item("PRO_VALUE").ToString &
                                            " , SALE_REQUEST_ID = '" & .Item("ID").ToString & "' " &
                                            " , SALE_PROJECT_ID = '" & .Item("project_code1").ToString & "' " &
                                        "WHERE UID = " & .Item("funnel_id").ToString
                        clsSQL.func_execute(clsSQL.strSql)
                    End With
                Next
            End If
        End If

    Catch ex As Exception

    End Try
    '</#UPDATE SALE FUNNEL FROM PROJECT OF MAN>
    ''#End Region
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

    '#TRICKER FOR DATA SYNC
%>
