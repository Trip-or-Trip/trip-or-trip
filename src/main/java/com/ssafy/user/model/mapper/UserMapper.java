package com.ssafy.user.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.user.model.UserDto;

@Mapper
public interface UserMapper {
	UserDto signinUser(String id, String password) throws Exception;
	int signupUser(UserDto userDto) throws Exception;
	int deleteUser(String id) throws Exception;
	int updateUser(UserDto userDto) throws Exception;
	int idCheck(String id) throws Exception;
}
