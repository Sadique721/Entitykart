package com.grownited.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ProductRepository;
import com.grownited.repository.SubCategoryRepository;

@Controller
public class SubCategoryController {

    // ========================= DEPENDENCY INJECTION =========================

    @Autowired
    private SubCategoryRepository subCategoryRepository;

    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private ProductRepository productRepository;


    // ========================= LOAD SUBCATEGORY PAGE =========================

    @GetMapping("/subCategory")
    public String viewSubCategoryPage(Model model) {

        // Load categories for dropdown
        List<CategoryEntity> categoryList =
                categoryRepository.findAll();

        model.addAttribute("categoryList", categoryList);

        return "subCategory";
    }
    
    @GetMapping("/viewSubCategory")
    public String viewSubCategory(@RequestParam Integer id, Model model) {
        Optional<SubCategoryEntity> optional = subCategoryRepository.findById(id);
        if (optional.isEmpty()) return "redirect:/listSubCategory";
        model.addAttribute("subCategory", optional.get());
        model.addAttribute("category", categoryRepository.findById(optional.get().getCategoryId()).orElse(null));
        return "viewSubCategory";
    }

    @GetMapping("/toggleSubCategoryActive")
    public String toggleSubCategoryActive(@RequestParam Integer id, RedirectAttributes redirectAttributes) {
        Optional<SubCategoryEntity> optional = subCategoryRepository.findById(id);
        if (optional.isPresent()) {
            SubCategoryEntity sub = optional.get();
            sub.setActive(!sub.getActive());
            subCategoryRepository.save(sub);
            redirectAttributes.addFlashAttribute("success", "Subcategory status updated!");
        }
        return "redirect:/listSubCategory";
    }


    // ========================= SAVE SUBCATEGORY =========================

    @PostMapping("/saveSubCategory")
    public String saveSubCategory(SubCategoryEntity subCategoryEntity, CategoryEntity categoryEntity) {

        subCategoryEntity.setActive(true);
        subCategoryEntity.setCategoryId(categoryEntity.getCategoryId());
        subCategoryRepository.save(subCategoryEntity);

        return "redirect:/listSubCategory";
    }


    // ========================= LIST SUBCATEGORY =========================

    @GetMapping("/listSubCategory")
    public String listSubCategory(Model model) {
        List<SubCategoryEntity> subCategories = subCategoryRepository.findAll();
        List<CategoryEntity> categoryList = categoryRepository.findAll();

        // Build a map of subCategoryId -> product count
        Map<Integer, Long> productCountMap = new HashMap<>();
        for (SubCategoryEntity sub : subCategories) {
            // subCategoryId is Integer, product table stores it as String
            Long count = productRepository.countBySubCategoryId(String.valueOf(sub.getSubCategoryId()));
            productCountMap.put(sub.getSubCategoryId(), count);
        }

        model.addAttribute("categoryList", categoryList);
        model.addAttribute("subCategories", subCategories);
        model.addAttribute("productCountMap", productCountMap);

        return "listSubCategory";
    }


    // ========================= DELETE SUBCATEGORY =========================

    @GetMapping("/deleteSubCategory")
    public String deleteSubCategory(
            @RequestParam Integer id) {

        if (subCategoryRepository.existsById(id)) {
            subCategoryRepository.deleteById(id);
        }

        return "redirect:/listSubCategory";
    }


    // ========================= EDIT SUBCATEGORY =========================

    @GetMapping("/editSubCategory")
    public String editSubCategory(@RequestParam Integer id,
                                  Model model) {

        Optional<SubCategoryEntity> optionalSub =
                subCategoryRepository.findById(id);

        if (optionalSub.isEmpty()) {
            return "redirect:/listSubCategory";
        }

        // Load categories for dropdown (important for edit page)
        List<CategoryEntity> categoryList =
                categoryRepository.findAll();

        model.addAttribute("subCategoryEntity",
                optionalSub.get());
        model.addAttribute("categoryList",
                categoryList);

        return "editSubCategory";
    }


    // ========================= UPDATE SUBCATEGORY =========================

    @PostMapping("/updateSubCategory")
    public String updateSubCategory(
            SubCategoryEntity subCategoryEntity) {

        Optional<SubCategoryEntity> optionalSub =
                subCategoryRepository.findById(
                        subCategoryEntity.getSubCategoryId());

        if (optionalSub.isEmpty()) {
            return "redirect:/listSubCategory";
        }

        SubCategoryEntity existingSub =
                optionalSub.get();

        // Preserve Active status
        subCategoryEntity.setActive(existingSub.getActive());

        subCategoryRepository.save(subCategoryEntity);

        return "redirect:/listSubCategory";
    }
    
}