/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.model;

/**
 *
 * @author Dino
 */
public class Game {

    private int id;
    private String name;
    private double price;
    private String imgFilePath;
    private Category category;

    public Game() {
    }

    public Game(String name, double price, String imgFilePath, Category category) {

        this.name = name;
        this.price = price;
        this.imgFilePath = imgFilePath;
        this.category = category;
    }

    public Game(int id, String name, double price, String imgFilePath, Category category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imgFilePath = imgFilePath;
        this.category = category;
    }

    public String getImgFilePath() {
        return imgFilePath;
    }

    public void setImgFilePath(String imgFilePath) {
        this.imgFilePath = imgFilePath;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

}
