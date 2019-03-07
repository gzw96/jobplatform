<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="Content-Type"  content="text/html;charset=utf-8">
    <meta name="keywords" content="Genesis,论坛,社区,程序员">
    <title>Genesis - 一个分享创造的开发者社区  </title>
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
    <div class="panel-heading" style="background-color: white">
        <a style="margin-right: 2%">论坛首页</a>
    </div>

<%--<ul class="list-group" style="width: 100%">--%>
    <%--<c:forEach items="${topics}" var="topic">--%>
    <%--<li class="list-group-item">--%>
        <%--<div style="height: 50px">--%>
            <%--<div style="float: left;width: 6%;margin-bottom: 5px">--%>
                <%--<img width="50px" height="50px" src="${topic.user.avatar}" class="img-rounded">--%>
            <%--</div>--%>
            <%--<div style="width: 89%;float: left">--%>
                <%--<a href="/t/${topic.id}">${topic.title}</a><br/>--%>
                <%--<div>--%>
                    <%--<a><span class="label label-default" >${topic.tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;--%>
                    <%--<a href="/member/${topic.user.username}"><span ><strong>${topic.user.username}</strong></span></a>&nbsp;&nbsp;&nbsp;--%>
                    <%--<small class="text-muted">${topic.localCreateTime}</small>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div style="width: 5%;float: right;text-align: center">--%>
                <%--<span class="badge">${topic.countReplies}</span>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</li>--%>
    <%--</c:forEach>--%>

<%--</ul>--%>



    <ul class="list-group" style="width: 100%">
        <c:forEach items="${pageInfo.list}" var="topicList" varStatus="status">
            <li class="list-group-item">
                <div style="height: 50px">
                    <div style="float: left;width: 6%;margin-bottom: 5px">
                        <img width="50px" height="50px" src="${pageInfo.list.get(status.index).user.avatar}" class="img-rounded">
                    </div>
                    <div style="width: 89%;float: left">
                        <a href="/t/${pageInfo.list.get(status.index).id}">${pageInfo.list.get(status.index).title}</a><br/>
                        <div>
                            <a><span class="label label-default" >${pageInfo.list.get(status.index).tab.tabName}</span></a>&nbsp;&nbsp;&nbsp;
                            <a href="/member/${pageInfo.list.get(status.index).user.username}"><span ><strong>${pageInfo.list.get(status.index).user.username}</strong></span></a>&nbsp;&nbsp;&nbsp;
                            <small class="text-muted">${pageInfo.list.get(status.index).localCreateTime}</small>
                        </div>
                    </div>
                    <div style="width: 5%;float: right;text-align: center">
                        <span class="badge">${pageInfo.list.get(status.index).countReplies}</span>
                    </div>
                </div>
            </li>
        </c:forEach>

    </ul>

    <div id="pagination" class="m-style M-box"></div>

    <script src="/js/jquery.pagination.js"></script>

    <script>
        var pageNum = ${pageInfo.pageNum};
        var pages = ${pageInfo.pages};
        var pageSize = ${pageInfo.pageSize};

        $("#pagination").pagination({
            current: pageNum,
            pageCount: pages,
            showData: pageSize,

            homePage: "首页",
            endPage: "尾页",
            prevContent: "<",
            nextContent: ">",
            keepShowPN: "true",
            coping: "true",
            isHide: "true",
            jump: "true",
        });
        //点击页数
        $('[data-page]').on('click', function () {
            var pageNum = $(this).attr('data-page');
            if (window.location.pathname.indexOf("tab")<0){//判断是否是tab页面
                window.location.href = encodeURI('/${topic.id}?pageNum=' + pageNum);
            }else {
                window.location.href = encodeURI('/tab/${tab.tabNameEn}?pageNum=' + pageNum);
            }
        });
        //点击上一页
        $('.prev').on('click', function () {
            var pageNum = parseInt($('.active').text())-1;
            if(pageNum >= 1){
                if (window.location.pathname.indexOf("tab")<0){//判断是否是tab页面
                    window.location.href = encodeURI('/${topic.id}?pageNum=' + pageNum);
                }else {
                    window.location.href = encodeURI('/tab/${tab.tabNameEn}?pageNum=' + pageNum);
                }
            }

        });
        //点击下一页
        $('.next').on('click', function () {
            var maxPageNum = ${pageInfo.pages};
            var pageNum = parseInt($('.active').text())+1;
            if(pageNum <= maxPageNum){
                if (window.location.pathname.indexOf("tab")<0){//判断是否是tab页面
                    window.location.href = encodeURI('/${topic.id}?pageNum=' + pageNum);
                }else {
                    window.location.href = encodeURI('/tab/${tab.tabNameEn}?pageNum=' + pageNum);
                }
            }
        });
        //输入页数跳转
        $('.jump-btn').on('click', function () {
            var maxPageNum = ${pageInfo.pages};
            var pageNum = parseInt($('.jump-ipt').val());
            if(pageNum!=null & pageNum<=maxPageNum & pageNum>=1){
                window.location.href = encodeURI('/${topic.id}?pageNum=' + pageNum);
            }
        });
    </script>

</div>

<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp"%>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp"%>
</body>
</html>