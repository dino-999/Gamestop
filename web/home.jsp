<%-- 
    Document   : home
    Created on : 01-Sep-2021, 13:34:01
    Author     : Dino
--%>

<%@page import="hr.algebra.model.Game"%>
<%@page import="java.util.Date"%>
<%@page import="hr.algerba.connection.Repository"%>
<%@page import="hr.algerba.connection.RepoFactory"%>
<%@page import="hr.algebra.dao.GamesRepo"%>

<%@page import="java.util.List"%>
<%@page import="hr.algebra.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hr.algebra.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    Repository repo = RepoFactory.getRepository();

    List<Game> games = repo.selectGames();
    if (games != null) {
        session.setAttribute("games", games);
    }

    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;

    if (cart_list != null) {

        cartProduct = repo.getCartProducts(cart_list);
        request.setAttribute("cart_list", cart_list);
    }
%>

<!doctype html>
<html lang="en">

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta  name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="ICON" href="assets/favicon.ico" />
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="style/home.css" rel="stylesheet" type="text/css"/>
    <title>GameStop</title>

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


        <div class="wrapper">
            <img src="assets/homePage2.png" alt=""/>
            <div class="foreground">
                <h1>GameStop</h1>

            </div>
        </div>



        <div class="container">
            <p class="home-text">
                GameStop je vrhunska trgovina za prodaju igrica za razne konzole i platforme. GameStop ducane mozete naci na raznim lokacija diljem cijele Hrvatske. Imamo najbolje cijene igrica te smo vodeci distributor igrica na nasem podrucju. Primarna nam je djelatnost maloprodaja igara, igraćih konzola, potrošačke elektronike, video nadzora i ostalih proizvoda za zabavu i održavanje informatičke opreme.

Trvtka smo koja posluje više od 10 godina te koja je orijentirana kupcima i njihovim potrebama. Cilj nam je imati u ponudi vrhunsku kvalitetu proizvoda i usluga te sigurnu i brzu dostavu za potpuno zadovoljstvo naših kupaca. Zadovoljan kupac je naš prioritet i na tome smo sagradili povjerenje naših klijenata.
            </p>
        </div>

        <jsp:include page="includes/footer.jsp"/>


        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>

