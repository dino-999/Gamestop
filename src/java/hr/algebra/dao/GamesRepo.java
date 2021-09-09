/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.dao;

import hr.algebra.model.Cart;
import hr.algebra.model.Game;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dino
 */
public class GamesRepo {

    private static List<Game> games = new ArrayList<>();

    static {
//        Game one = new Game(1, "Lego Ninjago", 450.56, "assets/game.jpg", 1);
//        Game two = new Game(2, "Lego Movie", 350.78, "assets/game2.jpg", 1);
//        Game three = new Game(3, "Olympic Game:Tokyo", 300.66, "assets/game3.jpg", 3);
//        Game f = new Game(4, "Lego Ninjago", 450.56, "assets/game.jpg", 1);
//        Game ff = new Game(5, "Lego Movie", 350.78, "assets/game2.jpg", 1);
//        Game fff = new Game(6, "Olympic Game:Tokyo", 300.66, "assets/game3.jpg", 3);
//        games.add(one);
//        games.add(two);
//        games.add(three);
//        games.add(f);
//        games.add(ff);
//        games.add(fff);
    }

    public static List<Game> getGames() {
        return games;
    }

    public static List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> products = new ArrayList<Cart>();

        try {
            if (cartList.size() > 0) {
                for (Cart c : cartList) {
                    List<Game> games = GamesRepo.getGames();

                    for (Game g : games) {

                        if (g.getId() == c.getId()) {
                            Cart cm = new Cart();
                            cm.setId(g.getId());
                            cm.setName(g.getName());
                            cm.setPrice(g.getPrice() * c.getQuantity());
                            cm.setImgFilePath(g.getImgFilePath());
                            //cm.setCategoryId(g.getCategoryId());
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

    public static double getTotalCartPrice(ArrayList<Cart> cartList) {

        double sum = 0;

        try {
            if (cartList.size() > 0) {
                for (Cart c : cartList) {
                    List<Game> games = GamesRepo.getGames();

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

}
