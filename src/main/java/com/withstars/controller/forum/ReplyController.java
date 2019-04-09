package com.withstars.controller.forum;

import com.withstars.domain.forum.Reply;
import com.withstars.service.forum.impl.ReplyServiceImpl;
import com.withstars.service.forum.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 回复相关控制类
 */
@Controller
public class ReplyController {

    @Autowired
    public ReplyServiceImpl replyService;
    @Autowired
    public UserServiceImpl userService;


    @RequestMapping(value = "/forum/reply/replyOthers")
    public ModelAndView addReplyOthers(HttpServletRequest request, HttpSession session,
                                       @RequestParam("fatherCommentId") String fatherCommentId,
                                       @RequestParam("topicId") String topicId,
                                       ModelAndView modelAndView) throws UnsupportedEncodingException {
        //处理参数
        request.setCharacterEncoding("utf-8");
        modelAndView.addObject("fatherCommentId",fatherCommentId);
        modelAndView.addObject("topicId",topicId);
        Integer uid=(Integer) session.getAttribute("userId");
        modelAndView.addObject("userId",uid);

        modelAndView.setViewName("forum/reply");

        return modelAndView;
    }

    /**
     * 添加评论
     */
    @RequestMapping(value = "/forum/reply/add",method = RequestMethod.POST)
    public ModelAndView addReply(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        //处理参数
        request.setCharacterEncoding("utf-8");
        Integer topicId=Integer.parseInt(request.getParameter("topicId"));
        Integer replyUserId=Integer.parseInt(request.getParameter("replyUserId"));

        String content=request.getParameter("content");

        //创建reply
        Reply reply=new Reply();
        reply.setTopicId(topicId);
        reply.setReplyUserId(replyUserId);
        reply.setContent(content);
        //reply.setFatherReplyId(replyUserId);
        reply.setCreateTime(new Date());
        reply.setUpdateTime(new Date());
        reply.setNotice(0);
        //执行添加
        boolean ifSucc=replyService.addReply(reply);
        //添加积分
        boolean ifSuccAddCredit=userService.addCredit(1,replyUserId);

        //新建视图
        ModelAndView view=new ModelAndView("redirect:/forum/t/"+topicId);
        return view;
    }

    /**
     * 添加评论de回复
     */
    @RequestMapping(value = "/forum/reply/addOthers",method = RequestMethod.POST)
    public ModelAndView addReplyOthers(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        //处理参数
        request.setCharacterEncoding("utf-8");
        Integer topicId=Integer.parseInt(request.getParameter("topicId"));
        Integer replyUserId=Integer.parseInt(request.getParameter("replyUserId"));
        Integer fatherCommentId=Integer.parseInt(request.getParameter("fatherCommentId"));
        String content=request.getParameter("content");

        //创建reply
        Reply reply=new Reply();
        reply.setTopicId(topicId);
        reply.setReplyUserId(replyUserId);
        reply.setContent(content);
        reply.setFatherReplyId(fatherCommentId);
        reply.setNotice(0);//0未读，1已读
        reply.setCreateTime(new Date());
        reply.setUpdateTime(new Date());
        //执行添加
        boolean ifSucc=replyService.addReplyWithFather(reply);
        //添加积分
        boolean ifSuccAddCredit=userService.addCredit(1,replyUserId);

//        //查询出父回复的用户名
//        String fatherReplyUsername;
//        fatherReplyUsername = replyService.getFatherReplyUsername(fatherCommentId);


        //新建视图
        ModelAndView view=new ModelAndView("redirect:/forum/t/"+topicId);
//        view.addObject("fatherCommentUser",fatherReplyUsername);
        return view;
    }


    @Autowired
    private HttpServletRequest request;
    @RequestMapping(value ="/forum/reply/upload",method=RequestMethod.POST)
    @ResponseBody
    public Object UpLoadImg(@RequestParam(value="myFileName")MultipartFile mf) {
        String realPath = request.getSession().getServletContext().getRealPath("static/img/avatar");//待解决
        System.out.println(realPath);
        //获取源文件
        String filename = mf.getOriginalFilename();
        System.out.println("文件名"+filename);
        String[] names=filename.split("\\.");//
        System.out.println("文件名"+names.toString());
        String tempNum=(int)(Math.random()*100000)+"";
        String uploadFileName=tempNum +System.currentTimeMillis()+"."+names[names.length-1];
        File targetFile = new File (realPath,uploadFileName);//目标文件

        //开始从源文件拷贝到目标文件

        //传图片一步到位
        try {
            mf.transferTo(targetFile);
        } catch (IllegalStateException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        Map<String, String> map = new HashMap<String, String>();
        map.put("data","http://localhost:8080/img/avatar/"+uploadFileName);//这里应该是项目路径
        return map;//将图片地址返回
    }
}
