<%-- 
    Document   : games
    Created on : 01-Sep-2021, 13:42:50
    Author     : Dino
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="hr.algebra.model.Category"%>
<%@page import="hr.algerba.connection.Repository"%>
<%@page import="hr.algerba.connection.RepoFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hr.algebra.model.Cart"%>
<%@page import="hr.algebra.dao.GamesRepo"%>
<%@page import="hr.algebra.model.User"%>
<%@page import="hr.algebra.model.Game"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Repository repo = RepoFactory.getRepository();
    DecimalFormat dcf = new DecimalFormat(".00");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    List<Game> games = (List<Game>) request.getSession().getAttribute("games");
    if (games != null) {

        request.setAttribute("games", games);
    }

    List<Category> cat = repo.selectCategories();
    if (cat != null) {
        session.setAttribute("cat", cat);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

    if (cart_list != null) {

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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="style/games.css" rel="stylesheet" type="text/css"/>
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




                <div class="container">


                    <div class="row-md-12" >
                        <form action="filter-categories" method="POST">
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
                            <button type="submit" class="btn btn-primary">Filter Games by category</button>
                        </form>

                    </div>

                    <div class="row">
                        <%
                            //List<Game> games = (List<Game>) session.getAttribute(Constants.SESSION_PARAM_LISTA_IGRICA);
                            if (!games.isEmpty()) {
                                for (Game game : games) {
                        %>

                        <div class="col-sm-3">
                            <br>
                            <div class="card">

                                <div class="image">

                                    <img src="<%= game.getImgFilePath()%>" alt=""/> 
                                </div>
                                <div class="title">
                                    <h1>
                                        <%= game.getName()%></h1>
                                </div>
                                <div class="des">
                                    <p><%= dcf.format(game.getPrice())%> kn</p>
                                    <a href="add-to-cart?id=<%=game.getId()%>" class="btn btn-dark">Add to cart</a>
                                    <a href="order-now?id=<%=game.getId()%>&quantity=1" class="btn btn-primary">Buy now</a>
                                </div>
                            </div>

                        </div>

                        <% } %>

                        <% }%>

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
