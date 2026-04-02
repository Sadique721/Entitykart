package com.grownited.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grownited.entity.OrderEntity;
import com.grownited.entity.PaymentEntity;
import com.grownited.repository.OrderRepository;
import com.grownited.repository.PaymentRepository;

import net.authorize.Environment;
import net.authorize.api.contract.v1.ANetApiResponse;
import net.authorize.api.contract.v1.CreateTransactionRequest;
import net.authorize.api.contract.v1.CreateTransactionResponse;
import net.authorize.api.contract.v1.CreditCardType;
import net.authorize.api.contract.v1.CustomerDataType;
import net.authorize.api.contract.v1.MerchantAuthenticationType;
import net.authorize.api.contract.v1.MessageTypeEnum;
import net.authorize.api.contract.v1.PaymentType;
import net.authorize.api.contract.v1.TransactionRequestType;
import net.authorize.api.contract.v1.TransactionResponse;
import net.authorize.api.contract.v1.TransactionTypeEnum;
import net.authorize.api.controller.CreateTransactionController;
import net.authorize.api.controller.base.ApiOperationBase;

@Service
public class PaymentService {

    private final String apiLoginId = "89g9AHbvJ";
    private final String transactionKey = "2jm95RVm69X4rc4a";

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private OrderRepository orderRepository;

    // ---------------------- Authorize.Net Card Payment ----------------------
    public PaymentEntity processCardPayment(Integer orderId, Double amount, Map<String, String> cardDetails) {
        String email = cardDetails.get("email");
        String cardNumber = cardDetails.get("cardNumber");
        String expiryMonth = cardDetails.get("expiryMonth");
        String expiryYear = cardDetails.get("expiryYear");
        String cvv = cardDetails.get("cvv");

        // Format expiry as "MMYY"
        String expiry = String.format("%02d%02d", Integer.parseInt(expiryMonth), Integer.parseInt(expiryYear.substring(2)));

        ApiOperationBase.setEnvironment(Environment.SANDBOX);

        MerchantAuthenticationType merchantAuthentication = new MerchantAuthenticationType();
        merchantAuthentication.setName(apiLoginId);
        merchantAuthentication.setTransactionKey(transactionKey);

        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(cardNumber);
        creditCard.setExpirationDate(expiry);
        creditCard.setCardCode(cvv);

        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);

        CustomerDataType customer = new CustomerDataType();
        customer.setEmail(email);

        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
        txnRequest.setPayment(paymentType);
        txnRequest.setCustomer(customer);
        txnRequest.setAmount(new BigDecimal(amount).setScale(2, RoundingMode.CEILING));

        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setMerchantAuthentication(merchantAuthentication);
        apiRequest.setTransactionRequest(txnRequest);

        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute();

        CreateTransactionResponse response = controller.getApiResponse();

        PaymentEntity payment = new PaymentEntity();
        payment.setOrderId(orderId);
        payment.setAmount(amount);
        payment.setPaymentMode(PaymentEntity.PaymentMode.CARD);
        payment.setGatewayName("AUTHORIZE.NET");
        payment.setPaymentDate(LocalDateTime.now());

        if (response != null && response.getMessages().getResultCode() == MessageTypeEnum.OK) {
            TransactionResponse result = response.getTransactionResponse();
            if (result.getMessages() != null) {
                payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.SUCCESS);
                payment.setGatewayTransactionId(result.getTransId());
                payment.setGatewayResponseCode(result.getResponseCode());
                payment.setGatewayResponseText(result.getMessages().getMessage().get(0).getDescription());
                payment.setTransactionRef(result.getTransId());  // use transaction ID as reference
            } else {
                // Transaction failed at gateway level
                payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.FAILED);
                if (result.getErrors() != null) {
                    payment.setGatewayResponseCode(result.getErrors().getError().get(0).getErrorCode());
                    payment.setGatewayResponseText(result.getErrors().getError().get(0).getErrorText());
                }
            }
        } else {
            // API level error
            payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.FAILED);
            if (response != null) {
                payment.setGatewayResponseCode(response.getMessages().getMessage().get(0).getCode());
                payment.setGatewayResponseText(response.getMessages().getMessage().get(0).getText());
            } else {
                ANetApiResponse errorResponse = controller.getErrorResponse();
                if (errorResponse != null && !errorResponse.getMessages().getMessage().isEmpty()) {
                    payment.setGatewayResponseCode(errorResponse.getMessages().getMessage().get(0).getCode());
                    payment.setGatewayResponseText(errorResponse.getMessages().getMessage().get(0).getText());
                } else {
                    payment.setGatewayResponseText("Unknown error");
                }
            }
        }

        return paymentRepository.save(payment);
    }

    // ---------------------- Razorpay Integration ----------------------
    public JSONObject createRazorpayOrder(Integer orderId, Double amount) {
        // This should call Razorpay API to create an order.
        // For simplicity, we return a mock JSON response.
        // In production, use Razorpay client with your API keys.
        JSONObject order = new JSONObject();
        order.put("id", "order_" + UUID.randomUUID().toString().substring(0, 12));
        order.put("amount", amount * 100); // in paise
        order.put("currency", "INR");
        order.put("receipt", "order_" + orderId);
        return order;
    }

    public boolean verifyRazorpaySignature(String orderId, String paymentId, String signature) {
        // Verify Razorpay signature using your secret key.
        // Return true for now (mock).
        return true;
    }

    public PaymentEntity saveRazorpayPayment(Integer orderId, String razorpayPaymentId,
                                             String razorpayOrderId, String razorpaySignature,
                                             Double amount) {
        PaymentEntity payment = new PaymentEntity();
        payment.setOrderId(orderId);
        payment.setAmount(amount);
        payment.setPaymentMode(PaymentEntity.PaymentMode.RAZORPAY);
        payment.setGatewayName("RAZORPAY");
        payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.SUCCESS);
        payment.setGatewayTransactionId(razorpayPaymentId);
        payment.setTransactionRef(razorpayPaymentId);
        payment.setPaymentDate(LocalDateTime.now());
        return paymentRepository.save(payment);
    }

    // ---------------------- Simulated Payments (COD, UPI) ----------------------
    public PaymentEntity simulatePayment(Integer orderId, Double amount, String paymentMode) {
        PaymentEntity payment = new PaymentEntity();
        payment.setOrderId(orderId);
        payment.setAmount(amount);
        payment.setPaymentMode(PaymentEntity.PaymentMode.valueOf(paymentMode));
        payment.setTransactionRef("TXN" + System.currentTimeMillis());

        // 95% success rate for simulation
        boolean success = Math.random() < 0.95;
        if (success) {
            payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.SUCCESS);
            payment.setPaymentDate(LocalDateTime.now());
        } else {
            payment.setPaymentStatus(PaymentEntity.PaymentGatewayStatus.FAILED);
        }
        return paymentRepository.save(payment);
    }

    // Wrapper method used by controller
    public PaymentEntity processPayment(Integer orderId, Double amount, Map<String, String> cardDetails) {
        return processCardPayment(orderId, amount, cardDetails);
    }
}