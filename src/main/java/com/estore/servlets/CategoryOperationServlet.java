package com.estore.servlets;

import com.estore.dao.CategoryDao;
import com.estore.entities.Category;
import com.estore.helper.FactoryProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CategoryOperationServlet", value = "/CategoryOperationServlet")
public class CategoryOperationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op.trim().equals("addCategory")){
//            fetching parameters
            String title = request.getParameter("cat");
            String desciption = request.getParameter("des");

//            creating category object
            Category cat = new Category();
            cat.setTitle(title);
            cat.setDescription(desciption);

            CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
            catDao.saveCategory(cat);
            HttpSession session = request.getSession();
            session.setAttribute("msg","Category added successfully.");
            response.sendRedirect("admin.jsp");

        } else if (op.trim().equals("updateCategory")){
            int cId = Integer.parseInt(request.getParameter("cId"));
            String title= request.getParameter("title");
            String description= request.getParameter("description");
           new CategoryDao(FactoryProvider.getFactory()).updateCategory(cId,title,description);
            HttpSession session = request.getSession();
            session.setAttribute("msg","Category updated successfully.");
            response.sendRedirect("allCategories.jsp");

        } else if (op.trim().equals("deleteCategory")) {
            int cId = Integer.parseInt(request.getParameter("cId"));
            new CategoryDao(FactoryProvider.getFactory()).deleteCategoryById(cId);
            HttpSession session = request.getSession();
            session.setAttribute("msg","Category deleted successfully.");
            response.sendRedirect("allCategories.jsp");
        }
        else {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Something went Wrong</h2>");
        }

    }
}