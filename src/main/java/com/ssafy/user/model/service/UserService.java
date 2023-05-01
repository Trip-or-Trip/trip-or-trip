package com.ssafy.user.model.service;

import com.ssafy.user.model.UserDto;

public interface UserService {
	UserDto signinUser(String id, String password) throws Exception;
	int signupUser(UserDto userDto) throws Exception;
	int deleteUser(String id) throws Exception;
	int updateUser(UserDto userDto) throws Exception;
	int idCheck(String id) throws Exception;
}
