package com.example.bai05.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.example.bai05.entity.User;

public interface UserService {

    Page<User> findAll(Pageable pageable);

    Page<User> findByUsernameContaining(String keyword, Pageable page);

    Optional<User> findById(Long id);

    Optional<User> findByUsername(String username);

    boolean existsByUsername(String username);

    /** Luu user; tu dong ma hoa mat khau neu la mat khau moi. */
    User save(User user);

    void deleteById(Long id);

    boolean checkPassword(User user, String rawPassword);
}
