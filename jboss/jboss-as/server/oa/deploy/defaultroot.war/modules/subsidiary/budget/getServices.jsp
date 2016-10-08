<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.budget.bd.BudgetBD"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
response.setContentType("text/html;Charset=UTF-8");
request.setCharacterEncoding("UTF-8");
String tag = request.getParameter("tag")==null?"":request.getParameter("tag").trim();
String result = "";
StringBuffer sb = new StringBuffer();
if("currentSectionOrderCode".equalsIgnoreCase(tag)){//预算部门排序
	String parentsectionid = request.getParameter("parentsectionid")==null?"":request.getParameter("parentsectionid").trim();
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	if(!"".equals(parentsectionid)){
		BudgetBD bd = new BudgetBD();
		String whereSQL = " where po.parentsectionid=" + parentsectionid;
		if(!"".equals(sectionid))		
		whereSQL += " and po.sectionid<>" + sectionid;
		whereSQL +=" order by sectionidstring";
		List list = bd.getSectionList(whereSQL);
		for(int k=0; null != list && k<list.size();k++){
			com.whir.ezoffice.budget.po.BudgetSectionPO po = (com.whir.ezoffice.budget.po.BudgetSectionPO)list.get(k);
			sb.append("<option value=\"" + po.getSectionid() + "\">").append(po.getSectionname()).append("</option>");
		}
	}
	result = sb.toString();	
}else if("currentSubjectOrderCode".equalsIgnoreCase(tag)){//科目排序
	String parentsubjectid = request.getParameter("parentsubjectid")==null?"":request.getParameter("parentsubjectid").trim();
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();
	if(!"".equals(parentsubjectid)){
		BudgetBD bd = new BudgetBD();
		String viewSQL = "distinct po.subjectid,po.subjectnamestring,po.subjectidstring";
        String fromSQL = "com.whir.ezoffice.budget.po.BudgetSubjectPO po join po.sections section";

		String whereSQL = " where po.status=0 and po.parentsubjectid=" + parentsubjectid;
		if(!"".equals(subjectid))		
		whereSQL += " and po.subjectid<>" + subjectid;
		whereSQL +=" order by subjectidstring";	
		com.whir.common.page.Page p = new com.whir.common.page.Page(viewSQL, fromSQL, whereSQL.toString());
	    p.setPageSize(9999999);
	    p.setcurrentPage(1);
	    List list = p.getResultList();	
		for(int k=0; null != list && k<list.size();k++){
			Object[] data = (Object[])list.get(k);
			//com.whir.ezoffice.budget.po.BudgetSubjectPO po = (com.whir.ezoffice.budget.po.BudgetSubjectPO)list.get(k);
			sb.append("<option value=\"" + data[0] + "\">").append(data[1]).append("</option>");
		}
	}
	result = sb.toString();	
}else if("changeSubject_adjust".equals(tag)){//预算调整选择科目
	result = "0,0";//新增修改都不需要审核
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();
	if(!"".equals(subjectid)){
		BudgetBD bd = new BudgetBD();
		com.whir.ezoffice.budget.po.BudgetSubjectPO po = bd.getBudgetSubject(Long.valueOf(subjectid));
		if(null != po && po.getSubjectaudit().intValue()==1){
			result = "1";//新增需要审核
		}else{
			result = "0";//新增不需要审核
		}
		if(null != po && po.getSubjectperiod().intValue()==1){
				result +=",1";//修改需要审核
		}else{
			result +=",0";//修改需要审核
		}
		
	}
}else if("changeSection".equals(tag)){//预算新增或修改选择部门
	result = "0,0";//不需要审核
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	if(!"".equals(sectionid)){
		BudgetBD bd = new BudgetBD();
		com.whir.ezoffice.budget.po.BudgetSectionPO po = bd.getBudgetSectionPO(Long.valueOf(sectionid));
		if(null != po && po.getSectionNeedCheckupForAdd().intValue()==1){
			result = "1";//需要审核
		}else{
			result = "0";//不需要审核
		}
		if(null != po && po.getSectionNeedCheckupForModi().intValue()==1){
				result +=",1";
		}else{
			result +=",0";
		}
		
	}
}else if("getWorkflowStatus".equals(tag)){//预算走流程时 已经在办理中的流程不允许多次申请
	result = "nohave";//不需要审核
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	String costyear = request.getParameter("costyear")==null?"":request.getParameter("costyear").trim();
	if(!"".equals(sectionid) && !"".equals(costyear)){
		BudgetBD bd = new BudgetBD();
		com.whir.ezoffice.budget.po.BudgetCostWorkFlowPO po = bd.
        getWorkflowpoByCostyearAndSectionid(costyear,sectionid+"");
		if(null != po){
			int stauts=0;
			
			if(po.getWorkflowStatus() != null){
				stauts=po.getWorkflowStatus().intValue();
			}
			if(stauts == 1 || stauts == -2){
				result = "ishave";
			}
		}		
	}
}else if("sectionnameValidate".equals(tag)){//预算部门名称不重复
	result = "0";
	String parentsectionid = request.getParameter("parentsectionid")==null?"":request.getParameter("parentsectionid").trim();
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	String sectionname = request.getParameter("sectionname")==null?"":request.getParameter("sectionname").trim();
	String hql = " where po.parentsectionid=" + parentsectionid;
	hql += " and po.sectionname='" + sectionname + "'";
	if(!"".equals(sectionid)){
		hql += " and po.sectionid<>" + sectionid;
	}
	com.whir.ezoffice.budget.bd.BudgetBD bd = new com.whir.ezoffice.budget.bd.BudgetBD();
	java.util.List list = bd.getSectionList(hql);
	if(list.size()>0){
		result = "1";
	}
}else if("subjectnameValidate".equals(tag)){//预算科目名称不重复
	result = "";
	String parentsubjectid = request.getParameter("parentsubjectid")==null?"":request.getParameter("parentsubjectid").trim();
	String sectionids = request.getParameter("sectionids")==null?"":request.getParameter("sectionids").trim();
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();
	String subjectname = request.getParameter("subjectname")==null?"":request.getParameter("subjectname").trim();
	
	String hql = "";
	String[] sectionidsArray = sectionids.split(",");
	for(int k=0;null != sectionidsArray && k<sectionidsArray.length && "".equals(result);k++){
		if("".equals(sectionidsArray[k]))continue;
		hql = " join po.sections section where po.parentsubjectid=" + parentsubjectid;
		hql += " and po.subjectname='" + subjectname + "'";
		hql += " and section.sectionid in(" + sectionidsArray[k] + ")";
		if(!"".equals(subjectid)){
			hql += " and po.subjectid<>" + subjectid;
		}
		com.whir.ezoffice.budget.bd.BudgetBD bd = new com.whir.ezoffice.budget.bd.BudgetBD();
		java.util.List list = bd.getSubjectList(hql);
		if(list.size()>0){
			result = sectionidsArray[k];
		}
	}

	
}else if("projectCostValidate".equals(tag)){//预算项目名称不重复
	result = "0";
	String projectId = request.getParameter("projectId")==null?"":request.getParameter("projectId").trim();
	String costId = request.getParameter("costId")==null?"":request.getParameter("costId").trim();
	String hql = " where po.projectId=" + projectId;
	if(!"".equals(costId)){
		hql += " and po.costId<>" + costId;
	}
	com.whir.ezoffice.budget.bd.BudgetProjectBD bd = new com.whir.ezoffice.budget.bd.BudgetProjectBD();
	java.util.List list = bd.getBudgetProjectCostList(hql);
	if(list.size()>0){
		result = "1";
	}
}else if("projectSubjectValidate".equals(tag)){//预算项目科目不重复
	result = "0";
	String parentsubjectid = request.getParameter("parentsubjectid")==null?"":request.getParameter("parentsubjectid").trim();
	String costId = request.getParameter("costId")==null?"":request.getParameter("costId").trim();
	String subjectname = request.getParameter("subjectname")==null?"":request.getParameter("subjectname").trim();
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();
	String hql = " join po.cost cost where po.cost in(" + costId + ")";
	hql +=" and po.parentsubjectid=" + parentsubjectid;
	hql +=" and po.subjectname='" + subjectname + "'";
	if(!"".equals(subjectid)){
		hql += " and po.subjectid<>" + subjectid;
	}
	com.whir.ezoffice.budget.bd.BudgetProjectBD bd = new com.whir.ezoffice.budget.bd.BudgetProjectBD();
	java.util.List list = bd.getBudgetProjectSubjectList(hql);
	if(list.size()>0){
		result = "1";
	}
}else if("budgetBalance".equals(tag)){//预算余额
	result = "0";
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();
	String subjectperiod = request.getParameter("subjectperiod")==null?"":request.getParameter("subjectperiod").trim();
	String p_wf_processId = request.getParameter("p_wf_processId")==null?"":request.getParameter("p_wf_processId").trim();
	String p_wf_recordId = request.getParameter("p_wf_recordId")==null?"":request.getParameter("p_wf_recordId").trim();
	String decnum = request.getParameter("decnum")==null?"2":request.getParameter("decnum").trim();
	

	String userId = session.getAttribute("userId").toString();
	String orgId = session.getAttribute("orgId").toString();


	String year = subjectperiod,month = "" ;
	if(subjectperiod.indexOf("-")>0){
		year = subjectperiod.substring(0,4);
		month = subjectperiod.substring(5,subjectperiod.length());
	}
    if(month !=null && !month.equals("") &&!month.equals("null")&&month.compareTo("10")<0){
        month=month.substring(1, month.length());
    }
	if(!"".equals(sectionid) && !"".equals(subjectid)){
		com.whir.ezoffice.budget.bd.BudgetBD bd = new com.whir.ezoffice.budget.bd.BudgetBD();
		Object[] data = bd.getBudgetCostBalance(userId,orgId,year,month,Long.valueOf(sectionid.split(";")[0]),Long.valueOf(subjectid.split(";")[0]),new Double(0),p_wf_processId,p_wf_recordId);

		result = data[3]==null?"0":data[3]+"";
		String num="0.";
		if(decnum == null || decnum.equals("") || decnum.equals("null") || decnum.equals("undefined")){
			decnum="6";
		}
		if(decnum != null && !decnum.equals("") && !decnum.equals("null")){
			int n=Integer.parseInt(decnum);
			for(int i=0;i<n;i++){
				num+="0";
			}
		}
		
		//result = com.whir.ezoffice.ezform.util.FormHelper.formatNumber(result, Integer.parseInt(decnum), true);
		java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat(num);//格式化数字
		result = decimalFormat.format(Double.parseDouble(result));
		result = result.substring(0,result.indexOf(".")+3);
	}

}else if("budgetBalanceCheck".equals(tag)){//预算余额提交检查
	result = "";
	java.util.TimeZone zone=java.util.TimeZone.getTimeZone("GMT+8");	
	java.util.Calendar cal = java.util.Calendar.getInstance(zone);
	String sectionIds = request.getParameter("sectionIds")==null?"":request.getParameter("sectionIds").trim();
	String subjectIds = request.getParameter("subjectids")==null?"":request.getParameter("subjectids").trim();
	String curAmounts = request.getParameter("curAmounts")==null?"0":request.getParameter("curAmounts").trim();
	String subjectperiod = request.getParameter("subjectperiod")==null?"":request.getParameter("subjectperiod").trim();
	String userId = session.getAttribute("userId").toString();
	String orgId = session.getAttribute("orgId").toString();
	String p_wf_processId = request.getParameter("p_wf_processId")==null?"":request.getParameter("p_wf_processId").trim();
	String p_wf_recordId = request.getParameter("p_wf_recordId")==null?"":request.getParameter("p_wf_recordId").trim();
	//String year = (cal.get(cal.YEAR))+"";
	//int curMonth = cal.get(cal.MONTH)+1;
	//String month = curMonth<10?"0"+curMonth:curMonth+"";
	
	if(!"".equals(subjectIds)){
		com.whir.ezoffice.budget.bd.BudgetBD bd = new com.whir.ezoffice.budget.bd.BudgetBD();
		String[] subjectArray = subjectIds.split(",");
		String[] sectionArray = sectionIds.split(",");
		String[] curAmountArray = curAmounts.split(",");
		String[] subjectperiodArray = subjectperiod.split(",");

		for(int k=0;k<subjectArray.length;k++){
			String curAmountValue = "".equals(curAmountArray[k])?"0":curAmountArray[k];
			String year = subjectperiodArray[k],month = "" ;
	if(subjectperiodArray[k].indexOf("-")>0){
		year = subjectperiodArray[k].substring(0,4);
		month = subjectperiodArray[k].substring(5,subjectperiodArray[k].length());
	}
    if(month !=null && !month.equals("") &&!month.equals("null")&&month.compareTo("10")<0){
        month=month.substring(1, month.length());
    }
	System.out.println("++==subjectperiodArray[k]:"+subjectperiodArray[k]);
			Object[] data = bd.getBudgetCostBalance(userId,orgId,year,month,Long.valueOf(sectionArray[k]),Long.valueOf(subjectArray[k]),Double.valueOf(curAmountValue),p_wf_processId,p_wf_recordId);
			result = data[3]==null?"0":data[3]+"";
			java.text.DecimalFormat decimalFormat = new java.text.DecimalFormat("0.00");//格式化数字
			result = decimalFormat.format(Double.parseDouble(result));
			double balanceAmount = Double.parseDouble(result);
			System.out.println("++==data[5]:"+data[5]);
			if("0".equals(data[5]+"")){
				result = (data[1]==null?"":data[1].toString()) + "没预算!" + ";" + (data[2]==null?"0":data[2].toString());
				break;
			}else if(balanceAmount<0){
				result = (data[1]==null?"":data[1].toString()) + "超预算了!" + ";" + (data[2]==null?"0":data[2].toString());
				break;
			}else{
				result = "";
			}
		}
	}
	

}else if("sectionQuote".equals(tag)){//预算部门是否被引用	
	result = "";
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();	
	if(!"".equals(sectionid)){
		com.whir.ezoffice.customdb.common.util.DbOpt dbopt = new com.whir.ezoffice.customdb.common.util.DbOpt();
		String countNum =  dbopt.executeQueryToStr("select count(*) from bg_cost where SECTIONID in(" + sectionid + ")");
		if(!"0".equals(countNum)){
			result = "1";
		}

	}

}else if("subjectQuote".equals(tag)){//预算部门是否被引用
	result = "";
	String subjectid = request.getParameter("subjectid")==null?"":request.getParameter("subjectid").trim();	
	if(!"".equals(subjectid)){
		com.whir.ezoffice.customdb.common.util.DbOpt dbopt = new com.whir.ezoffice.customdb.common.util.DbOpt();
		String countNum =  dbopt.executeQueryToStr("select count(*) from bg_cost where SUBJECTID in(" + subjectid + ")");
		if(!"0".equals(countNum)){
			result = "1";
		}

	}

}else if("costQuote".equals(tag)){//预算费用是否被引用
	result = "";
	String sectionid = request.getParameter("sectionid")==null?"":request.getParameter("sectionid").trim();
	String costyear = request.getParameter("costyear")==null?"":request.getParameter("costyear").trim();
	
	if(!"".equals(sectionid)){
		com.whir.ezoffice.customdb.common.util.DbOpt dbopt = new com.whir.ezoffice.customdb.common.util.DbOpt();
		String countNum =  dbopt.executeQueryToStr("select count(*) from BG_COST_APPLY where SECTIONID in(" + sectionid + ") and APPLYYEAR='" + costyear + "'");
		if(!"0".equals(countNum)){
			result = "1";
		}

	}

}
%>
<%
out.print(result);
%>
