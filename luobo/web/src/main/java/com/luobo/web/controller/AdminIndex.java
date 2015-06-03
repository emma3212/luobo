package com.luobo.web.controller;

import com.luobo.common.annotation.Module;
import com.luobo.common.enums.ModuleEnums;
import com.luobo.web.spring.AbstractController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author:liaom
 * @Time: 2015/6/2 16:41.
 */

@Controller
@Module(value = ModuleEnums.AdminHome)
@RequestMapping(value = "admin")
public class AdminIndex extends AbstractController {
    @RequestMapping(value = "index")
    public String index(){
        return "admin/index/home_home";
    }
}
