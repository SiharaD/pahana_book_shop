<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .profile-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            width: 400px;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        p {
            margin: 12px 0;
            font-size: 15px;
        }
        label {
            font-weight: bold;
            color: #555;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }
        input:focus {
            border-color: #6a82fb;
            box-shadow: 0 0 8px rgba(106,130,251,0.6);
            outline: none;
        }
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Popup notifications */
        .popup {
            position: fixed;
            top: 20px;
            right: -400px;
            padding: 15px 25px;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(0,0,0,0.4);
            transition: right 0.6s ease;
            z-index: 1000;
        }
        .popup.show { right: 20px; }
        .success { background-color: #28a745; }
        .error { background-color: #dc3545; }
    </style>
    <script>
        // Popup helper
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

        // Validation + confirm
        function validateAndConfirm(event) {
            const name = document.querySelector("input[name='name']").value.trim();
            const address = document.querySelector("input[name='address']").value.trim();
            const tel = document.querySelector("input[name='tell']").value.trim();
            const pass = document.querySelector("input[name='pass']").value.trim();

            if (name === "" || address === "" || tel === "" || pass === "") {
                showPopup("All fields are required!", "error");
                event.preventDefault();
                return false;
            }

            if (!/^[0-9]{10}$/.test(tel)) {
                showPopup("Telephone must be exactly 10 digits!", "error");
                event.preventDefault();
                return false;
            }

            if (pass.length < 6) {
                showPopup("Password must be at least 6 characters!", "error");
                event.preventDefault();
                return false;
            }

            if (!confirm("Are you sure you want to update your profile?")) {
                event.preventDefault();
                return false;
            }

            showPopup("Profile updated successfully!", "success");
            return true;
        }
    </script>
</head>
<body>
    <div class="profile-card">
        <h2>Welcome, ${custom.name}</h2>

        <form action="UpdateProfileServlet" method="post" onsubmit="return validateAndConfirm(event)">
            <input type="hidden" name="userid" value="${custom.userid}"/>

            <p><strong>User ID:</strong> ${custom.userid}</p>

            <p><label>Name:</label>
                <input type="text" name="name" value="${custom.name}" required/>
            </p>

            <p><label>Address:</label>
                <input type="text" name="address" value="${custom.address}" required/>
            </p>

            <p><label>Telephone:</label>
                <input type="number" name="tell" value="${custom.tell}" required/>
            </p>

            <p><label>Password:</label>
                <input type="password" name="pass" value="${custom.pass}" required/>
            </p>

            <button type="submit">Update Profile</button>
        </form>
    </div>
</body>
</html>
