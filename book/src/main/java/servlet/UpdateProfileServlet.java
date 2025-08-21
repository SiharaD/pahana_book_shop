package servlet;

import model.customer;
import service.services;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // get form values
        String userid = request.getParameter("userid");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String tell = request.getParameter("tell");
        String pass = request.getParameter("pass");

        // fill customer bean
        customer cus = new customer();
        cus.setUserid(userid);
        cus.setName(name);
        cus.setAddress(address);
        cus.setTell(Integer.parseInt(tell));
        cus.setPass(pass);

        // call service
        services ser = new services();
        boolean success = ser.updateProfile(cus);

        if (success) {
            // reload updated data
            customer updated = ser.getone(cus);
            request.setAttribute("custom", updated);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.getWriter().println("Profile update failed!");
        }
    }
}
