<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User List</title>
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
            width: 80%;
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

        /* Popup notification */
        .popup {
            position: fixed;
            top: 20px;
            right: -300px;
            padding: 15px 20px;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(0,0,0,0.4);
            transition: right 0.6s ease;
            z-index: 1000;
        }
        .popup.show { right: 20px; }
        .success { background-color: #4CAF50; }
        .error { background-color: #f44336; }
    </style>

    <script>
        // Animated title text
        let titleText = "✨ All Users ✨";
        let i = 0;
        function animateTitle() {
            document.querySelector("h2").innerHTML = titleText.substring(0, i);
            i++;
            if (i > titleText.length) i = 0;
            setTimeout(animateTitle, 200);
        }

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

        // Delete confirmation + validation
        function confirmDelete(userid) {
            if (userid === "" || userid == null) {
                showPopup("Invalid User ID!", "error");
                return false;
            }
            return confirm("Are you sure you want to delete user with ID: " + userid + "?");
        }

        window.onload = animateTitle;

        // Display popup if server sent a message
        window.addEventListener("load", function() {
            <% if(request.getAttribute("message") != null) { %>
                showPopup("<%= request.getAttribute("message") %>", "success");
            <% } %>
        });
    </script>
</head>
<body>

    <form action="UserServlet" method="get">
        <button type="submit" class="load-btn">Load All Users</button>
    </form>

    <h2>All Users</h2>
    <table>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Telephone</th>
            <th>Password</th>
            <th>Action</th>
        </tr>
        <c:forEach var="cus" items="${userList}">
            <tr>
                <td>${cus.userid}</td>
                <td>${cus.name}</td>
                <td>${cus.address}</td>
                <td>${cus.tell}</td>
                <td>${cus.pass}</td>
                <td>
                    <form action="UserServlet" method="post" 
                          onsubmit="return confirmDelete('${cus.userid}')">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="userid" value="${cus.userid}"/>
                        <input type="submit" value="Delete" class="btn"/>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
