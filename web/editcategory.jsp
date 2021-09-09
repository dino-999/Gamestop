<%-- 
    Document   : editcategory
    Created on : 07-Sep-2021, 12:09:10
    Author     : Dino
--%>

<%@page import="java.util.Optional"%>
<%@page import="hr.algebra.model.Category"%>
<%@page import="hr.algerba.connection.Repository"%>
<%@page import="hr.algerba.connection.RepoFactory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hr.algebra.model.Cart"%>
<%@page import="hr.algebra.dao.GamesRepo"%>
<%@page import="hr.algebra.model.Game"%>
<%@page import="java.util.List"%>
<%@page import="hr.algebra.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    Repository repo = RepoFactory.getRepository();
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    List<Category> cat = repo.selectCategories();
    
    List<Game> games = repo.selectGames();
     if (games != null) {

        session.setAttribute("games", games);
    }
    if (cat != null) {
        session.setAttribute("cat", cat);
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    
    if (cart_list != null) {
        
        cartProduct = repo.getCartProducts(cart_list);
        double total = repo.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
    }
    
    int id = Integer.parseInt(request.getParameter("id"));
    
    Category c = repo.selectCategory(id);
    if (c != null) {
        request.setAttribute("category", c);
    }
    

%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <link rel="ICON" href="assets/favicon.ico" />
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

       
        <title>GameStop</title>
    </head>
    <body>
       <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="home.jsp">GameStop</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="games.jsp">Games</a></li>
                        <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart <% if (cart_list != null && cart_list.size() > 0) { %><span class="badge badge-danger"> ${cart_list.size()} </span> <%} %></a></li>
                        <li class="nav-item"><a class="nav-link" href="edit.jsp">Edit</a></li>
                            <%

                            if (auth != null) {

                                if (auth.getRole().getId() == 2) {

                        %>

                        <li class="nav-item"><a class="nav-link" href="edit.jsp">Edit</a></li>
                            <%                                }
                                if (auth.getRole().getId() == 1) {
                            %>

                        <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
                        


                        <%} %>
                        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                        <%

                        } else {
                        %>


                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                            <% }%>
                    </ul>
                </div>
            </div>
        </nav>
                    
         <div class=" container">
            <div class="row">
                <div class="col-12">
                    <h3>
                        Edit Category Details</h3>
                    <form action="edit-category?id=<%= c.getId()%>" method="post">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input class="form-control" name="name" value="<%=c.getName()%>" required>
                        </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <a class="btn btn-primary" href="edit.jsp">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
