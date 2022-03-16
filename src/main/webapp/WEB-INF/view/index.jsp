<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wangxiaotong
  Date: 2022/3/8
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("basePath",request.getContextPath());
    %>
    <script src="${basePath}/static/js/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="${basePath}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="${basePath}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button type="button" class="btn btn-primary">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>id</th>
                    <th>empName</th>
                    <th>age</th>
                    <th>sex</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${requestScope.pageInfo.list}" var="list">
                <tr>
                    <td>${list.eid}</td>
                    <td>${list.empName}</td>
                    <td>${list.age}</td>
                    <td>${list.sex}</td>
                    <td>${list.email}</td>
                    <td>${list.dept.deptName}</td>
                    <td>
                        <button type="button" class="btn btn-primary">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                        </button>
                        <button type="button" class="btn btn-danger">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                        </button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前${requestScope.pageInfo.pageNum}页,
            共有${requestScope.pageInfo.pages}页,
            总计${requestScope.pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${basePath}/emps?pageNum=1">首页</a>
                    </li>
                    <c:if test="${requestScope.pageInfo.isFirstPage}">
                        <li class="disabled">
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!requestScope.pageInfo.isFirstPage}">
                        <li>
                            <a href="${basePath}/emps?pageNum=${requestScope.pageInfo.pageNum + 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${requestScope.pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum == requestScope.pageInfo.pageNum}">
                            <li class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if test="${pageNum != requestScope.pageInfo.pageNum}">
                            <li><a href="${basePath}/emps?pageNum=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${requestScope.pageInfo.isLastPage}">
                        <li class="disabled">
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                   <c:if test="${!requestScope.pageInfo.isLastPage}">
                       <li>
                           <a href="${basePath}/emps?pageNum=${requestScope.pageInfo.pageNum + 1}" aria-label="Next">
                               <span aria-hidden="true">&raquo;</span>
                           </a>
                       </li>
                   </c:if>
                    <li><a href="${basePath}/emps?pageNum=${requestScope.pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
