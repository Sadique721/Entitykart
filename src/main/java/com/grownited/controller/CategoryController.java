package com.grownited.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.SubCategoryRepository;

@Controller
public class CategoryController {

    // ========================= DEPENDENCY INJECTION =========================

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubCategoryRepository subCategoryRepository;


    // ========================= LOAD CATEGORY PAGE =========================

    @GetMapping("/category")
    public String viewCategoryPage() {
        return "category";
    }
    
    @GetMapping("/viewCategory")
    public String viewCategory(@RequestParam Integer categoryId, Model model) {
        Optional<CategoryEntity> optional = categoryRepository.findById(categoryId);
        if (optional.isEmpty()) return "redirect:/listCategory";
        model.addAttribute("category", optional.get());
        model.addAttribute("subCategories", subCategoryRepository.findByCategoryId(categoryId));
        return "viewCategory";
    }

    @GetMapping("/toggleCategoryActive")
    public String toggleCategoryActive(@RequestParam Integer categoryId, RedirectAttributes redirectAttributes) {
        Optional<CategoryEntity> optional = categoryRepository.findById(categoryId);
        if (optional.isPresent()) {
            CategoryEntity cat = optional.get();
            cat.setActive(!cat.getActive());
            categoryRepository.save(cat);
            redirectAttributes.addFlashAttribute("success", "Category status updated!");
        }
        return "redirect:/listCategory";
    }


    // ========================= SAVE CATEGORY =========================

    @PostMapping("/saveCategory")
    public String saveCategory(CategoryEntity categoryEntity,
                               SubCategoryEntity subCategoryEntity) {

        // Activate category
        categoryEntity.setActive(true);
        categoryRepository.save(categoryEntity);

//        // Map subcategory to category
//        subCategoryEntity.setActive(true);
//        subCategoryEntity.setCategoryId(
//                categoryEntity.getCategoryId());
//
//        subCategoryRepository.save(subCategoryEntity);

        return "redirect:/listCategory";
    }


    // ========================= LIST CATEGORY =========================

    @GetMapping("/listCategory")
    public String listCategory(Model model) {
        List<CategoryEntity> categoryList = categoryRepository.findAll();

        // Build a map of categoryId -> subcategory count
        Map<Integer, Long> subCategoryCountMap = new HashMap<>();
        for (CategoryEntity cat : categoryList) {
            Long count = subCategoryRepository.countByCategoryId(cat.getCategoryId());
            subCategoryCountMap.put(cat.getCategoryId(), count);
        }

        model.addAttribute("categoryList", categoryList);
        model.addAttribute("subCategoryCountMap", subCategoryCountMap);

        return "listCategory";
    }


    // ========================= DELETE CATEGORY =========================

    @GetMapping("/deleteCategory")
    public String deleteCategory(
            @RequestParam Integer categoryId) {

        if (categoryRepository.existsById(categoryId)) {

            // Optional: delete related subcategories first
            List<SubCategoryEntity> subList =
                    subCategoryRepository.findByCategoryId(categoryId);

            for (SubCategoryEntity sub : subList) {
                subCategoryRepository.deleteById(
                        sub.getSubCategoryId());
            }

            categoryRepository.deleteById(categoryId);
        }

        return "redirect:/listCategory";
    }


    // ========================= EDIT CATEGORY =========================

    @GetMapping("/editCategory")
    public String editCategory(@RequestParam Integer categoryId,
                               Model model) {

        Optional<CategoryEntity> optionalCategory =
                categoryRepository.findById(categoryId);

        if (optionalCategory.isEmpty()) {
            return "redirect:/listCategory";
        }

        CategoryEntity category =
                optionalCategory.get();

        List<SubCategoryEntity> subList =
                subCategoryRepository.findByCategoryId(categoryId);

        model.addAttribute("categoryEntity", category);
        model.addAttribute("subCategories", subList);

        return "editCategory";
    }


    // ========================= UPDATE CATEGORY =========================

    @PostMapping("/updateCategory")
    public String updateCategory(CategoryEntity categoryEntity) {

        Optional<CategoryEntity> optionalCategory =
                categoryRepository.findById(
                        categoryEntity.getCategoryId());

        if (optionalCategory.isEmpty()) {
            return "redirect:/listCategory";
        }

        CategoryEntity existingCategory =
                optionalCategory.get();

        // Preserve Active status
        categoryEntity.setActive(
                existingCategory.getActive());

        categoryRepository.save(categoryEntity);

        return "redirect:/listCategory";
    }
}