<%@ page contentType="application/msword;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
String title = request.getParameter("title")!=null?request.getParameter("title"):"导出Doc格式";
response.setHeader("Content-disposition", "attachment;filename="+com.whir.component.util.SystemUtils.encodeName(title, request)+".doc");
String content = request.getParameter("content");
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 14">
<meta name=Originator content="Microsoft Word 14">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<!--[if gte mso 9]><xml>
    <w:WordDocument>
        <w:View>Print</w:View>
        <w:TrackMoves>false</w:TrackMoves>
        <w:TrackFormatting/>
        <w:ValidateAgainstSchemas/>
        <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
        <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
        <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
        <w:DoNotPromoteQF/>
        <w:LidThemeOther>EN-US</w:LidThemeOther>
        <w:LidThemeAsian>ZH-CN</w:LidThemeAsian>
        <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
        <w:Compatibility>
            <w:BreakWrappedTables/>
            <w:SnapToGridInCell/>
            <w:WrapTextWithPunct/>
            <w:UseAsianBreakRules/>
            <w:DontGrowAutofit/>
            <w:SplitPgBreakAndParaMark/>
            <w:DontVertAlignCellWithSp/>
            <w:DontBreakConstrainedForcedTables/>
            <w:DontVertAlignInTxbx/>
            <w:Word11KerningPairs/>
            <w:CachedColBalance/>
            <w:UseFELayout/>
        </w:Compatibility>
        <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
        <m:mathPr>
            <m:mathFont m:val="Cambria Math"/>
            <m:brkBin m:val="before"/>
            <m:brkBinSub m:val="--"/>
            <m:smallFrac m:val="off"/>
            <m:dispDef/>
            <m:lMargin m:val="0"/>
            <m:rMargin m:val="0"/>
            <m:defJc m:val="centerGroup"/>
            <m:wrapIndent m:val="1440"/>
            <m:intLim m:val="subSup"/>
            <m:naryLim m:val="undOvr"/>
        </m:mathPr>
    </w:WordDocument>
</xml><![endif]-->
</head>
</head>
<body lang=ZH-CN>
<%=content%>
</body>
</html>