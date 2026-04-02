package com.grownited.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grownited.entity.*;
import com.grownited.repository.*;
import com.grownited.service.MailerService;

import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/export")
public class AdminExportController {

    private static final Logger log = LoggerFactory.getLogger(AdminExportController.class);

    @Autowired private OrderRepository orderRepository;
    @Autowired private ProductRepository productRepository;
    @Autowired private UserRepository userRepository;
    @Autowired private PaymentRepository paymentRepository;
    @Autowired private ReturnRefundRepository returnRepository;
    @Autowired private ReviewRatingRepository reviewRepository;
    @Autowired private WishlistRepository wishlistRepository;
    @Autowired private MailerService mailerService;

    // ==================== EXCEL EXPORTS ====================

    @GetMapping("/orders/excel")
    public void exportOrdersToExcel(HttpServletResponse response) throws IOException {
        List<OrderEntity> list = orderRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Orders");
        String[] cols = {"Order ID", "Customer ID", "Address ID", "Total Amount", "Order Status",
                         "Payment Status", "Order Date", "Created At", "Updated At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (OrderEntity o : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(o.getOrderId());
            row.createCell(1).setCellValue(o.getCustomerId());
            row.createCell(2).setCellValue(o.getAddressId() != null ? o.getAddressId() : 0);
            row.createCell(3).setCellValue(o.getTotalAmount());
            row.createCell(4).setCellValue(o.getOrderStatus() != null ? o.getOrderStatus().toString() : "");
            row.createCell(5).setCellValue(o.getPaymentStatus() != null ? o.getPaymentStatus().toString() : "");
            row.createCell(6).setCellValue(o.getOrderDate() != null ? o.getOrderDate().toString() : "");
            row.createCell(7).setCellValue(o.getCreatedAt() != null ? o.getCreatedAt().toString() : "");
            row.createCell(8).setCellValue(o.getUpdatedAt() != null ? o.getUpdatedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "orders.xlsx");
    }

    @GetMapping("/products/excel")
    public void exportProductsToExcel(HttpServletResponse response) throws IOException {
        List<ProductEntity> list = productRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Products");
        String[] cols = {"Product ID", "User ID", "Category ID", "SubCategory ID", "Name", "Description",
                         "Brand", "Price", "MRP", "Stock", "SKU", "Status", "Created At", "Main Image URL", "Discount %"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (ProductEntity p : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(p.getProductId());
            row.createCell(1).setCellValue(p.getUserId());
            row.createCell(2).setCellValue(p.getCategoryId() != null ? p.getCategoryId() : 0);
            row.createCell(3).setCellValue(p.getSubCategoryId() != null ? p.getSubCategoryId() : "");
            row.createCell(4).setCellValue(p.getProductName());
            row.createCell(5).setCellValue(p.getDescription());
            row.createCell(6).setCellValue(p.getBrand());
            row.createCell(7).setCellValue(p.getPrice() != null ? p.getPrice().doubleValue() : 0.0);
            row.createCell(8).setCellValue(p.getMrp() != null ? p.getMrp() : 0);
            row.createCell(9).setCellValue(p.getStockQuantity());
            row.createCell(10).setCellValue(p.getSku());
            row.createCell(11).setCellValue(p.getStatus());
            row.createCell(12).setCellValue(p.getCreatedAt() != null ? p.getCreatedAt().toString() : "");
            row.createCell(13).setCellValue(p.getMainImageURL());
            row.createCell(14).setCellValue(p.getDiscountPercent() != null ? p.getDiscountPercent().doubleValue() : 0.0);
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "products.xlsx");
    }

    @GetMapping("/users/excel")
    public void exportUsersToExcel(HttpServletResponse response) throws IOException {
        List<UserEntity> list = userRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Users");
        String[] cols = {"User ID", "Name", "Email", "Role", "Gender", "Contact", "Profile Pic", "Active", "Created At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (UserEntity u : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(u.getUserId());
            row.createCell(1).setCellValue(u.getName());
            row.createCell(2).setCellValue(u.getEmail());
            row.createCell(3).setCellValue(u.getRole());
            row.createCell(4).setCellValue(u.getGender());
            row.createCell(5).setCellValue(u.getContactNum());
            row.createCell(6).setCellValue(u.getProfilePicURL());
            row.createCell(7).setCellValue(u.getActive() != null && u.getActive() ? "Yes" : "No");
            row.createCell(8).setCellValue(u.getCreatedAt() != null ? u.getCreatedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "users.xlsx");
    }

    @GetMapping("/payments/excel")
    public void exportPaymentsToExcel(HttpServletResponse response) throws IOException {
        List<PaymentEntity> list = paymentRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Payments");
        String[] cols = {"Payment ID", "Order ID", "Amount", "Mode", "Transaction Ref", "Status", "Payment Date", "Created At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (PaymentEntity p : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(p.getPaymentId());
            row.createCell(1).setCellValue(p.getOrderId());
            row.createCell(2).setCellValue(p.getAmount());
            row.createCell(3).setCellValue(p.getPaymentMode() != null ? p.getPaymentMode().toString() : "");
            row.createCell(4).setCellValue(p.getTransactionRef());
            row.createCell(5).setCellValue(p.getPaymentStatus() != null ? p.getPaymentStatus().toString() : "");
            row.createCell(6).setCellValue(p.getPaymentDate() != null ? p.getPaymentDate().toString() : "");
            row.createCell(7).setCellValue(p.getCreatedAt() != null ? p.getCreatedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "payments.xlsx");
    }

    @GetMapping("/returns/excel")
    public void exportReturnsToExcel(HttpServletResponse response) throws IOException {
        List<ReturnRefundEntity> list = returnRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Returns");
        String[] cols = {"Return ID", "Order Item ID", "Reason", "Status", "Requested At", "Processed At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (ReturnRefundEntity rt : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(rt.getReturnId());
            row.createCell(1).setCellValue(rt.getOrderItemId());
            row.createCell(2).setCellValue(rt.getReason());
            row.createCell(3).setCellValue(rt.getReturnStatus() != null ? rt.getReturnStatus().toString() : "");
            row.createCell(4).setCellValue(rt.getRequestedAt() != null ? rt.getRequestedAt().toString() : "");
            row.createCell(5).setCellValue(rt.getProcessedAt() != null ? rt.getProcessedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "returns.xlsx");
    }

    @GetMapping("/reviews/excel")
    public void exportReviewsToExcel(HttpServletResponse response) throws IOException {
        List<ReviewRatingEntity> list = reviewRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Reviews");
        String[] cols = {"Review ID", "Product ID", "Customer ID", "Rating", "Comment", "Created At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (ReviewRatingEntity rev : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(rev.getReviewId());
            row.createCell(1).setCellValue(rev.getProductId());
            row.createCell(2).setCellValue(rev.getCustomerId());
            row.createCell(3).setCellValue(rev.getRating());
            row.createCell(4).setCellValue(rev.getComment());
            row.createCell(5).setCellValue(rev.getCreatedAt() != null ? rev.getCreatedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "reviews.xlsx");
    }

    @GetMapping("/wishlist/excel")
    public void exportWishlistToExcel(HttpServletResponse response) throws IOException {
        List<WishlistEntity> list = wishlistRepository.findAll();
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("Wishlist");
        String[] cols = {"Wishlist ID", "Customer ID", "Product ID", "Added At"};
        createHeaderRow(sheet, cols);

        int r = 1;
        for (WishlistEntity w : list) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(w.getWishlistId());
            row.createCell(1).setCellValue(w.getCustomerId());
            row.createCell(2).setCellValue(w.getProductId());
            row.createCell(3).setCellValue(w.getAddedAt() != null ? w.getAddedAt().toString() : "");
        }
        autoSizeColumns(sheet, cols.length);
        writeResponse(response, wb, "wishlist.xlsx");
    }

    // ==================== WORD EXPORTS ====================

    @GetMapping("/orders/word")
    public void exportOrdersToWord(HttpServletResponse response) throws IOException {
        List<OrderEntity> list = orderRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=orders.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Order Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (OrderEntity o : list) {
                writer.printf("Order #%d | Customer #%d | Total ₹%.2f | Status %s | Payment %s | Date %s%n",
                        o.getOrderId(), o.getCustomerId(), o.getTotalAmount(),
                        o.getOrderStatus(), o.getPaymentStatus(),
                        o.getOrderDate() != null ? o.getOrderDate().toString() : "");
            }
        }
    }

    @GetMapping("/products/word")
    public void exportProductsToWord(HttpServletResponse response) throws IOException {
        List<ProductEntity> list = productRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=products.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Product Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (ProductEntity p : list) {
                writer.printf("Product #%d | %s | Brand %s | Price ₹%.2f | Stock %d | Status %s%n",
                        p.getProductId(), p.getProductName(), p.getBrand(),
                        p.getPrice(), p.getStockQuantity(), p.getStatus());
            }
        }
    }

    @GetMapping("/users/word")
    public void exportUsersToWord(HttpServletResponse response) throws IOException {
        List<UserEntity> list = userRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=users.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("User Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (UserEntity u : list) {
                writer.printf("User #%d | %s | %s | Role %s | Contact %s%n",
                        u.getUserId(), u.getName(), u.getEmail(), u.getRole(), u.getContactNum());
            }
        }
    }

    @GetMapping("/payments/word")
    public void exportPaymentsToWord(HttpServletResponse response) throws IOException {
        List<PaymentEntity> list = paymentRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=payments.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Payment Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (PaymentEntity p : list) {
                writer.printf("Payment #%d | Order #%d | ₹%.2f | Mode %s | Status %s | Ref %s%n",
                        p.getPaymentId(), p.getOrderId(), p.getAmount(),
                        p.getPaymentMode(), p.getPaymentStatus(), p.getTransactionRef());
            }
        }
    }

    @GetMapping("/returns/word")
    public void exportReturnsToWord(HttpServletResponse response) throws IOException {
        List<ReturnRefundEntity> list = returnRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=returns.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Return Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (ReturnRefundEntity r : list) {
                writer.printf("Return #%d | Order Item #%d | Status %s | Reason %s%n",
                        r.getReturnId(), r.getOrderItemId(), r.getReturnStatus(), r.getReason());
            }
        }
    }

    @GetMapping("/reviews/word")
    public void exportReviewsToWord(HttpServletResponse response) throws IOException {
        List<ReviewRatingEntity> list = reviewRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=reviews.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Review Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (ReviewRatingEntity r : list) {
                writer.printf("Review #%d | Product #%d | Customer #%d | Rating %d/5 | %s%n",
                        r.getReviewId(), r.getProductId(), r.getCustomerId(),
                        r.getRating(), r.getComment());
            }
        }
    }

    @GetMapping("/wishlist/word")
    public void exportWishlistToWord(HttpServletResponse response) throws IOException {
        List<WishlistEntity> list = wishlistRepository.findAll();
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=wishlist.doc");
        try (PrintWriter writer = response.getWriter()) {
            writer.println("Wishlist Report\n");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");
            for (WishlistEntity w : list) {
                writer.printf("Wishlist #%d | Customer #%d | Product #%d | Added %s%n",
                        w.getWishlistId(), w.getCustomerId(), w.getProductId(),
                        w.getAddedAt() != null ? w.getAddedAt().toString() : "");
            }
        }
    }

    // ==================== EMAIL REPORT (with both attachments) ====================

    @PostMapping("/send-report")
    @ResponseBody
    public String sendReportEmail(@RequestParam String reportType, @RequestParam String email) {
        try {
            byte[] excelData = generateExcelReportBytes(reportType);
            byte[] wordData = generateWordReportBytes(reportType);
            mailerService.sendReportWithAttachments(email, reportType, excelData, wordData);
            return "Report sent successfully to " + email;
        } catch (Exception e) {
            log.error("Failed to send report for type: {}", reportType, e);
            return "Failed to send report: " + e.getMessage();
        }
    }

    // ==================== PRIVATE HELPERS ====================

    private void createHeaderRow(Sheet sheet, String[] cols) {
        Row header = sheet.createRow(0);
        for (int i = 0; i < cols.length; i++) {
            header.createCell(i).setCellValue(cols[i]);
        }
    }

    private void autoSizeColumns(Sheet sheet, int columnCount) {
        for (int i = 0; i < columnCount; i++) {
            sheet.autoSizeColumn(i);
        }
    }

    private void writeResponse(HttpServletResponse response, Workbook wb, String filename) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + filename);
        wb.write(response.getOutputStream());
        wb.close();
    }

    private byte[] generateExcelReportBytes(String reportType) throws IOException {
        try (Workbook wb = new XSSFWorkbook()) {
            Sheet sheet = wb.createSheet(reportType);
            String[] cols = null;
            int r = 1;

            if ("orders".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Order ID", "Customer ID", "Address ID", "Total Amount", "Order Status",
                        "Payment Status", "Order Date", "Created At", "Updated At"};
                createHeaderRow(sheet, cols);
                List<OrderEntity> list = orderRepository.findAll();
                for (OrderEntity o : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(o.getOrderId());
                    row.createCell(1).setCellValue(o.getCustomerId());
                    row.createCell(2).setCellValue(o.getAddressId() != null ? o.getAddressId() : 0);
                    row.createCell(3).setCellValue(o.getTotalAmount());
                    row.createCell(4).setCellValue(o.getOrderStatus() != null ? o.getOrderStatus().toString() : "");
                    row.createCell(5).setCellValue(o.getPaymentStatus() != null ? o.getPaymentStatus().toString() : "");
                    row.createCell(6).setCellValue(o.getOrderDate() != null ? o.getOrderDate().toString() : "");
                    row.createCell(7).setCellValue(o.getCreatedAt() != null ? o.getCreatedAt().toString() : "");
                    row.createCell(8).setCellValue(o.getUpdatedAt() != null ? o.getUpdatedAt().toString() : "");
                }
            } else if ("products".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Product ID", "Name", "Brand", "Price", "Stock", "Discount %"};
                createHeaderRow(sheet, cols);
                List<ProductEntity> list = productRepository.findAll();
                for (ProductEntity p : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(p.getProductId());
                    row.createCell(1).setCellValue(p.getProductName());
                    row.createCell(2).setCellValue(p.getBrand());
                    row.createCell(3).setCellValue(p.getPrice() != null ? p.getPrice().doubleValue() : 0.0);
                    row.createCell(4).setCellValue(p.getStockQuantity());
                    row.createCell(5).setCellValue(p.getDiscountPercent() != null ? p.getDiscountPercent().doubleValue() : 0.0);
                }
            } else if ("users".equalsIgnoreCase(reportType)) {
                cols = new String[]{"User ID", "Name", "Email", "Role", "Gender", "Contact", "Active", "Created At"};
                createHeaderRow(sheet, cols);
                List<UserEntity> list = userRepository.findAll();
                for (UserEntity u : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(u.getUserId());
                    row.createCell(1).setCellValue(u.getName());
                    row.createCell(2).setCellValue(u.getEmail());
                    row.createCell(3).setCellValue(u.getRole());
                    row.createCell(4).setCellValue(u.getGender());
                    row.createCell(5).setCellValue(u.getContactNum());
                    row.createCell(6).setCellValue(u.getActive() != null && u.getActive() ? "Yes" : "No");
                    row.createCell(7).setCellValue(u.getCreatedAt() != null ? u.getCreatedAt().toString() : "");
                }
            } else if ("payments".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Payment ID", "Order ID", "Amount", "Mode", "Transaction Ref", "Status", "Payment Date"};
                createHeaderRow(sheet, cols);
                List<PaymentEntity> list = paymentRepository.findAll();
                for (PaymentEntity p : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(p.getPaymentId());
                    row.createCell(1).setCellValue(p.getOrderId());
                    row.createCell(2).setCellValue(p.getAmount());
                    row.createCell(3).setCellValue(p.getPaymentMode() != null ? p.getPaymentMode().toString() : "");
                    row.createCell(4).setCellValue(p.getTransactionRef());
                    row.createCell(5).setCellValue(p.getPaymentStatus() != null ? p.getPaymentStatus().toString() : "");
                    row.createCell(6).setCellValue(p.getPaymentDate() != null ? p.getPaymentDate().toString() : "");
                }
            } else if ("returns".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Return ID", "Order Item ID", "Reason", "Status", "Requested At", "Processed At"};
                createHeaderRow(sheet, cols);
                List<ReturnRefundEntity> list = returnRepository.findAll();
                for (ReturnRefundEntity rt : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(rt.getReturnId());
                    row.createCell(1).setCellValue(rt.getOrderItemId());
                    row.createCell(2).setCellValue(rt.getReason());
                    row.createCell(3).setCellValue(rt.getReturnStatus() != null ? rt.getReturnStatus().toString() : "");
                    row.createCell(4).setCellValue(rt.getRequestedAt() != null ? rt.getRequestedAt().toString() : "");
                    row.createCell(5).setCellValue(rt.getProcessedAt() != null ? rt.getProcessedAt().toString() : "");
                }
            } else if ("reviews".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Review ID", "Product ID", "Customer ID", "Rating", "Comment", "Created At"};
                createHeaderRow(sheet, cols);
                List<ReviewRatingEntity> list = reviewRepository.findAll();
                for (ReviewRatingEntity rev : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(rev.getReviewId());
                    row.createCell(1).setCellValue(rev.getProductId());
                    row.createCell(2).setCellValue(rev.getCustomerId());
                    row.createCell(3).setCellValue(rev.getRating());
                    row.createCell(4).setCellValue(rev.getComment());
                    row.createCell(5).setCellValue(rev.getCreatedAt() != null ? rev.getCreatedAt().toString() : "");
                }
            } else if ("wishlist".equalsIgnoreCase(reportType)) {
                cols = new String[]{"Wishlist ID", "Customer ID", "Product ID", "Added At"};
                createHeaderRow(sheet, cols);
                List<WishlistEntity> list = wishlistRepository.findAll();
                for (WishlistEntity w : list) {
                    Row row = sheet.createRow(r++);
                    row.createCell(0).setCellValue(w.getWishlistId());
                    row.createCell(1).setCellValue(w.getCustomerId());
                    row.createCell(2).setCellValue(w.getProductId());
                    row.createCell(3).setCellValue(w.getAddedAt() != null ? w.getAddedAt().toString() : "");
                }
            }

            if (cols != null) {
                autoSizeColumns(sheet, cols.length);
            }

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            wb.write(baos);
            return baos.toByteArray();
        }
    }

    private byte[] generateWordReportBytes(String reportType) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (PrintWriter writer = new PrintWriter(baos)) {
            writer.println(reportType.toUpperCase() + " REPORT");
            writer.println("Generated: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
            writer.println("========================================\n");

            if ("orders".equalsIgnoreCase(reportType)) {
                List<OrderEntity> list = orderRepository.findAll();
                for (OrderEntity o : list) {
                    writer.printf("Order #%d | Customer #%d | Total ₹%.2f | Status %s | Payment %s | Date %s%n",
                            o.getOrderId(), o.getCustomerId(), o.getTotalAmount(),
                            o.getOrderStatus(), o.getPaymentStatus(),
                            o.getOrderDate() != null ? o.getOrderDate().toString() : "");
                }
            } else if ("products".equalsIgnoreCase(reportType)) {
                List<ProductEntity> list = productRepository.findAll();
                for (ProductEntity p : list) {
                    writer.printf("Product #%d | %s | Brand %s | Price ₹%.2f | Stock %d | Status %s%n",
                            p.getProductId(), p.getProductName(), p.getBrand(),
                            p.getPrice(), p.getStockQuantity(), p.getStatus());
                }
            } else if ("users".equalsIgnoreCase(reportType)) {
                List<UserEntity> list = userRepository.findAll();
                for (UserEntity u : list) {
                    writer.printf("User #%d | %s | %s | Role %s | Contact %s%n",
                            u.getUserId(), u.getName(), u.getEmail(), u.getRole(), u.getContactNum());
                }
            } else if ("payments".equalsIgnoreCase(reportType)) {
                List<PaymentEntity> list = paymentRepository.findAll();
                for (PaymentEntity p : list) {
                    writer.printf("Payment #%d | Order #%d | ₹%.2f | Mode %s | Status %s | Ref %s%n",
                            p.getPaymentId(), p.getOrderId(), p.getAmount(),
                            p.getPaymentMode(), p.getPaymentStatus(), p.getTransactionRef());
                }
            } else if ("returns".equalsIgnoreCase(reportType)) {
                List<ReturnRefundEntity> list = returnRepository.findAll();
                for (ReturnRefundEntity r : list) {
                    writer.printf("Return #%d | Order Item #%d | Status %s | Reason %s%n",
                            r.getReturnId(), r.getOrderItemId(), r.getReturnStatus(), r.getReason());
                }
            } else if ("reviews".equalsIgnoreCase(reportType)) {
                List<ReviewRatingEntity> list = reviewRepository.findAll();
                for (ReviewRatingEntity r : list) {
                    writer.printf("Review #%d | Product #%d | Customer #%d | Rating %d/5 | %s%n",
                            r.getReviewId(), r.getProductId(), r.getCustomerId(),
                            r.getRating(), r.getComment());
                }
            } else if ("wishlist".equalsIgnoreCase(reportType)) {
                List<WishlistEntity> list = wishlistRepository.findAll();
                for (WishlistEntity w : list) {
                    writer.printf("Wishlist #%d | Customer #%d | Product #%d | Added %s%n",
                            w.getWishlistId(), w.getCustomerId(), w.getProductId(),
                            w.getAddedAt() != null ? w.getAddedAt().toString() : "");
                }
            }
        }
        return baos.toByteArray();
    }
}