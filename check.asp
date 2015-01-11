<%

if session("admin")="pingfenxitongadmin" then

session("pass")="You are logged in!"

else 
session("erro")="You are not logged, please re-login!"
response.redirect "login.asp"
end if
session.TimeOut=15
%>


