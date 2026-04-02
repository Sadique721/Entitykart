package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.grownited.entity.AddressEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailerService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    // ========================= DEPENDENCY INJECTION =========================

    @Autowired
    private MailerService mailerService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private Cloudinary cloudinary;


    // ========================= USER REGISTRATION =========================

    @PostMapping("/register")
    public String userRegistration(UserEntity userEntity,
                                   AddressEntity addressEntity,
                                   @RequestParam("profilePic") MultipartFile profilePic,
                                   RedirectAttributes redirectAttributes) {

        try {
            // Check if email already exists
            Optional<UserEntity> existingUser = userRepository.findByEmail(userEntity.getEmail());
            if (existingUser.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Email already registered!");
                return "redirect:/signup";
            }

            // Upload profile picture (only once)
            if (profilePic != null && !profilePic.isEmpty()) {
                Map<?, ?> uploadResult =
                        cloudinary.uploader().upload(profilePic.getBytes(), null);
                userEntity.setProfilePicURL(
                        uploadResult.get("secure_url").toString());
            }

        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error uploading profile picture!");
            return "redirect:/signup";
        }

        // Set default values
        userEntity.setRole("USER");
        userEntity.setActive(true);
        userEntity.setCreatedAt(LocalDate.now());

        // Generate 6 digit OTP (optional - for email verification)
        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);
        userEntity.setOtp(otp);

        // Encode password
        userEntity.setPassword(
                passwordEncoder.encode(userEntity.getPassword()));

        // Save user first (to generate userId)
        userRepository.save(userEntity);

        // Set Address details
        addressEntity.setIsDefault(true);
        addressEntity.setFullName(userEntity.getName());
        addressEntity.setMobileNo(userEntity.getContactNum());
        addressEntity.setUserId(userEntity.getUserId());

        addressRepository.save(addressEntity);

        // Send welcome mail
        mailerService.sendWelcomeMail(userEntity);

        redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/login";
    }


    // ========================= LIST USERS (ADMIN ONLY) =========================

    @GetMapping("/listUser")
    public String listUserDetails(HttpSession session, 
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // Only admin can list all users
        if (!"ADMIN".equals(currentUser.getRole())) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to access this page!");
            return "redirect:/index";
        }

        List<UserEntity> userList = userRepository.findAll();
        model.addAttribute("userList", userList);

        return "listUser";
    }


    // ========================= VIEW USER =========================
    @GetMapping("/viewUser")
    public String viewUserDetails(@RequestParam Integer userId, 
                                  HttpSession session,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<UserEntity> optionalUser = userRepository.findById(userId);
        if (optionalUser.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "User not found!");
            return "redirect:/index";
        }
        
        UserEntity userEntity = optionalUser.get();
        
        // Check permission: Admin can view any user, regular users can only view themselves
        if (!"ADMIN".equals(currentUser.getRole()) && !currentUser.getUserId().equals(userId)) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to view this profile!");
            return "redirect:/index";
        }
        
        // Get all addresses for this user
        List<AddressEntity> addressList = addressRepository.findByUserId(userId);
        
        // Find default address (if any)
        AddressEntity defaultAddress = addressList.stream()
                .filter(addr -> addr.getIsDefault() != null && addr.getIsDefault())
                .findFirst()
                .orElse(null);

        model.addAttribute("userEntity", userEntity);
        model.addAttribute("addressList", addressList);
        model.addAttribute("defaultAddress", defaultAddress);
        model.addAttribute("address", defaultAddress); // For backward compatibility

        return "viewUser";
    }


    // ========================= DELETE USER (ADMIN ONLY) =========================

    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam Integer userId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        // Only admin can delete users
        if (!"ADMIN".equals(currentUser.getRole())) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to delete users!");
            return "redirect:/index";
        }
        
        // Prevent admin from deleting themselves
        if (currentUser.getUserId().equals(userId)) {
            redirectAttributes.addFlashAttribute("error", "You cannot delete your own account!");
            return "redirect:/listUser";
        }

        if (userRepository.existsById(userId)) {

            // Delete all addresses first (if exists)
            List<AddressEntity> addressList = addressRepository.findByUserId(userId);
            for (AddressEntity address : addressList) {
                addressRepository.deleteById(address.getAddressId());
            }

            userRepository.deleteById(userId);
            redirectAttributes.addFlashAttribute("success", "User deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "User not found!");
        }

        return "redirect:/listUser";
    }


    // ========================= EDIT USER =========================

    @GetMapping("/editUser")
    public String editUser(@RequestParam Integer userId, 
                           HttpSession session,
                           Model model,
                           RedirectAttributes redirectAttributes) {

        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<UserEntity> optionalUser = userRepository.findById(userId);
        if (optionalUser.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "User not found!");
            return "redirect:/index";
        }
        
        UserEntity userEntity = optionalUser.get();
        
        // Check permission: Admin can edit any user, regular users can only edit themselves
        if (!"ADMIN".equals(currentUser.getRole()) && !currentUser.getUserId().equals(userId)) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to edit this profile!");
            return "redirect:/index";
        }
        
        // Get all addresses for this user
        List<AddressEntity> addressList = addressRepository.findByUserId(userId);
        
        // Find default address (if any)
        AddressEntity defaultAddress = addressList.stream()
                .filter(addr -> addr.getIsDefault() != null && addr.getIsDefault())
                .findFirst()
                .orElse(null);
        
        // If no address exists, create a new one for the form
        if (addressList.isEmpty()) {
            AddressEntity newAddress = new AddressEntity();
            newAddress.setUserId(userId);
            newAddress.setFullName(userEntity.getName());
            newAddress.setMobileNo(userEntity.getContactNum());
            model.addAttribute("address", newAddress);
        } else {
            model.addAttribute("address", defaultAddress != null ? defaultAddress : addressList.get(0));
        }

        model.addAttribute("userEntity", userEntity);
        model.addAttribute("addressList", addressList);

        return "editUser";
    }


    // ========================= UPDATE USER =========================

    @PostMapping("/updateUser")
    public String updateUser(UserEntity userEntity,
                             AddressEntity addressEntity,
                             @RequestParam(required = false) MultipartFile profilePic,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Optional<UserEntity> optionalUser = userRepository.findById(userEntity.getUserId());
        if (optionalUser.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "User not found!");
            return "redirect:/index";
        }

        UserEntity existingUser = optionalUser.get();
        
        // Check permission: Admin can update any user, regular users can only update themselves
        if (!"ADMIN".equals(currentUser.getRole()) && !currentUser.getUserId().equals(userEntity.getUserId())) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to update this profile!");
            return "redirect:/index";
        }

        try {
            // Upload new profile picture if provided
            if (profilePic != null && !profilePic.isEmpty()) {
                Map<?, ?> uploadResult =
                        cloudinary.uploader().upload(profilePic.getBytes(), null);
                userEntity.setProfilePicURL(
                        uploadResult.get("secure_url").toString());
            } else {
                // Keep existing profile picture
                userEntity.setProfilePicURL(existingUser.getProfilePicURL());
            }
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error uploading profile picture!");
        }

        // Preserve old created date, password, role, and active status
        userEntity.setCreatedAt(existingUser.getCreatedAt());
        userEntity.setPassword(existingUser.getPassword()); // Password unchanged
        userEntity.setRole(existingUser.getRole()); // Keep existing role
        userEntity.setActive(existingUser.getActive()); // Keep existing status
        userEntity.setOtp(existingUser.getOtp()); // Keep OTP if any

        userRepository.save(userEntity);

        // Update address (check if addressId exists)
        if (addressEntity.getAddressId() != null) {
            // Update existing address
            Optional<AddressEntity> existingAddress = addressRepository.findById(addressEntity.getAddressId());
            if (existingAddress.isPresent()) {
                addressEntity.setUserId(userEntity.getUserId());
                addressEntity.setCreatedAt(existingAddress.get().getCreatedAt()); // Preserve creation date
                addressRepository.save(addressEntity);
            }
        } else {
            // New address
            addressEntity.setUserId(userEntity.getUserId());
            addressRepository.save(addressEntity);
        }

        redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        
        return "redirect:/viewUser?userId=" + userEntity.getUserId();
    }


    // ========================= SEND OTP (FORGOT PASSWORD) =========================

    @PostMapping("/send-otp")
    public String sendOtp(String email, Model model) {

        Optional<UserEntity> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isEmpty()) {
            model.addAttribute("error", "Email not found!");
            return "fp";
        }

        UserEntity user = optionalUser.get();
        
        // Check if account is active
        if (!user.getActive()) {
            model.addAttribute("error", "Your account is deactivated. Please contact support!");
            return "fp";
        }

        String otp = String.valueOf((int) (Math.random() * 900000) + 100000);

        user.setOtp(otp);
        userRepository.save(user);

        mailerService.sendOtpMail(user, otp);

        model.addAttribute("email", email);
        model.addAttribute("success", "OTP sent successfully to your email.");

        return "verifyOtp";
    }


    // ========================= VERIFY OTP =========================

    @PostMapping("/verify-otp")
    public String verifyOtp(String email,
                            String otp,
                            Model model) {

        Optional<UserEntity> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isEmpty()) {
            return "error";
        }

        UserEntity user = optionalUser.get();

        if (!otp.equals(user.getOtp())) {
            model.addAttribute("error", "Invalid OTP!");
            model.addAttribute("email", email);
            return "verifyOtp";
        }

        // =================== Generate reset token ===================
        String resetToken = UUID.randomUUID().toString();
        user.setResetToken(resetToken);
        user.setResetTokenExpiry(LocalDateTime.now().plusMinutes(15));
        userRepository.save(user);
        // ============================================================

        model.addAttribute("email", email);
        model.addAttribute("token", resetToken);
        return "resetPassword";
    }


    // ========================= UPDATE PASSWORD =========================

    // Handle GET requests to /update-password (redirect to forgot password)
    @GetMapping("/update-password")
    public String updatePasswordGet() {
        // Redirect to forgot password page to start over
        return "redirect:/fp";
    }

    @PostMapping("/update-password")
    public String updatePassword(@RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam String confirmPassword,
                                 @RequestParam String token,
                                 Model model) {

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match!");
            model.addAttribute("email", email);
            return "resetPassword";
        }

        Optional<UserEntity> optionalUser = userRepository.findByEmail(email);
        if (optionalUser.isEmpty()) {
            return "error";
        }

        UserEntity user = optionalUser.get();

        // =================== Validate token ===================
        if (user.getResetToken() == null || !user.getResetToken().equals(token)) {
            model.addAttribute("error", "Invalid reset link. Please request a new password reset.");
            model.addAttribute("email", email);
            return "resetPassword";
        }

        if (user.getResetTokenExpiry() == null || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            model.addAttribute("error", "Reset link has expired. Please request a new one.");
            model.addAttribute("email", email);
            return "resetPassword";
        }
        // ======================================================

        // Encode new password
        user.setPassword(passwordEncoder.encode(password));
        user.setOtp(null);                // Clear OTP
        user.setResetToken(null);         // Clear reset token
        user.setResetTokenExpiry(null);   // Clear expiry
        userRepository.save(user);

        model.addAttribute("success", "Password updated successfully! Please login with your new password.");

        return "login";
    }
    
    
    // ========================= MY PROFILE (SHORTCUT) =========================
    
    @GetMapping("/profile")
    public String myProfile(HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        return "redirect:/viewUser?userId=" + currentUser.getUserId();
    }
}