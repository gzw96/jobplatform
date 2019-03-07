<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="Genesis,论坛,社区,程序员">
    <title>Genesis - 未读信息  </title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/pagination.css">
    <link rel="stylesheet" type="text/css" href="/css/highlight.min.css" media="screen">
    <script src="/js/highlight.min.js"></script>
    <script src="/js/jquery-3.2.1.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <style>
        li {list-style-type:none;}
        html, body {
            height: 100%;
            font-size: 14px;
            color: #525252;
            font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
            background: #f0f2f5;
        }
        .footer {
            background-color: #fff;
            margin-top: 22px;
            margin-bottom: 22px;
            width: 100%;
            padding-top: 22px;
            color: #8A8A8A;
            display: block;
            height: 200px;
            border: 1px ;
            clear:both
        }

        .container {
            margin-right: 5%;
            margin-left: 5%;
            padding-left: 15px;
            padding-right: 15px;
            width: 40%;
            float: left;
        }
        .info {
            margin-right: 5%;
            width: 10%;
            float: left;
        }
        a{
            color: #8A8A8A;
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp"%>

<div class="panel panel-default" id="main" style="width: 70%;margin:1% 2% 5% 5%;float: left;">
    <c:if test="${!empty unreadTopic}">
        <div class="panel-heading" style="background-color: white">
            <strong style="font-size: 16px;color: rgba(130,108,116,0.93);margin-right: 2%">亲爱的${user.username},你所发的帖子有了新回复</strong>
        </div>
    </c:if>
    <c:if test="${empty unreadTopic and empty unreadTopic}">
        <div class="panel-heading" style="background-color: white;height: 450px">
            <strong style="font-size: 16px;color: rgba(130,108,116,0.93);margin-right: 2%;">暂无新回复…………</strong>
        </div>
    </c:if>



    <ul class="list-group" style="width: 100%">
        <c:forEach items="${unreadTopic}" var="topicList" varStatus="status">
            <li class="list-group-item">
                <div style="height: 50px">
                    <%--<div style="float: left;width: 6%;margin-bottom: 5px">--%>
                        <%--<img width="50px" height="50px" src="${unreadTopic.get(status.index).user.avatar}" class="img-rounded">--%>
                    <%--</div>--%>
                    <div style="width: 89%;float: left">
                        <a href="/t/${unreadTopic.get(status.index).id}">${unreadTopic.get(status.index).title}</a><br/>
                        <div>
                            <%--<a><span class="label label-default" >${unreadTopic.get(status.index).tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;--%>
                            <%--<a href="/member/${unreadTopic.get(status.index).user.username}"><span ><strong>${unreadTopic.get(status.index).user.username}</strong></span></a>&nbsp;&nbsp;&nbsp;--%>
                            <small class="text-muted">${unreadTopic.get(status.index).localCreateTime}</small>
                        </div>
                    </div>
                    <div style="width: 5%;float: right;text-align: center">
                        <span class="badge">${unreadTopic.get(status.index).countReplies}</span>
                    </div>
                </div>
            </li>
        </c:forEach>

    </ul>


<c:if test="${!empty unreadTopic}">

    <div class="panel-heading" style="background-color: #F0F2F5;border-color:#F0F2F5;">
        <strong style="font-size: 16px;color: rgba(130,108,116,0.93);margin-right: 2%"></strong>
    </div>

</c:if>

    <c:if test="${!empty unreadReply}">
        <div class="panel-heading" style="background-color: white">
            <strong style="font-size: 16px;color: rgba(130,108,116,0.93);margin-right: 2%">以下回复提到了你</strong>
        </div>

    </c:if>


    <ul class="list-group" style="width: 100%">
        <!-- 遍历评论 -->
        <c:forEach items="${unreadReply}" var="replyList" varStatus="status">
            <li class="list-group-item">
                    <%--<div style="height: 100px">--%>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                    <tr>
                        <td>
                            <div class="panel-group">
                                <div style="float: left;width: 6%;margin-bottom: 5px">
                                    <img width="50px" height="50px"
                                         src="${unreadReply.get(status.index).user.avatar}"
                                         class="img-rounded">
                                </div>
                                <div style="width: 89%;float: left;margin-left: 60px;margin-top: -60px">
                                    <a href="/member/${unreadReply.get(status.index).user.username}"><strong>${unreadReply.get(status.index).user.username}</strong></a>&nbsp;&nbsp;
                                    <small class="text-muted">${unreadReply.get(status.index).localCreateTime}
                                    </small>


                                    <br/>
                                    <div>
                                        <a href="/t/${unreadReply.get(status.index).topicId}?pageNum=${floorList.get(status.index)}">${unreadReply.get(status.index).content}</a>
                                    </div>
                                </div>
                            </div>



                        </td>
                    </tr>
                    </tbody>
                </table>
                    <%--</div>--%>
            </li>

        </c:forEach>


    </ul>



</div>

<!-- 引入侧边栏文件 -->
<c:if test="${empty userId}">
    <!-- 未登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <blockquote>
                Genesis
                <small>一个分享创造的开发者社区</small>
            </blockquote>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                <a  href="/signin" class="btn btn-primary btn-block">登录</a>
                <a  href="/signup" class="btn btn-default btn-block">注册</a>
            </li>
        </ul>
    </div>
</c:if>

<c:if test="${!empty userId}">
    <!-- 已登录 -->
    <div class="panel panel-default" id="sidebar2" style="width: 20%;margin:1% 2% 1% 0%;float: right">
        <div class="panel-heading" style="background-color: white;text-align: center">
            <a href="/member/${user.username}">${user.username}</a>
        </div>
        <ul class="list-group" style="width: 100%">
            <li class="list-group-item"><a href="/new">创作新主题</a></li>
            <li class="list-group-item"><a href="">积分:${user.credit}</a></li>
        </ul>
    </div>
</c:if>

<div class="panel panel-default" id="sidebar1" style="width: 20%;margin:1% 2% 1% 0%;float: right">
    <div class="panel-heading" style="background-color: white;text-align: center">
        本周热议主题
    </div>
    <ul class="list-group" style="width: 100%">
        <c:forEach items="${hotestTopics}" var="hotestTopic">
            <li class="list-group-item"><a href="/t/${hotestTopic.id}">${hotestTopic.title}</a></li>
        </c:forEach>
    </ul>
</div>


<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>
