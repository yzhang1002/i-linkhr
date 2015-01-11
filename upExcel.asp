<%@ Language=VBScript%>
<!--#include file="upload.asp"-->
<!--#include file="conn.asp"-->
<%
Set upload=new upload_5xsoft 
filePath = "upload/"

For Each formName In upload.objFile   
  Set file=upload.file(formName)
  if file.FileSize>0 Then
    extended_name=right(trim(file.FileName),len(trim(file.FileName))-InStrRev(trim(file.FileName),".")+1)
    filename=GetRndFileName(extended_name)
    file.SaveAs Server.mappath(filePath&filename)
  End If
  Set file=Nothing
Next
Set upload=Nothing


If Err.NUmber = 0 Then

  Set xlApp = CreateObject("Excel.Application")
  Set xlbook = xlApp.Workbooks.Open(Server.MapPath("upload/" & filename))
  Set xlsheet = xlbook.Worksheets(1)

  i = 2
  While xlsheet.cells(i,1) <> "" 
    Response.Write xlsheet.cells(i,1)

    sql = "insert into staff(name,ic,birthday,gender,nationality,hpno,school,address,join_date) values ('" & formatSpString(xlsheet.cells(i,1)) & "','" & formatSpString(xlsheet.cells(i,2)) & "','" & enDate2Str(xlsheet.cells(i,3)) & "','" & formatSpString(xlsheet.cells(i,4)) & "','" & formatSpString(xlsheet.cells(i,5)) & "','" & formatSpString(xlsheet.cells(i,6)) & "','" & formatSpString(xlsheet.cells(i,7)) & "','" & formatSpString(xlsheet.cells(i,8)) & "','" & formatSpString(xlsheet.cells(i,9)) & "')"

    Response.Write ExecQuery(sql)
    Response.Redirect "staff.asp"
    i = i + 1
  Wend

  Set xlsheet = Nothing
  Set xlbook = Nothing
  xlApp.quit
Else
  Response.Redirect "staff.asp"
End If

Function GetRndFileName(sExt)
	Dim sRnd
	Randomize
	sRnd = Int(900 * Rnd) + 100
	GetRndFileName = year(now) & month(now) & day(now) & hour(now) & minute(now) & second(now) & sRnd & sExt
End Function

%>
