<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
    </head>
    <body>
        <h1>Enter a new password</h1>
        <form action="reset" method="post">
            <p><input type="password" name="newpassword" value=""></p>
            <input type="hidden" name="uuid" value="${uuid}">
            <input type="submit" value="Submit">            
        </form>
    </body>
</html>
