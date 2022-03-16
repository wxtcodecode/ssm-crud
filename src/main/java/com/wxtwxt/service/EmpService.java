package com.wxtwxt.service;

import com.wxtwxt.mapper.EmpMapper;
import com.wxtwxt.pojo.Emp;
import com.wxtwxt.pojo.EmpExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Wxt
 * @create 2022-03-08 19:12
 */
@Service
public class EmpService {
    @Autowired
    private EmpMapper empMapper;
    /**
     * 批量删除员工
     */
    public void deleteBatch(List<Integer> list) {
        EmpExample example = new EmpExample();
        example.createCriteria().andEidIn(list);
        empMapper.deleteByExample(example);
    }
    /**
     * 根据id删除员工
     */
    public void deleteEmp(Integer id) {
        empMapper.deleteByPrimaryKey(id);
    }
    /**
     * 更新员工信息
     */
    public void updateEmp(Emp emp) {
        empMapper.updateByPrimaryKeySelective(emp);
    }
    /**
     * 根据id查询员工信息
     */

    public Emp getEmpById(int id) {
        Emp emp = empMapper.selectByPrimaryKey(id);
        return emp;
    }
    /**
     * 检查员工姓名是否可用
     */
    public boolean checkEmpName(String empName) {
        EmpExample example = new EmpExample();
        example.createCriteria().andEmpNameEqualTo(empName);
        int count = empMapper.countByExample(example);
        return count == 0;
    }
    /**
     * 保存所有员工
     */
    public void saveEmp(Emp emp) {
        empMapper.insert(emp);
    }
    /**
     * 查询所有员工
     */
    public List<Emp> getEmps() {
        EmpExample example = new EmpExample();
        example.setOrderByClause("eid");
        List<Emp> emps = empMapper.selectByExampleWithDept(example);
        return emps;
    }
}
