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
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>

                <% if (auth != null) {
                %>

                <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>


                <% } else { %>


                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    <% }%>
            </ul>
        </div>
    </div>
</nav>
