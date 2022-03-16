package com.wxtwxt.junit;

import com.wxtwxt.mapper.EmpMapper;
import com.wxtwxt.pojo.Emp;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author Wxt
 * @create 2022-03-08 19:22
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MVCTest {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testCRUD() {
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5) + "" + i;
            String email = uid + "@126.com";
            mapper.insert(new Emp(null, uid, 23, "男", email, 1));
        }
        System.out.println("插入成功");
    }
    @Test
    public void testSelectEmpAndDept() {
        Emp emp = empMapper.selectByPrimaryKeyWithDept(1);
        System.out.println(emp);
    }

}
