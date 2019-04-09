package com.withstars.controller.forum;

import com.withstars.domain.forum.Reply;
import com.withstars.domain.forum.Tab;
import com.withstars.domain.forum.Topic;
import com.withstars.domain.forum.User;
import com.withstars.service.forum.impl.ReplyServiceImpl;
import com.withstars.service.forum.impl.TabServiceImpl;
import com.withstars.service.forum.impl.TopicServiceImpl;
import com.withstars.service.forum.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 主控制类
 */
@Controller
public class MainController {

    @Autowired
    public TopicServiceImpl topicService;
    @Autowired
    public ReplyServiceImpl replyService;
    @Autowired
    public UserServiceImpl userService;
    @Autowired
    public TabServiceImpl tabService;

    /**
     * 进入登录页面.
     */
    @RequestMapping(value = {"/forum/signin"})
    public ModelAndView signin(){
        ModelAndView signinPage=new ModelAndView("forum/signin");

        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        signinPage.addObject("topicsNum",topicsNum);
        signinPage.addObject("usersNum",usersNum);
        return  signinPage;
    }

    /**
     * 进入注册页面.
     */
    @RequestMapping("/forum/signup")
    public ModelAndView signup(){
        ModelAndView signupPage=new ModelAndView("forum/signup");

        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        signupPage.addObject("topicsNum",topicsNum);
        signupPage.addObject("usersNum",usersNum);
        return  signupPage;
    }

    /**
     * 进入新建主题页面
     */
    @RequestMapping(value = {"/forum/new"})
    public ModelAndView newTopic(){
        ModelAndView newTopicPage=new ModelAndView("forum/new");
        List<Tab> tabs=tabService.getAllTabs();

        //获取统计信息
        int topicsNum=topicService.getTopicsNum();
        int usersNum=userService.getUserCount();

        newTopicPage.addObject("tabs",tabs);
        newTopicPage.addObject("topicsNum",topicsNum);
        newTopicPage.addObject("usersNum",usersNum);
        return  newTopicPage;
    }

    /**
     * 获取未读帖子列表
     */
    @RequestMapping(value = {"/forum/getUnread"})
    public ModelAndView getUnread(HttpSession session,@RequestParam(value="userId") Integer userId){
        ModelAndView unreadMessage=new ModelAndView("forum/unread");
        //获取到自己的有未读信息的帖子
        Integer user = (Integer) session.getAttribute("userId");
        unreadMessage.addObject("userId",user);

        List<Topic> hotestTopics=topicService.listMostCommentsTopics();
        unreadMessage.addObject("hotestTopics",hotestTopics);

        User user1=userService.getUserById(userId);
        unreadMessage.addObject("user",user1);

        List<Topic> unreadTopic = topicService.getUnreadTopics(userId);

        unreadMessage.addObject("unreadTopic",unreadTopic);

        List<Reply> unreadReply = replyService.getUnreadReply(userId);

        unreadMessage.addObject("unreadReply",unreadReply);


        //处理回复，设置notice字段为1，为已读

        List<Long> idList = new ArrayList<Long>();
        List<Long> idList1 = new ArrayList<Long>();

        List<Reply> ownTopicsReply = replyService.getOwnTopicsReply(user);

        for (int i = 0; i < ownTopicsReply.size(); i++) {
            idList.add(i,ownTopicsReply.get(i).getId());
        }

        for (int i = 0; i < idList.size(); i++) {
            replyService.updateUnreadReply(idList.get(i));
        }


        List<Reply> ownReply = replyService.getOwnReply(user);
        for (int i = 0; i < ownReply.size(); i++) {
            idList1.add(i,ownReply.get(i).getId());
        }

        for (int i = 0; i < idList1.size(); i++) {
            replyService.updateUnreadReply(idList1.get(i));
        }


        List<Integer> floorList = new ArrayList<Integer>();
        Integer floorTopicId;
        Long floorId;
        for (int i = 0; i < ownReply.size(); i++) {
            floorTopicId = ownReply.get(i).getTopicId();
            floorId = ownReply.get(i).getId();
            floorList.add(i,replyService.getFloor(floorTopicId,floorId)/5);
        }

        unreadMessage.addObject("floorList",floorList);



        return  unreadMessage;
    }

    /**
     * 配置404页面
     */
    @RequestMapping("/forum/*")
    public String notFind(){
        return "forum/404";
    }
}
