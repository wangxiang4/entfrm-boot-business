package com.entfrm.auth.handler;

import com.entfrm.data.handler.BaseMetaObjectHandler;
import com.entfrm.security.util.SecurityUtil;
import org.springframework.stereotype.Component;

/**
 * @author entfrm
 * @date 2019/8/10
 * @description 公共字段填充
 */
@Component
public class EntfrmMetaObjectHandler extends BaseMetaObjectHandler {

    @Override
    protected Object getUserName() {
        try {
            return SecurityUtil.getUser().getUsername();
        } catch (Exception e) {
            return "";
        }
    }
}
