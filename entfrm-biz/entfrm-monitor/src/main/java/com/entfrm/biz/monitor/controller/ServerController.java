package com.entfrm.biz.monitor.controller;

import com.entfrm.biz.monitor.server.Server;
import com.entfrm.base.api.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 服务器监控
 *
 * @author yong
 */
@RestController
@RequestMapping("/monitor/server")
public class ServerController {

    @GetMapping()
    public R getInfo() throws Exception {
        Server server = new Server();
        server.copyTo();
        return R.ok(server);
    }
}
