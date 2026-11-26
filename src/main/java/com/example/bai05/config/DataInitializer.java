package com.example.bai05.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.bai05.entity.User;
import com.example.bai05.repository.UserRepository;

@Configuration
public class DataInitializer {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Tao san tai khoan admin: admin / admin123
    @Bean
    CommandLineRunner initAdmin(UserRepository userRepository, PasswordEncoder encoder) {
        return args -> {
            if (!userRepository.existsByUsername("admin")) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(encoder.encode("admin123"));
                admin.setFullname("Quản trị viên");
                admin.setEmail("admin@example.com");
                admin.setAdmin(true);
                admin.setActive(true);
                userRepository.save(admin);
            }
        };
    }
}
