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
                                <li class="nav-item">
                                    <a class="nav-link" href="admin">Users</a>
                                </li>
                                <li class="nav-item active">
                                    <a class="nav-link" href="admininventory">Inventory</a>
                                </li>
                                <li class="nav-item">
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
            <br>
            <div class="row justify-content-md-center">
                <div class="col-md-12 col-lg-3">
                    <div class="row">
                        <div class="col">
                            <div class="card  bg-dark text-white"> <%-- left card for user form --%>
                                <h1 class="card-header">Search Item</h1>
                                <div class="card-body">                                    
                                    <form method="get" action="admininventory">
                                        <c:choose>
                                            <c:when test="${enableForm == false}">                                                                                                                                                                            
                                                <input type="text" name="searchKeyword" placeholder="Item name" class="form-control bg-dark text-white" value="${searchKeyword}">
                                                <br>                                                
                                                <input type="submit" value="Search" class="btn btn-success btn-block">
                                                <input type="hidden" name="action" value="searchItem">                               
                                            </c:when>
                                            <c:when test="${enableForm == true}">                                                    
                                                <input type="text" name="search" class="form-control bg-dark" value="Item name" disabled>
                                                <br>
                                                <input type="submit" value="Search" class="btn btn-success btn-block" disabled>     
                                            </c:when>            
                                        </c:choose>                            
                                    </form>
                                    <br>
                                    <form method="get" action="admininventory">
                                        <c:choose>
                                            <c:when test="${cancelForm == false}">
                                                <input type="submit" value="Cancel" class="btn btn-secondary btn-block">
                                                <input type="hidden" name="action" value="cancelSearch">                                         
                                            </c:when>
                                            <c:when test="${cancelForm == true}">
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
                                    <form method="get" action="admininventory">                              
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
                                    <form method="post" action="admininventory">
                                        <c:choose>
                                            <c:when test="${enableForm == true}">       
                                                <select name="itemOwner" class="form-control bg-dark text-white">
                                                    <c:forEach items="${users}" var="user">
                                                        <%-- when the role ID found then the opstion is default selected--%>
                                                        <option value="${user.email}" ${user.email == itemToEdit.owner.email ? 'selected="selected"' : ''}>${user.email}</option> 
                                                    </c:forEach>                        
                                                </select>  
                                                <br>        
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
                                                <select name="email" class="form-control bg-dark" disabled>
                                                    <option>Email</option>
                                                </select> 
                                                <br>
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
                                    <form method="get" action="admininventory">
                                        <c:choose>
                                            <c:when test="${cancelForm == true}">
                                                <input type="submit" value="Cancel" class="btn btn-secondary btn-block">
                                                <input type="hidden" name="action" value="cancelSave">                                         
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
                <div class="col-sm-12 col-md-8 col-lg-6">
                    <div class="card bg-dark text-white">  <%-- right card for user manage users form --%>
                        <h1 class="card-header">Inventory for Users</h1>
                        <div class="card-body overflow-auto">
                            <table class="table">
                                <thead class="baseColor">
                                    <tr>
                                        <th>Owner</th>
                                        <th>Category</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${items}" var="item"> <%-- loop to find users and display in the table --%>
                                    <tr class="text-white">
                                        <td>${item.owner.email}</td>
                                        <td>${item.category.categoryName}</td>                                    
                                        <td>${item.itemName}</td>
                                        <td>${item.price}</td>
                                        <td>
                                            <form action="admininventory" method="get">
                                                <input type="submit" value="Edit" class="btn btn-warning">
                                                <input type="hidden" name="action" value="editItem">
                                                <input type="hidden" name="itemId" value="${item.itemId}">
                                            </form>
                                            <br>            
                                        </td>
                                        <td>
                                            <form action="admininventory" method="post">
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
        </div>  <%-- container --%>
    </body>
</html>
