package com.entfrm.biz.workflow.vo;

import cn.hutool.core.util.StrUtil;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.enums.ExtendMessage;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * <p>
 * 任务内容评论数据封装Vo
 * 节点状态存放评论中,可以通过分割取出
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-13
 */

@Data
@Accessors(chain = true)
public class TaskCommentInfoVo {

    /** 操作按钮编码 */
    private String type;

    /** 历史记录的类型 */
    private String commentType;

    /** 操作按钮文字 */
    private String status;

    /** 任务意见 */
    private String message;

    /** status + '_FLOW_ACTION_' + message */
    private String fullMessage;

    /** 显示级别 info danger success */
    private String level;


    public static final String prefix = "COMMENT_";


    public String getFullMessage(){
        return this.status + WorkflowConstant.WORK_FLOW_ACTION+this.message;
    }


    public void setFullMessage(String fullMessage){
        if(StrUtil.isBlank(fullMessage) || !fullMessage.contains(WorkflowConstant.WORK_FLOW_ACTION)){
            this.setMessage (fullMessage);
        }else{
            String[] list=fullMessage.split(WorkflowConstant.WORK_FLOW_ACTION);
            if(list.length > 1){
                this.setStatus (list[0]);
                this.setMessage (list[1]);
            }else{
                this.setStatus(list[0]);
                this.setMessage ("");
            }
        }
    }

    public void setType(String type){
        this.type = type;
        this.level = ExtendMessage.getLevel (type);
    }

    public void setCommentType(String commentType){
        if(commentType.startsWith (prefix)){
            this.type = commentType.substring(prefix.length());
            this.level = ExtendMessage.getLevel (type);
        }
    }

    public String getCommentType(){
        return prefix+type;
    }

}
