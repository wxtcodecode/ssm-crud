package com.wxtwxt.controller;

import com.wxtwxt.pojo.Dept;
import com.wxtwxt.pojo.Msg;
import com.wxtwxt.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Wxt
 * @create 2022-03-09 9:18
 */
@Controller
public class DeptController {
    @Autowired
    private DeptService deptService;
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getAllDepts() {
        List<Dept> depts = deptService.getAllDept();
        return Msg.success().add("depts", depts);
    }
}
