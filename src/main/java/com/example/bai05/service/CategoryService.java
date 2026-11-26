package com.example.bai05.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.bai05.entity.Category;

public interface CategoryService {

    Page<Category> findAll(Pageable pageable);

    Page<Category> findByNameContaining(String keyword, Pageable page);

    Optional<Category> findById(Long id);

    Category save(Category category);

    void deleteById(Long id);

    long count();
}
