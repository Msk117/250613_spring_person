package com.koreait.www.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.koreait.www.domain.UserVO;
import com.koreait.www.repository.UserDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAuthUserService implements UserDetailsService {

	@Autowired
	private UserDAO udao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		UserVO uvo = udao.getUser(username);
		
		if (uvo == null) {
			throw new UsernameNotFoundException(username);
		}
		
		uvo.setAuthList(udao.getAuthList(username));
		log.info(">>> userDetails >> {}",uvo);
		
		return new AuthUser(uvo);
	}

}
