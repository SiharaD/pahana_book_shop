<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Email Bill</title>
<style>
    /* Make all text white */
    body, h2, label, input {
        color: white;
        font-family: Arial, sans-serif;
    }

    /* Center form */
    body {
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        transition: background 1s ease-in-out;
    }

    form {
        background: rgba(0, 0, 0, 0.6);
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0px 0px 15px rgba(255,255,255,0.3);
    }

    input[type="email"], input[type="submit"] {
        padding: 10px;
        margin: 10px 0;
        border: none;
        border-radius: 8px;
        width: 100%;
        max-width: 300px;
    }

    input[type="submit"] {
        background: #ff9800;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: 0.3s;
    }

    input[type="submit"]:hover {
        background: #e68900;
    }
</style>
</head>
<body>
 <div>
    <h2>Enter Your Email to Receive the Bill</h2>
    <form action="td" method="post">
        <label for="email">Email Address:</label><br>
        <input type="email" id="email" name="email" required>
        
        <!-- Hidden fields for bill details -->
        <input type="hidden" name="title" value="${param.title}">
        <input type="hidden" name="author" value="${param.author}">
        <input type="hidden" name="publisher" value="${param.publisher}">
        <input type="hidden" name="price" value="${param.price}">
        <input type="hidden" name="category" value="${param.category}">
        <input type="hidden" name="edition" value="${param.edition}">
        <input type="hidden" name="language" value="${param.language}">
        <input type="hidden" name="description" value="${param.description}">

        <br>
        <input type="submit" value="Send Bill">
    </form>
 </div>

<!-- Background animation (inline JS) -->
<script>
    const backgrounds = [
        "linear-gradient(135deg, #1e3c72, #2a5298)",
        "linear-gradient(135deg, #ff512f, #dd2476)",
        "linear-gradient(135deg, #11998e, #38ef7d)",
        "linear-gradient(135deg, #fc4a1a, #f7b733)",
        "linear-gradient(135deg, #654ea3, #eaafc8)"
    ];

    let index = 0;
    function changeBackground() {
        document.body.style.background = backgrounds[index];
        index = (index + 1) % backgrounds.length;
    }
    setInterval(changeBackground, 5000);
    changeBackground(); // Initial load
</script>
</body>
</html>
