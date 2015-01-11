<%@ Language=VBScript%>
<!--#include file="upload.asp"-->
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
  Response.Write "<script language=javascript>parent.UploadSaved('" & filename & "');location.href='UploadPic.asp';</script>"
Else
  Response.Write "<script language=javascript>parent.UploadError('" & Err.Description & "');history.back();</script>"
End If

Function GetRndFileName(sExt)
	Dim sRnd
	Randomize
	sRnd = Int(900 * Rnd) + 100
	GetRndFileName = year(now) & month(now) & day(now) & hour(now) & minute(now) & second(now) & sRnd & sExt
End Function

%>
