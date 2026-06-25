<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CraveCart | Home</title>

<!-- CSS FILES -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>

<body>

<!-- ================= NAVBAR START ================= -->
<header class="navbar">
    <div class="logo">CraveCart</div>

    <nav>
        <a href="#">Home</a>
        <a href="#restaurants">Restaurants</a>
        <a href="#categories">Categories</a>
        <a href="#">My Orders</a>
        <a href="#">Contact</a>
    </nav>

    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
</header>
<!-- ================= NAVBAR END ================= -->


<!-- ================= HERO SECTION START ================= -->
<section class="hero">

    <video autoplay muted playsinline class="hero-video" id="heroVideo">
        <source id="heroSource" src="${pageContext.request.contextPath}/videos/Veggs.mp4" type="video/mp4">
    </video>

    <div class="hero-overlay"></div>

    <div class="hero-content">
        <h1>
		    From Your Favorite Kitchen
		    <br>
		    To Your Doorstep.
		</h1>
        <p>Discover top restaurants, fresh meals, and fast delivery with CraveCart.</p>

        <div class="search-box">
            <input type="text" placeholder="Search restaurants, cuisines or dishes...">
            <button>Search</button>
        </div>

        <div class="hero-buttons">
		    <a href="#restaurants" class="main-btn">Explore Restaurants</a>
		    <a href="#categories" class="secondary-btn">Browse Categories</a>
		</div>
    </div>
</section>
<!-- ================= HERO SECTION END ================= -->


<!-- ================= CATEGORY SECTION START ================= -->
<section class="categories" id="categories">
    
	    <!-- ================= CATEGORIES HEADING START ================= -->
	
	<div class="section-badge">
	    🍽️ POPULAR CATEGORIES
	</div>
	
	<h2 class="category-title">
	    Choose. Crave.
	    <span>Celebrate.</span>
	</h2>
	
	<p class="category-subtitle">
	    Every craving begins here. Fresh flavors, endless choices, delivered with love.
	</p>
	
	<!-- ================= CATEGORIES HEADING END ================= -->

    <div class="category-container">

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/biriyani.webp" alt="Biryani">
            <h3>Biryani</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/burger.webp" alt="Burger">
            <h3>Burger</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/chole.webp" alt="Chole">
            <h3>Chole Bhature</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/dosa.webp" alt="Dosa">
            <h3>Dosa Idali</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/north.webp" alt="North Indian">
            <h3>North Indian</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/paneer.webp" alt="Paneer">
            <h3>Paneer</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/pizza.webp" alt="Pizza">
            <h3>Pizza</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/ramen.webp" alt="Ramen">
            <h3>Ramen</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/sweet.webp" alt="Desserts">
            <h3>Desserts</h3>
        </div>

        <div class="category-card">
            <img src="${pageContext.request.contextPath}/images/salad.webp" alt="Salad">
            <h3>Salad</h3>
        </div>

    </div>
</section>
<!-- ================= CATEGORY SECTION END ================= -->


<!-- ================= RESTAURANTS SECTION START ================= -->
<section class="restaurants" id="restaurants">

    <div class="section-badge">⭐ TOP RESTAURANTS</div>

    <h2>Curated for <span>Every Craving</span></h2>

    <p>
        Discover exceptional restaurants, signature dishes, and flavors you'll keep coming back for.
    </p>

    <div class="restaurant-container">

        <!-- RESTAURANT 1 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/meghana.webp" alt="Meghana Foods">
                
                <span class="time">⏱ 25 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Meghana Foods <span class="verified">✔</span></h3>
                <p>Biryani • Andhra</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.8</span>
                    <span>₹200+</span>
                    <span>North Indian</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag best">🔥 Best Seller</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=1" class="menu-btn">
                        View Menu →
                    </a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 2 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/empire.webp" alt="Empire Restaurant">
                
                <span class="time">⏱ 30 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Empire Restaurant <span class="verified">✔</span></h3>
                <p>North Indian • Mughlai</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.6</span>
                    <span>₹350+</span>
                    <span>Mughlai</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag purple">🌙 Open Late</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=2" class="menu-btn">
                        View Menu →
                    </a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 3 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/pizzahut.webp" alt="Pizza Hut">
               
                <span class="time">⏱ 28 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Pizza Hut <span class="verified">✔</span></h3>
                <p>Pizza • Italian</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.5</span>
                    <span>₹250+</span>
                    <span>Italian</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag orange">🍕 Cheesy Favourite</span>
                    <a href="${pageContext.request.contextPath}/menu?restaurantId=3" class="menu-btn">
                        View Menu →
                    </a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 4 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/dominos.webp" alt="Domino's Pizza">
                
                <span class="time">⏱ 20 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Domino's Pizza <span class="verified">✔</span></h3>
                <p>Pizza • Fast Food</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.4</span>
                    <span>₹220+</span>
                    <span>Pizza</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag green">🚀 Fast Delivery</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 5 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/kfc.webp" alt="KFC">
                
                <span class="time">⏱ 22 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>KFC <span class="verified">✔</span></h3>
                <p>Chicken • Burgers</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.5</span>
                    <span>300+</span>
                    <span>Chicken</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag orange">🍗 Crispy Chicken</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 6 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/california.webp" alt="California Burrito">
                <span class="time">⏱ 24 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>California Burrito <span class="verified">✔</span></h3>
                <p>Mexican • Healthy</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.7</span>
                    <span>₹400+</span>
                    <span>Mexican</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag green">🥗 Healthy Choice</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 7 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/beijingbites.webp" alt="Beijing Bites">
              
                <span class="time">⏱ 26 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Beijing Bites <span class="verified">✔</span></h3>
                <p>Chinese • Asian</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.4</span>
                    <span>₹280+</span>
                    <span>Chinese</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag red">🥢 Chinese Special</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 8 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/a2b.webp" alt="A2B">
              
                <span class="time">⏱ 18 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>A2B <span class="verified">✔</span></h3>
                <p>South Indian • Veg</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.7</span>
                    <span>₹180+</span>
                    <span>Vegetarian</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag green">🥘 Pure Veg</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

        <!-- RESTAURANT 9 -->
        <div class="restaurant-card">
            <div class="restaurant-image">
                <img src="${pageContext.request.contextPath}/images/bbq.webp" alt="Barbeque Nation">

                <span class="time">⏱ 35 mins</span>
                <span class="wishlist">♡</span>
            </div>

            <div class="restaurant-body">
                <h3>Barbeque Nation <span class="verified">✔</span></h3>
                <p>BBQ • Buffet</p>

                <div class="restaurant-meta">
                    <span>⭐ 4.8</span>
                    <span>₹500+</span>
                    <span>Buffet</span>
                </div>

                <div class="card-bottom">
                    <span class="card-tag orange">🔥 Grill Special</span>
                    <a href="#" class="menu-btn">View Menu →</a>
                </div>
            </div>
        </div>

    </div>

    <a href="#" class="view-all-btn">View All Restaurants →</a>

</section>
<!-- ================= RESTAURANTS SECTION END ================= -->

<!-- ================= WHY CHOOSE SECTION START ================= -->
<section class="why">
    <h2>Why Choose CraveCart?</h2>

    <div class="why-container">

        <div class="why-card">
            <h3>🚀 Fast Delivery</h3>
            <p>Get your favorite meals delivered quickly.</p>
        </div>

        <div class="why-card">
            <h3>⭐ Top Rated</h3>
            <p>Order from trusted and highly rated restaurants.</p>
        </div>

        <div class="why-card">
            <h3>🎁 Offers</h3>
            <p>Enjoy exciting coupons and special discounts.</p>
        </div>

        <div class="why-card">
            <h3>🍽 Variety</h3>
            <p>Explore biryani, pizza, paneer, chicken and more.</p>
        </div>

    </div>
</section>
<!-- ================= WHY CHOOSE SECTION END ================= -->


<!-- ================= FOOTER START ================= -->
<footer>
    <h3>CraveCart</h3>
    <p>From your favorite kitchen to your doorstep.</p>
    <p>© 2026 CraveCart. All Rights Reserved.</p>
</footer>
<!-- ================= FOOTER END ================= -->

<script src="${pageContext.request.contextPath}/js/home.js"></script>

</body>
</html>