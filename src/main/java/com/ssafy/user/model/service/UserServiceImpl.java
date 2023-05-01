package com.ssafy.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.user.model.UserDto;
import com.ssafy.user.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;

	public UserServiceImpl(UserMapper userMapper) {
		super();
		this.userMapper = userMapper;
	}

	@Override
	public UserDto signinUser(String id, String password) throws Exception {
		return userMapper.signinUser(id, password);
	}

	@Override
	public int signupUser(UserDto userDto) throws Exception {
		return userMapper.signupUser(userDto);
	}

	@Override
	public int deleteUser(String id) throws Exception {
		return userMapper.deleteUser(id);
	}

	@Override
	public int updateUser(UserDto userDto) throws Exception {
		return userMapper.updateUser(userDto);
	}

	@Override
	public int idCheck(String id) throws Exception {
		return userMapper.idCheck(id);
	}

}
