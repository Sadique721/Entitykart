////package com.grownited.service;
//
//import com.grownited.controller.OrderController;
//import com.grownited.entity.PaymentEntity;
//import com.grownited.entity.PaymentEntity.PaymentGatewayStatus;
//import com.grownited.entity.PaymentEntity.PaymentMode;
//import com.grownited.repository.PaymentRepository;
//import net.authorize.Environment;
//import net.authorize.api.contract.v1.*;
//import net.authorize.api.controller.CreateTransactionController;
//import net.authorize.api.controller.base.ApiOperationBase;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//import com.razorpay.RazorpayClient;
//import com.razorpay.Utils;
//import com.razorpay.Order;
//import org.json.JSONObject;
//
//import java.math.BigDecimal;
//import java.math.RoundingMode;
//import java.nio.charset.StandardCharsets;
//import java.time.LocalDateTime;
//import java.util.Base64;
//import java.util.Map;
//
//import javax.crypto.Mac;
//import javax.crypto.spec.SecretKeySpec;
//
//
////@Service
//public class PaymentService {
//
//	    @Value("${razorpay.key_secret}")   // Added missing field
//	    private String keySecret;
//
//	private static final Logger log = LoggerFactory.getLogger(PaymentService.class); // Fixed logger
//
//    // Credentials should be externalized (environment variables)
////    private final String apiLoginId = "89g9AHbwJ";
////    private final String transactionKey = "6HtUt87MfgD93L98";
//    
//    private final String apiLoginId = "22UmU47bLLM";
//	private final String transactionKey = "77afz2L75C2vFPb3";
//
//    @Autowired
//    private PaymentRepository paymentRepository;
//
//    @Autowired
//    private RazorpayClient razorpayClient;
//    
//    /**
//     * Create a Razorpay order (to be used on frontend)
//     */
//    public JSONObject createRazorpayOrder(Integer orderId, Double amount) throws Exception {
//        JSONObject options = new JSONObject();
//        options.put("amount", (int)(amount * 100));   // amount in paise
//        options.put("currency", "INR");
//        options.put("receipt", "order_" + orderId);
//        options.put("payment_capture", 1);            // auto capture
//
//        Order order = razorpayClient.orders.create(options);
//        return order.toJson();
//    }
//
//    /**
//     * Save payment after successful Razorpay checkout
//     */
//    @Transactional
//    public PaymentEntity saveRazorpayPayment(Integer orderId, String razorpayPaymentId,
//                                             String razorpayOrderId, String razorpaySignature,
//                                             Double amount) {   // <-- add amount parameter
//        PaymentEntity payment = new PaymentEntity();
//        payment.setOrderId(orderId);
//        payment.setAmount(amount);   // <-- set amount
//        payment.setPaymentMode(PaymentMode.valueOf("RAZORPAY")); // add RAZORPAY to enum
//        payment.setTransactionRef(razorpayPaymentId);
//        payment.setGatewayName("Razorpay");
//        payment.setGatewayTransactionId(razorpayOrderId);
//        payment.setGatewayResponseText(razorpaySignature);
//        payment.setPaymentStatus(PaymentGatewayStatus.SUCCESS);
//        payment.setPaymentDate(LocalDateTime.now());
//        return paymentRepository.save(payment);
//    }
//
//    /**
//     * Verify Razorpay signature (optional but recommended)
//     */
//    public boolean verifyRazorpaySignature(String orderId, String paymentId, String signature) {
//        try {
//            String payload = orderId + "|" + paymentId;
//            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
//            SecretKeySpec secretKeySpec = new SecretKeySpec(keySecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
//            sha256_HMAC.init(secretKeySpec);
//            String expectedSignature = Base64.getEncoder().encodeToString(sha256_HMAC.doFinal(payload.getBytes(StandardCharsets.UTF_8)));
//            return expectedSignature.equals(signature);
//        } catch (Exception e) {
//            log.error("Signature verification failed", e);
//            return false;
//        }
//    }
//
//    /**
//     * Process a credit card payment using Authorize.Net.
//     *
//     * @param orderId     the order ID
//     * @param amount      the total amount to charge
//     * @param cardDetails a map containing: cardNumber, expiryMonth, expiryYear, cvv, email
//     * @return the saved PaymentEntity with status and gateway details
//     */
//    @Transactional
//    public PaymentEntity processPayment(Integer orderId, Double amount, Map<String, String> cardDetails) {
//        PaymentEntity payment = new PaymentEntity();
//        payment.setOrderId(orderId);
//        payment.setAmount(amount);
//        payment.setPaymentMode(PaymentMode.CARD);
//        payment.setTransactionRef("TXN" + System.currentTimeMillis());
//        payment.setGatewayName("Authorize.Net");
//
//        try {
//            // 1. Set environment
//            ApiOperationBase.setEnvironment(Environment.SANDBOX);
//
//            // 2. Merchant authentication
//            MerchantAuthenticationType merchantAuth = new MerchantAuthenticationType();
//            merchantAuth.setName(apiLoginId);
//            merchantAuth.setTransactionKey(transactionKey);
//
//            // 3. Credit card details
//            CreditCardType creditCard = new CreditCardType();
//            creditCard.setCardNumber(cardDetails.get("cardNumber"));
//            // Expiry format: YYYY-MM (e.g., 2025-12)
//            String expiry = cardDetails.get("expiryYear") + "-" + cardDetails.get("expiryMonth");
//            creditCard.setExpirationDate(expiry);
//            creditCard.setCardCode(cardDetails.get("cvv"));
//
//            PaymentType paymentType = new PaymentType();
//            paymentType.setCreditCard(creditCard);
//
//            // 4. Transaction request
//            TransactionRequestType txnRequest = new TransactionRequestType();
//            txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
//            txnRequest.setAmount(new BigDecimal(amount).setScale(2, RoundingMode.CEILING));
//            txnRequest.setPayment(paymentType);
//            txnRequest.setOrder(new OrderType());
//            txnRequest.getOrder().setInvoiceNumber(orderId.toString());
//            txnRequest.setCustomer(new CustomerDataType());
//            txnRequest.getCustomer().setEmail(cardDetails.get("email"));
//
//            // 5. Create API request
//            CreateTransactionRequest apiRequest = new CreateTransactionRequest();
//            apiRequest.setMerchantAuthentication(merchantAuth);
//            apiRequest.setTransactionRequest(txnRequest);
//
//            // 6. Execute
//            CreateTransactionController controller = new CreateTransactionController(apiRequest);
//            controller.execute();
//
//            // 7. Process response
//            CreateTransactionResponse response = controller.getApiResponse();
//            if (response != null) {
//                if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {
//                    TransactionResponse result = response.getTransactionResponse();
//                    if (result.getMessages() != null) {
//                        payment.setPaymentStatus(PaymentGatewayStatus.SUCCESS);
//                        payment.setPaymentDate(LocalDateTime.now());
//                        payment.setGatewayTransactionId(result.getTransId());
//                        payment.setGatewayResponseCode(result.getResponseCode());
//                        payment.setGatewayResponseText(
//                                result.getMessages().getMessage().get(0).getDescription()
//                        );
//                        log.info("Payment successful for order {}: {}", orderId, payment.getGatewayResponseText());
//                    } else {
//                        // Transaction declined
//                        payment.setPaymentStatus(PaymentGatewayStatus.FAILED);
//                        if (result.getErrors() != null) {
//                            payment.setGatewayResponseCode(
//                                    result.getErrors().getError().get(0).getErrorCode()
//                            );
//                            payment.setGatewayResponseText(
//                                    result.getErrors().getError().get(0).getErrorText()
//                            );
//                        } else {
//                            payment.setGatewayResponseText("Transaction declined");
//                        }
//                        log.warn("Payment declined for order {}: {}", orderId, payment.getGatewayResponseText());
//                    }
//                } else {
//                    // API error (e.g., authentication)
//                    payment.setPaymentStatus(PaymentGatewayStatus.FAILED);
//                    if (response.getMessages().getMessage() != null) {
//                        payment.setGatewayResponseCode(
//                                response.getMessages().getMessage().get(0).getCode()
//                        );
//                        payment.setGatewayResponseText(
//                                response.getMessages().getMessage().get(0).getText()
//                        );
//                    } else {
//                        payment.setGatewayResponseText("API error");
//                    }
//                    log.error("API error for order {}: {}", orderId, payment.getGatewayResponseText());
//                }
//            } else {
//                payment.setPaymentStatus(PaymentGatewayStatus.FAILED);
//                payment.setGatewayResponseText("No response from gateway");
//                log.error("No response from gateway for order {}", orderId);
//            }
//
//        } catch (Exception e) {
//            log.error("Authorize.Net processing error for order {}", orderId, e);
//            payment.setPaymentStatus(PaymentGatewayStatus.FAILED);
//            payment.setGatewayResponseText("Exception: " + e.getMessage());
//        }
//
//        // Save payment record
//        paymentRepository.save(payment);
//        return payment;
//    }
//}