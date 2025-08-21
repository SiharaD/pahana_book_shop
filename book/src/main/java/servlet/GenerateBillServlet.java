package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get book details from request
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String edition = request.getParameter("edition");
        String language = request.getParameter("language");
        String description = request.getParameter("description");

        // Set response type for file download
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment;filename=bill.txt");

        // Write bill content
        PrintWriter out = response.getWriter();
        out.println("********** Book Purchase Bill **********");
        out.println("Title     : " + title);
        out.println("Author    : " + author);
        out.println("Publisher : " + publisher);
        out.println("Description: " + description);
        out.println("Category  : " + category);
        out.println("Edition   : " + edition);
        out.println("Language  : " + language);
        out.println("----------------------------------------");
        out.println("Price     : " + price);
        out.println("----------------------------------------");
        out.println("Thank you for your purchase!");
        out.close();
    }
}
