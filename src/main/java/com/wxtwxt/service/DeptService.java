package com.wxtwxt.service;

import com.wxtwxt.mapper.DeptMapper;
import com.wxtwxt.pojo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Wxt
 * @create 2022-03-09 9:19
 */
@Service
public class DeptService {
    @Autowired
    private DeptMapper deptMapper;

    /**
     * 查询所有部门信息
     * @return
     */
    public List<Dept> getAllDept() {
        List<Dept> depts = deptMapper.selectByExample(null);
        return depts;
    }
}
