package com.withstars.service.forum;

import com.withstars.domain.forum.LoginLog;

public interface LoginLogService {


    /**
     * 插入一条登录日志
     */
    boolean addLog(LoginLog log);
}
