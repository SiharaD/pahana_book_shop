<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Sign Up</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
  body {
    background: linear-gradient(135deg, #007bff, #6610f2);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Segoe UI', sans-serif;
  }

  .form-container {
    background: #fff;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    width: 100%;
    max-width: 600px;
    animation: fadeIn 1s ease-in-out;
  }

  h2 {
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
    color: #007bff;
  }

  .form-label { font-weight: 600; color: #444; }

  .form-control {
    border-radius: 10px;
    transition: all 0.3s ease-in-out;
  }

  .form-control:focus {
    box-shadow: 0 0 10px rgba(0,123,255,0.5);
    transform: scale(1.02);
  }

  .btn-submit {
    background: linear-gradient(45deg, #007bff, #00c6ff);
    border: none;
    font-weight: bold;
    border-radius: 30px;
    padding: 10px 20px;
    width: 100%;
    transition: 0.3s;
  }
  .btn-submit:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
  }

  @keyframes fadeIn {
    from {opacity: 0; transform: translateY(30px);}
    to {opacity: 1; transform: translateY(0);}
  }

  /* Floating labels */
  .form-group {
    position: relative;
    margin-bottom: 1.5rem;
  }
  .form-group label {
    position: absolute;
    top: 12px;
    left: 15px;
    transition: 0.3s;
    color: #666;
    pointer-events: none;
  }
  .form-control:focus + label,
  .form-control:not(:placeholder-shown) + label {
    top: -10px;
    left: 10px;
    font-size: 12px;
    color: #007bff;
    background: #fff;
    padding: 0 5px;
    border-radius: 5px;
  }

  /* Popup notification */
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
</head>
<body>

<div class="form-container">
  <h2><i class="fas fa-user-plus"></i> User Sign Up</h2>
  <form method="post" action="sign_up" onsubmit="return validateForm();">
  
    <div class="form-group">
      <input type="text" class="form-control" id="text1" name="userid" required placeholder=" ">
      <label for="text1">User ID</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="text2" name="name" required placeholder=" ">
      <label for="text2">User Name</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="text3" name="address" required placeholder=" ">
      <label for="text3">Address</label>
    </div>

    <div class="form-group">
      <input type="number" class="form-control" id="text4" name="tel" required placeholder=" ">
      <label for="text4">Telephone Number</label>
    </div>

    <div class="form-group">
      <input type="password" class="form-control" id="text5" name="pass" required placeholder=" ">
      <label for="text5">Password</label>
    </div>

    <button type="submit" class="btn btn-submit"><i class="fas fa-paper-plane"></i> Submit</button>
  </form>
</div>

<script>
  // Background auto-change
  const bgs = [
    "linear-gradient(135deg, #007bff, #6610f2)",
    "linear-gradient(135deg, #ff512f, #dd2476)",
    "linear-gradient(135deg, #11998e, #38ef7d)",
    "linear-gradient(135deg, #fc5c7d, #6a82fb)"
  ];
  let bgIndex = 0;
  setInterval(() => {
    document.body.style.background = bgs[bgIndex];
    bgIndex = (bgIndex + 1) % bgs.length;
  }, 5000);

  // Popup function
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

  // Form validation
  function validateForm() {
    const userid = document.getElementById("text1").value.trim();
    const name = document.getElementById("text2").value.trim();
    const address = document.getElementById("text3").value.trim();
    const tel = document.getElementById("text4").value.trim();
    const pass = document.getElementById("text5").value.trim();

    if (userid === "" || name === "" || address === "" || tel === "" || pass === "") {
      showPopup("All fields are required!", "error");
      return false;
    }

    if (!/^\d{10}$/.test(tel)) {
      showPopup("Telephone must be 10 digits!", "error");
      return false;
    }

    if (pass.length < 6) {
      showPopup("Password must be at least 6 characters!", "error");
      return false;
    }

    // If everything is good
    showPopup("Form submitted successfully!", "success");
    return true;
  }
</script>

</body>
</html>
