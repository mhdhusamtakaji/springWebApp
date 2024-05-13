package com.fullStack.webApp.services;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fullStack.webApp.models.UserModel;


public interface UserRepo extends JpaRepository<UserModel, Integer>{
    UserModel findByUsername(String username);
    UserModel findByToken(String token);
}
