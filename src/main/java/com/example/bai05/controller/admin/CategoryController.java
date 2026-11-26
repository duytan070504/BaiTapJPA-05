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

import com.example.bai05.entity.Category;
import com.example.bai05.service.CategoryService;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping({ "", "/" })
    public String index() {
        return "redirect:/admin/categories/searchpaginated";
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

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
        Page<Category> resultPage;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryService.findAll(pageable);
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

        model.addAttribute("categoryPage", resultPage);
        return "admin/categories/list";
    }

    // ============ THÊM ============
    @GetMapping("/add")
    public String add(ModelMap model) {
        Category category = new Category();
        category.setStatus(true);
        model.addAttribute("category", category);
        model.addAttribute("isEdit", false);
        return "admin/categories/addOrEdit";
    }

    // ============ SỬA ============
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap model, RedirectAttributes ra) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isEmpty()) {
            ra.addFlashAttribute("message", "Category không tồn tại");
            return "redirect:/admin/categories/searchpaginated";
        }
        model.addAttribute("category", opt.get());
        model.addAttribute("isEdit", true);
        return "admin/categories/addOrEdit";
    }

    // ============ LƯU (thêm mới hoặc cập nhật) ============
    @PostMapping("/saveOrUpdate")
    public String saveOrUpdate(@ModelAttribute("category") Category category,
            ModelMap model, RedirectAttributes ra) {

        if (!StringUtils.hasText(category.getName())) {
            model.addAttribute("error", "Tên category không được để trống");
            model.addAttribute("isEdit", category.getId() != null);
            return "admin/categories/addOrEdit";
        }

        boolean isEdit = category.getId() != null;
        categoryService.save(category);
        ra.addFlashAttribute("message", isEdit ? "Cập nhật category thành công" : "Thêm category thành công");
        return "redirect:/admin/categories/searchpaginated";
    }

    // ============ XÓA ============
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes ra) {
        try {
            categoryService.deleteById(id);
            ra.addFlashAttribute("message", "Xóa category thành công");
        } catch (Exception e) {
            ra.addFlashAttribute("message", "Không thể xóa category này");
        }
        return "redirect:/admin/categories/searchpaginated";
    }
}
