package com.fullStack.webApp.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fullStack.webApp.PasswordEncoder;
import com.fullStack.webApp.models.UserModel;
import com.fullStack.webApp.services.UserRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

	 @Autowired
     private UserRepo userRepo;

    // Render mapping for registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        // Add error message if exists
        model.addAttribute("error", "");
        return "register"; // jsp file name
    }

    // Action mapping for registration form submission
    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password, Model model) {
        UserModel user = new UserModel(username, password);
        if (userRepo.findByUsername(username) != null) {
            // Set error message and return to registration form
            model.addAttribute("error", "Username already exists. Please choose a different username.");
            return "register";
        }

        user.setPassword(PasswordEncoder.encode(password));
        userRepo.save(user);
        return "redirect:/login";
    }

    // renderMapping login form
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        // Add error message if exists
        model.addAttribute("error", "");
        return "login";
    }

    // actionMapping login submission
    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpServletRequest request) {
        UserModel user = userRepo.findByUsername(username);
        if (user == null || !PasswordEncoder.validatePassword(password, user.getPassword())) {
            // Set error message and return to login form
            model.addAttribute("error", "Invalid username or password.");
            return "login";
        }
        // set token to session after login
        final String token = PasswordEncoder.generateToken(username);
        user.setToken(token);
        UserHolder.setUser(user);
        return "redirect:/products";
    }
    
    // Render mapping for profile page
    @GetMapping("/profile")
    public String showProfile() {
        return "profile"; 
    }

    // Action mapping for logout
    @PostMapping("/logout")
    public String logout(HttpServletRequest request) {
        // Clear UserHolder
        UserHolder.clearUser();
        return "redirect:/login";
    }

    // @GetMapping("/user")
    // public ResponseEntity<?> getAuthenticatedUser(@RequestHeader("Authorization") String authorizationHeader) {
    //     // Check if Authorization header is present
    //     if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
    //         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Missing or invalid Authorization header");
    //     }
    //     // Extract token from Authorization header
    //     String token = authorizationHeader.substring(7); // Remove "Bearer " prefix

    //     // Retrieve user from database using token
    //     UserModel authenticatedUser = userRepo.findByToken(token);
    //     if (authenticatedUser != null) {
    //         return ResponseEntity.status(HttpStatus.OK).body(authenticatedUser);
    //     } else {
    //         return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
    //     }
    // }

    // @GetMapping("/users/orders") 
    // public ResponseEntity<?> fetchMyOrders(@RequestHeader("Authorization") String authorizationHeader) {
    //      // Check if Authorization header is present
    //      if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
    //         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Missing or invalid Authorization header");
    //     }
    //     // Extract token from Authorization header
    //     String token = authorizationHeader.substring(7); // Remove "Bearer " prefix

    //     // Retrieve user from database using token
    //     UserModel authenticatedUser = userRepo.findByToken(token);
    //     if (authenticatedUser == null) {
    //         return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
    //     }
    //     List<OrderModel> orders = authenticatedUser.getOrders();
    //     return ResponseEntity.status(HttpStatus.ACCEPTED).body(orders);
    // }
}
