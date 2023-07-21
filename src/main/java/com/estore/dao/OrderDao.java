package com.estore.dao;

import com.estore.entities.Order;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class OrderDao {
    private SessionFactory factory;

    public OrderDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean createOrder(Order o){
        boolean f=false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(o);
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

    public List<Order> getAllOrders(){
        Session session = this.factory.openSession();
        Query q;
        q = session.createQuery("from Order ");
        List<Order> olist = q.list();
        session.close();
        return olist;
    }

    public List<Order> getOrdersByUserId(int uId){
        Session ss = this.factory.openSession();
        Query q = ss.createQuery("from Order as o where o.user.userId=:id");
        q.setParameter("id",uId);
        List<Order> uolist = q.list();
        ss.close();
        return uolist;
    }

    public List<Order> getOrdersByStatus(String status){
        Session ss = this.factory.openSession();
        Query q = ss.createQuery("from Order as o where o.status=:st");
        q.setParameter("st",status);
        List<Order> solist = q.list();
        ss.close();
        return solist;
    }

    public void deleteOrderById(int oId){
        Session ss = this.factory.openSession();
        Transaction tx = ss.beginTransaction();
        Order o = ss.get(Order.class, oId);
        ss.delete(o);
        tx.commit();
        ss.close();

    }

    public void changeStatus(int oId,String status){
        Session ss = this.factory.openSession();
        Transaction tx = ss.beginTransaction();
        Order o = ss.get(Order.class, oId);
        o.setStatus(status);
        ss.update(o);
        tx.commit();
        ss.close();
    }

}
