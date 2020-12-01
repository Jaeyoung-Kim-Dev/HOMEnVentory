<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
    </head>
    <body>
        <h1>Reset Password</h1>
        <p>Please enter your email address to reset your password.</p>
        <form action="reset" method="post">
            <p>Email Address: <input type="text" name="email" value="${email}"></p>
            <input type="submit" value="Submit">
        </form>
        <c:if test="${emailSent eq true}"><p>Reset link has been sent to your email</p></c:if>
        <c:if test="${passwordChanged eq true}"><p>Password has been successfully changed. Please <a href="login">Login</a>.</p></c:if>
    </body>
</html>
