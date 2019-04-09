<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<meta http-equiv="content-type" content="text/html;charset=UTF-8"/>
<head>

    <link rel="stylesheet" href="/front/resources/css/reset.css">
    <link rel="stylesheet" href="/front/bower_components/bootstrap/dist/css/bootstrap.min.css">


    <link href="/front/resources/css/home/lower-sidebar.css" rel="stylesheet" type="text/css">
    <link href="/front/resources/css/nav.css" rel="stylesheet" type="text/css">
    <link href="/front/resources/css/tooltipster.css" rel="stylesheet" type="text/css">
    <!-- 模板引擎 -->


    <script type="text/javascript" src="/front/bower_components/nivo-slider/jquery.nivo.slider.js"></script>

    <!-- 	自定义           -->


    <title></title>
</head>

<body>
<div id="wrapper">


    <div id="pic-news" class="pic-slider" style="background:#8f4439">
        <div class="banner">

            <a href="/front/home" target="_blank">
                <img src="/front/attached/home-news/2017-11-30/1512031957418_lower-header-bg.png" alt="">
            </a>
        </div>
    </div>
</div>

<div class="container">
    <div>
        <div class="pku-col-3">

            <!-- 左侧导航栏 start-->
            <div class="sidebar">
                <div>
                    <div class="sidebar-menu">
                        <div class="block-title">
                            <img src="/front/resources/images/pku-badge.png">
                            <div>校园招聘</div>
                        </div>
                        <div class="block-content">

                            <div class="sub-block">
                                <div class="s-heading clearfix">
                                    <img src="/front/resources/images/sub-circle.png">
                                    <div class="name">招聘信息</div>
                                    <div class="s-line"></div>
                                </div>
                                <ul class="sub-nav-list">
                                    <li><a class="accordion-inner" href="#">可在线投递岗位</a></li>

                                </ul>
                            </div>
                            <div class="sub-block">
                                <div class="s-heading clearfix">
                                    <img src="/front/resources/images/sub-circle.png">
                                    <div class="name">校园宣讲会</div>
                                    <div class="s-line"></div>
                                </div>
                                <ul class="sub-nav-list">
                                    <li>
                                        <a class="accordion-inner" href="/front/recruitList/presentation"
                                           style="">宣讲会信息
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
        <div class="main-content pku-col-9">
            <div class="header clearfix">
                <div class="category">校园招聘</div>
                <div class="nav">
                    <div class="clearfix">
                        <div class="breadcrumb-item  pull-left">&gt</div>
                        <div class="breadcrumb-item  pull-left">招聘信息如下</div>
                    </div>
                </div>
            </div>
            <div class="serch-form-panal">
                <form class="form-horizontal clearfix" role="form" method="post" id="serchForm"
                      onsubmit="return false;">
                    <input name="category" type="hidden" value="2"/>
                    <input name="industry" type="hidden" value=""/>
                    <input name="companyProperty" type="hidden" value=""/>
                    <input name="province" type="hidden" value=""/>
                    <input name="degree" type="hidden" value=""/>
                    <input name="specialty" type="hidden" value=""/>
                    <div class="serch-combobox-panal row clearfix">
                        <div class="search-box">
                            <div class="btn-group">
                                <input type="button" name="_industry"
                                       class="btn btn-danger dropdown-toggle dropdown-toggle-label" value="所有行业"
                                       data-toggle="dropdown" style="width: 100px"/>
                                <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
                                    <span class="caret"></span>
                                </button>

                                <ul id="industry" class="dropdown-menu" role="menu">
                                    <%--循环行业列表--%>
                                    <%--<c:forEach --%>
                                    <li class="type-industry">
                                        <input class="hidden-type" type="hidden" value="">
                                        <a href="javascript:void(0)" )">金融</a>
                                    </li>

                                    <%--循环行业列表--%>
                                </ul>
                            </div>
                        </div>

                        <div class="serch-input-group">
                            <input type="text" name="serchParam" id="serchParam" class="form-control serch-input"
                                   placeholder="请输入要查找的雇主或职位关键字">
                            <input class="btn serch-btn" type="button" id="serchBtn"/>
                        </div>
                    </div>
                </form>
            </div>
            <div>
                <table id="articleList" class="table tabel-border-bottom">
                    <tbody id="articleList-body">
                    <c:forEach items="${pageInfo.list}" var="recruitList" varStatus="status">
                        <tr>
                            <td style="width: 3%; text-align: right"><img class="list-style"
                                                                          src="/front/resources/images/home/list-sytle.png"/>
                            </td>
                            <td style="width: 67%; text-align: left;">
                                    <%--<span class="top-color">【置顶】</span>--%>
                                <a target="_blank"
                                   href="/front/recruitList/t/${pageInfo.list.get(status.index).id}">${pageInfo.list.get(status.index).title}</a>
                            </td>
                            <td style='width: 20%; text-align: center'>${pageInfo.list.get(status.index).localPublishTime}
                            </td>
                        </tr>
                    </c:forEach>
                    <%--<tr>--%>
                    <%--<td style="width: 3%; text-align: right"><img--%>
                    <%--class="list-style"--%>
                    <%--src="/front/resources/images/home/list-sytle.png"/>--%>
                    <%--</td>--%>
                    <%--<td style="width: 67%; text-align: left;">--%>

                    <%--<a target="_blank" href="/front/recruitList/recruitDetail">北京大学校园招聘宣讲活动行为规范</a>--%>
                    <%--</td>--%>
                    <%--<td style='width: 20%; text-align: center'>2018-10-22 10:27:21.0--%>
                    <%--</td>--%>
                    <%--</tr>--%>


                    </tbody>

                    <tfoot>
                    <tr>
                        <td style="text-align: center; border: none;" colspan="10">
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
                                    window.location.href = encodeURI('/front/recruitList?pageNum=' + pageNum);
                                });
                                //点击上一页
                                $('.prev').on('click', function () {
                                    var pageNum = parseInt($('.active').text()) - 1;

                                    window.location.href = encodeURI('/front/recruitList?pageNum=' + pageNum);

                                });
                                //点击下一页
                                $('.next').on('click', function () {
                                    var maxPageNum = ${pageInfo.pages};
                                    var pageNum = parseInt($('.active').text()) + 1;

                                    window.location.href = encodeURI('/front/recruitList?pageNum=' + pageNum);


                                });
                                //输入页数跳转
                                $('.jump-btn').on('click', function () {
                                    var maxPageNum = ${pageInfo.pages};
                                    var pageNum = parseInt($('.jump-ipt').val());
                                    window.location.href = encodeURI('/front/recruitList?pageNum=' + pageNum);
                                });
                            </script>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
</div>
<!-- /#wrapper -->


<!-- 引入footer文件 -->
<%@ include file="footer.jsp" %>


<!-- 模板引擎 -->
<script type="text/javascript" src="js-lib/template.js"></script>
<script type="text/javascript"
        src="resources/js/information/anchor-menu.js"></script>


<script type="text/javascript" src="/front/js-lib/template.js"></script>
<script type="text/javascript" src="/front/bower_components/jquery/dist/jquery.min.js"></script>
<script type="text/javascript" src="/front/js-lib/bootstrap-3.2.0/js/bootstrap.min.js"></script>
</body>


</html>
