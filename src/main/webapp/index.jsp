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
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">age</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="age" id="age_update_input" placeholder="18">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select name="did" class="form-control" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10 empadd">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">age</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="age" id="age_add_input" placeholder="18">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10 empadd">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">sex</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id即可--%>
                            <select name="did" class="form-control" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>id</th>
                    <th>empName</th>
                    <th>age</th>
                    <th>sex</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalPage,nowPage;
   $(function () {
       to_page(1);
   })
    function to_page(pageNo) {
       $("#check_all").removeProp("checked");
        $.ajax({
           url:"${basePath}/emps",
           data:"pageNo=" + pageNo,
           type:"GET",
           success:function (result) {
               //1.解析并显示员工数据
               build_emps_table(result);
               //2.解析并显示分页信息
               build_page_info(result);
               //3.解析显示分页条数据
               build_page_nav(result);
           }
        });
    }
    function build_emps_table(result) {
       $("#emps_table tbody").empty();
        var emps = result.map.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var eidTd = $("<td></td>").append(item.eid);
            var empNameTd = $("<td></td>").append(item.empName);
            var ageTd = $("<td></td>").append(item.age);
            var sexTd = $("<td></td>").append(item.sex);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dept.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary edit_btn").append("<span></span>")
                            .addClass("glyphicon glyphicon-pencil").append("编辑");
            editBtn.attr("edit_id",item.eid);
            var delBtn = $("<button></button>").addClass("btn btn-danger del_btn").append("<span><span>")
                            .addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.attr("del_id",item.eid);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkTd).append(eidTd).append(empNameTd).append(ageTd).
                            append(sexTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
        });
    }
    function build_page_nav(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.map.pageInfo.pageNum + "页,共有" + result.map.pageInfo.pages + "页,总计" + result.map.pageInfo.total + "条记录");
        totalPage = result.map.pageInfo.total;
        nowPage = result.map.pageInfo.pageNum;
    }
    function build_page_info(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页")).attr("href","#");
        var prePageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
        if(result.map.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
               to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.map.pageInfo.pageNum - 1);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.map.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.map.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }else {
                numLi.click(function () {
                    to_page(item);
                });
            }
            ul.append(numLi);
        });
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.map.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.map.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.map.pageInfo.pages);
            });
        }
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    function reset_form(ele) {
       $(ele)[0].reset();
       //清空表单样式
       $(ele).find(".empadd").removeClass("has-error has-success");
       $(ele).find(".help-block").text("");
    }
    $("#emp_add_modal_btn").click(function () {
        //清空表单数据
        reset_form("#empAddModal form");
        //发送Ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //点击新增按钮，弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
   function getDepts(ele) {
       $(ele).empty();
       $.ajax({
          url:"${basePath}/depts",
          type: "GET",
          success:function (result) {
              $.each(result.map.depts,function (index,item) {
                  var optionEle = $("<option></option>").append(item.deptName).attr("value",item.did);
                  optionEle.appendTo(ele);
              });
          }
       });
   }
    function validate_add_form() {
        //1.先获取要校验的数据,使用正则表达式
        var empName = $("#empName_add_input").val();
        var regEmpName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regEmpName.test(empName)) {
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位的汉字或6-16位的字母或数字");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        }
        var email = $("#email_add_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(email)) {
            //应该清空这个元素之前的样式
            show_validate_msg("#email_add_input","error","邮箱格式错误");
            return false;
        }else {
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }
    function show_validate_msg(ele,status,msg) {
        //清除当前元素的检验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //校验用户名是否可用
   $("#empName_add_input").change(function () {
       var empName = $("#empName_add_input").val();
       $.ajax({
           url:"${basePath}/checkUser",
           data:"empName=" + empName,
           type:"POST",
           success:function (result) {
                if(result.code == 200) {
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax_va","success");
                }else {
                    show_validate_msg("#empName_add_input","error",result.map.msg);
                    $("#emp_save_btn").attr("ajax_va","error");
                }
           }
       })
   })
    $("#emp_save_btn").click(function () {
       //1.将模态框中的填写的表单数据提交给服务器进行保存
        //对提交的数据进行校验
        if(!validate_add_form()) {
            return false;
        }
        if($(this).attr("ajax_va") == "error") {
            return false;
        }
        //发送ajax请求保存员工
        $.ajax({
            url:"${basePath}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if(result.code == 200) {
                    //1.关闭模态框
                    $("#empAddModal").modal("hide");
                    //2.跳转到最后一页
                    to_page(totalPage);
                }else {
                    if(undefined != result.map.errorFields.email) {
                        show_validate_msg("#email_add_input","error",result.map.errorFields.email);
                    }
                    if(undefined != result.map.errorFields.empName) {
                        show_validate_msg("#empName_add_input","error",result.map.errorFields.empName);
                    }
                }
            }
        })
    });
   $(document).on("click",".edit_btn",function() {
       //查询员工信息，显示员工信息
       //查询部门信息，显示部门信息
       getDepts("#empUpdateModal select");
       getEmps($(this).attr("edit_id"));
       //把员工id传递给模态框的修改按钮
       $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
       //弹出模态框
       $("#empUpdateModal").modal({
           backdrop: "static"
       });
   });
   function getEmps(id) {
       $.ajax({
           url:"${basePath}/emp/" + id,
           type:"GET",
           success:function(result) {
               var empData = result.map.emp;
               $("#emp_update_static").text(empData.empName);
               $("#age_update_input").val(empData.age);
               $("#email_update_input").val(empData.email);
               $("#empUpdateModal input[name=sex]").val([empData.sex]);
               $("#empUpdateModal select").val([empData.did]);
           }
       });
   }
   //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱格式是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(email)) {
            show_validate_msg("#email_update_input","error","邮箱格式不合法");
            return false;
        }else {
            show_validate_msg("#email_update_input","success","");
        }
        //发送ajax请求，保存更新的员工数据
        $.ajax({
           url:"${basePath}/emp/" + $(this).attr("edit_id"),
           type:"POST",
           data:$("#empUpdateModal form").serialize() + "&_method=PUT",
           success:function () {
               //1.关闭对话框，回到本页面
               $("#empUpdateModal").modal("hide");
               to_page(nowPage);
           }
        });
    });
   $(document).on("click",".del_btn",function () {
       var empName = $(this).parents("tr").find("td:eq(2)").text();
       var eid = $(this).attr("del_id");
       if(confirm("您确定要删除【" + empName + "】吗?")) {
           $.ajax({
               url:"${basePath}/emp/" + eid,
               type:"DELETE",
               success:function() {
                   to_page(nowPage);
               }
           });
       }
   });
   //全选/全不选
   $("#check_all").click(function () {
      //attr获取checked时undefined
      //prop获取dom原生的属性，attr获取自定义的属性
      $(".check_item").prop("checked",$(this).prop("checked"));
   });
   $(document).on("click",".check_item",function() {
      //1.判断当前选中的元素是否选满
      var flag = $(".check_item:checked").length == $(".check_item").length;
      $("#check_all").prop("checked",flag);
   });
   //点击删除，批量删除
    $("#emp_delete_all_btn").click(function () {
       var empNames = "";
       var empIds = "";
       $.each($(".check_item:checked"),function () {
           empNames = empNames + $(this).parents("tr").find("td:eq(2)").text() + ",";
           empIds = empIds + $(this).parents("tr").find("td:eq(1)").text() + "-";
       });
       empNames.substr(0,empNames.length - 1);
       empIds.substr(0,empIds.length - 1);
       if(empNames == "") {
           alert("您还没有选择员工!!!");
           return false;
       }
       if(confirm("您确定要删除【" + empNames + "】吗?")) {
           $.ajax({
               url:"${basePath}/emp/" + empIds,
               type:"DELETE",
               success:function () {
                   to_page(nowPage);
               }
           })
       }
    });
</script>
</body>
</html>





