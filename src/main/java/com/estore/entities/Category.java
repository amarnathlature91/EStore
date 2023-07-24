package com.estore.entities;

import javax.persistence.*;
import java.util.List;

@Entity
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int catId;
    private String title;
    private String description;
    @OneToMany(mappedBy = "category",cascade= CascadeType.ALL,orphanRemoval = true,fetch = FetchType.LAZY)
    private List<Product> products;

    public Category(int catId, String title, String description, List<Product> products) {
        this.catId = catId;
        this.title = title;
        this.description = description;
        this.products = products;
    }

    public Category() {
    }

    public Category(String title, String description, List<Product> products) {
        this.title = title;
        this.description = description;
        this.products = products;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Category{" +
                "catId=" + catId +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", products=" + products +
                '}';
    }
}
