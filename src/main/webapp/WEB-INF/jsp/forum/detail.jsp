<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/pagination.css">
    <link rel="stylesheet" href="/css/jquery-ui.min.css">
    <link rel="stylesheet" type="text/css" href="/css/highlight.min.css" media="screen">

    <style>
        .w-e-toolbar {
            flex-wrap: wrap;
        }

    </style>
    <script src="/js/highlight.min.js"></script>
    <script src="/js/jquery-3.2.1.js"></script>
    <script src="/js/bootstrap.min.js"></script>


    <title>${topic.title} - Genesis </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp" %>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">
    <div class="panel panel-default" id="main" style="">
        <div class="panel-heading" style="background-color: white">
            <div>
                <div class="panel-heading" style="background-color: white">
                    <a href="/">Genesis</a> › 主题
                </div>
                <h3>${topic.title}</h3><br/>
                <div>
                    <a href="/forum/member/${topic.user.username}"><span><strong>${topic.user.username}</strong></span></a>&nbsp;&nbsp;
                    <small class="text-muted">${topic.localCreateTime}&nbsp;&nbsp;&nbsp;</small>&nbsp;&nbsp;
                    <small class="text-muted">${topic.click}次点击</small>
                </div>
            </div>

            <div style="float: right;margin-top: -100px">
                <img width="50px" height="50px" src="${topic.user.avatar}" class="img-rounded">
            </div>
        </div>
        `

        <ul class="list-group" style="width: 100%">
            <li class="list-group-item">
                ${topic.content}
            </li>
        </ul>
    </div>

    <c:if test="${!empty replies}">
        <div class="panel panel-default" id="main" style="">
            <div class="panel-heading" style="background-color: white">
        <span>
                ${fn:length(replies)} 回复  |  直到 <c:forEach items="${replies}" var="reply" varStatus="status">

            <c:if test="${status.last}">
                ${reply.localCreateTime}
            </c:if>
        </c:forEach>
    </span>
            </div>

            <ul class="list-group" style="width: 100%">
                <!-- 遍历评论 -->
                <c:forEach items="${pageInfo.list}" var="replyList" varStatus="status">
                    <li class="list-group-item">
                            <%--<div style="height: 100px">--%>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                            <tr>
                                <td>
                                    <div class="panel-group">
                                        <div style="float: left;width: 6%;margin-bottom: 5px">
                                            <img width="50px" height="50px"
                                                 src="${pageInfo.list.get(status.index).user.avatar}"
                                                 class="img-rounded">
                                        </div>
                                        <div style="width: 89%;float: left;margin-left: 60px;margin-top: -60px">
                                            <a href="/forum/member/${pageInfo.list.get(status.index).user.username}"><strong>${pageInfo.list.get(status.index).user.username}</strong></a>&nbsp;&nbsp;
                                            <small class="text-muted">${pageInfo.list.get(status.index).localCreateTime}
                                            </small>
                                            <a href="/forum/reply/replyOthers?fatherCommentId=${pageInfo.list.get(status.index).id}&topicId=${topic.id}">&nbsp;<strong>回复</strong></a>

                                            <br/>
                                            <div>

                                                <c:forEach items="${fatherReplyUsers}" var="fatherReplyList" varStatus="status1">
                                                    <c:if test="${pageInfo.list.get(status.index).fatherReplyId == fatherReplyUsers.get(status1.index).fatherReplyId}">
                                                        <p>回复 <strong>${fatherReplyUsers.get(status1.index).user.username}</strong>：</p>
                                                    </c:if>
                                                </c:forEach>
                                                    ${pageInfo.list.get(status.index).content}
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


            <div class="m-style M-box"></div>
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
                    window.location.href = encodeURI('/forum/t/${topic.id}?pageNum=' + pageNum);
                });
                //点击上一页
                $('.prev').on('click', function () {
                    var pageNum = parseInt($('.active').text()) - 1;
                    if (pageNum >= 1) {
                        window.location.href = encodeURI('/forum/t/${topic.id}?pageNum=' + pageNum);
                    }

                });
                //点击下一页
                $('.next').on('click', function () {
                    var maxPageNum = ${pageInfo.pages};
                    var pageNum = parseInt($('.active').text()) + 1;
                    if (pageNum <= maxPageNum) {
                        window.location.href = encodeURI('/forum/t/${topic.id}?pageNum=' + pageNum);
                    }
                });
                //输入页数跳转
                $('.jump-btn').on('click', function () {
                    var maxPageNum = ${pageInfo.pages};
                    var pageNum = parseInt($('.jump-ipt').val());
                    if (pageNum != null & pageNum <= maxPageNum & pageNum >= 1) {
                        window.location.href = encodeURI('/forum/t/${topic.id}?pageNum=' + pageNum);
                    }
                });
            </script>


        </div>
    </c:if>

    <%--登录用户可回帖--%>
    <c:if test="${!empty user}">

        <div class="panel panel-default" id="main" style="">
            <div class="panel-heading" style="background-color: white">
                添加一条新回复
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <form action="/forum/reply/add" method="post">
                        <input type="hidden" name="topicId" value="${topic.id}">
                        <input type="hidden" name="replyUserId" value="${user.id}">

                        <div id="div1">

                        </div>
                        <textarea id="text1" hidden="true" name="content"></textarea>

                        <script src="https://unpkg.com/wangeditor/release/wangEditor.min.js"></script>
                        <script type="text/javascript">

                            var E = window.wangEditor
                            var editor = new E('#div1')
                            var $text1 = $('#text1')
                            editor.customConfig.onchange = function (html) {
                                // 监控变化，同步更新到 textarea
                                $text1.val(html)
                            }//把编辑器内容同步到隐藏的textarea

                            //图片上传
                            editor.customConfig.uploadImgServer = '/forum/reply/upload'; //上传URL
                            editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
                            editor.customConfig.uploadImgMaxLength = 5;
                            editor.customConfig.uploadFileName = 'myFileName';
                            editor.customConfig.uploadImgHooks = {
                                customInsert: function (insertImg, result, editor) {
                                    // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
                                    // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

                                    // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
                                    var url = result.data;
                                    insertImg(url);

                                    // result 必须是一个 JSON 格式字符串！！！否则报错
                                }
                            }

                            editor.create()
                            editor.customConfig.customAlert = function (info) {
                                // info 是需要提示的内容
                                alert('自定义提示：' + info)
                            }
                            // 初始化 textarea 的值
                            $text1.val(editor.txt.html())


                            function getContent() {
                                var text = editor.txt.html();
                                var text1 = "<p><br></p>";
                                //alert(text);
                                if (text.trim() == text1.trim()) {
                                    alert("回复内容为空，请认真回复哦(*^▽^*)");
                                    return false;
                                }
                                else {
                                    return true;
                                }
                            }

                        </script>
                        <br/>


                        <input style="width: 48px;" type="submit" class="btn btn-danger btn-sm" value="回复"
                               id="submitText" onclick="return getContent()">

                    </form>
                </div>

            </div>
        </div>
    </c:if>

</div>
<!-- 引入侧边栏文件 -->
<%@ include file="side.jsp" %>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp" %>


</body>
</html>
