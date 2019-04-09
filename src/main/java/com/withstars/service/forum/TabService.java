package com.withstars.service.forum;

import com.withstars.domain.forum.Tab;

import java.util.List;

public interface TabService {
    List<Tab> getAllTabs();

    Tab getByTabNameEn(String tabName);
}
