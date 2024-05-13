package com.fullStack.webApp.controllers;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fullStack.webApp.CustomResponse;
import com.fullStack.webApp.models.OrderModel;
import com.fullStack.webApp.models.ProductModel;
import com.fullStack.webApp.models.UserModel;
import com.fullStack.webApp.services.OrderRepo;
import com.fullStack.webApp.services.ProductRepo;
import com.fullStack.webApp.services.UserRepo;




@Controller
@RequestMapping("/orders")
public class OrderController {
	
	@Autowired
	OrderRepo orderRepo;

	@Autowired
	UserRepo userRepo;

	@Autowired
	ProductRepo productRepo;
	
	
	@GetMapping({"", "/"})
	public String index(Model model) {
		try {
			List<OrderModel> orders = orderRepo.findAll();
			if (!orders.isEmpty()) {
				model.addAttribute("orders", orders);
			} else {
				model.addAttribute("message", "No orders found");
			}
			return "orders/ordersHomePage";
		} catch (Exception e) {
			model.addAttribute("error", "An error occurred while retrieving orders. Please try again later.");
			return "errorPage"; 
		}
	}

	
	// @GetMapping("/{id}")
	// public ResponseEntity<?> getOrder(@PathVariable("id") int id) {
	// 	final OrderModel order = orderRepo.findById(id).orElse(null);
	// 	if (order == null) {
	// 		CustomResponse error = new CustomResponse("Order not found");
	// 		return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
	// 	}
	// 	else {
	// 		return ResponseEntity.ok(order);
	// 	}
	// }

	@GetMapping("/add")
	public String showCreateOrderForm(Model model) {
		List<ProductModel> products = productRepo.findAll();
		model.addAttribute("products", products);
		return "orders/add";
	}

	@PostMapping("/add")
	public String createOrder(
		@RequestParam("productIds") String productIdsString
	) {
		// Convert comma-separated string to list of integers
		List<Integer> productIds = Arrays.stream(productIdsString.split(","))
										.map(Integer::parseInt)
										.collect(Collectors.toList());

		List<ProductModel> products = new ArrayList<>();
		Double total = 0.00;
		for (Integer id : productIds) {
			ProductModel product = productRepo.findById(id).orElse(null);
			if (product != null){
				products.add(product);
				total+= product.getPrice();
			}
		}
		OrderModel order = new OrderModel(products, total, LocalDate.now());
		UserModel user = UserHolder.getUser();
		order.setUser(user);
		orderRepo.save(order);

		return "redirect:/orders";
	}


	@DeleteMapping("/{id}")
    public ResponseEntity<String> deleteOrder(@PathVariable("id") int id){
        OrderModel order = orderRepo.findById(id).orElse(null);
        if (order == null) {
            return ResponseEntity.notFound().build();
        }
        orderRepo.delete(order);
        return ResponseEntity.ok().build();
    }
	
}