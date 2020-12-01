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
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark ">            
                    <div class="mr-3">
                        <div class="navbar-brand"><div class="baseColor p-1 pl-2 pr-2">${user.firstName} ${user.lastName}</div></div>
                    </div>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item active">
                                <a class="nav-link" href="inventory">Inventory</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="myaccount">My Account</a>
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
                                    <h1 class="card-header">Item</h1>
                                </c:when>
                                <c:when test="${addItem== true}">
                                    <h1 class="card-header">Add Item</h1>
                                </c:when>
                                <c:when test="${editItem== true}">
                                    <h1 class="card-header">Edit Item</h1>
                                </c:when>
                            </c:choose>
                            <div class="card-body">
                                <form method="get" action="inventory">                              
                                    <c:choose>
                                        <c:when test="${enableForm == true}">
                                            <input type="submit" value="Add Item"  class="btn btn-primary btn-block" disabled>          
                                        </c:when>
                                        <c:when test="${enableForm == false}">
                                            <input type="submit" value="Add Item" class="btn btn-primary btn-block">
                                            <input type="hidden" name="action" value="addItem">
                                        </c:when>
                                    </c:choose>
                                </form>
                                <br>      
                                <form method="post" action="inventory">
                                    <c:choose>
                                        <c:when test="${enableForm == true}">                                            
                                            <select name="categoryName" class="form-control bg-dark text-white">
                                                <c:forEach items="${categories}" var="category">
                                                    <%-- when the role ID found then the opstion is default selected--%>
                                                    <option value="${category.categoryId}" ${category.categoryId == itemToEdit.category.categoryId ? 'selected="selected"' : ''}>${category.categoryName}</option> 
                                                </c:forEach>                        
                                            </select>   
                                            <br>                                                                                        
                                            <input type="text" name="itemName" placeholder="Name" class="form-control bg-dark text-white" value="${itemToEdit.itemName}">
                                            <br>
                                            <input type="text" name="price" placeholder="Price" class="form-control bg-dark text-white" value="${itemToEdit.price}">
                                            <br>                                            
                                            <input type="submit" value="Save" class="btn btn-success btn-block">
                                            <input type="hidden" name="itemId" value="${itemToEdit.itemId}"> 
                                            <input type="hidden" name="action" value="saveItem"> 
                                            <input type="hidden" name="saveMode" value="${addItem ? 'addItem' : 'editItem'}">                                    
                                        </c:when>
                                        <c:when test="${enableForm == false}">    
                                            <select name="categoryName" class="form-control bg-dark" disabled>
                                                <option>Category</option>
                                            </select>  
                                            <br>
                                            <input type="text" name="itemName" class="form-control bg-dark" value="Name" disabled>
                                            <br>
                                            <input type="text" name="lastName" class="form-control bg-dark" value="Price" disabled>
                                            <br>
                                            <input type="submit" value="Save" class="btn btn-success btn-block" disabled>     
                                        </c:when>            
                                    </c:choose>                            
                                </form>
                                <br>
                                <form method="get" action="inventory">
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
                                        <p>The <span class="text-success">${itemAdded}</span> has been successfully <span class="text-success">added</span>.</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${editMsg == true}">
                                <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>The <span class="text-warning">${itemEdited}</span> has been successfully <span class="text-warning">edited</span>.</p>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${deleteMsg == true}">
                                <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>The <span class="text-danger">${itemDeleted}</span> has been successfully <span class="text-danger">deleted</span>.</p>                                
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${notOwnerMsg == true}">
                                <div class="card  bg-danger text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>The <span class="text-danger">${itemDeleted}</span> is not your item. You cannot edit it.</p>                                
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${invalidMsg == true}">
                                <div class="card  bg-danger text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>Item name and price cannot be empty.</p>                                
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${invalidPriceMsg == true}">
                                <div class="card  bg-danger text-white"> <%-- left card for user form --%>
                                    <div class="card-header">Message:</div>
                                    <div class="card-body">                               
                                        <p>Price should consist only of numbers.</p>                                
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>    
                    </div> <%-- col --%>
                </div>  <%-- row --%>
            </div> <%-- col --%>
            <div class="col-9">
                <div class="card bg-dark text-white">  <%-- right card for user manage users form --%>
                    <h1 class="card-header">Inventory for ${user.firstName} ${user.lastName}</h1>
                    <div class="card-body">
                        <table class="table">
                            <thead class="baseColor">
                                <tr>
                                    <th>Category</th>
                                    <th>Name</th>
                                    <th>Price</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <c:forEach items="${items}" var="item"> <%-- loop to find users and display in the table --%>
                                <tr class="text-white">
                                    <td>${item.category.categoryName}</td>                                    
                                    <td>${item.itemName}</td>
                                    <td>${item.price}</td>
                                    <td>
                                        <form action="inventory" method="get">
                                            <input type="submit" value="Edit" class="btn btn-warning">
                                            <input type="hidden" name="action" value="editItem">
                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                        </form>
                                        <br>            
                                    </td>
                                    <td>
                                        <form action="inventory" method="post">
                                            <input type="submit" value="Delete"class="btn btn-danger">
                                            <input type="hidden" name="action" value="deleteItem">                        
                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                            <br>            
                                        </form>
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
