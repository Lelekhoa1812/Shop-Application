package com.project.shopapp.controllers;

import com.project.shopapp.dtos.CategoryDTO;
import com.project.shopapp.models.Category;
import com.project.shopapp.services.CategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/categories")
//@RequestMapping("api/v1/categories")
//@Validated
// Dependency Injection
@RequiredArgsConstructor
public class CategoryController {
    private final CategoryService categoryService;
//    // Manually add Parameter Constructor as "RequiredArgsConstructor" annotation does not work
//    public CategoryController(CategoryService categoryService) {
//        this.categoryService = categoryService;
//    }

    @PostMapping("")
    // Case sending an object -> Data Transfer Object = Request Object
    public  ResponseEntity<?> createCategory(@Valid @RequestBody CategoryDTO categoryDTO, BindingResult result) {
        if(result.hasErrors()) {
            List<String> errorMessages = result.getFieldErrors()
                    .stream()
//                    .map(fieldError -> fieldError.getDefaultMessage())
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errorMessages);
        }
        categoryService.createCategory(categoryDTO);
        return ResponseEntity.ok("Insert cat " + categoryDTO);
    }

    // Display all categories
    @GetMapping("")  // http://localhost:8088/api/v1/categories?page=1&limit=10
    public  ResponseEntity<String> getCategory(
            @RequestParam("page")  int page,
            @RequestParam("limit") int limit
    ) {
        List<Category> categories = categoryService.getAllCategories();// List all
//        return ResponseEntity.ok(String.format("getCategory, page = %d, limit = %d", page, limit));
        return ResponseEntity.ok(categories.toString());
    }

    @PutMapping("/{id}")
    public  ResponseEntity<String> updateCategory(@PathVariable Long id, @Valid @RequestBody CategoryDTO categoryDTO) {
        categoryService.updateCategory(id, categoryDTO);
        return ResponseEntity.ok("Update category with id " + id + " successfully");
    }

    @DeleteMapping("/{id}")
    public  ResponseEntity<String> deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
        return ResponseEntity.ok("Delete category with id " + id + " successfully");
    }
}
