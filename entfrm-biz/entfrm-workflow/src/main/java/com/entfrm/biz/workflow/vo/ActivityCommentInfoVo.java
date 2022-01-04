package com.entfrm.biz.workflow.vo;

import cn.hutool.core.util.StrUtil;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.enums.ExtendMessage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

/**
 * <p>
 * 任务备注信息
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-13
 */
@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class ActivityCommentInfoVo {

    /** 操作名称 */
    private String mesName;

    /** 操作编码 */
    private String mesCode;

    /** 操作级别 */
    private String mesLevel;

    /** 任务备注 */
    private String message;

    /** 获取组合备注 */
    public String getCombinationMessage(){
        return this.mesName + WorkflowConstant.EXTEND_MESSAGE + this.message;
    }

    /** 设置组合备注 */
    public void setCombinationMessage(String message){
        if(StrUtil.isBlank(message) || !message.contains(WorkflowConstant.EXTEND_MESSAGE)){
            this.setMessage (message);
        }else{
            String[] list=message.split(WorkflowConstant.EXTEND_MESSAGE);
            if(list.length > 1){
                this.setMesName(list[0]);
                this.setMessage(list[1]);
            }else{
                this.setMesName(list[0]);
                this.setMessage("");
            }
        }
    }

    public void setMesCode(String mesCode){
        this.mesCode = mesCode;
        this.mesLevel = ExtendMessage.getMesLevel(mesCode);
    }

    /** 设置扩展信息 */
    public void setExtendMessage(String extendMessage){
        if(extendMessage.startsWith(WorkflowConstant.COMMENT_TYPE_PREFIX)){
            this.mesCode = extendMessage.substring(WorkflowConstant.COMMENT_TYPE_PREFIX.length());
            this.mesLevel = ExtendMessage.getMesLevel(mesCode);
        }
    }

    /** 获取扩展信息 */
    public String getExtendMessage(){
        return WorkflowConstant.COMMENT_TYPE_PREFIX + this.mesCode;
    }

}
