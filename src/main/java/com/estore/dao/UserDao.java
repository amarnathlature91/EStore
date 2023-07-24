package com.estore.dao;

import com.estore.entities.Product;
import com.estore.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Set;

public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    public User getUserByEmailAndPassword(String email,String password){
        User usr=null;
        try {
            String query="from User where email =:e and password =:p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e",email);
            q.setParameter("p",password);
            usr=(User) q.uniqueResult();
            session.close();

        }
        catch (Exception e){
            e.printStackTrace();
        }

        return usr;
    }

    public List<User> getAllUsers(){
        Session session = this.factory.openSession();
        Query q = session.createQuery("from User");
        List<User> ulist = q.list();
        session.close();
        return ulist;
    }

    public void deleteUserById(int uId) {
        Session ss = this.factory.openSession();
        Transaction tx = ss.beginTransaction();
        User u = ss.get(User.class, uId);
        ss.delete(u);
        tx.commit();
        ss.close();
    }

    public void changeRole(int uId, String role) {
        Session sess = this.factory.openSession();
        Transaction tx = sess.beginTransaction();
        User u = sess.get(User.class, uId);
        u.setRole(role);
        sess.update(u);
        tx.commit();
        sess.close();
    }

    public Set<Product> getFavoritesByUId(int uId){
        Session sess = this.factory.openSession();
        Transaction tx = sess.beginTransaction();
        User u = sess.get(User.class, uId);
        Set<Product> fav = u.getFavoriteProducts();
        tx.commit();
        sess.close();
        return fav;
    }

    public void addToFavorites(int uId,Product p){
        Session sess = this.factory.openSession();
        Transaction tx = sess.beginTransaction();
        User u = sess.get(User.class, uId);
        Set<Product> fav = u.getFavoriteProducts();
        fav.add(p);
        u.setFavoriteProducts(fav);
        tx.commit();
        sess.close();
    }

    public void removeFromFavorites(int uId,int pId) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        User user = session.get(User.class, uId);
        Product product = session.get(Product.class, pId);

        if (user != null && product != null) {
            user.getFavoriteProducts().remove(product);
            tx.commit();
        } else {
        }

        session.close();

    }
}
