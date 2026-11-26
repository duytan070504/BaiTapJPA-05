package com.example.bai05.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.bai05.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class AdminHomeController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping({ "", "/", "/home" })
    public String home(ModelMap model) {
        model.addAttribute("totalCategories", categoryService.count());
        return "admin/home";
    }
}
