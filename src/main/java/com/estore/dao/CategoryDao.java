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

    public int saveCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }

    public List<Category> getCategories() {
        Session session = this.factory.openSession();
        Query q;
        q = session.createQuery("from Category");
        List<Category> clist = q.list();
        session.close();
        return clist;
    }

    public Category getCategoryById(int cId) {
        Category cat = null;
        try {
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cId);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    public void updateCategory(int cId, String title, String description) {
        Session sess = this.factory.openSession();
        Transaction tx = sess.beginTransaction();
        Category c = sess.get(Category.class, cId);
        c.setTitle(title);
        c.setDescription(description);
        sess.update(c);
        tx.commit();
        sess.close();
    }

    public void deleteCategoryById(int cId) {
        Session ss = this.factory.openSession();
        Transaction tx = ss.beginTransaction();
        Category c = ss.get(Category.class, cId);
        ss.delete(c);
        tx.commit();
        ss.close();
    }
}
