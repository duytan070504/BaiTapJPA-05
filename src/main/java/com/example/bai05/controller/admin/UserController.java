package com.example.bai05.controller.admin;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import com.example.bai05.entity.User;
import com.example.bai05.service.UserService;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping({ "", "/" })
    public String index() {
        return "redirect:/admin/users/searchpaginated";
    }

    // ============ DANH SÁCH + TÌM KIẾM + PHÂN TRANG ============
    @RequestMapping("/searchpaginated")
    public String search(ModelMap model,
            @RequestParam(name = "name", required = false) String name,
            @RequestParam("page") Optional<Integer> page,
            @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(3);
        if (currentPage < 1) currentPage = 1;

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("username"));
        Page<User> resultPage;

        if (StringUtils.hasText(name)) {
            resultPage = userService.findByUsernameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = userService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("userPage", resultPage);
        return "admin/users/list";
    }

    // ============ THÊM ============
    @GetMapping("/add")
    public String add(ModelMap model) {
        User user = new User();
        user.setActive(true);
        model.addAttribute("user", user);
        model.addAttribute("isEdit", false);
        return "admin/users/addOrEdit";
    }

    // ============ SỬA ============
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap model, RedirectAttributes ra) {
        Optional<User> opt = userService.findById(id);
        if (opt.isEmpty()) {
            ra.addFlashAttribute("message", "User không tồn tại");
            return "redirect:/admin/users/searchpaginated";
        }
        User user = opt.get();
        user.setPassword(""); // khong hien hash ra form
        model.addAttribute("user", user);
        model.addAttribute("isEdit", true);
        return "admin/users/addOrEdit";
    }

    // ============ LƯU ============
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(@ModelAttribute("user") User user, ModelMap model, RedirectAttributes ra) {

        boolean isEdit = user.getId() != null;

        if (!StringUtils.hasText(user.getUsername())) {
            model.addAttribute("error", "Tên đăng nhập không được để trống");
            model.addAttribute("isEdit", isEdit);
            return "admin/users/addOrEdit";
        }

        if (isEdit) {
            User old = userService.findById(user.getId()).orElse(null);
            if (old == null) {
                ra.addFlashAttribute("message", "User không tồn tại");
                return "redirect:/admin/users/searchpaginated";
            }
            // de trong mat khau = giu nguyen mat khau cu
            if (!StringUtils.hasText(user.getPassword())) {
                user.setPassword(old.getPassword());
            }
            // khong cho doi username sang ten da co
            Optional<User> same = userService.findByUsername(user.getUsername());
            if (same.isPresent() && !same.get().getId().equals(user.getId())) {
                model.addAttribute("error", "Tên đăng nhập đã tồn tại");
                model.addAttribute("isEdit", true);
                return "admin/users/addOrEdit";
            }
        } else {
            if (!StringUtils.hasText(user.getPassword())) {
                model.addAttribute("error", "Mật khẩu không được để trống");
                model.addAttribute("isEdit", false);
                return "admin/users/addOrEdit";
            }
            if (userService.existsByUsername(user.getUsername())) {
                model.addAttribute("error", "Tên đăng nhập đã tồn tại");
                model.addAttribute("isEdit", false);
                return "admin/users/addOrEdit";
            }
        }

        userService.save(user);
        ra.addFlashAttribute("message", isEdit ? "Cập nhật user thành công" : "Thêm user thành công");
        return "redirect:/admin/users/searchpaginated";
    }

    // ============ XÓA ============
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, HttpSession session, RedirectAttributes ra) {
        User current = (User) session.getAttribute("currentUser");
        if (current != null && current.getId().equals(id)) {
            ra.addFlashAttribute("message", "Không thể tự xóa tài khoản đang đăng nhập");
            return "redirect:/admin/users/searchpaginated";
        }
        try {
            userService.deleteById(id);
            ra.addFlashAttribute("message", "Xóa user thành công");
        } catch (Exception e) {
            ra.addFlashAttribute("message", "Không thể xóa user này");
        }
        return "redirect:/admin/users/searchpaginated";
    }
}
