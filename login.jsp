<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
    body { 
        font-family: 'Segoe UI', sans-serif; 
        margin: 0; padding: 0; height: 100vh;
        display: flex; justify-content: center; align-items: center;
        background: linear-gradient(135deg, #74ebd5, #ACB6E5); 
        transition: background 2s ease;
    }
    .login-container {
        width: 320px; padding: 25px;
        background: rgba(255,255,255,0.95);
        border-radius: 12px;
        box-shadow: 0px 8px 20px rgba(0,0,0,0.2);
        animation: fadeIn 1.2s ease;
    }
    h2 { text-align: center; margin-bottom: 20px; color: #333; }
    
    .input-group { position: relative; margin-bottom: 18px; }
    .input-group input {
        width: 100%; padding: 12px 10px; 
        border: 1px solid #ccc; border-radius: 6px;
        outline: none; font-size: 14px;
        transition: all 0.3s ease;
    }
    .input-group label {
        position: absolute; top: 12px; left: 12px;
        font-size: 14px; color: #888;
        transition: 0.3s ease all;
        pointer-events: none;
    }
    .input-group input:focus { border-color: #4CAF50; box-shadow: 0px 0px 6px rgba(76,175,80,0.4); }
    .input-group input:focus + label,
    .input-group input:valid + label {
        top: -8px; left: 8px;
        font-size: 12px; background: #fff; padding: 0 5px; color: #4CAF50;
    }

    button {
        width: 100%; padding: 12px; background: linear-gradient(135deg,#4CAF50,#45a049);
        color: white; border: none; border-radius: 6px;
        font-size: 16px; font-weight: bold;
        cursor: pointer; transition: 0.3s ease;
    }
    button:hover { transform: scale(1.05); box-shadow: 0px 6px 15px rgba(0,0,0,0.2); }

    @keyframes fadeIn { from {opacity: 0; transform: translateY(-20px);} to {opacity: 1; transform: translateY(0);} }

    /* Popup notification */
    .popup {
        position: fixed;
        top: 20px; right: -400px;
        padding: 14px 25px;
        border-radius: 8px;
        color: #fff; font-weight: bold;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        transition: right 0.6s ease;
        z-index: 1000;
    }
    .popup.show { right: 20px; }
    .success { background: #28a745; }
    .error { background: #dc3545; }
</style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>
    <form method="post" action="log" onsubmit="return validateLogin(event)">
        <div class="input-group">
            <input type="text" id="exampleInputEmail1" name="username" required>
            <label for="exampleInputEmail1">Username</label>
        </div>
        <div class="input-group">
            <input type="password" id="exampleInputPassword1" name="password" required>
            <label for="exampleInputPassword1">Password</label>
        </div>
        <button type="submit">Submit</button>
    </form>
</div>

<script>
    // Background gradient changer every 5 seconds
    const colors = [
        "linear-gradient(135deg, #74ebd5, #ACB6E5)",
        "linear-gradient(135deg, #ff9a9e, #fad0c4)",
        "linear-gradient(135deg, #a18cd1, #fbc2eb)",
        "linear-gradient(135deg, #fddb92, #d1fdff)"
    ];
    let i = 0;
    setInterval(() => {
        document.body.style.background = colors[i];
        i = (i + 1) % colors.length;
    }, 5000);

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

    // Simple validation before submission
    function validateLogin(event) {
        const user = document.getElementById("exampleInputEmail1").value.trim();
        const pass = document.getElementById("exampleInputPassword1").value.trim();

        if (user === "" || pass === "") {
            showPopup("Username and Password are required!", "error");
            event.preventDefault();
            return false;
        }

        // You can add extra checks (length, regex, etc.)
        showPopup("Logging in...", "success");
        return true;
    }

    // Example: if server sends a message, show it
    <% if (request.getAttribute("message") != null) { %>
        showPopup("<%= request.getAttribute("message") %>", "error");
    <% } %>
</script>

</body>
</html>
