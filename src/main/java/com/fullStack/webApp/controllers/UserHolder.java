package com.fullStack.webApp.controllers;

import com.fullStack.webApp.models.UserModel;

public class UserHolder {
    private static final ThreadLocal<UserModel> userHolder = new ThreadLocal<>();

    public static void setUser(UserModel user) {
        userHolder.set(user);
    }

    public static UserModel getUser() {
        return userHolder.get();
    }

    public static void clearUser() {
        userHolder.remove();
    }
}