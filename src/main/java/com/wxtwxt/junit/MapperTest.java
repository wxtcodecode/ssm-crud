package com.wxtwxt.junit;

import com.github.pagehelper.PageInfo;
import com.wxtwxt.pojo.Emp;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Request;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.DefaultMockMvcBuilder;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author Wxt
 * @create 2022-03-08 19:56
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/resources/dispatcherServlet-servlet.xml"})
public class MapperTest {
    //传入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求
    MockMvc mockMvc;
    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo<Emp> pageInfo = (PageInfo<Emp>) request.getAttribute("pageInfo");
        //当前页码
        System.out.println("当前页码:" + pageInfo.getPageNum());
        //总页码
        System.out.println("总页码:" + pageInfo.getPages());
        //总记录数
        System.out.println("总记录数:" + pageInfo.getTotal());
        //在页面上连续显示的页码
        System.out.print("在页面上连续显示的页码 【");
        int[] pages = pageInfo.getNavigatepageNums();
        for (int page : pages) {
            System.out.print(" " + page + " ");
        }
        System.out.println("】");
        List<Emp> list = pageInfo.getList();
        System.out.println(list);
    }
}
