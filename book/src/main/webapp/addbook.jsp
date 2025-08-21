<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Book</title>
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

  .form-label {
    font-weight: 600;
    color: #444;
  }

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

  /* Floating labels effect */
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

  /* Popup notifications */
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
</head>
<body>

<div class="form-container">
  <h2><i class="fas fa-book"></i> Add a New Book</h2>
  <form method="post" action="addbook" enctype="multipart/form-data" onsubmit="return validateForm()">

    <div class="form-group">
      <input type="number" class="form-control" id="bookid" name="bookid" required placeholder=" ">
      <label for="bookid">Book ID</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="title" name="title" required placeholder=" ">
      <label for="title">Book Title</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="author" name="author" required placeholder=" ">
      <label for="author">Author</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="publisher" name="publisher" placeholder=" ">
      <label for="publisher">Publisher</label>
    </div>

    <div class="form-group">
      <input type="number" class="form-control" id="isbn" name="isbn" required min="1" step="0.01" placeholder=" ">
      <label for="isbn">Price</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="category" name="category" placeholder=" ">
      <label for="category">Category</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="edition" name="edition" placeholder=" ">
      <label for="edition">Edition</label>
    </div>

    <div class="form-group">
      <input type="text" class="form-control" id="language" name="language" placeholder=" ">
      <label for="language">Language</label>
    </div>

    <div class="form-group">
      <textarea class="form-control" id="description" name="description" rows="3" placeholder=" "></textarea>
      <label for="description">Description</label>
    </div>

    <div class="form-group">
      <input type="file" class="form-control" id="cover" name="cover" placeholder=" ">
      <label for="cover">Cover Image</label>
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
  let i = 0;
  setInterval(() => {
    document.body.style.background = bgs[i];
    i = (i + 1) % bgs.length;
  }, 5000);

  // Form validation
  function validateForm() {
    const bookid = document.getElementById("bookid").value.trim();
    const title = document.getElementById("title").value.trim();
    const author = document.getElementById("author").value.trim();
    const price = document.getElementById("isbn").value.trim();

    if (bookid === "" || title === "" || author === "" || price === "") {
      showPopup("Please fill in all required fields!", "error");
      return false;
    }
    if (Number(price) <= 0) {
      showPopup("Price must be greater than 0!", "error");
      return false;
    }
    return true;
  }

  // Popup notifications
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

  // File input notification
  document.getElementById("cover").addEventListener("change", function(){
    if(this.files && this.files[0]){
      showPopup("Cover image selected: " + this.files[0].name, "success");
    }
  });

  // Optional: show server message if available
  <% if(request.getAttribute("message") != null) { %>
    showPopup("<%= request.getAttribute("message") %>", "success");
  <% } %>
</script>

</body>
</html>
