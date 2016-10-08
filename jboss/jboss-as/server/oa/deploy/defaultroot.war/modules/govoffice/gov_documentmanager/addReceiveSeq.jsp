<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:if test="#parameters.view != null">查看流水号</s:if><s:else><s:if test="seqPo.id!=null">修改流水号</s:if><s:else>新流水号</s:else></s:else></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->

</head>

<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
		<iframe id="judgeNameFrame" name="judgeNameFrame" style="display:none"/></iframe>
	<s:form name="dataForm" id="dataForm" action="GovRecvDocSet!saveReceiveSeq.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
               <s:hidden name="seqPo.id" id="oldid" />
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="流水号名称" width="150" class="td_lefttitle">  
                            流水号名称<span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="3"> 
						     <s:textfield name="seqPo.seqNameR" id="fileWord" whir-options="vtype:['notempty',{'maxLength':50}]" cssClass="inputText" cssStyle="width:92%;;" />
                        </td>  
				
                    </tr>  
					<tr>  
                        <td for="流水号类别" class="td_lefttitle">  
                            流水号类别：  
                        </td>  
                        <td  colspan="3">
							<s:select name="seqPo.seqType" list="#request.seqTypeList" headerKey="0" headerValue="--请选择--" cssClass="easyui-combobox" cssStyle="width:92%;;height:29px;" data-options="width:202,panelHeight:'auto'" editable="false">

						    </s:select>
                        </td>  
                    </tr>
					<tr>  
                        <td for="对应流程" class="td_lefttitle">  
                            对应流程<span class="MustFillColor">*</span>：  
                        </td>  
                        <td  colspan="3">

							<s:hidden name="seqPo.seqProceNameR" id="seqProceNameR"/>
							<s:select name="seqPo.seqProceId" onchange="$('#seqProceNameR').val(this.value);" list="#request.proList" whir-options="vtype:['notempty']" headerKey="" headerValue="--请选择--" cssClass="easyui-combobox" cssStyle="width:92%;;height:29px;" editable="true" data-options="width:202,panelHeight:'auto',
    onSelect: function(record){  

       $('#seqProceNameR').val(record.text); 
    }">    

						    </s:select>
						</td>  
                    </tr>
					<tr>  
                        <td for="流水号中顺序号的位数" class="td_lefttitle">  
                            流水号中顺序号的位数：  
                        </td>  
                        <td  colspan="3">
						  <s:textfield id="seqBitNumR" name="seqPo.seqBitNumR" size="16" maxlength="3" cssClass="inputText"  whir-options="vtype:['p_integer_e','notempty',{'range':'1-999'}]"  style="width:200px;"/>
						</td>  
                    </tr>

					<tr>  
                        <td for="流水号中序号是否跨年重排" class="td_lefttitle">  
                            流水号中序号是否跨年重排：  
                        </td>  
                        <td  colspan="3">
							<s:radio name="seqPo.keyValue" label="文号中序号跨年重排" theme="simple" labelposition="top"
							list="#{'1':'是' , '0':'否' }"	/>
					    </td>  
                    </tr>

					<tr>  
                        <td for="格式中是否有年度" class="td_lefttitle">  
                            格式中是否有年度：  
                        </td>  
                        <td  colspan="3">
							<s:radio name="seqPo.seqIsYearR"  label="文号中序号跨年重排" theme="simple" labelposition="top"
							list="#{'1':'是' , '0':'否' }"  onclick="changeRadio();"	/>
					     </td>  
                    </tr>

					<tr>  
                        <td for="格式中是否有名称" class="td_lefttitle">  
                            格式中是否有名称：  
                        </td>  
                        <td  colspan="3">
							<s:radio name="seqPo.seqIsName"   label="文号中序号跨年重排" theme="simple" labelposition="top"
							list="#{'3':'是' , '2':'否' }"	 onclick="changeRadio();" />
						</td>  
                    </tr>

					<tr>  
                        <td for="顺序号的初始值" class="td_lefttitle">  
                            顺序号的初始值：  
                        </td>  
                        <td  colspan="3">
							 <s:textfield id="seqInitValueR"   name="seqPo.seqInitValueR" size="16"  maxlength="5"  whir-options="vtype:['p_integer_e','notempty',{'range':'1-99999'}]"  cssClass="inputText"  style="width:200px;"/>
                        </td>  
                    </tr>

					<tr>  
                        <td for="流水号格式" class="td_lefttitle">  
                            流水号格式：  
                        </td>  
                        <td  colspan="3">
							 <s:textfield id="seqPo.seqFormatR" name="seqPo.seqFormatR" size="16" cssClass="inputText"  style="width:92%;;"/><br><input type=button class="btnButton4font" onClick="javascript:preview();" value=预览 /><input type=button class="btnButton4font" onClick="javascript:repreview();" value=初始化 />
                        </td>  
                    </tr>

					<tr>  
                        <td for="流水号预览" class="td_lefttitle">  
                           流水号预览：  
                        </td>  
                        <td  colspan="3">
							<s:textfield id="seqPo.seqModeR" name="seqPo.seqModeR" size="16" cssClass="inputText"  style="width:92%;;"/>
				        </td>  
                    </tr>

					<tr>  
                        <td for="使用范围" class="td_lefttitle">  
                            使用范围：  
                        </td>  
                        <td  colspan="3"><s:hidden name="seqPo.receiveScopeId" id="receiveScopeId"/>
                            <s:textarea name="seqPo.receiveScopeName"  id="receiveScopeName" cols="112" rows="3" readonly="true" cssClass="inputTextarea" cssStyle="width:92%;;"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'receiveScopeId', allowName:'receiveScopeName', select:'user', single:'no', show:'user', range:'*0*'});"></a>
							<br><font color="red" style="font-color:red">使用范围为空时默认所有用户</label>
                        </td>  
                    </tr>

					<tr>  
                        <td for="可维护人" class="td_lefttitle">  
                            可维护人：  
                        </td>  
                        <td  colspan="3"><s:hidden name="seqPo.canModifyEmpId" id="canModifyEmpId"/>
                            <s:textarea name="seqPo.canModifyEmpName"  id="canModifyEmpName" cols="112" rows="3" readonly="true" cssClass="inputTextarea" cssStyle="width:92%;;"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'canModifyEmpId', allowName:'canModifyEmpName', select:'user', single:'no', show:'user', range:'*0*'});"></a>
						</td>  
                    </tr>

                   
                    <!--tr>  
                        <td for="角色" class="td_lefttitle">  
                           角色：  
                        </td>  
                        <td>  
                            <input type="checkbox" name="type" value="0"> 会员 <input type="checkbox" name="type" value="1"> 管理员
                        </td>  
                    </tr>
                    <tr>  
                        <td for="年龄" class="td_lefttitle">年龄：</td>  
                        <td>  
                           <input type="text" class="easyui-numberspinner" data-options="min:10,max:100" style="width:80px;" name="age" id="age" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">组织（公共选人、组织、群组）：</td>  
                        <td>  
                           <input type="text" class="inputText"  name="org" id="org" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">联系人（zTree）：</td>  
                        <td>  
                           <s:checkboxlist name="list" list="{'Java','.Net','RoR','PHP'}" value="{'Java','.Net'}" />
                        </td>  
                    </tr-->
                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap> 
						<s:if test="#parameters.view == null">
                            <input type="button" class="btnButton4font" onClick="{ saveok(0,this);}" value="保存退出" />  
							<s:if test="seqPo == null">
                            <input type="button" class="btnButton4font" onClick="saveok(1,this);" value="保存继续" />  
							</s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this)"     value="重    置" />  
						</s:if>
                            <input type="button" class="btnButton4font" onClick="window.close();" value="退    出" />  
                        </td>  
                    </tr>  
                </table>  


	</s:form>
		</div>
	</div>
</body>

<script type="text/javascript">
	var isy = 0;
	
		
	$(document).ready(function(){
		<s:if test="seqPo == null">
		if($('#seqInitValueR').val() == ""){
			$('#seqInitValueR').val("1");
			$('#seqInitValueR').attr("defaultValue","1");
		}
		if($('#seqBitNumR').val() == ""){
			$('#seqBitNumR').val("4");
			$('#seqBitNumR').attr("defaultValue","4");
		}

	
		$("input[name='seqPo.seqIsYearR'][value='1']").attr("checked","true");
		$("input[name='seqPo.seqIsYearR'][value='1']").click();
		$("input[name='seqPo.keyValue'][value='1']").attr("checked","true");
		$("input[name='seqPo.keyValue'][value='1']").click();
		$("input[name='seqPo.seqIsName'][value='3']").attr("checked","true");
		$("input[name='seqPo.seqIsName'][value='3']").click();

		</s:if>
		changeRadio();
		initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
	});
String.prototype.Trim = function(){
   return   this.replace(/\s/g,   '');
}
//检查页面参数有效性
function initPara() {
	
	$("input[name='seqPo.seqBitNumR']").val("年度  顺序号");
	 if( checkEmpty($("input[name='seqPo.seqBitNumR']")[0],"流水号中顺序号的位数，") && 
	 checkEmpty($("input[name='seqPo.seqInitValueR']")[0],"顺序号的初始值，")&& 
	// checkTextInput(document.all.seqBitNumR,"流水号中顺序号的位数，")&& 
	 checkNumber($("input[name='seqPo.seqBitNumR']")[0],"流水号中顺序号的位数",99999)&& 
	 checkZero($("input[name='seqPo.seqBitNumR']")[0] ,"流水号中顺序号的位数")&& 
	 checkNumber($("input[name='seqPo.seqInitValueR']")[0] ,"顺序号的初始值",99999)&& 
	 checkTextInput($("input[name='seqPo.seqNameR']")[0]  ,"流水号名称，")&& 
	 checkEmpty($("input[name='seqPo.seqNameR']")[0]  ,"流水号名称，")&& 
	 checkEmpty($("input[name='seqPo.seqProceId']")[0],"对应流程名，")){
	 
	 }else{
	 	return false;
	 }
	 /*
  	 var msg = $.ajax({
		  url: "govezoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendSeq&name="+encodeURIComponent(document.all.seqNameR.value),
		  async: false
	 }).responseText;
     if(msg !="-1" && msg!="null" ){
	  	alert("流水号名称已经存在!");
		document.all.seqNameR.focus();
		return false;
	 }else{
		ReceiveDocumentBaseActionForm.submit() ;
	}*/
	return true;
}
function saveok(a,b){
	//var sub = false;
	$.ajax({
	   type: "GET",
	   url: "/defaultroot/modules/govoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?oldid="+document.getElementById("oldid").value+"&type=sendSeqR&name="+document.getElementById("fileWord").value,
	   data: "",
	   async: false,
	   success: function(msg){
		   //alert(msg);
	    	if(msg !="-1" && msg!="null" ){
	    		whir_alert("流水号名称已经存在!");
				document.getElementById("fileWord").focus();
	    	}else{
		    	var flag = true;
	    		//增加判断。如果跨年重排选择的为是的话，是否有年度就必须为是。
	    		var kncp = $("input[name='seqPo.keyValue']:checked").val();
	    		var hasyear = $("input[name='seqPo.seqIsYearR']:checked").val();
	    		if(kncp == "1"){
	    	 		if(hasyear == "0"){
	    	 			whir_alert("跨年重排已选择，格式中必须有年度！");
	    	 			//haveY = "1";
	    	 			flag =  false;
	    	 		}
	    	 	}
	    	 	if(flag){
					ok(a,b);
		    	 }
		  		//sub =true;
				//alert(sub);
		  	}
	   }
	});

	//if(sub) save(a,b);
}

//保存继续
function saveContinue() {
	if(preview()==false)
		return ;
    if(initPara()==false)
    	return   ;
    ReceiveDocumentBaseActionForm.action.value = "receiveseqcontinue";

	document.all.judgeNameFrame.src="govezoffice/gov_documentmanager/senddocument_judgename.jsp?type=sendSeqR&name="+document.all.seqNameR.value;
	setTimeout("submitForm()",150,"javascript");

}
//保存退出
function saveClose() {
	if(preview()==false)
		return  ;
    if(initPara()==false) return   ;
    ReceiveDocumentBaseActionForm.action.value = "receiveseqclose";
    document.all.judgeNameFrame.src="govezoffice/gov_documentmanager/senddocument_judgename.jsp?type=sendSeqR&name="+document.all.seqNameR.value;
	  setTimeout("submitForm()",150,"javascript");

}


function submitForm(){
	if(document.all.judgeNameFrame.readyState!="complete"){
			setTimeout("submitForm()",150,"javascript");
		
	}else{
		if(document.all.judgeChannelName.value!="-1"){
			alert("名称重复!");
			document.all.seqNameR.focus();
		}else{

	       getscope();
		   ReceiveDocumentBaseActionForm.submit() ;
		}
	}	
}


//选人页面
function right(str){ openEndow("receiveScopeId","receiveScopeName",document.all.receiveScopeId.value,document.all.receiveScopeName.value,"userorggroup","no","userorggroup","*0*");   
}



//分割范围
function getscope(){

	var receiveScopeId = document.all.receiveScopeId.value;
	var  receiveUser="";
	var  receiveOrg="";
	var  receiveGroup="";


	if(receiveScopeId != ""){
	for( var i = 0; i < receiveScopeId.length; i ++ ){
	flagCode = receiveScopeId.charAt(i);
	nextPos = receiveScopeId.indexOf(flagCode,i + 1);
	str = receiveScopeId.substring(i,nextPos+1);
	if(flagCode == "$"){
	receiveUser = receiveUser + str;
	}else if(flagCode == "*"){
	receiveOrg = receiveOrg + str;
	}else{
	receiveGroup = receiveGroup + str;
	}
	i = nextPos;
	}
	}
	document.all.receiveUser.value = receiveUser;
	document.all.receiveOrg.value = receiveOrg;
	document.all.receiveGroup.value = receiveGroup;

}


//重置
function resetter() {
    ReceiveDocumentBaseActionForm.reset() ;
}

//关闭
function closer() {
    window.close();
}




function changeProceName(){
  nLen =document.all.seqProceId.length;
 for(i=0;i<nLen;i++){
		var optObj = document.all.seqProceId.options(i);
		var strText = optObj.text;

		if(optObj.selected){
		document.all.seqProceNameR.value=strText;
		}
	}

}





 
function  preview(){
 
/*
 String  v11="年度  顺序号";
  String  v12=" 顺序号";
  String  v13="流水号名称  年度  顺序号";
  String  v14="流水号名称  顺序号";
*/
    
	
	var dv=$("input[name='seqPo.seqFormatR']").val();//document.all.seqPo.seqFormatR.value;
 
 
       //-----------------------start  去掉多余的------------------------
    if(isy==2){//机无，年无， 如有先 去掉
      
       var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{
 
         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
		
 
		var resultJ=dv.indexOf("流水号名称");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+5);
        }
 
	 
	 }else{
	  if(isy==1){// 年有 ，去机
         var resultJ=dv.indexOf("流水号名称");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+5);
        }
		  
	  }else{
	   if(isy==4){//机有，  去年
	   
	     var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{
 
         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
	   
	   }
	  
	  
	  }
	 }
 $("input[name='seqPo.seqFormatR']").val(dv);
//	 document.all.seqFormatR.value=dv;
//----------------------------------end -------------------------------    
 
 
 
 
	//var dd=dv.Trim();
	var dd=dv;
    var dr1="";
    var resultX=dd.indexOf("顺序号");
	if(resultX==-1){
		//alert("文号模式格式中，不能少‘序号’");
		showTelGraph();
		return false;
	}else{
         dr1=dd.substring(0,resultX)+"[顺序号]"+dd.substring(resultX+3);
    }
 
 
 
 
 
 
 
    if(isy==1){	
 
        var resultY=dr1.indexOf("年度");
 
		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }
     }
     if(isy==3){
 
	  var resultY=dr1.indexOf("年度");
 
		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }
 
        var resultJ=dr1.indexOf("流水号名称");
		if(resultJ==-1){
		 // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		// chooseIsWord("2");
		  //isy=1;
		 // showTelGraph();
		  //return false ;
 
		   // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[流水号名称]"+dr1.substring(resultJ+5);
        }
	 
	 
	 }
 
	 if(isy==4){
	
	
		 var resultJ=dr1.indexOf("流水号名称");
 
		if(resultJ==-1){
		  // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		  // chooseIsWord("2");
		   // isy=2;
		 // showTelGraph();
		 // return false ;
 
		 // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[流水号名称]"+dr1.substring(resultJ+5);
        }
		 
	 }
       
  $("input[name='seqPo.seqModeR']").val(dr1);
 
	// document.all.seqModeR.value=dr1;
}
 
 


function  preview2(){

/*
 String  v11="年度  顺序号";
  String  v12=" 顺序号";
  String  v13="流水号名称  年度  顺序号";
  String  v14="流水号名称  顺序号";
*/
    
	
	var dv=$("input[name='seqPo.seqFormatR']").val();


       //-----------------------start  去掉多余的------------------------
    if(isy==2){//机无，年无， 如有先 去掉
      
       var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
		

		var resultJ=dv.indexOf("流水号名称");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+5);
        }
 
	 
	 }else{
	  if(isy==1){// 年有 ，去机
         var resultJ=dv.indexOf("流水号名称");
		if(resultJ==-1){
		
	    }else{
         dv=dv.substring(0,resultJ)+dv.substring(resultJ+5);
        }
		  
	  }else{
	   if(isy==4){//机有，  去年
	   
	     var resultY=dv.indexOf("年度");
		if(resultY==-1){
		
	    }else{

         dv=dv.substring(0,resultY)+dv.substring(resultY+2);
        }
	   
	   }
	  
	  
	  }
	 }

	 $("input[name='seqPo.seqFormatR']").val(dv);
//----------------------------------end -------------------------------    




	//var dd=dv.Trim();
	var dd=dv;
    var dr1="";
    var resultX=dd.indexOf("顺序号");
	if(resultX==-1){
		//alert("文号模式格式中，不能少‘序号’");
		showTelGraph();
		return false;
	}else{
         dr1=dd.substring(0,resultX)+"[顺序号]"+dd.substring(resultX+3);
    }







    if(isy==1){	

        var resultY=dr1.indexOf("年度");

		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }
     }
     if(isy==3){

	  var resultY=dr1.indexOf("年度");

		if(resultY==-1){
		 // alert("文号模式格式中选了包含‘年度’，所以不能少‘年度’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultY)+"[年度]"+dr1.substring(resultY+2);
        }

        var resultJ=dr1.indexOf("流水号名称");
		if(resultJ==-1){
		 // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		// chooseIsWord("2");
		  //isy=1;
		 // showTelGraph();
		  //return false ;

		   // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[流水号名称]"+dr1.substring(resultJ+5);
        }
	 
	 
	 }

	 if(isy==4){
	
	
		 var resultJ=dr1.indexOf("流水号名称");

		if(resultJ==-1){
		  // alert("文号模式格式 少‘机关代字’,系统将默认取文号中不含机关代字");
		  // chooseIsWord("2");
		   // isy=2;
		 // showTelGraph();
		 // return false ;

		 // alert("文号模式格式中选了包含‘机关代字’，所以不能少‘机关代字’");
		  showTelGraph();
		  return false ;
	    }else{
         dr1=dr1.substring(0,resultJ)+"[流水号名称]"+dr1.substring(resultJ+5);
        }
		 
	 }
       

	 $("input[name='seqPo.seqModeR']").val(dr1);

}


 

  
 function changeRadio(){
 
 
   var haveY=document.getElementsByName("seqPo.seqIsYearR"); 
	var yvalue;
   for(i=0;i<haveY.length;i++)  
   {  
   if(haveY[i].checked) yvalue=haveY[i].value;  
    }
 
	 var haveW=document.getElementsByName("seqPo.seqIsName"); 
	var wvalue;
   for(i=0;i<haveW.length;i++)  
   {  
   if(haveW[i].checked) wvalue=haveW[i].value;  
    }
  
 //alert(wvalue);
     if(wvalue=="3"){
		// alert(yvalue);
       if(yvalue=="1"){//两者有
         isy=3;
	   
	   }else{//机有， 年没有
	    isy=4;
	   
	   }
 
	 
	 
	 }else{
      if(yvalue=="1"){//机没有 ，年有
       isy=1;
 
	  
	  }else{//两者没有
		isy=2;
		  
	  }
		 
		 
		 
	 }
// alert(isy);
 
preview();
 
 }
 
 

 function changeRadio2(){
   var haveY= $("input[name='seqPo.seqIsYearR']"); 
   var yvalue;
   for(i=0;i<haveY.length;i++)  
   {  
		if(haveY[i].checked) yvalue=haveY[i].value;  
   }
   var haveW= $("input[name='seqPo.seqIsName']") ; 
   var wvalue;
   for(i=0;i<haveW.length;i++)  
   {  
		if(haveW[i].checked) wvalue=haveW[i].value;  
   }
  

     if(wvalue=="3"){
       if(yvalue=="1"){//两者有
         isy=3;
	   
	   }else{//机有， 年没有
	    isy=4;
	   
	   }
	 }else{
      if(yvalue=="1"){//机没有 ，年有
       isy=1;

	  
	  }else{//两者没有
		isy=2;
		  
	  }
 	 }
	preview();
 }


function showTelGraph(){
     
	 if(isy==1){
		$("input[name='seqPo.seqFormatR']").val("年度  顺序号");
		$("input[name='seqPo.seqModeR']").val("[年度] [顺序号]");
 	 }

   if(isy==2){
		$("input[name='seqPo.seqFormatR']").val(" 顺序号");
		$("input[name='seqPo.seqModeR']").val("[顺序号]");
   }


   if(isy==3){
		$("input[name='seqPo.seqFormatR']").val("流水号名称  年度  顺序号");
		$("input[name='seqPo.seqModeR']").val("[流水号名称] [年度] [顺序号]");
  }


   if(isy==4){
	   $("input[name='seqPo.seqFormatR']").val("流水号名称  顺序号");
	   $("input[name='seqPo.seqModeR']").val("[流水号名称] [顺序号]");
  }

}
 

function repreview(){
   showTelGraph();
}
 


</script>

</html>



