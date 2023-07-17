package com.estore.servlets;

import com.estore.dao.UserDao;
import com.estore.entities.User;
import com.estore.helper.FactoryProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            response.setContentType("text/html");
            PrintWriter out=response.getWriter();
            String eml = request.getParameter("eml");
            String pwd = request.getParameter("pwd");
            UserDao udo=new UserDao(FactoryProvider.getFactory());
            User usr = udo.getUserByEmailAndPassword(eml, pwd);

            HttpSession session = request.getSession();
            if (usr==null){
                session.setAttribute("msg","Wrong Password or Email..");
                response.sendRedirect("login.jsp");
            }
            else {
                out.println("<script>window.alert(\"Welcome"+usr.getUserName()+"\");</script>");
                session.setAttribute("current-user",usr);

                if (usr.getRole().equals("admin")){
                    response.sendRedirect("admin.jsp");
                } else if (usr.getRole().equals("user")) {
                    response.sendRedirect("user.jsp");
                }
                else {
                    out.println("<h4>We can't identify your role type please contact customer care.</h4>");
                }

            }

        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}