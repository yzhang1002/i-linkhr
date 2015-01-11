<%@ Language=VBScript%>
<!-- #include file="check.asp" -->
<!--#include file="conn.asp"-->

<%
sID = Request("signid")

hotelrate = 0
set rs = GetRecordSet("select hotelrate from customer where cusname='" & formatSpString(Request("hotelname")) & "'")

If (Not rs.eof) And (Not rs.bof) Then
  hotelrate = rs("hotelrate")
End If

'// update
sql = "update sign_base set signdate='" & formatSpString(Request("signdate")) & "',joborder='" & formatSpString(Request("joborder")) & "',timein='" & formatSpString(Request("timein")) & "',timeout='" & formatSpString(Request("timeout")) & "',hotelname='" & formatSpString(Request("hotelname")) & "',venuename='" & formatSpString(Request("venuename")) & "',hotelrate='" & hotelrate & "',attention='" & formatSpString(Request("attention")) & "',staffnum=" & formatSpString(Request("staffnum")) & " where signid=" & sID

Response.Write ExecQuery(sql)

'// delete
sql = "delete from sign_list where signid=" & sID
Response.Write ExecQuery(sql)

staffid = Split(Request("staffid"),",")
timein = Split(Request("row_timein"),",")
timeout = Split(Request("row_timeout"),",")
hours = Split(Request("hours"),",")

For i=LBound(staffid) To UBound(staffid)

  sql = "insert into sign_list(signid,staffid,timein,timeout,hours,hotelrate,amount) values (" & sID & "," & staffid(i) & ",'" & formatSpString(timein(i)) & "','" & formatSpString(timeout(i)) & "'," & formatSpString(hours(i)) & "," & hotelrate & "," & CDbl(hours(i)) * CDbl(hotelrate) & ")"

  Response.Write ExecQuery(sql)

Next

%>