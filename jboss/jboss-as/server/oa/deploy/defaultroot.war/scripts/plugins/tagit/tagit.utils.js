;
function whirTagit(json){
    //tagitId 必填
    if(json.tagitId === undefined){
        return ;
    }

    function split(val) {
        return val.split(/,\s*/);
    }

    String.prototype.trimLR = function() {
        return this.replace(/^\s+|\s+$/g, '');
    }

    function extractLast(term) {
        return split(term.trimLR()).pop();
    }

    var tagitId   = json.tagitId;
    var range     = json.range !== undefined ?json.range:'0';
    var inputName = json.inputName !== undefined ? json.inputName : '';
    var inputId   = json.inputId !== undefined ? json.inputId : '';
    var readOnly  = json.readOnly !== undefined ? json.readOnly : false;

    //inputName = replaceDollar(inputName);
    //inputId = replaceDollar(inputId);

    var maxTags = 1000;
    var single = false;//默认：多选
    if(json.single !== undefined){
        single = json.single;
        if(single){
            maxTags = 1;
        }
    }

    var initialTagsData = [];
    var initBool = false;
    if(json.initBool !== undefined){
        initBool = json.initBool;
        if(initBool){
            initialTagsData = getTagsData(json);
        }
    }

    function _added(tagValue, action, element, json){
        var inputName = json.inputName !== undefined ? json.inputName :'';
        var inputId   = json.inputId !== undefined ? json.inputId :'';

        inputName = replaceDollar(inputName);
        inputId = replaceDollar(inputId);

        var inputIdData = '';
        var inputNameData = '';
        if(inputId !== ''){
            inputIdData = $('#'+inputId).val();
        }
        if(inputName !== ''){
            inputNameData = $('#'+inputName).val();
        }

        var _label = $(element).attr('label');
        var _tagvalue = $(element).attr('tagvalue');

        if(single){
            inputNameData = _label;
            inputIdData = _tagvalue;
        }

        if(single == false){
            inputNameData += _label + ",";
            inputIdData += _tagvalue;
        }

        $('#'+inputId).val(inputIdData);
        $('#'+inputName).val(inputNameData);

        try{
            if(json.addedCallback !== undefined){
                var cb = eval(json.addedCallback);cb.call(this);
            }
        }catch(e){}
    }

    function _popped(tagValue, action, element, json){
        var inputName = json.inputName !== undefined ? json.inputName :'';
        var inputId = json.inputId !== undefined ? json.inputId :'';

        inputName = replaceDollar(inputName);
        inputId = replaceDollar(inputId);

        var inputIdData = '';
        var inputNameData = '';

        if(single == false){
            if(inputId !== ''){
                inputIdData = $('#'+inputId).val();

                if(inputName !== ''){
                    inputNameData = $('#'+inputName).val();
                }

                var _label = $(element).attr('label');

                inputNameData = "," + inputNameData + ",";
                inputNameData = inputNameData.replace(','+_label+',', ',');
                inputNameData = inputNameData.substring(1, inputNameData.length-1);

                var idLen = (''+tagValue+'').length;
                var idIndex = inputIdData.indexOf(''+tagValue+'');
                var idSubPre = inputIdData.substring(0, idIndex);
                var idSubSuf = inputIdData.substring(idIndex + idLen);
                inputIdData = idSubPre + idSubSuf;
            }
        }

        $('#'+inputId).val(inputIdData);
        $('#'+inputName).val(inputNameData);//.substring(1, inputNameData.length-1));

        try{
            if(json.poppedCallback !== undefined){
                var cb = eval(json.poppedCallback);cb.call(this);
            }
        }catch(e){}
    }

    var sourceUrl = whirRootPath + "/SelectOrgAndUser!searchUserByTerm.action";
    $('#'+tagitId).tagit({
        tagSource: function (request, response) {
            $.getJSON(sourceUrl + "?range="+range+"&single="+single, {
                term: extractLast(request.term)
            }, response);
        },
        allowNewTags: false,
        initialTags: initialTagsData,
        triggerKeys: ['enter', 'comma', 'tab'],
        maxTags: maxTags,
        readOnly: readOnly,
        tagsChanged: function (tagValue, action, element) {
            //alert(tagValue + ' was ' + action + ', obj:' + element);            
            if(action === 'added'){
                _added(tagValue, action, element, json);
            }else if(action === 'popped'){
                _popped(tagValue, action, element, json);
            }
        },
        focus: function() {
            // prevent value inserted on focus
            return true;
        }
    });

    //get a reference to the autocomplete object
	//var ac = $('#'+tagitId).tagit('autocomplete');

	//add a custom class for themeing
	//ac.menu.element.addClass('custom-ac');

	//attach the autocomplete to the bottom left of the tag list
	//ac.options.position = {my:"left top", at:"left bottom", collision:"none", of:$('#'+tagitId).data('tagit').element };

	//overwrite the autocomplete _renderItem function!
	//ac._renderItem = function (ul, item) {
    $.ui.autocomplete.prototype._renderItem = function (ul, item) {
		//highlight the matching terms
		var re = new RegExp(this.term, "gi");
		var label = item.label;//.replace(re, '<span class="blue">' + "$&" + "</span>");
		var title = item.title;//.replace(re, '<span class="blue">' + "$&" + "</span>");

		//render the entry
		var rendered = '<a><div>' + label + '&lt;' + title + "&gt;</div></a>";

		return $('<li class="ac-item ui-corner-all"></li>')
			.data("item.autocomplete", item)
			.append(rendered)
			.appendTo(ul);
	};
}

function whirTagitAdd(json){
    //tagitId 必填
    if(json.tagitId === undefined){
        return ;
    }

    var tagitId = json.tagitId;

    var inputName = json.inputName !== undefined ? json.inputName :'';
    var inputId   = json.inputId !== undefined ? json.inputId :'';

    inputName = replaceDollar(inputName);
    inputId = replaceDollar(inputId);

    var inputNameData = json.inputNameData !== undefined ? json.inputNameData :'';
    var inputIdData   = json.inputIdData !== undefined ? json.inputIdData :'';

    $('#'+tagitId).tagit("add", {label: inputNameData, value: inputIdData});
}

function whirTagitFill(json){
    //id 必填
    if(json.tagitId === undefined){
        return ;
    }

    var tagitId = json.tagitId;

    var inputName = json.inputName !== undefined ? json.inputName :'';
    var inputId   = json.inputId !== undefined ? json.inputId :'';

    inputName = replaceDollar(inputName);
    inputId = replaceDollar(inputId);

    var initialTagsData = [];
    var inputIdData = '';
    var inputNameData = '';
    if(inputId !== ''){
        inputIdData = $('#'+inputId).val();

        if(inputName !== ''){
            inputNameData = $('#'+inputName).val();
        }
        
        initialTagsData = getTagsData(json);
    }

    $('#'+tagitId).tagit("fill", initialTagsData);
}

function getTagsData(json){
    var tagitId = json.tagitId;

    var inputName = json.inputName !== undefined ? json.inputName :'';
    var inputId   = json.inputId !== undefined ? json.inputId :'';

    inputName = replaceDollar(inputName);
    inputId = replaceDollar(inputId);

    var separate_u = '$';
    var separate_o = '*';
    var separate_g = '@';
    var single = false;//默认：多选
    if(json.single !== undefined){
        single = json.single;
        if(single){
            separate_u = '';
        }
    }

    var initialTagsData = [];
    var inputIdData = '';
    var inputNameData = '';
    if(inputId !== ''){
        inputIdData = $('#'+inputId).val();

        if(inputName !== ''){
            inputNameData = $('#'+inputName).val();
        }
    
        $.ajax({
            url: whirRootPath + "/SelectOrgAndUser!getScopeFilter.action",
            type: "POST",
            cache: false,
            async: false,
            dataType: 'json',
            data: {"filter_scopeIds":inputIdData, "single":single, "whirTagit":"1"},
            success: function(data){
                //json
                var selectedId    = data.scopeIdStr;
                var selectedName  = data.scopeNameStr;
                var selectedTitle = data.scopeTitleStr;
                if(selectedId != ''){
                    var selectedNameArr = selectedName.split(",");
                    var selectedTitleArr = selectedTitle.split(",");

                    var start = 0;
                    var end = 0;
                    var charArray = selectedId;
                    var tempStr = "";
                    var j = 0;
                    var m = 0;
                    for(var i=0; i<charArray.length; i++){
                        tempStr = tempStr + charArray.charAt(i);
                        end++;

                       if(charArray.charAt(i)=='$' && (start+1) != end){//user
                            tempStr = tempStr.substring(1, tempStr.length - 1);

                            initialTagsData.push({label:selectedNameArr[j++], value:separate_u+tempStr+separate_u, title:selectedTitleArr[m++]});

                            tempStr = "";
                            start = end;
                        } else if(charArray.charAt(i)=='*' && (start+1) != end){//org
                            tempStr = tempStr.substring(1, tempStr.length - 1);

                            initialTagsData.push({label:selectedNameArr[j++], value:'*'+tempStr+'*'});//, title:selectedTitleArr[m++]});

                            tempStr = "";
                            start = end;
							m++;//2016-07-19 xiehd 添加 解决title不正确
                        }else if(charArray.charAt(i)=='@' && (start+1) != end){//group
                            tempStr = tempStr.substring(1, tempStr.length - 1);
                            initialTagsData.push({label:selectedNameArr[j++], value:'@'+tempStr+'@'});//, title:selectedTitleArr[m++]});
                            tempStr = "";
                            start = end;
							m++;//2016-07-19 xiehd 添加 解决title不正确
                        }
                    }
                }
            }
        });
    }
    
    return initialTagsData;
}

function whirTagitReset(json){
    //tagitId 必填
    if(json.tagitId === undefined){
        return ;
    }

    var tagitId = json.tagitId;
    $('#'+tagitId).tagit("reset");
}

function callbackTagit(json){
    //id 必填
    if(json.tagitId === undefined){
        return ;
    }

    whirTagitReset({tagitId:json.tagitId});
    whirTagitFill({tagitId:json.tagitId, inputId:json.inputId, inputName:json.inputName, single:json.single});
}
