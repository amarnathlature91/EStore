package com.estore.entities;

import javax.persistence.*;

@Entity
public class Favorites {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @OneToOne
    private User user;
    @OneToOne
    private Product product;


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProducts(Product product) {
        this.product = product;
    }

    public Favorites(int id, User user, Product product) {
        this.id = id;
        this.user = user;
        this.product = product;
    }

    public Favorites(User user, Product product) {
        this.user = user;
        this.product = product;
    }

    public Favorites() {
        super();
    }
}
