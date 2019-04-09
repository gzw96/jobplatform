package com.withstars.dao.forum;

import com.withstars.domain.forum.Topic;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Topic record);

    int insertSelective(Topic record);

    Topic selectById(Integer id);

    List<Topic> listTopicsAndUsers();

    List<Topic> listTopicsAndUsersOfTab(Integer tabId);

    List<Topic>  listMostCommentsTopics();

    List<Topic> getUnreadTopics(Integer userId);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKeyWithBLOBs(Topic record);

    int updateByPrimaryKey(Topic record);

    List<Topic> getAllTopics();

    int clickAddOne(Integer id);

    //获取主题总数
    int getTopicsNum();

    int getUnreadTopicsReplyNum(Integer userId);
    
    int getUnreadReplyNum(Integer userId);
}