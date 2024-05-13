package com.fullStack.webApp.services;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fullStack.webApp.models.OrderModel;


public interface OrderRepo extends JpaRepository<OrderModel, Integer>{
    
}