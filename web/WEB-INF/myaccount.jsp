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
                <form method="post" action="myaccount">
                    <h1 class="text-center">My Account</h1>
                    <br>
                    <br>
                    <input type="email" name="email" placeholder="Email" class="form-control bg-dark text-white" value="${userToEdit.email}">
                    <br>
                    <input type="text" name="firstName" placeholder="First Name" class="form-control bg-dark text-white" value="${userToEdit.firstName}">
                    <br>
                    <input type="text" name="lastName" placeholder="Last Name" class="form-control bg-dark text-white" value="${userToEdit.lastName}">
                    <br>
                    <input type="password" name="password" placeholder="Password" class="form-control bg-dark text-white" value="${userToEdit.password}">
                    <br>
                    <div class="form-check form-check-inline">                               
                        <div class="alert badge-success p-2 m-0">
                            <input class="form-check-input " type="radio" name="isActive" id="activeRadio" onclick = \"getAnswer('active') value="active" ${userToEdit.email == null || userToEdit.active ? 'checked': ''}>
                            <label class="form-check-label" for="activeRadio">Active</label>
                        </div>
                    </div>
                    <div class="form-check form-check-inline">
                        <div class="alert badge-danger p-2 m-0">
                            <input class="form-check-input" type="radio" name="isActive" id="inactiveRadio" onclick = \"getAnswer('active') value="inactive" ${userToEdit.email != null && !userToEdit.active ? 'checked':''}>
                            <label class="form-check-label" for="inactiveRadio">Inactive</label>
                        </div>
                    </div>
                    <br>
                    <br>
                    <input type="submit" value="Save" class="btn btn-success btn-block">
                    <input type="hidden" name="action" value="saveUser"> 
                </form>
                <br>
                <form method="get" action="myaccount">                                    
                    <input type="submit" value="Cancel" class="btn btn-secondary btn-block">
                    <input type="hidden" name="action" value="cancel">                                                                             
                </form> 
                <br>
                <c:choose>
                    <c:when test="${saved == true}">
                        <p>The account information is successfully updated.</p>
                    </c:when>
                    <c:when test="${emptiedField == true}">
                        <p>Invalid entry. Please enter all the fields.</p>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </body>
</html>