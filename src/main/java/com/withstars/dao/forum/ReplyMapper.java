package com.withstars.dao.forum;

import com.withstars.domain.forum.Reply;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReplyMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Reply record);

    int insertWithFather(Reply record);


    int insertSelective(Reply record);

    Reply selectByPrimaryKey(Long id);

    String getFatherReplyUsername(Integer fatherReplyId);

    List<Reply> getRepliesOfTopic(Integer topicId);

    List<Reply> getFatherName(Integer topicId);

    int updateByPrimaryKeySelective(Reply record);

    int updateByPrimaryKeyWithBLOBs(Reply record);

    int updateByPrimaryKey(Reply record);

    int getRepliesNum(Integer topicId);

    List<Reply> getUnreadReply(Integer userId);

    boolean updateUnreadReply(Long id);

    List<Reply> getOwnTopicsReply(Integer userId);

    List<Reply> getOwnReply(Integer userId);

    Integer getFloor(@Param("topicId") Integer topicId, @Param("id") Long id);

}