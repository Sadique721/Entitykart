package com.grownited.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.transaction.annotation.Transactional;

import com.grownited.entity.AddressEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.AddressRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class AddressController {

    @Autowired
    private AddressRepository addressRepository;

    @GetMapping("/address")
    public String addAddressPage(HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("currentUser", currentUser);
        return "addAddress";
    }

    @PostMapping("/saveAddress")
    @Transactional
    public String saveAddress(AddressEntity addressEntity,
                              @RequestParam(required = false) Boolean isDefault,
                              HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        addressEntity.setUserId(currentUser.getUserId());

        if (isDefault != null && isDefault) {
            // Unset existing default
            List<AddressEntity> existingAddresses = addressRepository.findByUserId(currentUser.getUserId());
            for (AddressEntity addr : existingAddresses) {
                if (addr.getIsDefault() != null && addr.getIsDefault()) {
                    addr.setIsDefault(false);
                    addressRepository.save(addr);
                }
            }
            addressEntity.setIsDefault(true);
        } else {
            addressEntity.setIsDefault(false);
        }

        addressRepository.save(addressEntity);
        session.setAttribute("successMessage", "Address added successfully!");
        return "redirect:/listAddress";
    }

    @GetMapping("/listAddress")
    public String listAddress(HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        List<AddressEntity> addressList = addressRepository.findByUserId(currentUser.getUserId());
        model.addAttribute("addressList", addressList);
        return "listAddress";
    }

    @GetMapping("/deleteAddress")
    @Transactional
    public String deleteAddress(@RequestParam Integer id, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Optional<AddressEntity> optionalAddress = addressRepository.findById(id);
        if (optionalAddress.isPresent()) {
            AddressEntity address = optionalAddress.get();
            if (address.getUserId().equals(currentUser.getUserId())) {
                if (address.getIsDefault() != null && address.getIsDefault()) {
                    List<AddressEntity> otherAddresses = addressRepository.findByUserId(currentUser.getUserId());
                    for (AddressEntity addr : otherAddresses) {
                        if (!addr.getAddressId().equals(id)) {
                            addr.setIsDefault(true);
                            addressRepository.save(addr);
                            break;
                        }
                    }
                }
                addressRepository.deleteById(id);
                session.setAttribute("successMessage", "Address deleted successfully!");
            } else {
                session.setAttribute("errorMessage", "You don't have permission to delete this address!");
            }
        }
        return "redirect:/listAddress";
    }

    @GetMapping("/editAddress")
    public String editAddress(@RequestParam Integer id, HttpSession session, Model model) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Optional<AddressEntity> optionalAddress = addressRepository.findById(id);
        if (optionalAddress.isPresent()) {
            AddressEntity address = optionalAddress.get();
            if (address.getUserId().equals(currentUser.getUserId())) {
                model.addAttribute("address", address);
                model.addAttribute("currentUser", currentUser);
                return "editAddress";
            }
        }
        session.setAttribute("errorMessage", "Address not found!");
        return "redirect:/listAddress";
    }

    @PostMapping("/updateAddress")
    @Transactional
    public String updateAddress(AddressEntity addressEntity,
                                @RequestParam(required = false) Boolean isDefault,
                                HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Optional<AddressEntity> optionalExisting = addressRepository.findById(addressEntity.getAddressId());
        if (optionalExisting.isPresent()) {
            AddressEntity existingAddress = optionalExisting.get();
            if (!existingAddress.getUserId().equals(currentUser.getUserId())) {
                session.setAttribute("errorMessage", "You don't have permission to edit this address!");
                return "redirect:/listAddress";
            }

            addressEntity.setUserId(currentUser.getUserId());

            if (isDefault != null && isDefault) {
                List<AddressEntity> userAddresses = addressRepository.findByUserId(currentUser.getUserId());
                for (AddressEntity addr : userAddresses) {
                    if (addr.getIsDefault() != null && addr.getIsDefault() && !addr.getAddressId().equals(addressEntity.getAddressId())) {
                        addr.setIsDefault(false);
                        addressRepository.save(addr);
                    }
                }
                addressEntity.setIsDefault(true);
            } else {
                addressEntity.setIsDefault(false);
            }

            addressRepository.save(addressEntity);
            session.setAttribute("successMessage", "Address updated successfully!");
        }
        return "redirect:/listAddress";
    }

    @GetMapping("/setDefaultAddress")
    @Transactional
    public String setDefaultAddress(@RequestParam Integer id, HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Optional<AddressEntity> optionalAddress = addressRepository.findById(id);
        if (optionalAddress.isPresent()) {
            AddressEntity newDefault = optionalAddress.get();
            if (newDefault.getUserId().equals(currentUser.getUserId())) {
                List<AddressEntity> userAddresses = addressRepository.findByUserId(currentUser.getUserId());
                for (AddressEntity addr : userAddresses) {
                    if (addr.getIsDefault() != null && addr.getIsDefault()) {
                        addr.setIsDefault(false);
                        addressRepository.save(addr);
                    }
                }
                newDefault.setIsDefault(true);
                addressRepository.save(newDefault);
                session.setAttribute("successMessage", "Default address updated successfully!");
            }
        }
        return "redirect:/listAddress";
    }

    // REST API endpoints (optional)
    @GetMapping("/api/addresses")
    @ResponseBody
    public List<AddressEntity> getUserAddresses(HttpSession session) {
        UserEntity currentUser = (UserEntity) session.getAttribute("user");
        if (currentUser == null) {
            return List.of();
        }
        return addressRepository.findByUserId(currentUser.getUserId());
    }
}