<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String contextPath = request.getContextPath();
%>

<style>
    .footer {
        background: #172337;
        color: white;
        margin-top: 50px;
    }
    
    .footer-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 40px 20px 20px;
    }
    
    .footer-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 30px;
        margin-bottom: 30px;
    }
    
    .footer-column h3 {
        font-size: 12px;
        color: #878787;
        text-transform: uppercase;
        margin-bottom: 20px;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    
    .footer-column ul {
        list-style: none;
        padding: 0;
    }
    
    .footer-column ul li {
        margin-bottom: 12px;
    }
    
    .footer-column ul li a {
        color: white;
        text-decoration: none;
        font-size: 14px;
        transition: color 0.3s;
    }
    
    .footer-column ul li a:hover {
        color: #ff9f00;
    }
    
    .footer-bottom {
        border-top: 1px solid #2d3e50;
        padding-top: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .copyright {
        color: #878787;
        font-size: 13px;
    }
    
    .footer-links {
        display: flex;
        gap: 20px;
    }
    
    .footer-links a {
        color: white;
        text-decoration: none;
        font-size: 13px;
    }
    
    .social-icons {
        display: flex;
        gap: 15px;
    }
    
    .social-icons a {
        color: white;
        font-size: 18px;
        transition: color 0.3s;
    }
    
    .social-icons a:hover {
        color: #ff9f00;
    }
    
    .back-to-top {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 50px;
        height: 50px;
        background: #2874f0;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        cursor: pointer;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s;
        z-index: 999;
        box-shadow: 0 4px 12px rgba(40, 116, 240, 0.3);
    }
    
    .back-to-top.visible {
        opacity: 1;
        visibility: visible;
    }
    
    .back-to-top:hover {
        background: #1e5fd8;
        transform: translateY(-3px);
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-grid">
            <div class="footer-column">
                <h3>ABOUT</h3>
                <ul>
                    <li><a href="<%= contextPath %>/contact">Contact Us</a></li>
                    <li><a href="<%= contextPath %>/about">About Us</a></li>
                    <li><a href="<%= contextPath %>/careers">Careers</a></li>
                    <li><a href="<%= contextPath %>/press">Press</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>HELP</h3>
                <ul>
                    <li><a href="<%= contextPath %>/payments">Payments</a></li>
                    <li><a href="<%= contextPath %>/shipping">Shipping</a></li>
                    <li><a href="<%= contextPath %>/returns">Cancellation & Returns</a></li>
                    <li><a href="<%= contextPath %>/faq">FAQ</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>POLICY</h3>
                <ul>
                    <li><a href="<%= contextPath %>/return-policy">Return Policy</a></li>
                    <li><a href="<%= contextPath %>/terms">Terms Of Use</a></li>
                    <li><a href="<%= contextPath %>/security">Security</a></li>
                    <li><a href="<%= contextPath %>/privacy">Privacy</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>SOCIAL</h3>
                <div class="social-icons">
                    <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
                    <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="footer-column">
                <h3>MAIL US</h3>
                <ul>
                    <li>EntityKart Internet Private Limited,</li>
                    <li>Buildings Alyssa, Begonia &</li>
                    <li>Clove Embassy Tech Village,</li>
                    <li>Outer Ring Road,</li>
                    <li>Begusarai, Bihar - 861126</li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="copyright">
                <p>&copy; 2024 EntityKart. All rights reserved.</p>
            </div>
            <div class="footer-links">
                <a href="<%= contextPath %>/terms">Terms of Service</a>
                <a href="<%= contextPath %>/privacy">Privacy Policy</a>
                <a href="<%= contextPath %>/sitemap">Sitemap</a>
            </div>
            <div class="social-icons">
                <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
                <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
    </div>
</footer>

<!-- Back to Top Button -->
<div class="back-to-top" id="backToTop" onclick="scrollToTop()">
    <i class="fas fa-chevron-up"></i>
</div>

<script>
    // Back to top functionality
    window.addEventListener('scroll', function() {
        const backToTop = document.getElementById('backToTop');
        if (backToTop) {
            if (window.scrollY > 300) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        }
    });
    
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
</script>