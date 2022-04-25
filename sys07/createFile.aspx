<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>



<%
    Dim fp As StreamWriter
    Dim data As String = Request.Form("data")
    Try

        fp = File.CreateText(Server.MapPath("\sys07\") & "data.txt")

        fp.WriteLine(data)

        fp.Close()
        Response.Write("SUCCESS")
    Catch err As Exception
        Response.Write("FAIL")

    End Try



    %>