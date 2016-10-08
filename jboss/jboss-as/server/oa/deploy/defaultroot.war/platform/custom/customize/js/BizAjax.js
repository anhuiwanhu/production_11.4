function showoperate(po,i){

	var tableName = $("#tableName").val();
	var menuId = $("#menuId").val();
	var rightType = $("#rightType").val();
	var defineOrgs = $("#defineOrgs").val();
	var hasNewForm = $("#hasNewForm").val();

	var rootPath = $("#rootPath").val();
	var html = '';

	//var json = ajaxForSync("custormerbiz!hasUpdAndDelRight.action","tableName="+tableName+"&infoId="+po.id+"&rightType="+rightType+"&defineOrgs="+defineOrgs);
	//if(eval(json) == 1){
	if(po.hasUpdAndDelRight=="true"){
		if(hasNewForm=="true"){
		  html += '<img  style="cursor:pointer" border="0" src="'+rootPath+'/images/modi.gif" title="修改" onclick="editnewform(\''+po.id+'\')">';
		}else{
		  html += '<img  style="cursor:pointer" border="0" src="'+rootPath+'/images/modi.gif" title="修改" onclick="edit(\''+po.id+'\')">';
		}
        
	    html += '<img  style="cursor:pointer" border="0" src="'+rootPath+'/images/del.gif" title="删除" onclick="del(\''+po.id+'\')">';
    }

	var json = ajaxForSync("custormerbiz!getButtonList.action","menuId="+$("#menuId").val());
	 if(json!='')
		 json = eval("("+json+")");
	 
	 //查询方案
	 if(json.length>0){
		 
		 for(var i = 0; i < json.length-1; i++) {
			var obj = json[i];
			html += "<img  style=\"cursor:pointer\" border=\"0\" src=\""+rootPath+"/images/py.gif\" title=\""+obj.name+"\" onclick=\"goBatch('"+obj.linkurl+"','" +po.id+"')\">";
			//html += "<input type=\"button\" class=\""+obj.css+"\" onclick=\"goBatch('"+obj.linkurl+"','" +po.id+"')\" value=\""+obj.name+"\" />";
		 }
	 }
     html += '<input name="infoId" id="infoId" value="'+po.id+'" type="hidden">';

	return html;
}

function showcheckbox(po,i){

	var html = '';
	var isHasExport = $("#isHasExport").val(); 
	if(po.hasUpdAndDelRight=="true"){
        
	    html = ' style="display:;" ';
    }else{
    	if(isHasExport=="true"){//判断是否有导出权限
    		html = ' style="display:;" ';
    	}else{
    		html = ' style="display:none;" disabled ';
    	}
    	//html = ' style="display:none;" disabled ';
	}
	return html;
}

function showApp(po,i){
	var html = '';
    if(po.workstatus=='100'){
	   html = '办理完毕';
	}else{
	   html = po.workcurstep;
	}

	return html;
}

function add() {
    var formId = $("#formId").val();
	var menuId = $("#menuId").val();
	var rootPath = $("#rootPath").val();

	var url = rootPath+"/CustomMantence!addCustomMantence.action?formId=" + formId + "&menuId="+menuId+"&moduleType=customizeAdd";
	openWin({url:url,isFull:'true',winName: 'customizeAdd' });
}
//新表单
function addnewform() {
    var formId = $("#formId").val();
	var menuId = $("#menuId").val();
	var rootPath = $("#rootPath").val();

	if(formId.indexOf("new$")!=-1)
        formId = formId.replace("new$","");

	var url = rootPath+"/EzFormMantence!addCustomMantence.action?menuId="+menuId+"&formId="+formId+"&moduleType=customizeAdd";
	openWin({url:url,isFull:'true',winName: 'customizeAdd' });
}

function edit(recordId) {
	var formId = $("#formId").val();
	var menuId = $("#menuId").val();
	var rootPath = $("#rootPath").val();
	var flag = '0';
	var url = rootPath+"/CustomMantence!loadCustomMantence.action?flag=" + flag + "&formId=" + formId + "&recordId=" + recordId + "&menuId="+menuId+"&moduleType=customizeModi";
	openWin({url:url,isFull:'true',winName: 'customizeModi'+recordId });
}
//新表单
function editnewform(recordId) {
    var formId = $("#formId").val();
	var menuId = $("#menuId").val();
	var rootPath = $("#rootPath").val();
	var flag = '0';

	if(formId.indexOf("new$")!=-1)
        formId = formId.replace("new$","");

	var url = rootPath+"/EzFormMantence!loadCustomMantence.action?flag=" + flag + "&menuId="+menuId+"&formId="+formId+"&recordId="+recordId+"&moduleType=customizeModi";
	openWin({url:url,isFull:'true',winName: 'customizeModi'+recordId });
}
function view(recordId) {
	var hasNewForm = $("#hasNewForm").val();
    if(hasNewForm=="true"){
       viewnewform(recordId);
	}else{
		var formId = $("#formId").val();
		var menuId = $("#menuId").val();
		var rootPath = $("#rootPath").val();
		var flag = '1';
		var url = rootPath+"/CustomMantence!loadCustomMantenceV.action?flag=" + flag + "&formId=" + formId + "&recordId=" + recordId + "&menuId="+menuId+"&moduleType=customizeModi";
		openWin({url:url,isFull:'true',winName: 'customizeModi'+recordId });
	}
}
//新表单
function viewnewform(recordId) {
    var formId = $("#formId").val();
	var menuId = $("#menuId").val();
	var rootPath = $("#rootPath").val();
	var flag = '0';

	if(formId.indexOf("new$")!=-1)
        formId = formId.replace("new$","");

	var url = rootPath+"/EzFormMantence!loadCustomMantenceV.action?flag=" + flag + "&menuId="+menuId+"&formId="+formId+"&recordId="+recordId+"&moduleType=customizeModi";
	openWin({url:url,isFull:'true',winName: 'customizeModi'+recordId });
}

function goFlow(url) {
  //alert(url);
  openWin({url:url,isFull:'true',winName: 'openflow' });
}
function importData() {
	var rootPath = $("#rootPath").val();
    var menuId = $("#menuId").val();
	var tableName = $("#tableName").val();
	var formId = $("#formId").val();
	var hasNewForm = $("#hasNewForm").val();
	var url = rootPath+'/custormerbiz!importDataExcel.action?menuId='+menuId+"&tableName="+tableName+"&formId="+formId+"&hasNewForm="+hasNewForm;
    excelImport({importer:encodeURIComponent(url), title: '数据导入'} ); 
}
function importMod() {
    var rootPath = $("#rootPath").val();
	var url = rootPath+'/custormerbiz!expDataExcelMod.action';
	commonExportExcel({formId:'queryForm', action:url});
}
//选中导出
function exportDataById() {

	var ids = getCheckBoxData("id","id");
    if(ids==""){
	  whir_alert("请选择要导出的数据！",null);
	  return;
	}

    var rootPath = $("#rootPath").val();
	var url = rootPath+'/custormerbiz!expDataExcel.action?infoIds='+ids;
	commonExportExcel({formId:'queryForm', action:url});
}
//导出
function exportData() {
    var rootPath = $("#rootPath").val();
	var url = rootPath+'/custormerbiz!expDataExcel.action';
	commonExportExcel({formId:'queryForm', action:url});
}
function goBatch(url, ids) {
    
    if(ids == ""){
	   ids = getCheckBoxData("id","id");
	}
	if(url.indexOf("?")>-1){
	   url = url + "&ids="+ids;
	}else{
	   url = url + "?ids="+ids;
	}
	openWin({url:url,isFull:'true',winName: 'openflow' });
}
function checkNum(obj) {
    if (obj.value!='' && isNaN(obj.value)) {
        //alert(Workflow.inputnumber);
		whir_alert("请输入数字！",null);
        //obj.select();
        obj.value='';
        obj.focus();
    }
}