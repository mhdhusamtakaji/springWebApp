package com.fullStack.webApp.services;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fullStack.webApp.models.ProductModel;

import java.util.List;

public interface ProductRepo extends JpaRepository<ProductModel, Integer>{
    ProductModel findByname(String name);
}