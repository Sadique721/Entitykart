<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Pay with Razorpay</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
    <h2>Order #${order.orderId}</h2>
    <p>Total Amount: ₹${order.totalAmount}</p>
    <button id="rzp-button">Pay Now</button>

    <script>
        document.getElementById("rzp-button").onclick = function(e) {
            fetch('/razorpay/create-order?orderId=' + ${order.orderId})
            .then(response => response.json())
            .then(orderData => {
                var options = {
                	"key": "${razorpayKey}",  // same as in application.properties
                    "amount": orderData.amount,
                    "currency": "INR",
                    "name": "EntityKart",
                    "description": "Order Payment",
                    "order_id": orderData.id,
                    "handler": function (response) {
                        // After successful payment, send to backend
                        fetch('/razorpay/success', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: `orderId=${orderData.receipt.split('_')[1]}&razorpay_payment_id=${response.razorpay_payment_id}&razorpay_order_id=${response.razorpay_order_id}&razorpay_signature=${response.razorpay_signature}`
                        })
                        .then(res => res.json())
                        .then(data => {
                            if (data.success) {
                                window.location.href = "/order/confirmation?orderId=" + data.orderId;
                            } else {
                                alert("Payment verification failed");
                                window.location.href = "/checkout";
                            }
                        });
                    },
                    "prefill": {
                        "name": "${sessionScope.user.name}",
                        "email": "${sessionScope.user.email}",
                        "contact": "${sessionScope.user.contactNum}"
                    },
                    "theme": {
                        "color": "#3399cc"
                    }
                };
                var rzp = new Razorpay(options);
                rzp.open();
            })
            .catch(err => {
                console.error(err);
                alert("Unable to create order");
            });
        };
    </script>
</body>
</html>