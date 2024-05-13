package com.fullStack.webApp.controllers;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fullStack.webApp.CustomResponse;
import com.fullStack.webApp.models.ProductModel;
import com.fullStack.webApp.services.ProductRepo;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {
	@Autowired
	ProductRepo productRepo;
		
	@GetMapping({"", "/"})
    public String index(Model model) {
        try {
            List<ProductModel> products = productRepo.findAll();
            if (products.isEmpty()) {
                model.addAttribute("message", "No products available.");
            } else {
                model.addAttribute("products", products);
            }
            return "products/productsHomePage";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while retrieving products. Please try again later.");
            return "errorPage"; 
        }
    }

    @GetMapping("/add")
    public String createProdcte() {
        return "products/add";
    }

    @PostMapping("/add")
    public String addProduct(
            @RequestParam String name,
            @RequestParam Double price,
            @RequestParam(required = false) String description) {
                ProductModel product = new ProductModel(name, price, description);
                productRepo.save(product);
                return "redirect:/products";
    }

    @GetMapping("/update/{id}")
    public String showUpdateProduct(@PathVariable("id") int id, Model model) {
        ProductModel product = productRepo.findById(id).orElse(null);
        if (product == null) {
            return "redirect:/products";
        }
        model.addAttribute("product", product);
        return "products/update";
    }

    @PostMapping("/{id}")
    public String updateProduct(
            @PathVariable("id") int id,
            @RequestParam String name,
            @RequestParam double price,
            @RequestParam String description
    ) {
        final ProductModel product = productRepo.findById(id).orElse(null);
        if (product == null) {
            CustomResponse error = new CustomResponse("Product not found");
            // Assuming you have an error page, redirect to it
            return "redirect:/error";
        } else {
            product.setName(name);
            product.setPrice(price);
            product.setDescription(description);
            productRepo.save(product);
            return "redirect:/products";
        }   
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable("id") int id){
        ProductModel product = productRepo.findById(id).orElse(null);
        if (product == null) {
            return ResponseEntity.notFound().build();
        }
        productRepo.delete(product);
        return ResponseEntity.ok().build();
    }

}