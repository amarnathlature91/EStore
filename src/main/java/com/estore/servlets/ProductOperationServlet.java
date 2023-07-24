package com.estore.servlets;

import com.estore.dao.CategoryDao;
import com.estore.dao.ProductDao;
import com.estore.entities.Category;
import com.estore.entities.Product;
import com.estore.helper.FactoryProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;

@MultipartConfig
@WebServlet(name = "ProductOperationServlet", value = "/ProductOperationServlet")
public class ProductOperationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

//        fetch operation
        String opr = request.getParameter("op");

        if (opr.trim().equals("addProduct")) {

//            fetching parameters
            String name = request.getParameter("nm");
            String description = request.getParameter("pdes");
            int price = Integer.parseInt(request.getParameter("prc"));
            int discount =Integer.parseInt( request.getParameter("dis"));
            int quantity = Integer.parseInt(request.getParameter("qua"));
            Part photo = request.getPart("pht");
            int cId=Integer.parseInt(request.getParameter("catId"));

//            creating product object and setting data
            Product p=new Product();
            p.setpName(name);
            p.setpDescription(description);
            p.setpPrice(price);
            p.setpDiscount(discount);
            p.setpQuantity(quantity);
            p.setpPhoto(photo.getSubmittedFileName());
            CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
            Category c = cdao.getCategoryById(cId);
            p.setCategory(c);

//            saving product to database
            ProductDao pdao=new ProductDao(FactoryProvider.getFactory());
            pdao.saveProduct(p);
//            saving the photo
            String path=request.getRealPath("img")+File.separator+"product"+File.separator+photo.getSubmittedFileName();
            try {
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
            }catch (Exception e){
                e.printStackTrace();
            }
            HttpSession session = request.getSession();
            session.setAttribute("msg","Product added successfully.");
            response.sendRedirect("admin.jsp");

        }else if (opr.trim().equals("updateProduct")){
            Part photo = request.getPart("photo");
            if (photo.getSize()>0){
                //fetching parameters
                String name = request.getParameter("name");
                int price = Integer.parseInt(request.getParameter("price").trim());
                int discount =Integer.parseInt( request.getParameter("discount").trim());
                int quantity = Integer.parseInt(request.getParameter("quantity").trim());
                int pId=Integer.parseInt(request.getParameter("pId"));

                //deleting old photo
                try{
                    String oldpht = new ProductDao(FactoryProvider.getFactory()).getProductById(pId).getpPhoto();
                    String filePath = request.getRealPath("img") + File.separator + "product" + File.separator + oldpht;
                    System.out.println(filePath);
                    File file = new File(filePath);
                    file.delete();
                }catch (Exception e){
                    e.printStackTrace();
                }
                //updating product with photo name
                new ProductDao(FactoryProvider.getFactory()).updateProductWithPhotoChange(pId,name,price,discount,quantity, photo.getSubmittedFileName());

//                saving new photo
                String path=request.getRealPath("img")+File.separator+"product"+File.separator+photo.getSubmittedFileName();
                try {
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
                }catch (Exception e){
                    e.printStackTrace();
                }

            }else {
                //fetching parameters
                String name = request.getParameter("name");
                int price = Integer.parseInt(request.getParameter("price").trim());
                int discount =Integer.parseInt( request.getParameter("discount").trim());
                int quantity = Integer.parseInt(request.getParameter("quantity").trim());
                int pId=Integer.parseInt(request.getParameter("pId"));

                new ProductDao(FactoryProvider.getFactory()).updateProduct(pId,name,price,discount,quantity);
            }
            HttpSession session = request.getSession();
            session.setAttribute("msg","Product updated successfully.");
            response.sendRedirect("allProducts.jsp");
        } else if (opr.trim().equals("deleteProduct")){
            int pId=Integer.parseInt(request.getParameter("pId"));
            new ProductDao(FactoryProvider.getFactory()).deleteProductById(pId);
            HttpSession session = request.getSession();
            session.setAttribute("msg","Product deleted successfully.");
            response.sendRedirect("allProducts.jsp");
        }
    }
}