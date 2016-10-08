<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String oaflowIds =request.getParameter("oaflowIds");
	com.whir.ezoffice.ezcard.bd.EzcardBD bd =new com.whir.ezoffice.ezcard.bd.EzcardBD();
	boolean ret =false;
	try {
		ret =bd.updateEzCardStatusByOaflowId(oaflowIds);
	} catch (Exception e) {
		e.printStackTrace();
	}
	if(ret){
		out.print("正常");
		com.whir.evo.weixin.bd.WeiXinBD  weixinbd=new  com.whir.evo.weixin.bd.WeiXinBD();
		List list =bd.getEzCardInfoByOaFlowId(Long.valueOf(oaflowIds));
		if(list !=null && list.size() >0){
			Object[] obj =(Object[])list.get(0);
			String userId =obj[1]==null?"":obj[1].toString();
			if(!"".equals(userId)){
				weixinbd.sendMsg(userId,"新订购提醒：您申请的名片，已被审批！请耐心等待，可在订单状态中查询。","",null,null,"ezcard",null);
			}
		}
	}else{
		out.print("失败");
	}
%>
</html>