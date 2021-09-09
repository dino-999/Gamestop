/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.dao;

import hr.algebra.model.Cart;
import hr.algebra.model.Category;
import hr.algebra.model.Game;
import hr.algebra.model.Order;
import hr.algebra.model.Role;
import hr.algebra.model.User;
import hr.algerba.connection.DbCon;
import hr.algerba.connection.Repository;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.sql.DataSource;

/**
 *
 * @author Dino
 */
public class RepositorySQL implements Repository {

    private static final String ID_GAME = "IDGame";
    private static final String GAME_NAME = "GameName";
    private static final String IMG_FILE_PATH = "ImgFilePath";
    private static final String PRICE = "Price";
    private static final String CATEGORY_ID = "CategoryID";

    private static final String CREATE_GAME = " { call spCreateGame (?, ?, ?, ?, ?) } ";
    private static final String SELECT_GAME = " { call spSelectGame (?) } ";
    private static final String SELECT_GAMES = " { call spSelectGames } ";
    private static final String UPDATE_GAME = " { call spUpdateGame (?,?,?,?,?) } ";
    private static final String DELETE_GAME = " { call spDeleteGame (?) } ";

    private static final String ID_CATEGORY = "IDCategory";
    private static final String NAME = "CategoryName";

    private static final String ID_ORDER = "IDOrder";
    private static final String USER_ID = "AppUserID";
    private static final String QUANTITY = "Quantity";
    private static final String PAYMENT_METHOD = "PaymentMethod";
    private static final String DATE = "Datee";

    private static final String CREATE_ORDER = " { call spCreateOrder (?,?,?,?,?,?) } ";
    private static final String SELECT_ORDER = " { call spSelectOrder (?) } ";
    private static final String SELECT_ORDERS = " { call spSelectOrders } ";

    private static final String DELETE_ORDER = " { call spDeleteOrder (?) } ";

    private static final String ID_ROLE = "IDAppRole";
    private static final String ROLE_NAME = "RoleName";
    private static final String SELECT_ROLE = " { call spSelectRole (?) } ";

    private static final String CREATE_CATEGORY = " { call spCreateCategory (?,?) } ";
    private static final String SELECT_CATEGORY = " { call spSelectCategory (?) } ";
    private static final String SELECT_CATEGORIES = " { call spSelectCategories } ";
    private static final String UPDATE_CATEGORY = " { call spUpdateCategory (?,?) } ";
    private static final String DELETE_CATEGORY = " { call spDeleteCategory (?) } ";

    private static final String ID_APP_USER = "IDAppUser";
    private static final String EMAIL = "Email";
    private static final String PASS = "Pass";
    private static final String ROLE = "AppRoleID";

    private static final String CREATE_USER = " { call spCreateUser (?,?,?) } ";
    private static final String SELECT_USER = " { call spSelectUser (?) } ";
    private static final String FIND_USER = " { call spFindUser (?,?) } ";
    private static final String SELECT_USERS = " { call spSelectUsers } ";

    @Override
    public int createGame(Game game) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_GAME)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setString(2, game.getName());
            stmt.setDouble(3, game.getPrice());
            stmt.setString(4, game.getImgFilePath());
            stmt.setInt(5, game.getCategory().getId());

            stmt.executeUpdate();

            return stmt.getInt(1);
        }
    }

    @Override
    public Game selectGame(int id) throws Exception {

        Game game = null;
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_GAME)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    game = new Game(rs.getInt(ID_GAME),
                            rs.getString(GAME_NAME),
                            rs.getDouble(PRICE),
                            rs.getString(IMG_FILE_PATH),
                            selectCategory(rs.getInt(CATEGORY_ID)));
                }
            }
        }
        return game;
    }

    @Override
    public List<Game> selectGames() throws Exception {
        List<Game> games = new ArrayList<>();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_GAMES);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                games.add(new Game(rs.getInt(ID_GAME),
                        rs.getString(GAME_NAME),
                        rs.getDouble(PRICE),
                        rs.getString(IMG_FILE_PATH),
                        selectCategory(rs.getInt(CATEGORY_ID))));
            }
        }
        return games;
    }

    @Override
    public void updateGame(int id, Game newGame) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(UPDATE_GAME)) {
            stmt.setInt(1, id);
            stmt.setString(2, newGame.getName());
            stmt.setDouble(3, newGame.getPrice());
            stmt.setString(4, newGame.getImgFilePath());
            stmt.setInt(5, newGame.getCategory().getId());

            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteGame(int id) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(DELETE_GAME)) {
            stmt.setInt(1, id);

            stmt.execute();
        }
    }

    @Override
    public int createUser(User user) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_USER)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, user.getRole().getId());

            stmt.executeUpdate();

            return stmt.getInt(1);
        }
    }

    @Override
    public Optional<User> selectUser(int id) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_USER)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new User(rs.getInt(ID_APP_USER),
                            rs.getString(EMAIL),
                            rs.getString(PASS),
                            selectRole(rs.getInt(ROLE))
                    ));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public List<User> selectUsers() throws Exception {
        List<User> users = new ArrayList<>();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_USERS);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(new User(rs.getInt(ID_APP_USER),
                        rs.getString(EMAIL),
                        rs.getString(PASS),
                        selectRole(rs.getInt(ROLE))));
            }
        }
        return users;
    }

    @Override
    public User findUser(User user) throws Exception {

        User u = new User();

        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(FIND_USER)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    u.setId(rs.getInt(ID_APP_USER));
                    u.setEmail(rs.getString(EMAIL));
                    u.setPassword(rs.getString(PASS));
                    Role role = selectRole(rs.getInt(ROLE));
                    u.setRole(role);
                }
            }
        }
        return u;
    }

    @Override
    public List<Cart> getCartProducts(ArrayList<Cart> cartList) throws Exception {
        List<Cart> products = new ArrayList<Cart>();

        try {
            if (cartList.size() > 0) {
                for (Cart c : cartList) {
                    List<Game> games = selectGames();

                    for (Game g : games) {

                        if (g.getId() == c.getId()) {
                            Cart cm = new Cart();
                            cm.setId(g.getId());
                            cm.setName(g.getName());
                            cm.setPrice(g.getPrice() * c.getQuantity());
                            cm.setImgFilePath(g.getImgFilePath());
                            cm.setCategory(g.getCategory());
                            cm.setQuantity(c.getQuantity());
                            products.add(cm);
                        }

                    }

                }

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());

        }

        return products;
    }

    @Override
    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;

        try {
            if (cartList.size() > 0) {
                for (Cart c : cartList) {
                    List<Game> games = selectGames();

                    for (Game g : games) {

                        if (g.getId() == c.getId()) {
                            sum += g.getPrice() * c.getQuantity();
                        }

                    }

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sum;

    }

    @Override
    public int createCategory(Category category) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_CATEGORY)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setString(2, category.getName());

            stmt.executeUpdate();

            return stmt.getInt(1);
        }
    }

    @Override
    public Category selectCategory(int id) throws Exception {

        Category cat = null;
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_CATEGORY)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cat = new Category(rs.getInt(ID_CATEGORY),
                            rs.getString(NAME)
                    );
                }
            }
        }
        return cat;
    }

    @Override
    public List<Category> selectCategories() throws Exception {
        List<Category> categories = new ArrayList<>();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_CATEGORIES);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getInt(ID_CATEGORY),
                        rs.getString(NAME)
                ));
            }
        }
        return categories;
    }

    @Override
    public void updateCategory(int id, Category newCategory) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(UPDATE_CATEGORY)) {
            stmt.setInt(1, id);
            stmt.setString(2, newCategory.getName());
            stmt.executeUpdate();
        }
    }

    @Override
    public void deleteCategory(int id) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(DELETE_CATEGORY)) {
            stmt.setInt(1, id);

            stmt.execute();
        }
    }

    @Override
    public Role selectRole(int id) throws Exception {
        Role role = new Role();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_ROLE)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    role.setId(rs.getInt(ID_ROLE));
                    role.setRole(rs.getString(ROLE_NAME));

                }
            }
        }
        return role;
    }

    @Override
    public List<Order> getOrdersForUser(int id) throws Exception {
        List<Order> orders = new ArrayList<>();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_ORDER)) {
            
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {

                    Order order = new Order();
                    int gameID = rs.getInt("GameID");
                    Game game = selectGame(gameID);

                    order.setOrderid(rs.getInt(ID_ORDER));
                    order.setId(gameID);
                    order.setName(game.getName());
                    order.setPrice(game.getPrice() * rs.getInt(QUANTITY));
                    order.setImgFilePath(game.getImgFilePath());
                    order.setCategory(game.getCategory());
                    order.setQuantity(rs.getInt(QUANTITY));
                    order.setPaymentMethod(rs.getString(PAYMENT_METHOD));
                    order.setDate(rs.getString(DATE));
                    orders.add(order);
                }
            }

        }
        return orders;
    }

    @Override
    public List<Order> getAllOrders() throws Exception {
        List<Order> orders = new ArrayList<>();
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(SELECT_ORDERS);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                int gameID = rs.getInt("GameID");
                Game game = selectGame(gameID);

                order.setOrderid(rs.getInt(ID_ORDER));
                order.setId(gameID);
                order.setUserid(rs.getInt(USER_ID));
                order.setName(game.getName());
                order.setPrice(game.getPrice() * rs.getInt(QUANTITY));
                order.setImgFilePath(game.getImgFilePath());
                order.setCategory(game.getCategory());
                order.setQuantity(rs.getInt(QUANTITY));
                order.setPaymentMethod(rs.getString(PAYMENT_METHOD));
                order.setDate(rs.getString(DATE));
                orders.add(order);
            }
        }
        return orders;
    }

    @Override
    public void deleteOrder(int id) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(DELETE_ORDER)) {
            stmt.setInt(1, id);

            stmt.execute();
        }
    }

    @Override
    public int CreateOrder(Order order) throws Exception {
        DataSource dataSource = DbCon.getInstance();
        try (Connection con = dataSource.getConnection();
                CallableStatement stmt = con.prepareCall(CREATE_ORDER)) {
            stmt.registerOutParameter(1, Types.INTEGER);
            stmt.setInt(2, order.getId());
            stmt.setInt(3, order.getUserid());
            stmt.setInt(4, order.getQuantity());
            stmt.setString(5, order.getPaymentMethod());
            stmt.setString(6, order.getDate());

            stmt.executeUpdate();

            return stmt.getInt(1);
        }
    }

}
