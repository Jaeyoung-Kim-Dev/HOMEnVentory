<%--
    This is jsp includes html for our web page. It's connected with style.css under same WEB-INF folder.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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

        <div class="row ml-5 mr-5 mt-3">
            <div class="col  text-white">
                <h1>Home eVentory</h1>
            </div>
        </div>
         <div class="row ml-5 mr-5 mt-3">
            <div class="col">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">            
                    <div class="mr-3">
                        <div class="navbar-brand">Menu</div>
                    </div>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="inventory">Inventory</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="admin">Users</a>
                            </li>
                            <li class="nav-item active">
                                <a class="nav-link" href="category">Category</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="login?logout">Logout</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>

        <div class="row m-5">
            <div class="col-3">
                <div class="row">
                    <div class="col">
                        <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                            <c:choose>
                                <c:when test="${defaultTitle == true}">
                                    <h1 class="card-header">Category</h1>
                                </c:when>
                                <c:when test="${addCategory== true}">
                                    <h1 class="card-header">Add Category</h1>
                                </c:when>
                                <c:when test="${editCategory== true}">
                                    <h1 class="card-header">Edit Category</h1>
                                </c:when>
                            </c:choose>
                            <div class="card-body">
                                <form method="get" action="category">                              
                                    <c:choose>
                                        <c:when test="${enableForm == true}">
                                            <input type="submit" value="Add Category"  class="btn btn-primary btn-block" disabled>          
                                        </c:when>
                                        <c:when test="${enableForm == false}">
                                            <input type="submit" value="Add Category" class="btn btn-primary btn-block">
                                            <input type="hidden" name="action" value="addCategory">
                                        </c:when>
                                    </c:choose>
                                </form>
                                <br>      
                                <form method="post" action="category">
                                    <c:choose>
                                        <c:when test="${enableForm == true}">
                                            <input type="text" name="categoryName" placeholder="Category" class="form-control bg-dark text-white" value="${categoryToEdit.categoryName}">                                            
                                            <br>
                                            <input type="submit" value="Save" class="btn btn-success btn-block">
                                            <input type="hidden" name="categoryId" value="${categoryToEdit.categoryId}"> 
                                            <input type="hidden" name="action" value="saveCategory"> 
                                            <input type="hidden" name="saveMode" value="${addCategory ? 'addCategory' : 'editCategory'}">                                    
                                        </c:when>
                                        <c:when test="${enableForm == false}">    
                                            <input type="text" name="categoryName" placeholder="Category" class="form-control bg-dark text-white" disabled>                                            
                                            <br>
                                            <input type="submit" value="Save" class="btn btn-success btn-block" disabled>     
                                        </c:when>            
                                    </c:choose>                            
                                </form>
                                <br>
                                <form method="get" action="category">
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
                                        <p>The <span class="text-success">${categoryAdded}</span> has been successfully <span class="text-success">added</span>.</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${editMsg == true}">
                                <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>The <span class="text-warning">${categoryEdited}</span> has been successfully <span class="text-warning">edited</span>.</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${invalidMsg == true}">
                                <div class="card  bg-danger text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>Category name cannot be empty.</p>                                
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>    
                    </div> <%-- col --%>
                </div>  <%-- row --%>
            </div> <%-- col --%>
            <div class="col-9">
                <div class="card bg-dark text-white">  <%-- right card for user manage users form --%>
                    <h1 class="card-header">Manage Categories</h1>
                    <div class="card-body">
                        <table class="table">
                            <thead class="baseColor">
                                <tr>
                                    <th>Category Name</th>
                                    <th>Edit</th>
                                </tr>
                            </thead>
                            <c:forEach items="${categories}" var="category"> <%-- loop to find users and display in the table --%>
                                <tr class="text-white">
                                    <td>${category.categoryName}</td>
                                    <td>
                                        <form action="category" method="get">
                                            <input type="submit" value="Edit" class="btn btn-warning">
                                            <input type="hidden" name="action" value="editCategory">
                                            <input type="hidden" name="categoryId" value="${category.categoryId}">
                                        </form>
                                        <br>            
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>  
                    </div>  <%-- card-body --%>
                </div>  <%-- card --%>
            </div> <%-- col --%>
        </div>  <%-- row --%>
    </body>
</html>
