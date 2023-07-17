package com.estore.dao;

import com.estore.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product p){
        boolean f=false;
    try {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(p);
        f=true;
        tx.commit();
        session.close();
    }
    catch (Exception e){
        f=false;
        e.printStackTrace();
    }
    return f;
    }

    public List<Product> getAll(){
        Session ss = this.factory.openSession();
        Query q = ss.createQuery("from Product");
        List<Product> plist = q.list();
        ss.close();
        return plist;
    }

    public Product getProductById(int pId){
        Product pd=null;
        try {
            Session session = this.factory.openSession();
            pd = session.get(Product.class, pId);
            session.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return pd;
    }

    public List<Product> getByCategoryId(int cId){
        Session ss = this.factory.openSession();
        Query q = ss.createQuery("from Product as p where p.category.catId=:id");
        q.setParameter("id",cId);
        List<Product> plist = q.list();
        ss.close();
        return plist;
    }
}
