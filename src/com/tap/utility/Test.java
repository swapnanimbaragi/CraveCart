
package com.tap.utility;

import com.tap.DAOimpl.UserDAOimpl;
import com.tap.model.User;

public class Test {
	public static void main(String[] args) {
		
		User user = new User(
				"Praveen",
				"praveen@gmail.com",
				"Prav@123",
				"BTM",
				"Customer"
			);

		UserDAOimpl userDAOimpl = new UserDAOimpl();
		userDAOimpl.addUser(user);

		System.out.print("User Added");
	}
}