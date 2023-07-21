package com.estore.servlets;

import com.estore.dao.OrderDao;
import com.estore.dao.ProductDao;
import com.estore.entities.Cart;
import com.estore.entities.Order;
import com.estore.entities.Product;
import com.estore.entities.User;
import com.estore.helper.FactoryProvider;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "/PlaceOrderServlet", value = "/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            // Read the JSON string from the request body
            String cartJson = request.getParameter("cart");

            // Deserialize the JSON string to a List of CartItems using Jackson
            ObjectMapper objectMapper = new ObjectMapper();
            //list of cart items
            List<Cart> clist = objectMapper.readValue(cartJson, new TypeReference<List<Cart>>() {
            });

            //fetching address and billing name from the request body
            String billAdd = request.getParameter("bilAdd");
            String billNm = request.getParameter("bilName");
            String contact = request.getParameter("bilcn");

            //fetching user from session
            HttpSession session = request.getSession();
            User usr = (User) session.getAttribute("current-user");

            //creating product list from cart
            Set<Product> plist = new HashSet<>();
            int oTotal = 0;
            int totalProd = 0;
            for (Cart c : clist) {
                ProductDao pd = new ProductDao(FactoryProvider.getFactory());
                Product p = pd.getProductById(c.getProductId());
                p.setpQuantity(c.getProductQuantity());
                p.setpPrice(c.getProductPrice());
                plist.add(p);
                int cal = c.getProductPrice() * c.getProductQuantity();
                oTotal = oTotal + cal;
                totalProd = totalProd + c.getProductQuantity();
            }
            //setting order status as ordered
            String status = "ordered";

            //creating order object and setting values
            Order o = new Order();
            o.setUser(usr);
            o.setProducts(plist);
            o.setTotalProducts(totalProd);
            o.setOrderTotal(oTotal);
            o.setAddress(billAdd);
            o.setContact(contact);
            o.setBillingName(billNm);
            o.setStatus(status);

            //saving order in orders table with status=ordered
            OrderDao od = new OrderDao(FactoryProvider.getFactory());
            od.createOrder(o);
            response.sendRedirect("orderPlaced.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}