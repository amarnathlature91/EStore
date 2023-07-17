package com.estore.dao;

import com.estore.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.List;

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
}
