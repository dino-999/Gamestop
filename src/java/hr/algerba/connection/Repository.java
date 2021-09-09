/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algerba.connection;

import hr.algebra.model.Cart;
import hr.algebra.model.Category;
import hr.algebra.model.Game;
import hr.algebra.model.Order;
import hr.algebra.model.Role;
import hr.algebra.model.User;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author Dino
 */
public interface Repository {

    int createGame(Game game) throws Exception;

    Game selectGame(int id) throws Exception;

    List<Game> selectGames() throws Exception;

    void updateGame(int id, Game newGame) throws Exception;

    void deleteGame(int id) throws Exception;

    int createCategory(Category category) throws Exception;

    Category selectCategory(int id) throws Exception;

    List<Category> selectCategories() throws Exception;

    void updateCategory(int id, Category newCategory) throws Exception;

    void deleteCategory(int id) throws Exception;

    int createUser(User user) throws Exception;

    Optional<User> selectUser(int id) throws Exception;

    Role selectRole(int id) throws Exception;

    List<User> selectUsers() throws Exception;

    User findUser(User user) throws Exception;

    List<Cart> getCartProducts(ArrayList<Cart> cartList) throws Exception;

    double getTotalCartPrice(ArrayList<Cart> cartList);
    
    int CreateOrder(Order order) throws Exception;

    List<Order> getOrdersForUser(int id) throws Exception;

    List<Order> getAllOrders() throws Exception;

    void deleteOrder(int id) throws Exception;

}
