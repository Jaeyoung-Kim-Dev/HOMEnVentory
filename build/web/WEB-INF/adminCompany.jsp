<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1"> <!--fits on mobile device screen-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">                
        <style><%@include file="./style.css"%></style>
        <title>Home Inventory</title>
    </head>
    <body>
        <%-- Bootstrap --%>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

        <div class="container-fluid">
            <div class="row justify-content-md-center">
                <div class="col-9 text-white">
                    <br>
                    <h1>Home eVentory</h1>
                </div>
            </div>
            <div class="row justify-content-md-center">
                <div class="col-md-12 col-lg-9">
                    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                        <a class="navbar-brand" href="login"><div class="baseColor p-1 pl-2 pr-2">${user.firstName} ${user.lastName}</div></a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="companyadmin">Users</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="login?logout">Logout</a>
                                </li>                          
                            </ul>                        
                        </div>
                    </nav>
                </div>
            </div>
            <br>
            <div class="row justify-content-md-center">
                <div class="col-md-12 col-lg-3">
                    <div class="row">
                        <div class="col">
                            <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                <c:choose>
                                    <c:when test="${defaultTitle == true}">
                                        <h1 class="card-header">User</h1>
                                    </c:when>
                                    <c:when test="${addUser== true}">
                                        <h1 class="card-header">Add User</h1>
                                    </c:when>
                                    <c:when test="${editUser== true}">
                                        <h1 class="card-header">Edit User</h1>
                                    </c:when>
                                </c:choose>
                                <div class="card-body">
                                    <form method="get" action="companyadmin">                              
                                        <c:choose>
                                            <c:when test="${enableForm == true}">
                                                <input type="submit" value="Add User"  class="btn btn-primary btn-block" disabled>          
                                            </c:when>
                                            <c:when test="${enableForm == false}">
                                                <input type="submit" value="Add User" class="btn btn-primary btn-block">
                                                <input type="hidden" name="action" value="addUser">
                                            </c:when>
                                        </c:choose>
                                    </form>
                                    <br>      
                                    <form method="post" action="companyadmin">
                                        <c:choose>
                                            <c:when test="${enableForm == true}">
                                                <c:choose>
                                                    <c:when test="${addUser== true}">
                                                        <%--<input type="email" name="email" placeholder="Email" class="form-control bg-dark text-white" ${enableForm == true ? 'value="${userToEdit.email}"' : 'readonly'}> --%>                           
                                                        <input type="email" name="email" placeholder="Email" class="form-control bg-dark text-white">
                                                    </c:when>
                                                    <c:when test="${editUser== true}">
                                                        <input type="email" name="email" placeholder="Email" class="form-control bg-dark text-white" value="${userToEdit.email}" readonly>
                                                    </c:when>        
                                                </c:choose>
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
                                                <input type="text" name="firstName" placeholder="First Name" class="form-control bg-dark text-white" value="${userToEdit.firstName}">
                                                <br>
                                                <input type="text" name="lastName" placeholder="Last Name" class="form-control bg-dark text-white" value="${userToEdit.lastName}">
                                                <br>
                                                <input type="password" name="password" placeholder="Password" class="form-control bg-dark text-white">
                                                <br>                                    
                                                <select name="roleName" class="form-control bg-dark text-white">
                                                    <c:forEach items="${roles}" var="role">
                                                        <%-- when the role ID found then the opstion is default selected--%>
                                                        <option value="${role.roleId}" ${role.roleId == userToEdit.role.roleId ? 'selected="selected"' : ''}>${role.roleName}</option> 
                                                    </c:forEach>                        
                                                </select>   
                                                <input type="hidden" name="company" value="${company.companyId}"> 
                                                <br>
                                                <input type="submit" value="Save" class="btn btn-success btn-block">
                                                <input type="hidden" name="action" value="saveUser"> 
                                                <input type="hidden" name="saveMode" value="${addUser ? 'addUser' : 'editUser'}">                                    
                                            </c:when>
                                            <c:when test="${enableForm == false}">
                                                <input type="email" name="email" class="form-control bg-dark" value="Email" disabled>
                                                <br>
                                                <div class="form-check form-check-inline">
                                                    <div class="alert badge-secondary p-2 m-0">
                                                        <input class="form-check-input" type="radio" name="isActive" id="activeRadio" value="active" disabled>
                                                        <label class="form-check-label" for="activeRadio" style="color: white">Active</label>
                                                    </div>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <div class="alert badge-secondary p-2 m-0">
                                                        <input class="form-check-input" type="radio" name="isActive" id="inactiveRadio" value="inactive" disabled>
                                                        <label class="form-check-label" for="inactiveRadio" style="color: white">Inactive</label>
                                                    </div>
                                                </div>
                                                <br>
                                                <br>
                                                <input type="text" name="firstName" class="form-control bg-dark" value="First Name" disabled>
                                                <br>
                                                <input type="text" name="lastName" class="form-control bg-dark" value="Last Name" disabled>
                                                <br>
                                                <input type="text" name="password" class="form-control bg-dark" value="Password" disabled>
                                                <br>
                                                <select name="roleName" class="form-control bg-dark" disabled>
                                                    <option>Role</option>
                                                </select>  
                                                <br>
                                                <input type="submit" value="Save" class="btn btn-success btn-block" disabled>     
                                            </c:when>            
                                        </c:choose>                            
                                    </form>
                                    <br>
                                    <form method="get" action="companyadmin">
                                        <c:choose>
                                            <c:when test="${cancelForm == true}">
                                                <input type="submit" value="Cancel" class="btn btn-secondary btn-block">
                                                <input type="hidden" name="action" value="cancel">                                         
                                            </c:when>
                                            <c:when test="${cancelForm == false}">
                                                <input type="submit" value="Cancel" class="btn btn-secondary btn-block" disabled>            
                                            </c:when>            
                                        </c:choose>
                                    </form>                        
                                </div> <%-- card-body --%>                    
                            </div>  <%-- card --%>
                        </div>  <%-- col --%>
                    </div> <%-- row --%>
                    <br>
                    <div class="row">
                        <div class="col">
                            <c:choose>
                                <c:when test="${addMsg == true}">
                                    <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                        <div class="card-header">Message:</div>
                                        <div class="card-body">                               
                                            <p>The user (<span class="text-success">${emailAdded}</span>) has been successfully <span class="text-success">added</span>.</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${editMsg == true}">
                                    <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                        <div class="card-header">Message:</div>
                                        <div class="card-body">                               
                                            <p>The user (<span class="text-warning">${emailedited}</span>) has been successfully <span class="text-warning">edited</span>.</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${deleteMsg == true}">
                                    <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                        <div class="card-header">Message:</div>
                                        <div class="card-body">                               
                                            <p>The user (<span class="text-danger">${emailDeleted}</span>) has been successfully <span class="text-danger">deleted</span>.</p>                                
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${invalidMsg == true}">
                                    <div class="card  bg-danger text-white"> <%-- left card for user form --%>
                                        <div class="card-header">Message:</div>
                                        <div class="card-body">                               
                                            <p>All fields cannot be empty.</p>                                            
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>    
                        </div> <%-- col --%>
                    </div>  <%-- row --%>
                </div> <%-- col --%>
                <div class="col-sm-12 col-md-8 col-lg-6">
                    <div class="card bg-dark text-white">  <%-- right card for user manage users form --%>
                        <h1 class="card-header">Manage Users of ${user.company.companyName}</h1>
                        <div class="card-body overflow-auto">
                            <table class="table">
                                <thead class="baseColor">
                                    <tr>
                                        <th>Email Address</th>
                                        <th>Active</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Company</th>
                                        <th>Role</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${users}" var="user"> <%-- loop to find users and display in the table --%>
                                    <tr class="text-white">
                                        <td>${user.email}</td>
                                        <td>
                                            ${user.active ? '<span class="badge badge-success">Active</span>' : '<span class="badge badge-danger">Inactive</span>'}
                                        </td>
                                        <td>${user.firstName}</td>
                                        <td>${user.lastName}</td>
                                        <td>${user.company.companyName}</td>
                                        <td>${user.role.roleName}</td> <%-- JPA magic happening here! --%>
                                        <td>
                                            <form action="companyadmin" method="get">
                                                <input type="submit" value="Edit" class="btn btn-warning">
                                                <input type="hidden" name="action" value="editUser">
                                                <input type="hidden" name="email" value="${user.email}">
                                            </form>
                                            <br>            
                                        </td>
                                        <td>
                                            <form action="companyadmin" method="post">
                                                <input type="submit" value="Delete"class="btn btn-danger">
                                                <input type="hidden" name="action" value="deleteUser">                        
                                                <input type="hidden" name="email" value="${user.email}">
                                                <br>            
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>  
                        </div>  <%-- card-body --%>
                    </div>  <%-- card --%>
                </div> <%-- col --%>
            </div> <%-- row --%>
        </div>  <%-- container --%>
    </body>
</html>
