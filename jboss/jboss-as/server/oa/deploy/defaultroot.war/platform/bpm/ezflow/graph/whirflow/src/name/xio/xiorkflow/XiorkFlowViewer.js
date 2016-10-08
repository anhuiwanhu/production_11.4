
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function XiorkFlowViewer() {
    this.base = ScrollPanel;
    this.base();

    //
    this.setClassName("NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_VIEWER"); 
    var this_=this;
	//非IE状况下 加
	if(Toolkit.getBrowserType()!="MSIE"){
	   $(this.getUI()).css("overflow","hidden");
	   $(this.getUI()).resize(function(){ 
		  var elem = $(this);
	      //alert(elem.width());
		  //alert(elem.height());
		  var svgObj=this_.getSvgPanel(); 
		  if(svgObj){
		      //svgObj.setAttribute("height",elem.height()-30);
		      //svgObj.setAttribute("width",elem.width()-30);
		  }

	   });	 
	}
}
XiorkFlowViewer.prototype = new ScrollPanel();

XiorkFlowViewer.prototype.setSvgPanel= function (svgPanel) {
     if(!this.svgPanel){
	   this.add(svgPanel);
	   this.svgPanel=svgPanel;
	 }else{
	 
	 }
};

XiorkFlowViewer.prototype.updateSvgPosition = function (point) {

	//非IE状况下 加
	if(Toolkit.getBrowserType()!="MSIE"){
		//
	    var svgObj=this.getSvgPanel(); 
	    if(svgObj){
			var s_h=svgObj.getAttribute("height");
			var s_w=svgObj.getAttribute("width");
			var px=point.getX()+90;
			var py=point.getY()+40;

            if(s_h<py){
				svgObj.setAttribute("height",py);
			}
			if(s_w<px){
				svgObj.setAttribute("width",px);
			} 
		    //svgObj.setAttribute("height",elem.height()-30);
		    //svgObj.setAttribute("width",elem.width()-30);
	    }
	}
   
};


XiorkFlowViewer.prototype.getSvgPanel = function () {
    return this.svgPanel;
};

XiorkFlowViewer.prototype.removeSvg = function (svgObj) {
    return this.svgPanel.removeChild(svgObj);
};


XiorkFlowViewer.prototype.addChildElement = function (obj) {
	if(Toolkit.getBrowserType()=="MSIE"){
		this.add(obj);
	}else{
		this.getSvgPanel().appendChild(obj.getSvgLineUI());
	}
};

XiorkFlowViewer.prototype.removeChildElement = function (obj) {
    if(Toolkit.getBrowserType()=="MSIE"){
		this.remove(obj);
	}else{
		this.removeSvg(obj.getSvgLineUI());
	}
};





