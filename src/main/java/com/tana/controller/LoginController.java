package com.tana.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.entities.Account;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.SessionUtility;

@Controller
public class LoginController extends HeaderController{

	private Logger LOGGER = Logger.getLogger(LoginController.class);
	
	@GetMapping("/login")
	public String goToLogin(Model model) {
		LOGGER.info("Redirect to login page");
		model.addAttribute("user", new Account());
		return "index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String doLogin(@ModelAttribute("SpringWeb") Account accountLogin, HttpSession session, ModelMap model, HttpServletResponse response,
            HttpServletRequest request) {
		Account account = accountRepository.findByUsername(accountLogin.getUsername());
		if (account != null) {
			if (account.getPassword().equals(accountLogin.getPassword())) {
				LOGGER.info("Logging in as '" + account.getUsername() + "' successfully");
				session.setAttribute("user", account);
				model.addAttribute("alert",AlertMessage.LOGIN_SUCCESS);
				return "index";
			}
		}
		model.addAttribute("loginErrorMsg",AlertMessage.LOGIN_FAIL);
		return "index";
	}

	@RequestMapping(value = "/logout")
	public String doLogout(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage alert = null;
		if (account != null) {
			session.removeAttribute("user");
			alert = AlertMessage.LOGOUT_SUCCESS;
		}else{
			alert = AlertMessage.ANONYMOUS_USER;
		}

		session.removeAttribute(SessionUtility.isAdminView);
		model.addAttribute("alert",alert);
		return "index";
	}

}
