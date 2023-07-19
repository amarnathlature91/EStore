package com.estore.servlets;

import com.estore.entities.User;
import com.estore.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@MultipartConfig
@WebServlet(name = "AccountPref", value = "/AccountPref")
public class AccountPref extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

//            fetching all parameters from Form
            int uid = Integer.parseInt(request.getParameter("userid"));
            String unm = request.getParameter("unm");
            String eml = request.getParameter("eml");
            String pwd1 = request.getParameter("pwd1");
            String cnt = request.getParameter("cnt");
            String adds = request.getParameter("adds");
            Part photo = request.getPart("fl");
            String role = "user";
            String cnf=request.getParameter("dl");

            Session hbses = FactoryProvider.getFactory().openSession();
            Transaction tx = hbses.beginTransaction();
            User usr = hbses.get(User.class, uid);

            if (cnf.trim().equals("yes")){
                String filePath = request.getRealPath("img") + File.separator + "user" + File.separator + usr.getProfilePic();
                File file = new File(filePath);
                boolean deleted = file.delete();
                usr.setProfilePic("alt_profile.png");
                hbses.save(usr);
            }

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
                usr.setRole(role);
                hbses.save(usr);
            }
            tx.commit();
            hbses.close();

//            update redirecting
            HttpSession session = request.getSession();
            session.setAttribute("msg", "Changes Saved.!");
            response.sendRedirect("user.jsp");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}