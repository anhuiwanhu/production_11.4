<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.ezform.ui.*"%>
<%@ include file="/public/include/init.jsp"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String formCode = request.getParameter("formCode");
String subTable = request.getParameter("subTable");
String fields = request.getParameter("fields");
String fieldShow = request.getParameter("fieldShow");
String fieldType = request.getParameter("fieldType");
String[] fieldArr = new String[0];
if(fields!=null){
    if(fields.endsWith(",")){
        fields = fields.substring(0, fields.length()-1);
        fieldArr = fields.split(",");
    }
}
if(fieldShow!=null){
    if(fieldShow.endsWith(",")){
        fieldShow = fieldShow.substring(0, fieldShow.length()-1);
    }
}
if(fieldType!=null){
    if(fieldType.endsWith(",")){
        fieldType = fieldType.substring(0, fieldType.length()-1);
    }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>导入</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%@ include file="/public/include/meta_base.jsp"%>
	</head>
	<body class="Pupwin">
    <div class="BodyMargin_10">
        <div class="_docBoxNoPanel">
        <br/>
		<div align="center"><P><font color="#3366CC">请选择要导入的excel文件</font></p></div>
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		<center>
		<form id="upFileFrm" name="upFileFrm" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/platform/custom/ezform/run/imp/uploadSubData.jsp?path=customform&col=<%=fieldArr.length%>&fieldShow=<%=fieldShow%>&fieldType=<%=fieldType%>" target="target_upload" onsubmit="return checkFile('.xls');">
  			<tr>
     			<td align="center"><input type="file" id="fileUrl" name="fileUrl" style="height:24px;" size="40"/></td>
  			</tr>
  			<tr height=20>
    			<td><span id=sp style="display:none"><img src="<%=request.getContextPath()%>/images/load.gif"/></span></td>
  			</tr>
  			<tr>
     			<td align="center"><input type="hidden" name="continueUpload" value="0">
	 				<input NAME="submit" VALUE="导&nbsp;&nbsp;&nbsp;入" TYPE="submit" class="btnButton4font">&nbsp;
	 				<input NAME="reset" VALUE="退&nbsp;&nbsp;&nbsp;出" TYPE="button" onclick="window.close();" class="btnButton4font">
     			</td>
  			</tr>
  			<tr>
    			<td>&nbsp;</td>
  			</tr>
  			<tr>
    			<td align="center">
    			</td>
  			</tr>
		</form>
        <iframe name="target_upload" src="" style="width:1px;height:1px;border:0;visibility:hidden;float:right"></iframe>
		</center>
		</table>
        </div>
        </div>
	</body>
</html>
<script language="JavaScript">
<!--
<%
StringBuffer dataScripts = new StringBuffer("");
if(fieldShow != null){
    String[] fieldShowArr = fieldShow.split(",");
    UIData uidata = new UIData();
    for(int i=0; i<fieldShowArr.length; i++){
        if(",404,405,".indexOf(fieldShowArr[i]) != -1){
            String[][] retData = uidata.getDataArr(subTable, fieldArr[i], fieldShowArr[i], request);
            if(retData != null){
                dataScripts.append("\nvar data"+fieldShowArr[i]+"_"+fieldArr[i]+" = [");
                for(int j=0, jlen=retData.length; j<jlen; j++){
                    if(j > 0)dataScripts.append(",");
                    dataScripts.append("'"+retData[j][0]+"'");
                }
                dataScripts.append("];");
            }
        }
    }
}
%>
//比较数据
<%=dataScripts%>
function checkFile(type){
    var fileUrl = $('#fileUrl').val();
    if(fileUrl==''){
        return false;
    }

    var ext = fileUrl.lastIndexOf('.')!=-1?fileUrl.substring(fileUrl.lastIndexOf('.')):'';
    if(ext==''){
        alert('文件格式不正确');
        return false;
    }

    var t = type.split(',');
    for(var i=0; i<t.length; i++){
        if(t[i]==ext){
            return true;
        }
    }

    alert('请选择正确的文件格式');
    $('#fileUrl').val('');
    return false;
}

var form_p_wf_cur_ModifyField = "";
try{
    form_p_wf_cur_ModifyField = opener.document.getElementById("p_wf_cur_ModifyField").value;
}catch(e){}

var _f = '<%=fields%>';//导入字段
var _s = '<%=fieldShow%>';//显示方式
var _type = '<%=fieldType%>';//字段类型
//子表导入目前支持常用基本类型:单行文本、多行文本、单选、多选、下拉
//不支持导入选择组织、用户等，因涉及到隐藏值、显示值
function fillData(data){
    if(data){
        if(data.length>0){
            var _fArr = _f.split(",");
            var _sArr = _s.split(",");
            var parentDoc = opener.document;
            var _subTable = replaceDollar('<%=subTable%>');//.replace(/\$/igm,'\\$');

            var _subTableTR = null;//$('#'+_subTable+'TR', parentDoc);
            if($.browser.msie){
                _subTableTR = opener.document.getElementsByName("<%=subTable%>TR");
            }else{
                _subTableTR = $('#'+_subTable+'TR', parentDoc);
            }
            var _subTableTR_first = _subTableTR[0];
            //var _subTableTR_last = _subTableTR[_subTableTR.length-1];
            opener.currentRow = _subTableTR_first;//opener.document.getElementsByName('<%=subTable%>TR')[opener.document.getElementsByName('<%=subTable%>TR').length-1];

            var rowLen = _subTableTR.length;
            
            for(var i=0; i<data.length; i++){

                var _index = rowLen + i;
                if(rowLen > 1){
                    _index += 1;
                }
                var _ind = _index - 1; //alert(_index+"--"+_ind);
                if(_index > 1){// || i>0){
                    opener.addRow(_index - 1, false);
                }else{
                   _ind = 0;
                   var TRID = opener.currentRow.id;
                   if(TRID && _subTableTR_first && _subTableTR_first.style.display=='none'){
                       _subTableTR_first.style.display='';
                   }
                }

                var dataObj = data[i];
                for(var j=0,m=_sArr.length; j<m; j++){
                    if(form_p_wf_cur_ModifyField.indexOf('$'+_fArr[j]+'$')==-1)continue;//不可编辑
                    var dv = dataObj[j];
                    if(_sArr[j]!=''){
                        if('103'==_sArr[j]){//单选
                            var new_component_ = parentDoc.getElementsByName('new_component_'+_fArr[j])[_ind].value;
                            var opt = parentDoc.getElementsByName(_fArr[j]+new_component_);
                            for(var k=0,n=opt.length; k<n; k++){
								opt[k].checked=false;
							}
							for(var k=0,n=opt.length; k<n; k++){
								if(dv!=''&&dv==opt[k].value){
									opt[k].checked=true;
								}
							}

                        }else if('105'==_sArr[j] || '402'==_sArr[j]){//下拉
                            var flag = false;
                            if(parentDoc.getElementsByName(_fArr[j])[_ind].options){//可写
                                var opt = parentDoc.getElementsByName(_fArr[j])[_ind].options;
                                for(var k=0,n=opt.length; k<n; k++){
                                    if(opt[k].text==dv){
                                        opt[k].selected=true;
                                        flag = true;
                                        break;
                                    }
                                }
                                if(flag==false)opt[0].selected=true;
                            }

						}else if('104'==_sArr[j]){//多选
							var new_component_ = parentDoc.getElementsByName('new_component_'+_fArr[j])[_ind].value;
							var opt = parentDoc.getElementsByName(_fArr[j]+new_component_);
							for(var k=0,n=opt.length; k<n; k++){
								opt[k].checked=false;
							}
							for(var k=0,n=opt.length; k<n; k++){
								if(dv!=''&&(","+dv+",").indexOf(","+opt[k].value+",")!=-1){
									opt[k].checked=true;
								}
							}

                        }else if('404'==_sArr[j]){//单选弹出
                            if(parentDoc.getElementsByName(_fArr[j])[_ind]){
                                var tmpVal = dv!=""?dv.replace(/\r|\n/gm,""):"";
                                try{
                                    var compareData = eval('data'+_sArr[j]+'_'+_fArr[j]);
                                    if(compareData){
                                        for(var k=0, klen=compareData.length; k<klen; k++){
                                            if(compareData[k] == tmpVal){
                                                parentDoc.getElementsByName(_fArr[j])[_ind].value=tmpVal;
                                                break;
                                            }
                                        }
                                    }
                                }catch(e){}
                            }

                        }else if('405'==_sArr[j]){//多选弹出
                            if(parentDoc.getElementsByName(_fArr[j])[_ind]){
                                var tmpVal = dv!=""?dv.replace(/\r|\n/gm,""):"";
                                var retVal = '';
                                try{
                                    var compareData = eval('data'+_sArr[j]+'_'+_fArr[j]);
                                    if(compareData){
                                        for(var k=0, klen=compareData.length; k<klen; k++){
                                            if((","+tmpVal+",").indexOf(","+compareData[k]+",")!=-1 && (","+retVal+",").indexOf(","+compareData[k]+",") == -1){
                                                retVal += compareData[k] + ",";
                                            }
                                        }
                                    }
                                }catch(e){}                                
                                parentDoc.getElementsByName(_fArr[j])[_ind].value=retVal;
                            }

                        }else{
                           if(parentDoc.getElementsByName(_fArr[j])[_ind]){
								var opt = parentDoc.getElementById(_fArr[j]);
								var optType = parentDoc.getElementsByName(_fArr[j]+"_type")[0].value;
								var decnum = opt.getAttribute("decnum");
								if(optType=="number"){
									if(decnum!=undefined){//浮点型
										if(dv.indexOf(".")!=-1){
											var dvs = dv.split(".");	
											dvs[1] = dvs[1].substring(0,decnum);
											dv = dvs[0]+"."+dvs[1];
										}
									}else{//整型
										if(dv.indexOf(".")!=-1){
											var dvs = dv.split(".");
											dv = dvs[0]
										}
									}
								}
                                parentDoc.getElementsByName(_fArr[j])[_ind].value=dv!=""?dv.replace(/\r|\n/gm,""):"";
                            }
                        }
                    }
                }
            }

            try{
                opener.batchInvoke();
            }catch(e){
                alert(e);
            }
        }
    }
}
//-->
</script>