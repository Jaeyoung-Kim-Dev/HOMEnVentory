<%-- 
    Document   : login
    Created on : Nov 10, 2020, 12:35:00 AM
    Author     : kornk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">                
        <style><%@include file="./style.css"%></style>
        <title>Login</title>
    </head>
    <body>
        <%-- Bootstrap --%>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


        <div class="col-md-8 col-lg-6 col-xl-4 align-self-center m-5">
            <div class="jumbotron bg-dark text-white">
                <form method="post" action="login">
                    <h1 class="text-center">Home eVentory</h1>
                    <br>
                    <br>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend ">
                            <span class="input-group-text baseColor">Username</span>
                        </div>
                        <input type="email" class="form-control" name="email" value="jaeyoung.kim.test@gmail.com">  <%-- value="${email}"> --%>
                    </div>

                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text baseColor">Password</span>
                        </div>
                        <input type="password" class="form-control" name="password" value="password"> <%-- value="${password}"> --%>
                    </div>
                    <div class="form-group row p-3">
                        <input type="submit" class="btn btn-primary btn-block" value="Log in">
                    </div>
                    <c:choose>
                        <c:when test="${emptiedField == true}">
                            <p>Invalid entry. Please enter both your username and password.</p>
                        </c:when>
                        <c:when test="${invalid == true}">
                            <p>Invalid login</p>
                        </c:when>
                        <c:when test="${logout == true}">
                            <p>The user has successfully logged out.</p>
                        </c:when>
                    </c:choose>
                </form>
                    <br>
                <form method="get" action="signup">
                    <input type="submit" class="btn btn-success btn-block" value="Sign Up">
                </form>
                <br>
                <form method="post" action="forgot">
                    <input type="submit" class="btn btn-warning btn-block" value="Forgot Password">
                </form>
            </div>
        </div>

    </body>
</html>
