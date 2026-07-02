package com.tap.DAO;

import com.tap.model.User;

public interface AdminDAO 
{
    User adminLogin(String email, String password);
}
