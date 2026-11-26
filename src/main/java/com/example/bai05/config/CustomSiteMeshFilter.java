package com.example.bai05.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder
            // Decorator mặc định cho trang web
            .addDecoratorPath("/*", "web.jsp")
            // Decorator riêng cho khu vực admin và các trang con
            .addDecoratorPath("/admin/**", "admin.jsp")
            // Decorator cho trang đăng nhập / đăng ký
            .addDecoratorPath("/login*", "login.jsp")
            .addDecoratorPath("/login/*", "login.jsp")
            .addDecoratorPath("/register*", "login.jsp")
            // Không áp dụng SiteMesh cho tài nguyên tĩnh và API
            .addExcludedPath("/static/**")
            .addExcludedPath("/api/**");
    }
}