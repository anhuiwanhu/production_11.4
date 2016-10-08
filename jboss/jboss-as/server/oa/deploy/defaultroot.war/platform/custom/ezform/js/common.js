;
var legal_cnst ="\\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/";
var CONST_FIELD_XML = "<formSettings><fields></fields></formSettings>";
var EZFORM_FIELD_XML_ATTR = CONST_FIELD_XML;

/*String.prototype.trimLR = function() {
	return this.replace(/(^ +| +$)/, "");
}

function legalCharacters(o) {
	//参数'o'是页面上的一个对象，如'document.forms[0].code'
	//var cnst ="!\"#$%&'()=`|~{+*}<>?_-^\\@[;:],./";
	//var cnst ="\\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/";
	//var cnst ="\\\"'`<>^/";

    for (i=0;i<o.value.length;i++){
       	if (legal_cnst.indexOf(o.value.charAt(i))>-1){
			return true;
        }
    }
    return false;
}*/

//初始化ext的tabpanel

function initTableFieldTab3(arr) {
    var tabs = new Ext.TabPanel({
        renderTo: document.getElementById("fieldDIV"),
        activeTab: 0,
        width: 200,
        height: 520,
        plain: true,
        enableTabScroll: true,
        defaults: {
            autoScroll: true
        },
        items: arr
    });
}

function initTableFieldTab(arr) {
    var tabs = Ext.widget('tabpanel', {
        renderTo: document.getElementById("fieldDIV"),
        activeTab: 0,
        width: 200,
        height: 520,
        plain: true,
        enableTabScroll: true,
        defaults: {
            autoScroll: true
        },
        items: arr
    });
}

function changePanel(flag){
    $('#li_'+flag).click();
}

function saveTheFormData(flag, obj){
    var formName = $('#formName').val();
    var formCode = $('#formCode').val();
    if(formName == ''){
        changePanel(0);
    }

    if(formCode == ''){
        changePanel(0);
    }

    saveFormData(flag, obj)
}

function saveFormData(flag, obj){
    //var tableId = whirCombobox.getValue('tableId');
    var tableId = whirExtCombobox.getValue('tableId');
    if(tableId == ''){
        whir_alert('请选择关联数据表！', null);
        return;
    }

    var fieldelt = $('#mainFields').val();
	var wfModuleId = $('#wfModuleId').val();
    /*var forTable = $('#forTable').val();*/
    if(fieldelt == ''/* && forTable == ''*/){
        whir_alert('请选择关联数据表字段！', null);
        return;
    }

    /*var boardroomField = $('#boardroomField').val();
	if(boardroomField!="" && boardroomField!="null"){
		var fieldFlag="true";
		var fieldData= Base64.decode(boardroomField);
		if(typeof(fieldData)!="undefined" && fieldData!='{"fieldData":]}'){
			var fieldDataObj= eval("("+fieldData+")");
			var fieldDataObjeLength=fieldDataObj.fieldData.length;
			if(fieldDataObjeLength>0){
				$.each(fieldDataObj.fieldData,function(i,item){
					var fieldCodeData= item.fieldCode ;
					if(fieldelt.indexOf("oa_boardroomapply-"+fieldCodeData)<0){
						fieldFlag="false";
						whir_alert(item.fieldNameData+"是必选项，请您选中!");
						return false;
					}
				});
			}
			//if return false只能跳出父级，不能跳出父父一级
			if(fieldFlag=="false"){
				return false;
			}
		}
	}
   /* if(fieldelt.indexOf("oa_boardroomapply-addr")<0){
		whir_alert("地点是必选项，请您选中!");
		return;
	}*/
	if(wfModuleId=="15"){
		if(fieldelt.indexOf("oa_boardroomapply-boardroomid")<0){
			whir_alert("会议室名称是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-destinedate")<0){
			whir_alert("时间是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-emceename")<0){
			whir_alert("主持人是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-motif")<0){
			whir_alert("会议主题是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-bdroomapptypeid")<0){
			whir_alert("会议类型是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-applyempname")<0){
			whir_alert("预订者是必选项，请您选中!");
			return;
		}
		if(fieldelt.indexOf("oa_boardroomapply-applyorgname")<0){
			whir_alert("预订部门是必选项，请您选中!");
			return;
		}
	}
    var templateIframe = document.getElementById("templateIframe");
	var type = document.getElementById("editor").getAttribute("data-type");
    try{
		if(type=="1"){
			$('#formContent').val(templateIframe.contentWindow.getHTML());
		}else{
			templateIframe.contentWindow.ue.execCommand('source');
			$('#formContent').val(templateIframe.contentWindow.ue.getContent());
			templateIframe.contentWindow.ue.execCommand('source');
		}
    }catch(e){
        $('#formContent').val(templateIframe.getHTML());
    }

    $('#formXML').val(EZFORM_FIELD_XML_ATTR);

    ok(flag, obj);
}

function getTable(){
    var modelId = whirExtCombobox.getValue('modelId');

    whirExtCombobox.clearValue('tableId');

    tableStore.load({params:{modelId:modelId}});

    /*var modelId = whirCombobox.getValue('modelId');
    whirCombobox.clear('tableId');
    whirCombobox.reload('tableId', whirRootPath + '/EzForm!getTableList.action?modelId='+modelId);*/

    getTableField();
}

//清除所有选中字段
function clearField(doc) {
    var ff = $('#mainFields').val().split(";");
    for (var i = 0; i < ff.length; i++) {
        if (doc.getElementById(ff[i])) {
            try {
                doc.getElementById(ff[i]).removeNode(true);
            } catch(e){
                $(doc.getElementById(ff[i])).remove();
            }
        }
    }
}

//清除所有选中子表
function clearTable(doc){
    var tt = $('#subTable').val().split(";");
    for (var i = 0; i < tt.length; i++) {
        if (doc.getElementById(tt[i] + "DIV")) {
            try {
                doc.getElementById(tt[i] + "DIV").parentNode.removeChild(doc.getElementById(tt[i] + "DIV"));
            } catch(e) {
                $(doc.getElementById(tt[i] + "DIV").parentNode).remove($(doc.getElementById(tt[i] + "DIV")));
            }
        }

        if (document.getElementById(tt[i])) {
            try {
                document.getElementById(tt[i]).removeNode(true);
            } catch(e){
                $(document.getElementById(tt[i])).remove();
            }
        }
    }
}

function getFieldDataJson(){
    //initExtCss();

    //var tableId = whirCombobox.getValue('tableId');
    var tableId = whirExtCombobox.getValue('tableId');
    var data = ajaxForSync(whirRootPath + '/EzForm!getFieldInfo.action', 'tableId='+tableId);
    data = eval("("+data+")");
    return data;
}

function initExtCss(){
    if($.browser.msie){
        var ver = $.browser.version;
        if(ver > 9.0){
            if(document.getElementById('tabpanel-1016-body')){
                $('#tabpanel-1016-body').css('top', '0px');
            }
        }
    }
}

//获得指定表的所有字段
function getTableField() {
    $('#fieldDIV').html('');
	var type = document.getElementById("editor").getAttribute("data-type");
    try{
		//-------------------------------------------------修改表单---------------------------------------------------------
		if(type=="1"){
			clearField(document.getElementById('templateIframe').contentWindow.document.getElementById('eWebEditor').contentWindow.document);
			clearTable(document.getElementById('templateIframe').contentWindow.document.getElementById('eWebEditor').contentWindow.document);
		}else{
			clearField(document.getElementById('templateIframe').contentWindow.document.getElementById('ueditor_0').contentWindow.document);
			clearTable(document.getElementById('templateIframe').contentWindow.document.getElementById('ueditor_0').contentWindow.document);
		}
	}catch(e){
        clearField(document.getElementById("templateIframe").eWebEditor.document);
        clearTable(document.getElementById("templateIframe").eWebEditor.document);
    }

    $('#mainFields').val('');
    $('#subTable').val('');

    showField(getFieldDataJson());

    //------------------------------------
    EZFORM_FIELD_XML_ATTR = CONST_FIELD_XML;
    //------------------------------------
}

//modify load
function loadField(flag) {
    var data = getFieldDataJson();

	var html = "";
	var htmlArr = new Array();

    //-------------------------------------------------------------------------
    //用于表单修改
    var mainFields = $("input[name='mainFields']");
    var subTable_fields = $("input[name='subTable_fields']");
    //-------------------------------------------------------------------------

    if (data.maintable) {
        var priField = data.maintable;
		 if (priField != null && priField.length > 0) {
	    	for(var i=0;i<priField.length;i++){
                var mainField = priField[i];

                //var fieldelt = $('#fieldelt').val();
                var sel = checkedFields(mainFields, mainField.tablenm, mainField.fieldname, false);//是否选中
				//var sel = fieldelt.indexOf(mainField.fieldid+"-"+mainField.fieldname)>=0?"checked":"";

				html += "<div style='padding:3px 0 0 5px;'><input type=checkbox id='"+mainField.fieldid+"-"+mainField.fieldname+ "' " + sel+" value='"+mainField.fieldid+"-"+mainField.fieldname+"-"+mainField.fieldshow+"' onclick=setHTML2Editor(this,'"+mainField.fielddesname+"') field_name='"+mainField.fieldname+"' table_name='"+mainField.tablenm+"' field_show='"+mainField.fieldshow + "'>&nbsp;<label id='"+mainField.fieldid+"-"+mainField.fieldname+"text'>"+mainField.fielddesname+"</label></div>";
			}
			htmlArr[0] = {title: '主表字段', html: html};
		 }

		$('#subTable').val('');

        if(data.subtable){
            for (var j = 0; j < data.subtable.length; j++) {
                var forField = data.subtable[j];
                var forHTML = "";
                if (forField != null && forField.length > 0) {
                    for(var i=0;i<forField.length;i++){//alert(forField);
                        var subField = forField[i];
                        if(i==0){
                            var val = $('#subTable').val();
                            $('#subTable').val(val + subField.tablenm + ";");
                            if(!document.getElementById(subField.tablenm)){
                                var pryElt = document.createElement("INPUT");
                                pryElt.type = "hidden";
                                pryElt.id = forField[0].tablenm;
                                pryElt.name = forField[0].tablenm;
                                $('#dataForm').append(pryElt);
                            }
                        }

                        var selectedSubField = $('#selectedSubField').val();
                        //----------------------------------------------------------
                        //初始化选中的值，以防止提交保存，再次打开丢失
                        if(document.getElementById(forField[0].tablenm) && selectedSubField.indexOf(","+subField.tablenm+"-"+subField.fieldname+",")>=0){
                            var val = ";" + document.getElementById(forField[0].tablenm).value;
                            if(val.indexOf(";" + subField.tablenm+"-"+subField.fieldname + ";")==-1){
                                document.getElementById(forField[0].tablenm).value += subField.tablenm+"-"+subField.fieldname + ";";
                            }
                        }
                        //----------------------------------------------------------
                        //alert(document.getElementById(forField[0][6]).value);

                        /*var sel = "";
                        try{
                            sel = selectedSubField.indexOf(","+subField.fieldid+"-"+subField.fieldname+",")>=0?"checked":"";
                        }catch(e3){}*/

                        var sel = checkedFields(subTable_fields, subField.tablenm, subField.fieldname, true);//是否选中

                        forHTML += "<div style='padding:3px 0 0 5px;'><input type=checkbox id='"+subField.fieldid+"-"+subField.fieldname+ "' " + sel+" value='"+subField.fieldid+"-"+subField.fieldname+"-"+subField.fieldshow+"' onclick=setForHTML2Editor(this,'"+subField.fielddesname+"','"+subField.tablenm+"') field_name='"+subField.fieldname+"' table_name='"+subField.tablenm+"' field_show='"+subField.fieldshow + "'>&nbsp;<label id='"+subField.tablenm+"-"+subField.fieldname+"text'>"+subField.fielddesname+"</label></div>";
                    }
                    htmlArr[htmlArr.length] = {title: forField[0].tabledesnm,'html': forHTML};
                    //alert(forHTML);
                }
                //alert(j+"end");
             }
        }
    }

	initTableFieldTab(htmlArr);

    if(flag){
        EZFORM_FIELD_XML_ATTR = $('#formXML').val();

        removeXMLFields();
    }
}

function lazyLoad(){

    var eWebEditor_Temp_HTML = null;

    var templateIframe = document.getElementById("templateIframe");
    try{
        //eWebEditor_Temp_HTML = templateIframe.contentWindow.document.getElementById('eWebEditor_Temp_HTML');
		eWebEditor_Temp_HTML = templateIframe.contentWindow.document.getElementById('ueditor_0');
    }catch(e){
        //eWebEditor_Temp_HTML = templateIframe.document.getElementById('eWebEditor_Temp_HTML');
		eWebEditor_Temp_HTML = templateIframe.document.getElementById('ueditor_0');
    }

    if(eWebEditor_Temp_HTML){
        setLazyContent();
    }else{
        setTimeout(lazyLoad, 1500);
    }
}

function setLazyContent(){
    var templateIframe = document.getElementById("templateIframe");
    try{
        //templateIframe.contentWindow.insertHTML($('#codeDIV').html());
		templateIframe.contentWindow.ue.execCommand('inserthtml',$('#codeDIV').html().replace(/  /g,'')); 
    }catch(e){
        //templateIframe.insertHTML($('#codeDIV').html());

		templateIframe.ue.execCommand('inserthtml',$('#codeDIV').html()); 
    }

    //$('#codeDIV').html('');
}

function showField(data) {
    var html = "";
    var htmlArr = new Array();
    if (data.maintable) {
        var priField = data.maintable;
        if (priField != null && priField.length > 0) {
            for (var i = 0; i < priField.length; i++) {
                var mainField = priField[i];
                html += "<div style='padding:3px 0 0 5px;'><input type=checkbox id='" + mainField.fieldid + "-" + mainField.fieldname + "' value='" + mainField.fieldid + "-" + mainField.fieldname + "-" + mainField.fieldshow + "' onclick=setHTML2Editor(this,'" + mainField.fielddesname + "') field_name='"+mainField.fieldname+"' table_name='"+mainField.tablenm+"' field_show='"+mainField.fieldshow + "'>&nbsp;<label id='" + mainField.fieldid + "-" + mainField.fieldname + "text'>" + mainField.fielddesname + "</label></div>";
            }
            htmlArr[0] = {
                title: '主表字段',
                'html': html
            };
        }

        $('#subTable').val('');

        if(data.subtable){
            for (var j = 0; j < data.subtable.length; j++) {
                var forField = data.subtable[j];
                var forHTML = "";
                if (forField != null && forField.length > 0) {
                    for (var i = 0; i < forField.length; i++) {
                        var subField = forField[i];
                        if (i == 0) {
                            var val = $('#subTable').val();
                            $('#subTable').val(val + subField.tablenm + ";");
                            if (document.getElementById(subField.tablenm)) {
                                document.getElementById(subField.tablenm).removeNode(true);
                            }
                            var pryElt = document.createElement("INPUT");
                            pryElt.type = "hidden";
                            pryElt.id = subField.tablenm;
                            pryElt.name = subField.tablenm;
                            $('#dataForm').append(pryElt);
                        }

                        forHTML += "<div style='padding:3px 0 0 5px;'><input type=checkbox id='" + subField.fieldid + "-" + subField.fieldname + "' value='" + subField.fieldid + "-" + subField.fieldname + "-" + subField.fieldshow + "' onclick=setForHTML2Editor(this,'" + subField.fielddesname + "','" + subField.tablenm + "') field_name='"+subField.fieldname+"' table_name='"+subField.tablenm+"' field_show='"+subField.fieldshow + "'>&nbsp;<label id='" + subField.tablenm + "-" + subField.fieldname + "text'>" + subField.fielddesname + "</label></div>";
                    }

                    htmlArr[htmlArr.length] = {
                        title: forField[0].tabledesnm,
                        html: forHTML
                    };
                }
            }
        }
    }

    if (htmlArr.length < 1) {
        htmlArr[0] = {
            title: '主表字段',
            html: ''
        };
    }

    initTableFieldTab(htmlArr);
}

//检查所有选中字段是否有对应的标签在HTML编辑器中
function checkField(doc) {
    var ff = $('#mainFields').val().split(";");
    for (var i = 0; i < ff.length; i++) {
        //alert(ff[i] + ":" +doc.getElementById(ff[i]));
        if (ff[i].length > 1 && !doc.getElementById(ff[i])) {
            //alert(document.getElementById(ff[i]).checked);

            var fieldelt = ";" + $('#mainFields').val();
            fieldelt = fieldelt.replace(";" + ff[i] + ";", ";");
            while(fieldelt.indexOf(";;")!=-1){
                fieldelt = fieldelt.replace(";;", ";");
            }

            if(fieldelt == ';') fieldelt= '';

            $('#mainFields').val(fieldelt);

            if (document.getElementById(ff[i])) {
                document.getElementById(ff[i]).checked = '';
            }
            //去掉选中属性
        }
    }
}

//设置关联字段的HTML标签到编辑器中
function setHTML2Editor(obj, fnm) {
    var field_name = $(obj).attr('field_name');
    var table_name = $(obj).attr('table_name');
    var field_show = $(obj).attr('field_show');

    var doc = null;
	var type = document.getElementById("editor").getAttribute("data-type");
    try{

		if(type=="1"){
			doc = document.getElementById('templateIframe').contentWindow.document.getElementById('eWebEditor').contentWindow.document;
		}else{
			doc = document.getElementById('templateIframe').contentWindow.document.getElementById('ueditor_0').contentWindow.document;
		}
	}catch(e){
        doc = document.getElementById("templateIframe").eWebEditor.document;
    }

    checkField(doc);

    var $obj = $(obj);

    //var val = $obj.val();
    //var valArr = val.split("-");

    var valId = table_name;//valArr[0];
    var valName = field_name;//valArr[1];

    if ($obj.attr('checked') == undefined || $obj.attr('checked') != 'checked') {
        try {
            if($.browser.msie){
                doc.getElementById(valId + "-" + valName).removeNode(true);
            }else{
                $(doc.getElementById(valId + "-" + valName)).remove();
            }
        } catch (e) {}

        var fieldelt = ";" + $('#mainFields').val();
        fieldelt = fieldelt.replace(";" + valId + "-" + valName + ";", ";");
        while(fieldelt.indexOf(";;")!=-1){
            fieldelt = fieldelt.replace(";;", ";")
        }

        $('#mainFields').val(fieldelt);

        //---------------------------------
        createField2XML(table_name + "-" + field_name, false);
        //---------------------------------

        return;
    }

    var html = "";
    html = "<strong>[" + fnm + "]</strong>";

    html = "<div style=width:100%; id=" + valId + "-" + valName + ">" + html + "</div>";
    var idn = valId + "-" + valName;

    var divobj = doc.getElementById(eval("\"" + idn + "\""));

    if (divobj) {
        try {
            if($.browser.msie){
                divobj.removeNode(true);
            }else{
                $(divobj).remove();
            }
        } catch (ew) {}
    }

    var fieldelt = $('#mainFields').val();

    fieldelt += valId + "-" + valName + ";";

    $('#mainFields').val(fieldelt);

    try {
        if (doc.selection.type != "Control") {
            var elem = doc.selection.createRange().parentElement()
            while (elem.tagName.toUpperCase() != "TD" && elem.tagName.toUpperCase() != "TH") {
                elem = elem.parentElement;
                if (elem == null)
                    break;
            }
            if (elem) {
                if (elem.innerText.trim().length < 1) {
                    //alert(elem.innerHTML);
                    elem.innerHTML = "";
                }
            }
        }
        /*var curObject=doc.editGetActiveObject();
		var aTags=doc.__editGetTagHierarchy(curObject,1);
		for(var i=0;i<aTags.length;i++){
			//alert(aTags[i].tagName.toLowerCase());
			var tag=aTags[i].tagName.toLowerCase();
			curObject=aTags[i];
			if((tag=="th"||tag=="td")){
				try{
					 //alert(curObject.innerText);
					 if(curObject.innerText.trim().length<1){
						curObject.innerHTML = "";
					 }
				}catch(e4){}
				break;
			}
		}*/
    } catch (er) {}

    /*if($.browser.mozilla){
        templateIframe.contentWindow.insertHTML(html);
    }else{
        templateIframe.insertHTML(html);
    }*/

    var templateIframe = document.getElementById("templateIframe");

    try{
		if(type=="1"){
			templateIframe.contentWindow.insertHTML(html);
		}else{
			templateIframe.contentWindow.ue.focus();  
			templateIframe.contentWindow.ue.execCommand('inserthtml',html);
		}
    }catch(e){

        templateIframe.insertHTML(html);
    }

    //---------------------------------
    createField2XML(table_name + "-" + field_name, true);
    //---------------------------------
}

//设置子表的关联字段到HTML编辑器中
function setForHTML2Editor(obj, fnm, tblnm){
    var field_name = $(obj).attr('field_name');
    var table_name = $(obj).attr('table_name');
    var field_show = $(obj).attr('field_show');    

    var doc = null;
	var type = document.getElementById("editor").getAttribute("data-type");
    try{
		if(type=="1"){//ewebeditor
			doc = document.getElementById('templateIframe').contentWindow.document.getElementById('eWebEditor').contentWindow.document;
		}else{
			doc = document.getElementById('templateIframe').contentWindow.document.getElementById('ueditor_0').contentWindow.document;
		}
	}catch(e){
        doc = document.getElementById("templateIframe").eWebEditor.document;
    }
	
    var $obj = $(obj);

    //var val = $obj.val();
    //var valArr = val.split("-");

    var valId = table_name;//valArr[0];
    var valName = field_name;//valArr[1];

	if ($obj.attr('checked') == undefined || $obj.attr('checked') != 'checked') {
        var subVal = ";" + document.getElementById(tblnm).value;
        subVal = subVal.replace(";"+valId+"-"+valName+";",";");
        while(subVal.indexOf(";;")!=-1){
            subVal = subVal.replace(";;", ";")
        }

        if(subVal == ";") subVal = "";
		document.getElementById(tblnm).value = subVal;

        //---------------------------------
        createField2XML(table_name + "-" + field_name, false);
        //---------------------------------
	}else{
        if(field_show == '501'){//相关对象            
            obj.checked = false;
            whir_alert('相关对象不支持子表。');
            return;
        }

        if(field_show == '401'){//批示意见            
            obj.checked = false;
            whir_alert('批示意见不支持子表。');
            return;
        }

		document.getElementById(tblnm).value += valId+"-"+valName+";";

        //---------------------------------
        createField2XML(table_name + "-" + field_name, true);
        //---------------------------------
	}

	setForeignHTML(doc, tblnm);
}

//设置子表字段到ext tabpanel中
function setForeignHTML(doc, tblnm) {
    var obj = document.getElementById(tblnm);
    if (doc.getElementById(tblnm + "DIV")) {
        doc.getElementById(tblnm + "DIV").parentNode.removeChild(doc.getElementById(tblnm + "DIV"));
    } //else{

	//新编辑器添加内容开始
	if (doc.getElementById("zw")) {
		doc.getElementById("zw").parentNode.removeChild(doc.getElementById("zw").parentNode.firstChild);
		doc.getElementById("zw").parentNode.removeChild(doc.getElementById("zw"));
    }
	//新编辑器添加内容结束

    try {
        if (doc.selection.type != "Control") {
            var elem = doc.selection.createRange().parentElement()
            while (elem.tagName.toUpperCase() != "TD" && elem.tagName.toUpperCase() != "TH") {
                elem = elem.parentElement;
                if (elem == null)
                    break;
            }
            if (elem) {
                if (elem.innerText.trim().length < 1) {
                    //	alert(elem.innerHTML);
                    elem.innerHTML = "";
                }
            }
        }
        /*var curObject=doc.editGetActiveObject();
			var aTags=doc.__editGetTagHierarchy(curObject,1);
			for(var i=0;i<aTags.length;i++){
				//alert(aTags[i].tagName.toLowerCase());
				var tag=aTags[i].tagName.toLowerCase();
				curObject=aTags[i];
				if((tag=="th"||tag=="td")){
					try{
						//alert(curObject.innerText);
						if(curObject.innerText.trim().length<1){
							curObject.innerHTML = "";
						}
					}catch(e4){}
					break;
				}
			}*/
    } catch (er) {}

    var templateIframe = document.getElementById("templateIframe");
	var type = document.getElementById("editor").getAttribute("data-type");
    try{
		if(type=="1"){
			templateIframe.contentWindow.insertHTML("<DIV id=" + tblnm + "DIV style='width:100%;' align='center' class='subtablediv'></DIV>");
		}else{
			templateIframe.contentWindow.ue.execCommand('inserthtml',"<br><DIV id=" + tblnm + "DIV style='width:100%;' align='center' class='subtablediv'></DIV><div id='zw'></div>"); 	
		}
	}catch(e){
		if(type=="1"){
			templateIframe.insertHTML("<DIV id=" + tblnm + "DIV style='width:100%;' align='center' class='subtablediv'></DIV>");
		}else{
			templateIframe.ue.execCommand('inserthtml',"<DIV id=" + tblnm + "DIV style='width:100%;' align='center' class='subtablediv'></DIV>"); 
		}
	}

    try {
        doc.editGetActiveObject().innerHTML = doc.editGetActiveObject().innerHTML.replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("&nbsp;", "").replace("<p></p>", "").replace("<p></p>", "").replace("<p></p>", "").replace("<p></p>", "").replace("<p></p>", "").replace("<P></P>", "").replace("<P></P>", "").replace("<P></P>", "").replace("<P></P>", "").replace("<P></P>", "");
    } catch (er) {}
    //}
    if (obj.value && obj.value.length > 0) {
        var ff = obj.value.split(";");
        var wid = doc.getElementById(tblnm + "DIV").parentNode.offsetWidth;
        var tblHead = "<table style='border-right: #000000 2px solid; border-top: #000000 2px solid; border-left: #000000 2px solid; width: " + (wid >= 750 ? "750" : wid) + "; border-bottom: #000000 2px solid; border-collapse: collapse' bordercolor='#000000' cellspacing='0' cellpadding='0' align='center' border='0'><tr>";
        if(type!="1"){
			tblHead = "<table style='border-right: #000000 2px solid; border-top: #000000 2px solid; border-left: #000000 2px solid; width: " + (wid >= 750 ? "750" : wid) + "; border-bottom: #000000 2px solid; border-collapse: collapse;margin-bottom:5px;' bordercolor='#000000' cellspacing='0' cellpadding='0' align='center' border='0'><tr>";
		}
		var tblRow = "<tr id=" + tblnm + "TR onmouseover='try{setAbsolute(this)}catch(ETR){}'>";
        for (var i = 0; i < ff.length; i++) {
            if (ff[i].length < 1) continue;
            //alert(ff[i]+"    "+document.getElementById(ff[i]).tagName);
            tblHead += "<td align=center style='border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid'>" + document.getElementById(ff[i] + "text").innerHTML + "</td>";
            //alert("begin row "+i+"...");
            tblRow += "<td align=center style='border-right: #000000 1px solid; border-top: #000000 1px solid; border-left: #000000 1px solid; border-bottom: #000000 1px solid'>" + "<div style=width:100%; id='" + ff[i] + "'>" + "<strong>[" + document.getElementById(ff[i] + "text").innerHTML + "]</strong></div></td>";
            /*var html = "";
			html="<strong>["+fnm+"]</strong>";
			html = "<div style=width:98%; id="+obj.value.split("-")[0]+"-"+obj.value.split("-")[1]+">"+ html +"</div>";*/
        }
        tblHead += "</tr>";
        tblRow += "</tr></table>";
        //alert(tblRow);
        doc.getElementById(tblnm + "DIV").innerHTML = tblHead + tblRow;
    }
}

//字段是否选中
function checkedFields(table_fields, tablename, field_name, isSubTable){
    var sel = "";
    if(table_fields.length>0){
        for(var k=0; k<table_fields.length; k++){
            var sub_tableName = $(table_fields[k]).attr('tableName');
            if(sub_tableName == tablename){
                var val = $(table_fields[k]).val();
                if(val.indexOf(tablename+"-"+field_name+";")>=0){
                    sel = " checked ";
                    if(isSubTable){
                        if (document.getElementById(tablename)){
                            document.getElementById(tablename).value += tablename + '-' + field_name + ';';
                        }
                    }
                }
                break;
            }
        }
    }
    return sel;
}

//----------------------------------------------------
//表单绑定字段属性相关
//----------------------------------------------------
function loadXML(sXml){
	var xmlDom = null;
	//if (window.ActiveXObject){
    if(!! document.all || "ActiveXObject" in window){
		xmlDom = new ActiveXObject("Microsoft.XMLDOM");
        xmlDom.async = false;
        //xmlDom.preserveWhiteSpace = true;
        xmlDom.loadXML(sXml);
	}else{
		if (document.implementation&&document.implementation.createDocument){
			//xmlDom = document.implementation.createDocument("","doc",null);

            var oParser = new DOMParser();
            xmlDom = oParser.parseFromString(sXml,"text/xml");
		}
	}
	
	return xmlDom;
}

function createField2XML(fieldName, addOrDelete){
    if(EZFORM_FIELD_XML_ATTR=='')EZFORM_FIELD_XML_ATTR=CONST_FIELD_XML;

	var xmlDom = loadXML(EZFORM_FIELD_XML_ATTR);
	var fields = xmlDom.selectSingleNode("formSettings/fields");

	if(fields!=null) {
        if(addOrDelete){
            var field = xmlDom.createElement("field");
            var name = xmlDom.createElement("name");
            //name.appendChild(xmlDom.createTextNode(fieldName));
            name.appendChild(xmlDom.createCDATASection(fieldName));

            field.appendChild(name);
            fields.appendChild(field);
        }else{
            var field = fields.selectNodes("field");
            if(field!=null){
                for(var i=0; i<field.length; i++){
                    var name = field[i].selectSingleNode("name");
                    if(name!=null){
                        if(name.text == fieldName){
                            fields.removeChild(field[i]);
                            break;
                        }
                    }
                }
            }
        }
	}

    //alert(xmlDom.xml);

	EZFORM_FIELD_XML_ATTR = xmlDom.xml;
	//alert(xmlDom.xml);
}

function removeXMLFields(){
    var mainFields = ";" + $('#mainFields').val();
    var selectedSubField = ";" + $('#selectedSubField').val();

    var all_fields = mainFields + selectedSubField;

    if(EZFORM_FIELD_XML_ATTR=='')EZFORM_FIELD_XML_ATTR=CONST_FIELD_XML;

	var xmlDom = loadXML(EZFORM_FIELD_XML_ATTR);
	var fields = xmlDom.selectSingleNode("formSettings/fields");

	if(fields!=null) {
        var field = fields.selectNodes("field");
        if(field!=null){
            for(var i=0; i<field.length; i++){
                var name = field[i].selectSingleNode("name");
                if(name!=null){
                    if(all_fields.indexOf(";"+name.text+";")==-1){
                        fields.removeChild(field[i]);
                    }
                }
            }
        }
	}

    EZFORM_FIELD_XML_ATTR = xmlDom.xml;
}

function createFieldAttr2XML(controlID, attrJson){
    if(EZFORM_FIELD_XML_ATTR=='')EZFORM_FIELD_XML_ATTR=CONST_FIELD_XML;

	var xmlDom = loadXML(EZFORM_FIELD_XML_ATTR);
	var fields = xmlDom.selectSingleNode("formSettings/fields");

	if(fields!=null) {
        var field = fields.selectNodes("field");
        /*if(field==null || field.length == 0){
            var fieldNew = xmlDom.createElement("field");
            var name = xmlDom.createElement("name");
            //name.appendChild(xmlDom.createTextNode(fieldName));
            name.appendChild(xmlDom.createCDATASection(controlID));

            fieldNew.appendChild(name);
            fields.appendChild(fieldNew);

            field = fields.selectNodes("field");
        }*/
        var exist = xmlDom.selectSingleNode("formSettings/fields/field/name[.='"+controlID+"']");
        if(exist==null){
            var fieldNew = xmlDom.createElement("field");
            var name = xmlDom.createElement("name");
            //name.appendChild(xmlDom.createTextNode(fieldName));
            name.appendChild(xmlDom.createCDATASection(controlID));

            fieldNew.appendChild(name);
            fields.appendChild(fieldNew);

            field = fields.selectNodes("field");
        }
        if(field!=null){
            for(var i=0; i<field.length; i++){
                var name = field[i].selectSingleNode("name");
                if(name!=null){
                    //if(controlID.indexOf('-'+name.text)!=-1){
                    if(controlID == name.text){
                        var json_ = eval("("+attrJson+")");
                        if(json_){
                            var events = json_.events;
                            if(events){
                                for(var attr in events){
                                    if(attr!='blank'){
                                        var val = events[attr];
                                        createFieldAttr(xmlDom, "events", field[i], attr, val);
                                    }
                                }
                            }

                            var style = json_.style;
                            if(style){
                                for(var attr in style){
                                    if(attr!='blank'){
                                        var val = style[attr];
                                        createFieldAttr(xmlDom, "style", field[i], attr, val);
                                    }
                                }
                            }
                        }
                        break;
                    }
                }
            }
        }
	}

	EZFORM_FIELD_XML_ATTR = xmlDom.xml;
	//alert(EZFORM_FIELD_XML_ATTR);
}

function createFieldAttr(xmlDom, type, field, name, value){
    var eleObj = field.selectSingleNode(type);
    if(eleObj!=null){
        var nameObj = eleObj.selectSingleNode(name);
        if(nameObj!=null){
            eleObj.removeChild(nameObj);
        }
        var name = xmlDom.createElement(name);
        name.appendChild(xmlDom.createCDATASection(value));
        eleObj.appendChild(name);
        field.appendChild(eleObj);
    }else{
        var newObj = xmlDom.createElement(type);
        var name = xmlDom.createElement(name);
        name.appendChild(xmlDom.createCDATASection(value));
        newObj.appendChild(name);
        field.appendChild(newObj);
    }    
}

function getFieldsWithXml(){
    var xmlDom = loadXML(EZFORM_FIELD_XML_ATTR);
	var fields = xmlDom.selectSingleNode("formSettings/fields");
    return fields;
}

function getFieldAttrWithXml(fields, controlID, type, attr){
    if(fields!=null) {
        var field = fields.selectNodes("field");
        if(field){
            for(var i=0; i<field.length; i++){
                var name = field[i].selectSingleNode("name");
                if(name!=null){
                    //if(controlID.indexOf('-'+name.text)!=-1){
                    if(controlID == name.text){
                        var eleObj = field[i].selectSingleNode(type);
                        if(eleObj!=null){
                            var attrObj = eleObj.selectSingleNode(attr);
                            if(attrObj!=null){
                                return attrObj.text;
                            }
                        }
                    }
                }
            }
        }
	}
    return "";
}

//------------------------------------------------------------
var isIE = !! document.all || "ActiveXObject" in window;//!!window.ActiveXObject || "ActiveXObject" in window;//!! document.all;

function parseXML(st) {
    if (isIE) {
        var result = new ActiveXObject("Microsoft.XMLDOM");
        result.loadXML(st);
    } else {
        var parser = new DOMParser();
        var result = parser.parseFromString(st, "text/xml");
    }
    return result;
}

if (!isIE) {
    var ex;
    XMLDocument.prototype.__proto__.__defineGetter__("xml", function () {
        try {
            return new XMLSerializer().serializeToString(this);
        } catch (ex) {
            var d = document.createElement("div");
            d.appendChild(this.cloneNode(true));
            return d.innerHTML;
        }
    });
    Element.prototype.__proto__.__defineGetter__("xml", function () {
        try {
            return new XMLSerializer().serializeToString(this);
        } catch (ex) {
            var d = document.createElement("div");
            d.appendChild(this.cloneNode(true));
            return d.innerHTML;
        }
    });
    XMLDocument.prototype.__proto__.__defineGetter__("text", function () {
        return this.firstChild.textContent;
    });
    Element.prototype.__proto__.__defineGetter__("text", function () {
        return this.textContent;
    });

    XMLDocument.prototype.selectSingleNode = Element.prototype.selectSingleNode = function (xpath) {
        var x = this.selectNodes(xpath);
        if (!x || x.length < 1) return null;
        return x[0];
    }
    XMLDocument.prototype.selectNodes = Element.prototype.selectNodes = function (xpath) {
        var xpe = new XPathEvaluator();
        var nsResolver = xpe.createNSResolver(this.ownerDocument == null ?
            this.documentElement : this.ownerDocument.documentElement);
        var result = xpe.evaluate(xpath, this, nsResolver, 0, null);
        var found = [];
        var res;
        while (res = result.iterateNext())
            found.push(res);
        return found;
    }
}
//------------------------------------------------------------