package com.wxtwxt.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wxtwxt.pojo.Emp;
import com.wxtwxt.pojo.Msg;
import com.wxtwxt.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Wxt
 * @create 2022-03-08 19:10
 */
@Controller
public class EmpController {
    @Autowired
    private EmpService empService;
    /**
     * 删除员工信息
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if(ids.contains("-")) {
            String[] str_ids = ids.split("-");
            ArrayList<Integer> list = new ArrayList<>();
            for (String strId : str_ids) {
                int parseInt = Integer.parseInt(strId);
                list.add(parseInt);
            }
           empService.deleteBatch(list);
           return Msg.success();
        }else {
            int parseInt = Integer.parseInt("ids");
            empService.deleteEmp(parseInt);
            return Msg.success();
        }
    }
    /**
     * 根据员工id更新员工信息
     */
    @RequestMapping(value = "/emp/{eid}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Emp emp) {
        empService.updateEmp(emp);
        return Msg.success();
    }
    /**
     * 根据员工id查询员工信息
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@PathVariable Integer id) {
        Emp emp = empService.getEmpById(id);
        return Msg.success().add("emp", emp);
    }
    /**
     * 检验用户名是否可用
     */
    @RequestMapping(value = "/checkUser")
    @ResponseBody
    public Msg checkEmpName(@RequestParam("empName") String empName) {
        //1.先判断用户名是否合法
        String regEmpName = "(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regEmpName)) {
            return Msg.fail().add("msg", "用户名必须是2-5位中文或6-16位字母数字的组合");
        }else {
            boolean b = empService.checkEmpName(empName);
            if(b) {
                return Msg.success();
            }else {
                return Msg.fail().add("msg", "用户名已存在");
            }
        }
    }

    /**
     * 保存员工信息
     * JSR303校验
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emp emp, BindingResult result) {
       if(result.hasErrors()) {
           Map<String,Object> map = new HashMap<>();
           List<FieldError> errors = result.getFieldErrors();
           for (FieldError error : errors) {
               map.put(error.getField(), error.getDefaultMessage());
           }
           return Msg.fail().add("errorFields", map);
       }else {
           empService.saveEmp(emp);
           return Msg.success();
       }
    }
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNo",defaultValue = "1")Integer pageNo){
        PageHelper.startPage(pageNo, 5);
        List<Emp> emps = empService.getEmps();
        PageInfo<Emp> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo",pageInfo);
    }


    /**
     * 查询员工数据(分页查询)
     */
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum, Model model) {
//        PageHelper.startPage(pageNum, 5);
//        List<Emp> emps = empService.getEmps();
//        PageInfo<Emp> pageInfo = new PageInfo<>(emps, 5);
//        model.addAttribute("pageInfo", pageInfo);
//        return "index";
//    }
}
