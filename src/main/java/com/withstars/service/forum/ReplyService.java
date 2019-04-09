package com.withstars.service.forum;

import com.github.pagehelper.PageInfo;

import com.withstars.domain.forum.Reply;

import java.util.List;

public interface ReplyService {

    List<Reply> getRepliesOfTopic(Integer topicId);

    PageInfo<Reply> selectRoleList(Integer pageNum, Integer pageSize,Integer topicId);

    boolean addReply(Reply reply);

    boolean addReplyWithFather(Reply reply);

    int repliesNum(Integer topicId);

    String getFatherReplyUsername(Integer fatherReplyId);

    List<Reply> getFatherName(Integer topicId);


    List<Reply> getUnreadReply(Integer userId);

    boolean updateUnreadReply(Long id);

    List<Reply> getOwnTopicsReply(Integer userId);

    List<Reply> getOwnReply(Integer userId);

    Integer getFloor(Integer topicId, Long id);

}
