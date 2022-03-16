package com.wxtwxt.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用返回json的类
 * @author Wxt
 * @create 2022-03-08 20:47
 */
public class Msg {
    //状态码
    private Integer code;
    //提示消息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String,Object> map = new HashMap<>();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }

    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理成功");
        return msg;
    }
    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理失败");
        return msg;
    }
    public Msg add(String key,Object value) {
        this.getMap().put(key, value);
        return this;
    }
}
