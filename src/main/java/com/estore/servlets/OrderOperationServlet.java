package com.estore.servlets;

import com.estore.dao.OrderDao;
import com.estore.helper.FactoryProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "OrderOperationServlet", value = "/OrderOperationServlet")
public class OrderOperationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int oId = Integer.parseInt(request.getParameter("oId"));
        String status = request.getParameter("status");
        OrderDao od=new OrderDao(FactoryProvider.getFactory());
        if (status == null){
            od.deleteOrderById(oId);
        }else{
            od.changeStatus(oId,status.trim());
        }
        response.sendRedirect("orders.jsp");
    }
}