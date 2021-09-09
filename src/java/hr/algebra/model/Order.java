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
public class Order extends Game {

    private int orderid;
    private int userid;
    private int quantity;
    private String paymentMethod;
    private String date;

    public Order() {
    }

    public Order(int orderid, int userid, int quantity, String paymentMethod, String date) {
        super();
        this.orderid = orderid;
        this.userid = userid;
        this.quantity = quantity;
        this.paymentMethod = paymentMethod;
        this.date = date;
    }

    public Order(int userid, int quantity, String paymentMethod, String date) {
        super();

        this.userid = userid;
        this.quantity = quantity;
        this.paymentMethod = paymentMethod;
        this.date = date;
    }

    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

}
