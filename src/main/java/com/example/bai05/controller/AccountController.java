package com.example.bai05.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import com.example.bai05.entity.User;
import com.example.bai05.service.UserService;

@Controller
public class AccountController {

    @Autowired
    private UserService userService;

    // ================= ĐĂNG KÝ =================
    @GetMapping("/register")
    public String registerForm() {
        return "web/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam(required = false) String fullname,
            @RequestParam(required = false) String email,
            ModelMap model) {

        model.addAttribute("username", username);
        model.addAttribute("fullname", fullname);
        model.addAttribute("email", email);

        if (!StringUtils.hasText(username) || !StringUtils.hasText(password)) {
            model.addAttribute("error", "Vui lòng nhập tên đăng nhập và mật khẩu");
            return "web/register";
        }
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu nhập lại không khớp");
            return "web/register";
        }
        if (userService.existsByUsername(username)) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại");
            return "web/register";
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password); // service se ma hoa BCrypt
        user.setFullname(fullname);
        user.setEmail(email);
        user.setAdmin(false);
        user.setActive(true);
        userService.save(user);

        return "redirect:/login?registered";
    }

    // ================= ĐĂNG NHẬP =================
    @GetMapping("/login")
    public String loginForm(@RequestParam(required = false) String registered, ModelMap model) {
        if (registered != null) {
            model.addAttribute("message", "Đăng ký thành công, hãy đăng nhập");
        }
        return "web/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            ModelMap model) {

        Optional<User> opt = userService.findByUsername(username);

        if (opt.isEmpty() || !userService.checkPassword(opt.get(), password)) {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
            model.addAttribute("username", username);
            return "web/login";
        }
        User user = opt.get();
        if (!user.isActive()) {
            model.addAttribute("error", "Tài khoản đã bị khóa");
            return "web/login";
        }

        session.setAttribute("currentUser", user);
        return user.isAdmin() ? "redirect:/admin/home" : "redirect:/";
    }

    // ================= ĐĂNG XUẤT =================
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
