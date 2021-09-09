/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.dao;

import hr.algebra.model.Role;
import hr.algebra.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dino
 */
public class UserRepo {

//    private Connection con;
//
//    private String query;
//    private PreparedStatement pst;
//    private ResultSet rs;
//
//    public UserRepo(Connection con) {
//        this.con = con;
//    }
//
//    public User userLogin(String email, String password) {
//        User user = null;
//        try {
//            query = "select * from user where email=? and password=?";
//            pst = this.con.prepareStatement(query);
//            pst.setString(1, email);
//            pst.setString(2, password);
//            rs = pst.executeQuery();
//            if (rs.next()) {
//                user = new User();
//                user.setId(rs.getInt("id"));
//
//                user.setEmail(rs.getString("email"));
//            }
//        } catch (SQLException e) {
//            System.out.print(e.getMessage());
//        }
//        return user;
//    }
    private static List<User> userList;

    static {
        userList = new ArrayList<User>();
        Role role= new Role(1,"user");
        userList.add(new User(1,"ivan@gmail.com", "ivan", role));
    }

    public List<User> getUserList() {
        return userList;
    }

    public static User checkUserCredentials(User user) {
        User u = new User();

        for (User temp : userList) {
            if (temp.getEmail().equals(user.getEmail())
                    && temp.getPassword().equals(user.getPassword())) {
                u.setId(temp.getId());
                u.setEmail(user.getEmail());
                u.setPassword(user.getPassword());
                u.setRole(temp.getRole());
                break;
            }
        }

        return u;
    }
}
