package com.example.bai05.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.bai05.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    Page<Category> findByNameContaining(String keyword, Pageable page);
}
