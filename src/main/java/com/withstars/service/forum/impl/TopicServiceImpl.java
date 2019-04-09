package com.withstars.service.forum.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.withstars.dao.forum.TopicMapper;
import com.withstars.domain.forum.Topic;
import com.withstars.service.forum.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    public TopicMapper topicDao;

    //获取全部主题
    public List<Topic> getAllTopics() {
        return topicDao.getAllTopics();
    }

    @Override
    public PageInfo<Topic> selectTopicList(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Topic> list = topicDao.listTopicsAndUsers();
        PageInfo<Topic> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    //获取指定id主题
    public Topic selectById(Integer id) {
        Topic topic=topicDao.selectById(id);
        return topic;
    }

    @Override
    public PageInfo<Topic> selectTabTopicList(Integer pageNum, Integer pageSize,Integer id) {
        PageHelper.startPage(pageNum, pageSize);
        List<Topic> list = topicDao.listTopicsAndUsersOfTab(id);
        PageInfo<Topic> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    public List<Topic> listMostCommentsTopics() {
        return topicDao.listMostCommentsTopics();
    }

    public boolean addTopic(Topic topic) {
        return topicDao.insert(topic)>0;
    }

    public boolean clickAddOne(Integer id) {
        return topicDao.clickAddOne(id)>0;
    }

    public int getTopicsNum() {
        return topicDao.getTopicsNum();
    }

    @Override
    public int getUnreadTopicsReplyNum(Integer userId) {
        return topicDao.getUnreadTopicsReplyNum(userId);
    }

    @Override
    public int getUnreadReplyNum(Integer userId) {
        return topicDao.getUnreadReplyNum(userId);
    }

    @Override
    public List<Topic> getUnreadTopics(Integer userId) {
        return topicDao.getUnreadTopics(userId);
    }

    public List<Topic> listTopicsAndUsers() {
        return topicDao.listTopicsAndUsers();
    }

    public List<Topic> listTopicsAndUsersOfTab(Integer tabId) {
        return topicDao.listTopicsAndUsersOfTab(tabId);
    }

}
