<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.book" %>
<!DOCTYPE html>
<html>
<head>
  <title>Book Store</title>
  <!-- Bootstrap & FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
    /* Default text */
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  color: white;       /* White text */
  font-weight: bold;  /* Bold everywhere */
  margin: 0;
  padding: 0;
}

/* Navbar links */
.nav-link {
  position: relative;
  font-weight: bold;
  color: white !important; /* white by default */
  transition: 0.3s;
}
.nav-link:hover {
  color: #ffd700 !important; /* yellow on hover */
  font-weight: bold;
}

/* Headings */
h2 {
  text-align: center;
  margin: 30px 0 20px;
  color: #ffd700;     /* Headings yellow */
  font-weight: bold;
}

/* Paragraph text inside cards stays black */
.card {
  background: white;
  color: #000; /* keep card text black */
}
    

    /* Card */
    .card {
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 5px 20px rgba(0,0,0,0.2);
      transition: transform 0.3s, box-shadow 0.3s;
      margin: 20px 0;
      background: white;
      color: #000; /* Black text inside card */
    }
    .card:hover {
      transform: translateY(-15px);
      box-shadow: 0 15px 40px rgba(0,0,0,0.3);
    }
    .card img {
      width: 100%;
      height: 250px;
      object-fit: cover;
      transition: transform 0.5s;
    }
    .card img:hover { transform: scale(1.1); }
    .card-body h5 {
      font-weight: bold;
      margin-bottom: 10px;
      color: #007BFF;
    }

    /* Buttons */
    .btn-custom {
      background: linear-gradient(to right, #007BFF, #00CFFF);
      color: white;
      font-weight: bold;
      border-radius: 25px;
      padding: 8px 20px;
      transition: all 0.3s;
    }
    .btn-custom:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    /* Slider */
    #slider {
      max-width: 1000px;
      margin: 20px auto;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.2);
    }
    #slider img { width: 100%; height: 400px; object-fit: cover; display: none; }
    #slider img:first-child { display: block; }

    /* Footer */
    footer {
      background: #222;
      color: #fff;
      padding: 20px 0;
      text-align: center;
      margin-top: 50px;
    }
    footer a { color: #fff; margin: 0 10px; text-decoration: none; }
    footer a:hover { text-decoration: underline; }

    /* Headings */
    h2 { text-align: center; margin: 30px 0 20px; color: #ffd700; }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg" style="background: linear-gradient(45deg, #007bff, #6610f2); box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
  <div class="container">
    <a class="navbar-brand text-light" href="#"><i class="fas fa-book-open me-2"></i>BookStore</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-lg-center">
        <li class="nav-item"><a class="nav-link text-light px-3" href="#">Home</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle text-light px-3" href="#" role="button" data-bs-toggle="dropdown">Categories</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Fiction</a></li>
            <li><a class="dropdown-item" href="#">Non-Fiction</a></li>
            <li><a class="dropdown-item" href="#">Comics</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link text-light px-3" href="#">Contact</a></li>
        <li class="nav-item"><a class="nav-link text-light px-3" href="#">About</a></li>
        <li class="nav-item ms-3">
          <form class="d-flex">
            <input class="form-control form-control-sm" type="search" placeholder="Search books...">
            <button class="btn btn-sm btn-light ms-2" type="submit"><i class="fas fa-search"></i></button>
          </form>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Slider -->
<div id="slider">
  <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794" class="slide">
  <img src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f" class="slide">
  <img src="https://images.unsplash.com/photo-1516979187457-637abb4f9353" class="slide">
  <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66" class="slide">
  <img src="https://images.unsplash.com/photo-1551024601-bec78aea704b" class="slide">
  <span onclick="prevSlide()" style="position:absolute; top:50%; left:10px; font-size:2rem; color:white; cursor:pointer;">&#10094;</span>
  <span onclick="nextSlide()" style="position:absolute; top:50%; right:10px; font-size:2rem; color:white; cursor:pointer;">&#10095;</span>
</div>

<!-- Books Section -->
<div class="container mt-5">
  <div class="text-center mb-4">
    <a href="${pageContext.request.contextPath}/viewbooks" class="btn btn-custom">Load Books</a>
  </div>
  <h2>All Books</h2>
  <div class="row justify-content-center">
    <%
      List<book> books = (List<book>) request.getAttribute("books");
      if (books != null && !books.isEmpty()) {
        for (book bk : books) {
    %>
    <div class="col-md-4 col-lg-3">
      <div class="card">
        <%
          String imageData = bk.getImage();
          if (imageData != null && imageData.length() > 0) {
        %>
          <img src="data:image/jpeg;base64,<%= imageData %>" alt="Book Cover"/>
        <% } else { %>
          <img src="https://via.placeholder.com/250x250?text=No+Image" alt="No Image"/>
        <% } %>
        <div class="card-body">
          <h5><%= bk.getTitle() %></h5>
          <p><strong>Author:</strong> <%= bk.getAuthor() %></p>
          <p><strong>Publisher:</strong> <%= bk.getPublisher() %></p>
          <p><strong>Price:</strong> $<%= bk.getIsbn() %></p>
          <form action="GenerateBillServlet" method="post">
            <input type="hidden" name="title" value="<%= bk.getTitle() %>"/>
            <input type="hidden" name="author" value="<%= bk.getAuthor() %>"/>
            <input type="hidden" name="publisher" value="<%= bk.getPublisher() %>"/>
            <input type="hidden" name="price" value="<%= bk.getIsbn() %>"/>
            <button type="submit" class="btn btn-custom w-100"><i class="fas fa-shopping-cart"></i> Buy</button>
          </form>
        </div>
      </div>
    </div>
    <%
        }
      } else {
    %>
    <p class="text-center">No books found. Click "Load Books" to view books.</p>
    <% } %>
  </div>
</div>

<!-- Services -->
<div class="text-center my-5" data-aos="fade-up">
  <h2>Our Services</h2>
  <p>We offer modern web solutions with great user experience.</p>
</div>

<!-- Counters -->
<div class="d-flex justify-content-around my-5">
  <div><h2 id="count1">0</h2><p>Happy Clients</p></div>
  <div><h2 id="count2">0</h2><p>Projects Done</p></div>
  <div><h2 id="count3">0</h2><p>Awards</p></div>
</div>

<!-- Footer -->
<footer>
  <p>Follow Us:</p>
  <a href="#"><i class="fab fa-facebook fa-2x"></i></a>
  <a href="#"><i class="fab fa-twitter fa-2x"></i></a>
  <a href="#"><i class="fab fa-instagram fa-2x"></i></a>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init();</script>

<script>
  // Slider
  var slides = document.getElementsByClassName("slide"), index=0;
  function showSlide(i){ for(let s of slides) s.style.display="none"; slides[i].style.display="block"; }
  function nextSlide(){ index=(index+1)%slides.length; showSlide(index); }
  function prevSlide(){ index=(index-1+slides.length)%slides.length; showSlide(index); }
  setInterval(nextSlide,3000);

  // Counters
  function animateValue(id, start, end, duration){
    let obj=document.getElementById(id), range=end-start, startTime=null;
    function step(timestamp){
      if(!startTime) startTime=timestamp;
      let progress=Math.min((timestamp-startTime)/duration,1);
      obj.innerHTML=Math.floor(progress*range+start);
      if(progress<1) requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }
  animateValue("count1",0,500,2000);
  animateValue("count2",0,120,2000);
  animateValue("count3",0,15,2000);

  // Background changer
  const backgrounds=[
    "url('https://picsum.photos/1920/1080?random=1')",
    "url('https://picsum.photos/1920/1080?random=2')",
    "url('https://picsum.photos/1920/1080?random=3')",
    "url('https://picsum.photos/1920/1080?random=4')"
  ];
  let bgIndex=0; document.body.style.transition="background 1s ease-in-out";
  function changeBg(){ document.body.style.background=backgrounds[bgIndex]+" no-repeat center/cover"; bgIndex=(bgIndex+1)%backgrounds.length; }
  changeBg(); setInterval(changeBg,5000);
</script>
</body>
</html>
