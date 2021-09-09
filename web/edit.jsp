<%-- 
    Document   : edit
    Created on : 06-Sep-2021, 20:31:38
    Author     : Dino
--%>
<%@page import="java.util.Date"%>
<%@page import="hr.algebra.model.Order"%>
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>

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

    List<Order> orders = repo.getAllOrders();
    if (orders != null) {
        request.setAttribute("all-orders", orders);
    }

    if (cart_list != null) {

        cartProduct = repo.getCartProducts(cart_list);
        double total = repo.getTotalCartPrice(cart_list);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cart_list);
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

        <link href="style/cart.css" rel="stylesheet" type="text/css"/>
        <title>GameStop</title>
    </head>
    <body>

        <div class="content">
            
            <div class="content-inside">
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

        <br>
        <br>
        <br>
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-md-3">
                        <h3>
                            Input Game Information</h3>
                        <form action="add-game" method="post">
                            <div class="form-group">
                                <label>Game Name</label>
                                <input class="form-control" name="name" place-holder="Game name" required>
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input class="form-control" name="price" place-holder="Price" required>
                            </div>
                           
                            <div class="form-group" >
                                <label>Category</label>
                                <select id="inputState" class="form-control" name="category" required>
                                    <option selected disabled>Choose Category</option>
                                    <%  for (Category c : cat) {
                                    %>

                                    <option value="<%=c.getName()%>"><%= c.getName()%></option>

                                    <% } %>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                    <div class="col-md-9">
                        <h3>
                            Game Information From Database</h3>
                        <table class="table">
                            <thead class="bg-light">
                                <tr>
                                    <th scope="col">Game Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Category</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  for (Game game : games) {
                                %>
                                <tr>
                                    <td><%=game.getName()%></td>
                                    <td><%=game.getPrice()%></td>
                                    <td> <%=game.getCategory().getName()%></td>
                                    <td><a href="editgame.jsp?id=<%=game.getId()%>">Edit</a> 
                                        <a href="deletegame?id=<%=game.getId()%>">Delete</a></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <br>
        <br>
        <br>
        <div class="container">
            <div class="inner">
                <div class="row">
                    <div class="col-md-3">
                        <h3>
                            Input Category Information</h3>
                        <form action="add-category" method="post">
                            <div class="form-group">
                                <label>Category Name</label>
                                <input class="form-control" name="category" place-holder="Category name" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                    <div class="col-md-9">
                        <h3>
                            Category Information From Database</h3>
                        <table class="table">
                            <thead class="bg-light">
                                <tr>
                                    <th scope="col">Category Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  for (Category c : cat) {
                                %>
                                <tr>
                                    <td><%=c.getName()%></td>
                                    <td><a href="editcategory.jsp?id=<%=c.getId()%>">Edit</a> 
                                        <a href="deletecategory?id=<%=c.getId()%>">Delete</a></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <div class="container">

            <div class="d-flex py-3"><h3>Orders</h3></div>

            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">User ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Payment Method</th>
                        <th scope="col">Date</th>


                    </tr>
                </thead>

                <tbody>
                    <%
                        if (orders != null) {
                            for (Order o : orders) {

                    %>
                    <tr>
                        <td><%= o.getUserid()%></td>
                        <td><%= o.getName()%></td>
                        <td><%=o.getCategory().getName()%></td>
                        <td><%= dcf.format(o.getPrice() * o.getQuantity())%> kn </td>
                        <td><%= o.getQuantity()%></td>
                        <td><%= o.getPaymentMethod()%>  </td>
                        <td><%= o.getDate()%>  </td>


                    </tr>

                    <%  }
                        }

                    %>



                </tbody>

            </table>


            <div class="row">

                <table class="table table-light" border="1">
                    <tr>
                        <th>Session Id</th>

                        <th>Session Creation Time</th>


                    </tr>
                    <c:forEach items="${applicationScope['sessionList']}" var="sessionInfo" >
                        <tr>
                            <td>
                                <c:out value="${sessionInfo.sessionId}" />
                            </td>

                            <td>
                                <fmt:parseDate value="${ sessionInfo.sessionCreationTime }" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                <fmt:formatDate pattern="dd.MM.yyyy HH:mm" value="${ parsedDateTime }" />
                            </td>

                        </tr>
                    </c:forEach>
                </table>

            </div>

        </div>     


            </div>
        </div>
        
        




        <jsp:include page="includes/footer.jsp"/>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
