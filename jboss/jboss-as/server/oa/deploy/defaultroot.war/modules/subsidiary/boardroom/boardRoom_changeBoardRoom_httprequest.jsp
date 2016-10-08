<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.boardroom.bd.BoardRoomBD"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomPO"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomEquipmentPO"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

String boardroomId = request.getParameter("boardroomId");

String userId = session.getAttribute("userId").toString(); //取当前用户的ID

String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();

BoardRoomBD bd = new BoardRoomBD();
BoardRoomPO boardRoomPO = new BoardRoomPO();
boardRoomPO = bd.selectBoardroom(new Long(boardroomId));
String nr="";
String isVideo="";
String maxNumber="";
String emphasis="";
String addr = "";
if (boardRoomPO != null) {
	isVideo = boardRoomPO.getIsVideo() + "";
	maxNumber = boardRoomPO.getMaxNumber() + "";
	emphasis = boardRoomPO.getEmphasis() + "";
	addr = boardRoomPO.getWorkaddress()+"";
}
if(addr.equals("null")){
	addr="";
}
nr+="isVideo@@"+isVideo;
if(isVideo.equals("1")){
	nr+="##points@@<input type=\"text\" name=\"points\" maxlength=\"10\" value=\"0\" id=\"points\" class=\"inputText\" style=\"width:94.7%;\" whir-options=\"vtype:['p_integer_e','notempty',{'maxLength':10}]\"/><input type=\"hidden\" name=\"maxNumber\" value=\""+maxNumber+"\" id=\"maxNumber\"/><span class=\"mustFillSpan\"><input type=\"hidden\" name=\"mustWrite\" value=\"points\"><label class=MustFillColor>*</label></span><br><span style=\"color:red;\" id=\"pointsTip\">该会议室最大支持"+maxNumber+"点</span>";
}else{
	nr+="##addr@@<textarea id='addr' name='addr' rows='1' maxlength='750'  class='flowInput formInputarea autoHeight'  onblur='checkSize(this);'  onmouseout='setStyle(this, event);'  onmouseover='setStyle(this, event);'  isSubTableField='false' >"+addr+"</textarea><span class=\"mustFillSpan\"><input type=\"hidden\" name=\"mustWrite\" value=\"addr\"><label class=MustFillColor>*</label></span>";
}
String bdEqu="";
Set equSet = boardRoomPO == null ? null : boardRoomPO.getBoardRoomEquipment();
if (equSet != null) {
	Iterator iter = equSet.iterator();
	BoardRoomEquipmentPO po = null;
	if (iter.hasNext()) {
		while (iter.hasNext()) {
			po = (BoardRoomEquipmentPO) iter.next();
			bdEqu+="<input type=\"checkbox\" name=\"bdEqu\"  value=\""+po.getEquId()+"\">"+po.getEquName()+" <input type=\"hidden\" name=\"bdEquName\" value=\""+po.getEquName()+"\">";
		}
	}
	bdEqu+="<input type=\"hidden\" name=\"boardEquipment\" value=\"\" id=\"boardEquipment\"/>";
}
nr+="##bdEqu@@"+bdEqu;
//System.out.println("+++++nr:"+nr);
out.print(nr);
%>
