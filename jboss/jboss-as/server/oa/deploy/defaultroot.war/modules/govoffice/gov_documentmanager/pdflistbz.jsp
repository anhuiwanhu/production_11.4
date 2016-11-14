<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>标准列表页面结构</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="/defaultroot/GovDocReceiveProcess!pdflistbzdata.action" method="post" theme="simple">
    <input type="hidden" name="receiveFileId" value="<%=request.getParameter("receiveFileId")%>"/>
    <input type="hidden" name="pdfgwlx" value="<%=request.getParameter("pdfgwlx")%>"/>
    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>


    <!-- SEARCH PART END -->


    <!-- MIDDLE	BUTTONS	START -->

    <!-- MIDDLE	BUTTONS	END -->

    <!-- LIST TITLE PART START -->
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
        <thead id="headerContainer">
        <tr class="listTableHead">
            <td whir-options="field:'pdfrealname',width:'30%',renderer:show">批注PDF</td>
            <td whir-options="field:'pdfzhxgsj',width:'30%',renderer:common_DateFormatMinite">最后批注时间</td>
            <td whir-options="field:'pdfpzhj', width:'40%'">批注人及环节</td>
        </tr>
        </thead>
        <tbody  id="itemContainer" >

        </tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->

</s:form>


</body>


<script type="text/javascript">

    //*************************************下面的函数属于公共的或半自定义的*************************************************//

    //初始化列表页form表单,"queryForm"是表单id，可修改。
    $(document).ready(function(){
        initListFormToAjax({formId:"queryForm"});
        //initListFormToAjax("queryForm");
    });




    //自定义查看栏内容
    function show(po,i){

        var url="<%=rootPath +"/public/download/download.jsp?FileName="%>"+ po.pdfsavename +"%26name="+po.pdfsavename+"%26path="+po.pdfwjjmc + "%26ispdf=1" ;
        var html='<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/modules/govoffice/gov_documentmanager/viewPDFTemp.jsp?FileName='+ po.pdfsavename +'&name='+po.pdfsavename+'&path='+po.pdfwjjmc+'\',width:620,height:600,winName:\'showPDF\'});">'+po.pdfrealname+'</a>';

      return html;
    }







</script>

</html>

