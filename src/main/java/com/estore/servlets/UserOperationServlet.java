package com.estore.servlets;

import com.estore.dao.ProductDao;
import com.estore.dao.UserDao;
import com.estore.entities.Product;
import com.estore.helper.FactoryProvider;

import javax.persistence.EntityExistsException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UserOperationServlet", value = "/UserOperationServlet")
public class UserOperationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int uId = Integer.parseInt(request.getParameter("uId"));
        String op = request.getParameter("op");

        if (op.trim().equals("addFavorite")) {
            int pId = Integer.parseInt(request.getParameter("pId"));
            Product p = new ProductDao(FactoryProvider.getFactory()).getProductById(pId);
            try {
            new UserDao(FactoryProvider.getFactory()).addToFavorites(uId,p);
        }catch (EntityExistsException e){
            HttpSession sess= request.getSession();
            sess.setAttribute("msg","Product already added");
        }
            response.sendRedirect("/EStore_war_exploded/index.jsp");
        } else if (op.trim().equals("deleteFavorite")) {
            int pId = Integer.parseInt(request.getParameter("pId"));

                new UserDao(FactoryProvider.getFactory()).removeFromFavorites(uId, pId);
            response.sendRedirect("/EStore_war_exploded/favorites.jsp");

        } else if (op.trim().equals("deleteUser")) {
            new UserDao(FactoryProvider.getFactory()).deleteUserById(uId);
            response.sendRedirect("allUsers.jsp");
        } else if (op.trim().equals("changeRole")) {
            String role = request.getParameter("role");
            if (role.trim().equals("user")) {
                new UserDao(FactoryProvider.getFactory()).changeRole(uId, "admin");
            } else if (role.trim().equals("admin")) {
                new UserDao(FactoryProvider.getFactory()).changeRole(uId, "user");
            }
            response.sendRedirect("allUsers.jsp");
        }
    }
}