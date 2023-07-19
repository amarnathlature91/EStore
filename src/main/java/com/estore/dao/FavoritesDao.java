package com.estore.dao;

import com.estore.entities.Favorites;
import com.estore.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class FavoritesDao {
    private SessionFactory factory;

    public FavoritesDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int savefavorites( Favorites fav){
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int favId=(int) session.save(fav);
        tx.commit();
        session.close();
        return favId;
    }

    public List<Product> getByUserId(int fId){
        Session ss = this.factory.openSession();
        Query q = ss.createQuery("from Favorites as f where f.user.id=id");
        q.setParameter("id",fId);
        List<Product> plist = q.list();
        ss.close();
        return plist;
    }
}
