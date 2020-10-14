package com.ex.LaunchTest.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ex.LaunchTest.models.Users;
import com.ex.LaunchTest.repository.UsersRepository;
import com.ex.LaunchTest.utils.DataValidation;

@Controller
@SessionAttributes({"loggedInUser", "role"})
public class AppController {
	
	@ModelAttribute("user")
	public Users user() {
		return new Users();
	}
	
	@Autowired
	private UsersRepository userRepository;
	
	@Autowired
	private DataValidation dataValidation;
	
	@GetMapping({"home","/"})
	public String home(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		return "home";
	}
	
	@GetMapping("about")
	public String about(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		return "about";
	}
	
	@GetMapping("contact")
	public String contact(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		return "contact";
	}
	
	@GetMapping("login")
	public String login(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		return "login";		
	}
	
	@PostMapping("login")
	public String login(RedirectAttributes redirect, Model model, @RequestParam String email, @RequestParam String password) {
		Optional<Users> user = userRepository.login(email, password);
		if(user.isPresent()) {
			model.addAttribute("loggedInUser", email);
			model.addAttribute("role", user.get().getRole());
		} else {
			redirect.addFlashAttribute("error", "Error - Invalid Credentials");
			return "redirect:/login";
		}
		return "redirect:/profile";
	}
	
	@GetMapping("logout")
	public String logout(Model model, SessionStatus status, HttpSession session) {
		session.invalidate();
		model.addAttribute("loggedInUser", "");
		model.addAttribute("role", "");
		Users user = new Users();
		model.addAttribute("user", user);
		model.addAttribute("msg", "You have been logged out.");
		return "login";
	}
	
	@GetMapping("profile")
	public String profile(@SessionAttribute(required = false) String loggedInUser, Model model) {
		try {
		if(loggedInUser.isEmpty() && loggedInUser != null) {
			model.addAttribute("error", "Error - Session expired please log in.");
			return "login";
		}
		userRepository.findUserByEmail(loggedInUser).ifPresent(a->{
			model.addAttribute("user_account", a);
		});
		model.addAttribute("page", "Profile");		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "profile";
	}
	
	@GetMapping("register")
	public String signUp(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		model.addAttribute("users", new Users());
		return "register";
	}
	
	@PostMapping("register")
	public String register(@ModelAttribute("user") Users user, Model model) {
		if(userRepository.findUserByEmail(user.getEmail()).isPresent()) {
			model.addAttribute("msg", "Register");
			model.addAttribute("page", "Register");
			model.addAttribute("users", new Users());
			model.addAttribute("error", "Error - User already exists!");
			return "register";
		}		
		user.setRole("USER");
		userRepository.save(user);
		model.addAttribute("user_account", user);
		model.addAttribute("msg", "Welcome " + user.getFirstName());
		model.addAttribute("page", "Profile");
		model.addAttribute("loggedInUser", user.getEmail());
		model.addAttribute("role", user.getRole());
		
		return "profile";
		
		/*
		 * userRepository.save(user); model.addAttribute("welcomeMessage",
		 * "Welcome Message!"); model.addAttribute("success", user);
		 * model.addAttribute("msg1", "Hello, "+user.getFirstName());
		 * 
		 * return "profile";
		 */
	}
	
	@GetMapping("admin")
	public String admin(Model model) {
		model.addAttribute("welcomeMessage", "Welcome Message!");
		model.addAttribute("list", userRepository.findAll());
		return "admin";
	}
	
	@PostMapping("editrole")
	public String editrole(@RequestParam Long id, @RequestParam String role, RedirectAttributes redirect) {
		try {
			userRepository.findById(id).ifPresent(a->{
				a.setRole(role);
				userRepository.save(a);
			});
			redirect.addFlashAttribute("resp", "Success - Role Granted.");
		} catch(Exception e) {
			e.printStackTrace();
			redirect.addFlashAttribute("resp", "Error - Operation failed.");
		}
		return "redirect:/admin";
	}
	
	@GetMapping("removeuser")
	public String removeUser(Model model, @RequestParam Long id) {
		try {
			userRepository.deleteById(id);
			model.addAttribute("resp", "Success - Operation Completed.");
			model.addAttribute("list", userRepository.findAll());			
		} catch(Exception e) {
			e.printStackTrace();
			model.addAttribute("resp", "Error - Operation failed.");
		}
		return "admin";
	}
	
	@PostMapping("updatemyinfo")
	public String updatemyinfo(@ModelAttribute Users user, RedirectAttributes redirect) {
		userRepository.findById(user.getId()).ifPresent(a->{
			a.setFirstName(user.getFirstName());
			a.setLastName(user.getLastName());
			userRepository.save(a);
			redirect.addFlashAttribute("resp", "Success - Update successful");
		});
		return "redirect:/profile";
	}
	
	@PostMapping("search")
	public String search(@RequestParam String keyword, Model model) {
		model.addAttribute("page", "Admin");
		List<Users> users = userRepository.searchUser(keyword);
		if(users.isEmpty()) {
			model.addAttribute("msg", "No match found");
		} else {
			model.addAttribute("list", users);
			model.addAttribute("msg", users.size() + " found.");
		}
		return "admin";
	}
	
	@PostMapping("customSearchUser")
	public String customSearchUser(@RequestParam String email, @RequestParam String name, Model model) {
		model.addAttribute("page", "Admin");
		List<Users> users = userRepository.customSearchUser(name, email);
		if(users.isEmpty()) {
			model.addAttribute("msg", "No match found");
		} else {
			model.addAttribute("list", users);
			model.addAttribute("msg", users.size() + " found.");
		}
		return "admin";
	}

}
