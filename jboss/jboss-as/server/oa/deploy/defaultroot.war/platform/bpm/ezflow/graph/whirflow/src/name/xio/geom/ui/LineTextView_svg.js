
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function LineTextView_svg() {
    this.base = LineView_svg_t;
    this.base();
     //this.setPosition("absolute");
    //this.setLeft("0px");
    //this.setTop("0px");

    //
    //this.path = Toolkit.newElement("<v:path textpathok='true'/>");
    this.path = Toolkit.newElement("<input type='hidden'  name='path' />");
    this.add(this.path);

    //
    this.textPath = Toolkit.newElement("<input type='text'  name='textpath' />");
    this.add(this.textPath);
}
LineTextView_svg.prototype = new LineView_svg_t();

//
LineTextView_svg.prototype.setText = function (text) {
    text = text ? text : "";
    //this.textPath.string = text;
	this.getSvgLineUI().textContent = "　　"+text;
};
LineTextView_svg.prototype.getText = function () {
    return this.textPath.string;
};

//
LineTextView_svg.prototype.setFrom = function (point) {
    if (!point) {
        return;
    }
    this.fromPoint = point;
    this._updateDirection();
};
LineTextView_svg.prototype.setTo = function (point) {
    if (!point) {
        return;
    }
    this.toPoint = point;
    this._updateDirection();
};
LineTextView_svg.prototype._updateDirection = function () {
    if (!this.fromPoint) {
        return;
    }
    if (!this.toPoint) {
        return;
    }

    //
    if (this.fromPoint.getX() == this.toPoint.getX()) {
        this.fromPoint.setX(this.fromPoint.getX() - 1);
    }
    if (this.fromPoint.getY() == this.toPoint.getY()) {
        this.fromPoint.setY(this.fromPoint.getY() - 1);
    }
    
	//设置text的起始位置
	var XX1=this.fromPoint.getX();
	var YY1=this.fromPoint.getY();
	var XX2=this.toPoint.getX();
	var YY2=this.toPoint.getY();
    //
    if (this.fromPoint.getX() > this.toPoint.getX()) {
        //this.getUI().from = this.toPoint.getX() + "," + this.toPoint.getY();
        //this.getUI().to = this.fromPoint.getX() + "," + this.fromPoint.getY();
		/*this.getSvgLineUI().setAttribute("x1",this.toPoint.getX());
		this.getSvgLineUI().setAttribute("y1",this.toPoint.getY());
		this.getSvgLineUI().setAttribute("x2",this.fromPoint.getX());
		this.getSvgLineUI().setAttribute("y2",this.fromPoint.getY());*/

		this.getSvgLineUI().setAttribute("x",this.toPoint.getX());
		this.getSvgLineUI().setAttribute("y",this.toPoint.getY());


		 XX2=this.fromPoint.getX();
		 YY2=this.fromPoint.getY();
		 XX1=this.toPoint.getX();
		 YY1=this.toPoint.getY();
	 
    } else {
        //this.getUI().from = this.fromPoint.getX() + "," + this.fromPoint.getY();
        //this.getUI().to = this.toPoint.getX() + "," + this.toPoint.getY();
		/*this.getSvgLineUI().setAttribute("x2",this.toPoint.getX());
		this.getSvgLineUI().setAttribute("y2",this.toPoint.getY());
		this.getSvgLineUI().setAttribute("x1",this.fromPoint.getX());
		this.getSvgLineUI().setAttribute("y1",this.fromPoint.getY());*/

		this.getSvgLineUI().setAttribute("x",this.fromPoint.getX());
		this.getSvgLineUI().setAttribute("y",this.fromPoint.getY());

	    XX1=this.fromPoint.getX();
	    YY1=this.fromPoint.getY();
	    XX2=this.toPoint.getX();
	    YY2=this.toPoint.getY();
    }

    //var  x0=(XX1+XX2)/2;
	//var  y0=(YY1+YY2)/2;
    
	//设置字的角度
    var  angle=Toolkit.getAngle(XX1,YY1, XX2, YY2);
	this.getSvgLineUI().setAttribute("transform", " rotate("+ angle+","+XX1+","+YY1+")");
};

