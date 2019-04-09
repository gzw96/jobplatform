<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2019/2/26
  Time: 22:05
  To change this template use File | Settings | File Templates.
--%>
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


    <script src="/js/highlight.min.js"></script>
    <script src="/js/jquery-3.2.1.js"></script>
    <script src="/js/bootstrap.min.js"></script>


    <title>${topic.title} - Genesis </title>
</head>
<body>
<!-- 引入header文件 -->
<%@ include file="header.jsp" %>
<div style="width: 70%;margin:1% 2% 1% 5%;float: left;">

    <%--登录用户可回帖--%>
<c:if test="${!empty userId}">

        <div class="panel panel-default" id="main">
            <div class="panel-heading" style="background-color: white">
                添加一条新回复
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <form action="/forum/reply/addOthers" method="post">
                        <input type="hidden" name="topicId" value="${topicId}">

                        <input type="hidden" name="replyUserId" value="${userId}">

                        <input type="hidden" name="fatherCommentId" value="${fatherCommentId}">

                        <script>console.log(${topicId});console.log(${userId});console.log(${fatherCommentId});</script>
                        <%--添加一个父评论的id--%>
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
<!-- 侧边栏，版规 -->
<div class="panel panel-default" id="sidebar1" style="width: 20%;margin:1% 2% 1% 0%;float: right">
    <div class="panel-heading" style="background-color: white;text-align: center">
        回复请注意
    </div>
    <ul class="list-group" style="width: 100%">

        <li class="list-group-item">禁止发布时政、军事、民生、恐暴、金融等相关敏感内容</li>
        <li class="list-group-item">不得讨论违禁的色情话题</li>
        <li class="list-group-item">不得讨论黄、赌、毒内容</li>
        <li class="list-group-item">不得对他人进行人身攻击</li>
        <li class="list-group-item">不允许任何形式的广告</li>
        <li class="list-group-item">不得发布任何以商业推广为目的的网站链接</li>


    </ul>
</div>

<!-- 引入footer文件 -->
<%@ include file="footer.jsp" %>


</body>
</html>

