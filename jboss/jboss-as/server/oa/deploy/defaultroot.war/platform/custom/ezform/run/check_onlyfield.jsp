<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String infoId = request.getParameter("infoId");
String field = request.getParameter("field");
String fieldValue=request.getParameter("fieldValue");
String fieldId = request.getParameter("fieldId");
String isSubTableField=request.getParameter("isSubTableField");
response.setContentType("text/html; charset=UTF-8");
response.setHeader("Cache-Control","no-cache");
com.whir.ezoffice.customdb.common.util.DbOpt dbOpt = new com.whir.ezoffice.customdb.common.util.DbOpt();
String aaa = dbOpt.dbtype.indexOf("sqlserver")>=0?"N":"";
com.whir.common.util.DataSourceBase ds = new com.whir.common.util.DataSourceBase();
java.sql.Connection conn = null;
java.sql.Statement stmt = null;
try {
	conn = ds.getDataSource().getConnection();
	stmt = conn.createStatement();
	String tableName="";
	java.sql.ResultSet rs=stmt.executeQuery("select table_name from ttable where table_id in(select field_table from tfield where field_id="+fieldId+")");
	if(rs.next()){
		tableName=rs.getString(1);
	}
	rs.close();
	fieldValue = fieldValue.trim();
	if(fieldValue==null || fieldValue.equals("") || fieldValue.equals("null")){
		fieldValue="Îª¿ÕÊ±²»ÅÐ¶Ï";
	}
	String sql="select count(*) from "+tableName+" where "+field+"="+aaa+"'"+fieldValue+"' ";//and ("+tableName+"_WORKSTATUS!=-1 or "+tableName+"_WORKSTATUS is null)";
	if(infoId!=null && !"null".equals(infoId) && !"".equals(infoId)){
        if("1".equals(isSubTableField)){
            sql+=" and "+tableName+"_foreignkey<>"+infoId+" and ("+tableName+"_WORKSTATUS!=-1 or "+tableName+"_WORKSTATUS is null)";
        }else{
		    sql+=" and "+tableName+"_id<>"+infoId;
        }
	}
	//System.out.println(sql);
	rs=stmt.executeQuery(sql);
	if(rs.next()){
		String cnt = rs.getString(1);
		out.print(!"0".equals(cnt)?"more":"none");
	}
	rs.close();
	stmt.close();
 }catch(Exception ex){
	ex.printStackTrace();
}finally{
    if(conn!=null){
		try{
			conn.close();
		}catch(Exception err){
			err.printStackTrace();
		}
	}
}
%>