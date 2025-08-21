package servlet;

import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/td")
public class td extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String toEmail = request.getParameter("email");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String price = request.getParameter("price");
        String category = request.getParameter("category");
        String edition = request.getParameter("edition");
        String language = request.getParameter("language");
        String description = request.getParameter("description");

        // Your Gmail credentials
        final String fromEmail = "thulakshanadissanayake13@gmail.com";          // 🔁 Replace with your Gmail
        final String password = "jfxbscdyfvpbduae";              // 🔁 Replace with your 16-digit app password
        final String subject = "Your Book Purchase Bill";

        // Compose the bill content
        StringBuilder billContent = new StringBuilder();
        billContent.append("********** Book Purchase Bill **********\n");
        billContent.append("Title     : ").append(title).append("\n");
        billContent.append("Author    : ").append(author).append("\n");
        billContent.append("Publisher : ").append(publisher).append("\n");
        billContent.append("Description: ").append(description).append("\n");
        billContent.append("Category  : ").append(category).append("\n");
        billContent.append("Edition   : ").append(edition).append("\n");
        billContent.append("Language  : ").append(language).append("\n");
        billContent.append("----------------------------------------\n");
        billContent.append("Price     : ").append(price).append("\n");
        billContent.append("----------------------------------------\n");
        billContent.append("Thank you for your purchase!\n");

        // Gmail SMTP configuration
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.debug", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(billContent.toString());

            Transport.send(message);

            response.setContentType("text/html");
            response.getWriter().println("<h3>Bill sent successfully to " + toEmail + "</h3>");
        } catch (MessagingException e) {
            e.printStackTrace(); // Still prints to server logs
            response.setContentType("text/html");
            response.getWriter().println("<h3>Failed to send email:<br>" + e.getMessage() + "</h3>");
        }
    }
}
