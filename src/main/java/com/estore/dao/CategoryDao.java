package com.estore.dao;

import com.estore.entities.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int saveCategory( Category cat){
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId=(int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }

    public List<Category> getCategories(){
        Session session = this.factory.openSession();
        Query q;
        q = session.createQuery("from Category");
        List<Category> clist = q.list();
        session.close();
        return clist;
    }

    public Category getCategoryById(int cId){
        Category cat=null;
    try {
        Session session = this.factory.openSession();
         cat = session.get(Category.class, cId);
         session.close();
    }
    catch (Exception e){
        e.printStackTrace();
    }
    return cat;
    }
}
