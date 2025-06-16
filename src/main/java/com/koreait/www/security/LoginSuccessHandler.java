package com.koreait.www.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import com.koreait.www.repository.UserDAO;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private UserDAO udao;
	
	
	private RedirectStrategy redStr = new DefaultRedirectStrategy();
	
	
	private RequestCache reqCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		String AuthEmail = authentication.getName();
		int isOk = udao.updateLastLogin(AuthEmail);
		
		String authUrl = "/board/list";
		
		HttpSession ses = request.getSession();
		if (ses == null) {
			
			return;
		}else {
			
			ses.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
			
		}
		
		
		SavedRequest saveRequest = reqCache.getRequest(request, response);
		redStr.sendRedirect(request, response,
				saveRequest != null? saveRequest.getRedirectUrl() : authUrl);
		
		
		
	}

}
