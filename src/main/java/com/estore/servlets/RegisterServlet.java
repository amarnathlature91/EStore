package com.estore.servlets;

import com.estore.entities.User;
import com.estore.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;

@MultipartConfig
@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            String unm = request.getParameter("unm");
            String eml = request.getParameter("eml");
            String pwd1 = request.getParameter("pwd1");
            String cnt = request.getParameter("cnt");
            String adds = request.getParameter("adds");
            Part photo = request.getPart("fl");
            String role = "user";

            User usr = new User();
            Session hbses = FactoryProvider.getFactory().openSession();
            Transaction tx = hbses.beginTransaction();

//            checking if user submitted new file
            if (photo.getSize() > 0) {
                try {
//            saving user
                    usr.setUserName(unm);
                    usr.setEmail(eml);
                    usr.setPassword(pwd1);
                    usr.setContact(cnt);
                    usr.setAddress(adds);
                    usr.setProfilePic(photo.getSubmittedFileName());
                    usr.setRole(role);
                    hbses.save(usr);

//            saving Photo
                    String path = request.getRealPath("img") + File.separator + "user" + File.separator + photo.getSubmittedFileName();
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = photo.getInputStream();
                    int read = 0;
                    byte[] bytes = new byte[1024];
                    while ((read = is.read(bytes)) != -1) {
                        fos.write(bytes, 0, read);
                    }
                    is.close();
                    fos.flush();
                    fos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
//            saving only user
                usr.setUserName(unm);
                usr.setEmail(eml);
                usr.setPassword(pwd1);
                usr.setContact(cnt);
                usr.setAddress(adds);
                usr.setProfilePic("alt_profile.png");
                usr.setRole(role);
                hbses.save(usr);
            }
            tx.commit();
            hbses.close();
//            update redirecting
            HttpSession session = request.getSession();
            session.setAttribute("msg", "Registration Successful.!");
            response.sendRedirect("register.jsp");
            return;
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}