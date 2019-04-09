package com.withstars.service.forum.impl;

import com.withstars.dao.forum.LoginLogMapper;
import com.withstars.domain.forum.LoginLog;
import com.withstars.service.forum.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginLogServiceImpl implements LoginLogService {

    @Autowired
    public LoginLogMapper loginLogDao;

    public boolean addLog(LoginLog log) {

        if(loginLogDao.insert(log)>0){
            return true;
        }else {
            return false;
        }
    }
}
