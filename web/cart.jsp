<%-- 
    Document   : cart
    Created on : 03-Sep-2021, 12:22:38
    Author     : Dino
--%>

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
    DecimalFormat dcf = new DecimalFormat(".00");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }

    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;

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

                    <div class="d-flex py-3"><h3>Total Price: ${(total>0) ? dcf.format(total): 0 } kn</h3> <a class="mx-3 btn btn-primary" href="checkout.jsp">Check Out</a></div>

                    <table class="table table-light">
                        <thead>
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">Category</th>
                                <th scope="col">Price</th>
                                <th scope="col">Buy now</th>
                                <th scope="col">Cancel</th>

                            </tr>
                        </thead>

                        <tbody>
                            <%
                                if (cart_list != null) {
                                    for (Cart c : cartProduct) {

                            %>
                            <tr>
                                <td><%=c.getName()%></td>
                                <td><%=c.getCategory().getName()%></td>
                                <td><%= dcf.format(c.getPrice())%> kn </td>
                                <td class="form_td">
                                    <form action="" method="post" class="form-inline">
                                        <input type="hidden" name="id" value="<%=c.getId()%>" class="form-input">
                                        <div class="form-group d-flex justify-content-between">
                                            <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=<%= c.getId()%>"> <i class="fas fa-minus-square"></i></a>
                                            <input type="text" name="quantity" class="form-control"  value="<%=c.getQuantity()%>" readonly >
                                            <a class="btn btn-sm btn-incre " href="quantity-inc-dec?action=inc&id=<%= c.getId()%>"> <i class="fas fa-plus-square"></i></a>
                                        </div>
                                    </form>
                                </td>
                                <td> <a class="btn btn-sm btn-danger" href="remove-from-cart?id=<%=c.getId()%>">Remove</a></td>
                            </tr>

                            <%  }
                                }

                            %>



                        </tbody>

                    </table>




                </div>

            </div>
        </div>




        <jsp:include page="includes/footer.jsp"/>

        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
