<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>All Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: linear-gradient(270deg, #ff9a9e, #fad0c4, #fad0c4, #a1c4fd);
            background-size: 800% 800%;
            animation: bgAnimation 20s ease infinite;
            color: #fff;
        }
        @keyframes bgAnimation {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        h2 {
            text-align: center;
            font-size: 28px;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: white;
            animation: textPulse 2s infinite;
        }
        @keyframes textPulse {
            0% { color: #fff; }
            50% { color: #ffe600; }
            100% { color: #fff; }
        }
        table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
            background: rgba(0,0,0,0.6);
            border-radius: 10px;
            overflow: hidden;
            animation: fadeIn 2s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            color: white;
        }
        th {
            background: #222;
            color: #ffeb3b;
        }
        tr:hover {
            background-color: rgba(255,255,255,0.2);
            transform: scale(1.02);
            transition: all 0.3s ease;
        }
        .btn {
            padding: 6px 12px;
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            transition: 0.3s;
        }
        .btn:hover {
            background-color: #d32f2f;
            box-shadow: 0 0 10px red, 0 0 20px red;
        }
        .load-btn {
            margin: 20px auto;
            display: block;
            padding: 12px 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            transition: 0.3s;
        }
        .load-btn:hover {
            background-color: #45a049;
            box-shadow: 0 0 15px lime, 0 0 30px lime;
        }
        .details-btn {
            padding: 6px 12px;
            background-color: #2196F3;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            transition: 0.3s;
        }
        .details-btn:hover {
            background-color: #1976D2;
            box-shadow: 0 0 10px cyan, 0 0 20px cyan;
        }

        /* Popup notification */
        .popup {
            position: fixed;
            top: 20px;
            right: -400px;
            padding: 12px 20px;
            border-radius: 6px;
            font-weight: bold;
            color: #fff;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0,0,0,0.4);
            transition: right 0.6s ease;
        }
        .popup.show { right: 20px; }
        .success { background-color: #28a745; }
        .error { background-color: #dc3545; }
    </style>

    <script>
        // Animated title text
        let titleText = "📚 All Books 📚";
        let i = 0;
        function animateTitle() {
            document.querySelector("h2").innerHTML = titleText.substring(0, i);
            i++;
            if (i > titleText.length) i = 0;
            setTimeout(animateTitle, 200);
        }
        window.onload = animateTitle;

        // Popup notification
        function showPopup(message, type) {
            const popup = document.createElement("div");
            popup.className = "popup " + type;
            popup.innerText = message;
            document.body.appendChild(popup);
            setTimeout(() => popup.classList.add("show"), 100);
            setTimeout(() => {
                popup.classList.remove("show");
                setTimeout(() => popup.remove(), 600);
            }, 3000);
        }

        // Example: show notification if server sets a message
        <% if(request.getAttribute("message") != null) { %>
            showPopup("<%= request.getAttribute("message") %>", "success");
        <% } %>

    </script>
</head>
<body>

    <form action="BookListServlet" method="get">
        <button type="submit" class="load-btn">Load All Books</button>
    </form>

    <h2>All Books</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Publisher</th>
            <th>ISBN</th>
            <th>Category</th>
            <th>Edition</th>
            <th>Language</th>
            <th>Description</th>
            <th>Image</th>
            <th>Action</th>
        </tr>

        <c:forEach var="b" items="${books}">
            <tr>
                <td>${b.bookid}</td>
                <td>${b.title}</td>
                <td>${b.author}</td>
                <td>${b.publisher}</td>
                <td>${b.isbn}</td>
                <td>${b.category}</td>
                <td>${b.edition}</td>
                <td>${b.language}</td>
                <td>${b.description}</td>
                <td>${b.image}</td>
                <td>
                    <form action="BookListServlet" method="post" style="display:inline;">
                        <input type="hidden" name="delete" value="${b.bookid}"/>
                        <input type="submit" value="Delete" class="btn" 
                               onclick="return confirm('Are you sure you want to delete this book?')"/>
                    </form>
                    <form action="BookDetailsServlet" method="get" style="display:inline;">
                        <input type="hidden" name="bookid" value="${b.bookid}"/>
                        <input type="submit" value="Details" class="details-btn"/>
                    </form>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty books}">
            <tr>
                <td colspan="11">No books found!</td>
            </tr>
            <script>
                showPopup("No books found!", "error");
            </script>
        </c:if>
    </table>
</body>
</html>
