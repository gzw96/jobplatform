package com.withstars.service.forum.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.withstars.dao.forum.ReplyMapper;
import com.withstars.domain.forum.Reply;
import com.withstars.service.forum.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    public ReplyMapper replyDao;

    public List<Reply> getRepliesOfTopic(Integer topicId) {
        return replyDao.getRepliesOfTopic(topicId);
    }

    @Override
    public PageInfo<Reply> selectRoleList(Integer pageNum, Integer pageSize, Integer topicId) {
        PageHelper.startPage(pageNum, pageSize);
        List<Reply> list = replyDao.getRepliesOfTopic(topicId);
        PageInfo<Reply> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }


    public boolean addReply(Reply reply) {
        return replyDao.insert(reply)>0;
    }

    public boolean addReplyWithFather(Reply reply) {
        return replyDao.insertWithFather(reply)>0;
    }

    public int repliesNum(Integer topicId) {
        return replyDao.getRepliesNum(topicId);
    }

    @Override
    public String getFatherReplyUsername(Integer fatherReplyId) {
        return replyDao.getFatherReplyUsername(fatherReplyId);
    }

    @Override
    public List<Reply> getFatherName(Integer topicId) {
        return replyDao.getFatherName(topicId);
    }

    @Override
    public List<Reply> getUnreadReply(Integer userId) {
        return replyDao.getUnreadReply(userId);
    }

    @Override
    public boolean updateUnreadReply(Long id) {
        return replyDao.updateUnreadReply(id);
    }

    @Override
    public List<Reply> getOwnTopicsReply(Integer userId) {
        return replyDao.getOwnTopicsReply(userId);
    }

    @Override
    public List<Reply> getOwnReply(Integer userId) {
        return replyDao.getOwnReply(userId);
    }

    @Override
    public Integer getFloor(Integer topicId, Long id) {
        return  replyDao.getFloor(topicId,id);
    }


}
