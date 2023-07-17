package com.estore.servlets;

import com.estore.entities.User;
import com.estore.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "RegisterServlet",value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            response.setContentType("text/html");
            PrintWriter out=response.getWriter();

            String unm=request.getParameter("unm");
            String eml=request.getParameter("eml");
            String pwd1=request.getParameter("pwd1");
            String cnt=request.getParameter("cnt");
            String adds = request.getParameter("adds");
            String role="user";

            User usr=new User(unm,eml,pwd1,cnt,"deffalt.jpg",adds,role);
            Session hbses = FactoryProvider.getFactory().openSession();
            Transaction tx = hbses.beginTransaction();
            int userId =(int) hbses.save(usr);
            tx.commit();
            hbses.close();

            HttpSession session = request.getSession();
            session.setAttribute("msg","Registration successful.! Welcome "+unm);
            response.sendRedirect("register.jsp");
            return;
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}