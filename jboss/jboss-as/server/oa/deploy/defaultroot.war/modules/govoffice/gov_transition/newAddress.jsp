<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test="#parameters.view != null">查看地址簿</s:if><s:else><s:if test="groupPO.groupId != null">修改地址簿</s:if><s:if test="groupPO.groupId == null">新建地址簿</s:if></s:else></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->

</head>

<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="GovTrans!saveAddress.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
				 <input type=hidden name="groupPO.groupId" value="${param.groupId}"/>
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="地址簿名" width="100" class="td_lefttitle">  
                            地址簿名<span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="3"> 
						     <s:textarea name="groupPO.groupName"  whir-options="vtype:['notempty',{'maxLength':50}]" id="groupName" maxlength="100" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:94%;"></s:textarea>
                        </td>  
				
                    </tr>  
  
					<tr>  
                        <td for="单位名称" class="td_lefttitle">  
                            单位名称<span class="MustFillColor">*</span>：  
                        </td>  
                        <td  colspan="3" nowrap>
                            <s:hidden name="groupPO.groupOrgIds" id="groupOrgIds" />
							 <s:textarea name="groupPO.groupOrgNames" whir-options="vtype:['notempty']"  readonly="true" id="groupOrgNames" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:94%;"></s:textarea>
							<s:if test="#parameters.view == null"><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'groupOrgIds', allowName:'groupOrgNames', select:'org', single:'no', show:'org', range:'*0*',winModalDialog:1});"></a>
							</s:if>
							
                        </td>  
                    </tr>
					<tr>  
                        <td for="备注" class="td_lefttitle">  
                            备注：  
                        </td>  
                        <td>
							 <s:textarea name="groupPO.groupComment"  id="groupComment"  whir-options="vtype:[{'maxLength':50}]" cols="112" rows="3" maxlength="200" cssClass="inputTextarea" cssStyle="width:94%;"></s:textarea>
			            </td>  
                    </tr>
                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap>  
							<s:if test="#parameters.view == null">
								    <s:if test="groupPO.groupId != null">
										<input type="button" class="btnButton4font" onClick="{ ok(0,this);}" value="保    存" /> 
									</s:if>
									<s:else>
									<input type="button" class="btnButton4font" onClick="{ ok(1,this);}" value="保    存" />  
									</s:else>
									    <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value="重    置" /> 
							</s:if>
							<!-- <s:if test="#parameters.view != null">
								    <input type="button" class="btnButton4font" onClick="{ ok(1,this);}" value="保    存" />  
							</s:if>-->
							                         
							<s:if test="groupPO.groupId != null">
								 <input type="button" class="btnButton4font" onClick="window.close();" value="退    出" />
							</s:if>
                      
                        </td>  
                    </tr>  
                </table>  


	</s:form>
		</div>
	</div>
</body>

<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	var isy=3;
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

	$(document).ready(function(){
		//initPara();
	});
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	//上传 红头
	function  uploadHead(){
		popup({content:'url:<%=rootPath%>/govezoffice/gov_documentmanager/senddocument_import.jsp?path=govReadHead&fileName=numPo.redHeadName&saveName=numPo.redHeadSaveName&fileMaxSize=0&fileMaxNum=1&fileType=jpg,gif,bmp,jpeg,png',title: '导入',width:620,height:350,winName:'selProcess'});
	}


	function clearHead(){
		$('#redHeadName').val("");
		$('#redHeadSaveName').val("");
	}



//判断输入的是否是数字
function checkNumber(obj,name,maxnum) {
    var regu = /[0-9]/g ;
    var re = new RegExp(regu);
    var val = obj.value ;
    if(val =="") return true  ;
     if(/^[0-9]+$/.exec(val)) {} else {
    //if (val.search(re) == -1){
		try{
        alert(name+comm.mustinteger) ;
		}catch(e){
        alert(name+"必须是正整数！") ;
		}
         //alert(name+common.mustinteger) ;
         obj.focus();
         obj.select() ;
         return false ;
     }
   // }else {
        if(parseInt(val) > maxnum) {
		try{
        alert(name+comm.notgreaterthan+maxnum+"！") ;
		}catch(e){
        alert(name+"不能大于"+maxnum+"！") ;
		}
         //alert(name+comm.notgreaterthan+maxnum+"！") ;
         obj.focus();
         obj.select() ;
         return false ;
        }
  //  }
   // if(val.indexOf(".")!=-1) {
   //      alert(name+"必须是整数！") ;
   //      obj.focus();
   //      obj.select() ;
   //      return false ;
  //  }
    return true ;
}

//重置
function resetter() {
    SenddocumentBaseActionForm.reset() ;
	isy=3;

}

//关闭
function closer() {
    window.close();
}
//检查页面参数有效性
function initPara() {

	 if($("input[name='seqPo.seqBitNum']").val()==""){
	   alert("流水号中顺序号的位数,不能为空");
	   return false;
	 }

	 if($("input[name='seqPo.seqInitValue']").val()==""){ 
	   alert("顺序号的初始值,不能为空");
	   return false;
	 }

 	var result=checkNumber($("input[name='seqPo.seqBitNum']")[0] ,"流水号中顺序号的位数",99999);
		 if(result==false)
		 return false;
    var num = $("input[name='seqPo.seqBitNum']").val()  ;
 	if(num==0){
 		 alert("流水号中顺序号的位数,不能为0");
 		 return false;
 	}
 	
   result=checkNumber($("input[name='seqPo.seqInitValue']")[0],"顺序号的初始值",99999);
		 if(result==false)
		 return false;		 
		
	var reg =/.*['<>"]+.*/;
	if(reg.test($("input[name='seqPo.seqName']").val() )){
		alert("流水号名称不能有非法字符'\"<>！");
        return false;
	}
	
    if($("input[name='seqPo.seqName']").val()==""){
    	alert("流水号名称不能为空！");
        return false;
    }else{
		
    	return true;
    }
}

//保存继续
function saveContinue() {
	if(preview()==false)
		return ;
    if(initPara()==false)
    	return   ;
    SenddocumentBaseActionForm.action.value = "senddocumentseqcontinue";
	$.ajax({
	   type: "GET",
	   url: "govezoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendSeq&name="+encodeURIComponent(document.all.seqName.value),
	   data: "",
	   async: false,
	   success: function(msg){
	    	if(msg !="-1" && msg!="null" ){
	    		alert("流水号名称已经存在!");
				document.all.seqName.focus();
	    	}else{
		  		SenddocumentBaseActionForm.submit() ;
		  	}
	   }
	});
}
//保存退出
function saveClose() {
	if(preview()==false)
		return  ;
    if(initPara()==false) return   ;
    SenddocumentBaseActionForm.action.value = "senddocumentseqclose";
	$.ajax({
	   type: "GET",
	   url: "govezoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendSeq&name="+encodeURIComponent(document.all.seqName.value),
	   data: "",
	   async: false,
	   success: function(msg){
	    	if(msg !="-1" && msg!="null" ){
	    		alert("流水号名称已经存在!");
				document.all.seqName.focus();
	    	}else{
		  		SenddocumentBaseActionForm.submit() ;
		  	}
	   }
	});
}


function submitForm(){
	if(document.all.judgeNameFrame.readyState!="complete"){
			setTimeout("submitForm()",150,"javascript");
		
	}else{
		if(document.all.judgeChannelName.value!="-1"){
			alert("名称重复!");
			document.all.seqName.focus();
		}else{
	
		    SenddocumentBaseActionForm.submit() ;
		}
	}	
}


//重置
function resetter() {
    SenddocumentBaseActionForm.reset() ;
}

//关闭
function closer() {
    window.close();
}

function choseWord(){
		//window.open("govezoffice/gov_documentmanager/chooseWord.jsp?type=1",'选择机关代字','menubar=0,scrollbars=0,locations=0,width=274,height=230,resizable=yes');

		var wordName=document.all.fileWord.value;
		var wordIds=document.all.fileWordIds.value;

		if(document.all.fileWordIds.value!=""){
			
		postWindowOpen("govezoffice/gov_documentmanager/chooseWord_two.jsp?type=1&wordName="+document.all.fileWord.value+"&wordIds="+document.all.fileWordIds.value,'选择机关代字','menubar=0,scrollbars=0,locations=0,width=274,height=230,resizable=yes');
		
		}else{
		postWindowOpen("govezoffice/gov_documentmanager/chooseWord_two.jsp?type=1",'选择机关代字','menubar=0,scrollbars=0,locations=0,width=274,height=230,resizable=yes');
		
		}
}

function  preview(){
	
	var dv=$("input[name='seqPo.seqFormat']").val();

	var dd=dv;
    var dr1="";
    var resultX=dd.indexOf("顺序号");
	if(resultX==-1){
		//alert("文号模式格式中，不能少‘顺序号’");
		showTelGraph(isy);
		return false;
	}else{
         dr1=dd.substring(0,resultX)+"[顺序号]"+dd.substring(resultX+3);
    }

    if(isy==1){		
        var resultY=dr1.indexOf("年度");

		if(resultY==-1){
		  //alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph(isy);
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }
     }
	 var dv=$("input[name='seqPo.seqMode']").val(dr1);

}


function showTelGraph(value){
	if(value==1){
		isy=1;

		$("input[name='seqPo.seqFormat']").val("年度  顺序号");
		$("input[name='seqPo.seqMode']").val("[年度][顺序号]");

	}else{
		isy=0
		$("input[name='seqPo.seqFormat']").val(" 顺序号");
		$("input[name='seqPo.seqMode']").val("[顺序号]");
	}

}
function repreview(){
   showTelGraph(isy);
}


</script>

</html>



