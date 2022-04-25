<%@ Page Language="VB"     %>

<script runat="server">

    Dim clss As New MY_CLASS_MSSQL("newsm", "sa", "Sapb1")
    Dim cls As New MY_CLASS_MSSQL("RUENGDECH_STMED", "ruengdech", "r4442440044ST")
</script>
<%

    Dim param As String = Request.Form("param")
    If param = "get_province" Then
        Try
            cls.strSql = " SELECT  PROVINCENAME " &
                        " FROM            SYS00_POSTCODE " &
                        " GROUP BY PROVINCENAME " &
                        " ORDER BY PROVINCENAME "
            cls.func_SetDataSet(cls.strSql, "PROV")
            If cls.ds.Tables("PROV").Rows.Count > 0 Then
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("PROV")))
            Else
                Response.Write("[]")
            End If
        Catch ex As Exception
            Response.Write("[]")
        End Try
    ElseIf param = "get_district" Then
        Try
            Dim prov As String = Request.Form("prov")

            cls.strSql = " SELECT        DISTRICTNAME " &
                            " FROM            SYS00_POSTCODE " &
                            " WHERE        (PROVINCENAME = '" & prov & "') " &
                            " GROUP BY DISTRICTNAME " &
                            " ORDER BY DISTRICTNAME "
            cls.func_SetDataSet(cls.strSql, "DIS")
            If cls.ds.Tables("DIS").Rows.Count > 0 Then
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("DIS")))
            Else
                Response.Write("[]")
            End If
        Catch ex As Exception
            Response.Write("[]")

        End Try
    ElseIf param = "get_sdistrict" Then
        Try
            Dim dis As String = Request.Form("dis")

            cls.strSql = " SELECT        SUBDISTRICTNAME " &
                            " FROM            SYS00_POSTCODE " &
                            " WHERE        (DISTRICTNAME = '" & dis & "') " &
                            " GROUP BY SUBDISTRICTNAME " &
                            " ORDER BY SUBDISTRICTNAME "
            cls.func_SetDataSet(cls.strSql, "SDIS")
            If cls.ds.Tables("SDIS").Rows.Count > 0 Then
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("SDIS")))
            Else
                Response.Write("[]")
            End If
        Catch ex As Exception
            Response.Write("[]")

        End Try
    ElseIf param = "get_data_from_postcode" Then
        Try
            Dim post As String = Request.Form("post")

            cls.strSql = " SELECT        PROVINCENAME, DISTRICTNAME, SUBDISTRICTNAME " &
                        " FROM            SYS00_POSTCODE " &
                        " WHERE        (POSTCODE = '" & post & "') " &
                        " GROUP BY SUBDISTRICTNAME, PROVINCENAME, DISTRICTNAME " &
                        " ORDER BY SUBDISTRICTNAME "
            cls.func_SetDataSet(cls.strSql, "POST")
            If cls.ds.Tables("POST").Rows.Count > 0 Then
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("POST")))
            Else
                Response.Write("[]")
            End If
        Catch ex As Exception
            Response.Write("[]")

        End Try
    ElseIf param = "get_customer_from_id" Then
        Dim taxid As String = Request.Form("tax").Replace("-", "")
        Try
            '<1. CHECK from NEW_SM then check from My SYS THEN RESPONSE>
            clss.strSql = " SELECT top(1)  'TRUE' as SAP, 'FALSE' as SYS03, CRD1.CardCode, OCRD.CardName, CRD1.GlblLocNum, OCRD.Phone1, OCRD.Phone2, CRD1.Building, CRD1.Address2, CRD1.Address3, CRD1.Street, CRD1.Block, CRD1.ZipCode, CRD1.City, CRD1.County, CRD1.Country, (SELECT Name FROM OCST WHERE (OCST.Code = CRD1.state)) as province " &
                " FROM            CRD1 INNER JOIN " &
                "                          OCRD ON CRD1.CardCode = OCRD.CardCode " &
                " WHERE        (CRD1.AdresType = 'B') AND (CRD1.GlblLocNum = N'" & taxid & "') " &
                " ORDER BY CardCode Desc"
            clss.func_SetDataSet(clss.strSql, "SAP")
            If clss.ds.Tables("SAP").Rows.Count > 0 Then
                cls.strSql = " SELECT     'TRUE' as SAP, 'TRUE' as SYS03,  UID, CardCode, TAXID, LINEID, CUSTOMER_NAME, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, STATUS " &
                            " FROM            SYS03_MS_CUSTOMER " &
                            " WHERE        (CardCode = '" & clss.ds.Tables("SAP").Rows(0).Item("CardCode").ToString() & "') OR (TAXID = '" & taxid & "') "
                cls.func_SetDataSet(cls.strSql, "CUSTOMER")
                If cls.ds.Tables("CUSTOMER").Rows.Count > 0 Then
                    Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("CUSTOMER")))
                Else
                    Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(clss.ds.Tables("SAP")))
                End If
            Else
                cls.strSql = " SELECT     'FALSE' as SAP, 'TRUE' as SYS03,  UID, CardCode, TAXID, LINEID, CUSTOMER_NAME, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, STATUS " &
                            " FROM            SYS03_MS_CUSTOMER " &
                            " WHERE        (TAXID = '" & taxid & "') "
                cls.func_SetDataSet(cls.strSql, "CUSTOMER")
                If cls.ds.Tables("CUSTOMER").Rows.Count > 0 Then
                    Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("CUSTOMER")))
                Else
                    Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(clss.ds.Tables("SAP")))
                End If
            End If
        Catch ex As Exception
            Response.Write("[]")
        End Try
    ElseIf param = "get_customer_from_lineid" Then
        Dim taxid As String = Request.Form("line").Replace("-", "")
        Try

            cls.strSql = " SELECT 'TRUE' as SYS03,  UID, CardCode, TAXID, LINEID, CUSTOMER_NAME, CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP, C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_DOB, C_EMAIL, STATUS " &
                        " FROM SYS03_MS_CUSTOMER " &
                        " WHERE (LINEID = '" & taxid & "') "
            cls.func_SetDataSet(cls.strSql, "CUSTOMER")

            If cls.ds.Tables("CUSTOMER").Rows.Count > 0 Then
                Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(cls.ds.Tables("CUSTOMER")))
            Else
                Response.Write("[]")
            End If
        Catch ex As Exception
            Response.Write("[]")
        End Try
    ElseIf param = "set_customer" Then
        Try
            Dim txt_id As String = Request.Form("txt_id").Replace("'", "&sbquo;")
            Dim txt_line As String = Request.Form("txt_line")
            Dim txt_name As String = Request.Form("txt_name").Replace("'", "&sbquo;")
            Dim txt_mob1 As String = Request.Form("txt_mob1").Replace("'", "&sbquo;")
            Dim txt_mob2 As String = Request.Form("txt_mob2").Replace("'", "&sbquo;")
            Dim txt_email As String = Request.Form("txt_email").Replace("'", "&sbquo;")
            Dim txt_addr1 As String = Request.Form("txt_addr1").Replace("'", "&sbquo;")
            Dim txt_addr2 As String = Request.Form("txt_addr2").Replace("'", "&sbquo;")
            Dim txt_zip As String = Request.Form("txt_zip")
            Dim txt_province As String = Request.Form("txt_province").Replace("'", "&sbquo;")
            Dim txt_district As String = Request.Form("txt_district").Replace("'", "&sbquo;")
            Dim txt_sdistrict As String = Request.Form("txt_sdistrict").Replace("'", "&sbquo;")
            Dim sap_id As String = Request.Form("sap_id")
            Dim sys_id As String = Request.Form("sys_id")
            cls.strSql = " SELECT UID, CardCode, TAXID, LINEID, STATUS " &
                           " FROM SYS03_MS_CUSTOMER " &
                           " WHERE (CardCode = '" & sap_id & "') OR (TAXID = '" & txt_id & "') OR (LINEID = '" & txt_line & "') "
            cls.func_SetDataSet(cls.strSql, "CUSTOMER")
            If cls.ds.Tables("CUSTOMER").Rows.Count > 0 Then
                '<Existing Customer>
                cls.strSql = "UPDATE SYS03_MS_CUSTOMER " &
                           " SET TAXID = '" & txt_id & "', LINEID = '" & txt_line & "', CUSTOMER_NAME = '" & txt_name & "', CUSTOMER_MOB = '" & txt_mob1 & "', CUSTOMER_MOB2 = '" & txt_mob2 & "' " &
                                        ", C_Address1 = '" & txt_addr1 & "', C_Address2 = '" & txt_addr2 & "', C_ZIP = '" & txt_zip & "', C_PROVINCE = '" & txt_province & "', C_DISTRICT = '" & txt_district & "' " &
                                        ", C_SUBDISTRICT = '" & txt_sdistrict & "', C_EMAIL = '" & txt_email & "', MWHEN = GETDATE() " &
                           " WHERE (UID = " & cls.ds.Tables("CUSTOMER").Rows(0).Item("UID").ToString() & ") "
                If cls.func_execute(cls.strSql) Then
                    Response.Write("SUCCESS:UPDATE")
                Else
                    Response.Write("FAIL:UPDATE")
                End If
                '</Existing Customer>
            Else
                '<New Customer>
                cls.strSql = "INSERT INTO SYS03_MS_CUSTOMER " &
                           " (CardCode, TAXID, LINEID, CUSTOMER_NAME" &
                           ", CUSTOMER_MOB, CUSTOMER_MOB2, C_Address1, C_Address2, C_ZIP" &
                           ", C_PROVINCE, C_DISTRICT, C_SUBDISTRICT, C_EMAIL, DATE_ADD) " &
                           " VALUES ('" & sap_id & "', '" & txt_id & "', '" & txt_line & "', '" & txt_name & "'" &
                                    ", '" & txt_mob1 & "', '" & txt_mob2 & "', '" & txt_addr1 & "', '" & txt_addr2 & "', '" & txt_zip & "'" &
                                    ", '" & txt_province & "', '" & txt_district & "', '" & txt_sdistrict & "', '" & txt_email & "', GETDATE()) "
                If cls.func_execute(cls.strSql) Then
                    Response.Write("SUCCESS:ADD")
                Else
                    Response.Write("FAIL:ADD")
                End If
                '</New Customer>
            End If
        Catch ex As Exception
            Response.Write("FAIL:CATCH")
        End Try

    End If




%>