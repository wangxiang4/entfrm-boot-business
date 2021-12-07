package com.entfrm.base.util;

import cn.hutool.core.util.StrUtil;
import com.entfrm.base.config.GlobalConfig;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.context.i18n.LocaleContextHolder;

import java.text.MessageFormat;
import java.util.Locale;

/**
 * @author yong
 * @date 2020/3/18
 * @description 国际化util
 */
public class MessageUtil {

    private static MessageSource messageSource = (MessageSource) SpringContextUtil.getBean("messageSource");

    public static String getText(String code, String... params) {
        if (StrUtil.isBlank(code)) {
            return code;
        } else {
            Locale locale = Locale.CHINA;

            try {
                locale = new Locale(GlobalConfig.getLang());
            } catch (IllegalArgumentException iaEx) {
                ;
            }
            try {
                return messageSource.getMessage(code, params, locale);
            } catch (NoSuchMessageException var5) {
                return params != null && params.length > 0 ? (new MessageFormat(code != null ? code : "", LocaleContextHolder.getLocale())).format(params) : code;
            }
        }
    }
}
