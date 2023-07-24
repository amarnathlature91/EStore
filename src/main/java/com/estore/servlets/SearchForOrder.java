package com.estore.servlets;

import com.estore.dao.OrderDao;
import com.estore.entities.Order;
import com.estore.helper.FactoryProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SearchForOrder", value = "/SearchForOrder")
public class SearchForOrder extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        Order order = new OrderDao(FactoryProvider.getFactory()).getOrderById(orderId);

        request.setAttribute("order", order);
        request.getRequestDispatcher("/searchOrder.jsp").forward(request, response);
    }
}
