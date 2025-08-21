package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.book;
import service.services;

@WebServlet("/BookListServlet")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        services svc = new services();
        List<book> books = svc.bkall();
        request.setAttribute("books", books);

        RequestDispatcher dispatcher = request.getRequestDispatcher("booklist.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("delete") != null) {
            int bookid = Integer.parseInt(request.getParameter("delete"));
            services svc = new services();
            svc.deleteBook(bookid);
        }
        response.sendRedirect("BookListServlet");
    }
}
