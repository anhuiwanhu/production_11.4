
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function TransitionCompass() {
}

 

TransitionCompass.judgeIsGate =function (metaNodeModel){
	var result=false;
	if(metaNodeModel instanceof ExclusiveGatewayNodeModel){ 
		return true;
	}
	if(metaNodeModel instanceof ParallelGatewayNodeModel){
		return true;
	}
	if(metaNodeModel instanceof InclusiveGatewayNodeModel){
		return true;
	}
	return false; 
};
TransitionCompass.getOffset = function (fromMetaNodeModel, toMetaNodeModel) {
    if ((!fromMetaNodeModel) || (!toMetaNodeModel)) {
        return null;
    }
     
	//解决 padding问题 
	var _x=5;
	var _y=2;   
	if(Toolkit.isIE()){ 
		_x=0;
		_y=0; 
	}else{
		if(this.judgeIsGate(fromMetaNodeModel)){ 
		  _x=5;
		  _y=2;
	   }
	}
	
 
 
 
    //
    var fromPoint = fromMetaNodeModel.getPosition();
    var fromX = fromPoint.getX()-_x;
    var fromY = fromPoint.getY()-_y;
    var fromSize = fromMetaNodeModel.getSize();
    var fromWidth = fromSize.getWidth()+2*_x;
    var fromHeight = fromSize.getHeight()+2*_y;
    var fromMinX = fromX;
    var fromMinY = fromY;
    var fromMaxX = fromX + fromWidth;
    var fromMaxY = fromY + fromHeight;

	var xxxfromWidth=Math.round(fromWidth/4);
	var yyyfromHeight=Math.round(fromHeight/4); 
 
	//解决 padding问题 
	_x=5;
    _y=2;  

	if(Toolkit.isIE()){ 
	   _x=0;
	   _y=0; 
	}else{
	   if(this.judgeIsGate(toMetaNodeModel)){ 
		 _x=5;
	     _y=2;
	   }
	}



    //
    var toPoint = toMetaNodeModel.getPosition();
    var toX = toPoint.getX()-_x;
    var toY = toPoint.getY()-_y;
    var toSize = toMetaNodeModel.getSize();
    var toWidth = toSize.getWidth()+2*_x;
    var toHeight = toSize.getHeight()+2*_y;
    var toMinX = toX;
    var toMinY = toY;
    var toMaxX = toX + toWidth;
    var toMaxY = toY + toHeight;

	var xxxtoWidth=Math.round(toWidth/4);
	var yyytoHeight=Math.round(toHeight/4); 

	var fromOffsetX=0;
	var fromOffsetY=0;
	var toOffsetX=0;
	var toOffsetY=0;

	//来源最大高度 <=目标的最小高度。       （来源高于目标）
    if (fromMaxY <= toMinY) {
		//来源最右边》=目标的最左边 并且 来源的最左边小于目标的最右边   （来源跟目标重叠部分，或者完全重叠）
        if ((fromMaxX >= toMinX) && (fromMinX <= toMaxX)) {
            var min = Math.max(fromMinX, toMinX);
            var max = Math.min(fromMaxX, toMaxX);
            var x = Math.round((min + max) / 2);

			fromOffsetX=x - fromX;
            fromOffsetY=fromMaxY - fromY;
			toOffsetX=x - toX;
            toOffsetY=toMinY - toY;

			if(this.judgeIsGate(fromMetaNodeModel)){
				fromOffsetX=Math.round(fromWidth/2);
			    fromOffsetY=fromHeight;
			}
			if(this.judgeIsGate(toMetaNodeModel)){
				toOffsetX=Math.round(toWidth/2);
                toOffsetY=0;
			}   
            return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
            //return [new Point(x - fromX, fromMaxY - fromY), new Point(x - toX, toMinY - toY)];
        } else {
			//来源在目标的右边
            if (fromMinX > toMaxX) {
				fromOffsetX=fromMinX - fromX;
				fromOffsetY=fromMaxY - fromY;
				toOffsetX=toMaxX - toX;
				toOffsetY=toMinY - toY;

				if(this.judgeIsGate(fromMetaNodeModel)){
					fromOffsetX=Math.round(fromWidth/2);
					fromOffsetY=fromHeight;
				}
				if(this.judgeIsGate(toMetaNodeModel)){
					toOffsetX=Math.round(toWidth/2);
					toOffsetY=0;
			    }

                //return [new Point(fromMinX - fromX, fromMaxY - fromY), new Point(toMaxX - toX, toMinY - toY)];
				return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
            } else {//来源在目标的左边
                if (fromMaxX < toMinX) {
					fromOffsetX=fromMaxX - fromX;
					fromOffsetY=fromMaxY - fromY;
					toOffsetX=toMinX - toX;
					toOffsetY=toMinY - toY;

					if(this.judgeIsGate(fromMetaNodeModel)){
						fromOffsetX=Math.round(fromWidth/2);
						fromOffsetY=fromHeight;
					}
					if(this.judgeIsGate(toMetaNodeModel)){
						toOffsetX=Math.round(toWidth/2);
						toOffsetY=0;
					}
					return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
					//alert([new Point(fromMaxX - fromX, fromMaxY - fromY), new Point(toMinX - toX, toMinY - toY)])
                    //return [new Point(fromMaxX - fromX, fromMaxY - fromY), new Point(toMinX - toX, toMinY - toY)];
                }
            }
        }
    }

    //来源在目标的下面
    if (fromMinY >= toMaxY) {
		//来源与目标 有重叠 或者完全重叠
        if ((fromMaxX >= toMinX) && (fromMinX <= toMaxX)) {
            var min = Math.max(fromMinX, toMinX);
            var max = Math.min(fromMaxX, toMaxX);
            var x = Math.round((min + max) / 2);

			fromOffsetX=x - fromX;
			fromOffsetY=fromMinY - fromY;
			toOffsetX=x - toX;
			toOffsetY=toMaxY - toY;

			if(this.judgeIsGate(fromMetaNodeModel)){ 
				fromOffsetX=Math.round(fromWidth/2);
				fromOffsetY=0;
			}
			if(this.judgeIsGate(toMetaNodeModel)){
				toOffsetX=Math.round(toWidth/2);
				toOffsetY=toHeight; 
			}
			return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
            //return [new Point(x - fromX, fromMinY - fromY), new Point(x - toX, toMaxY - toY)];
        } else {
			//来源在目标的右边
            if (fromMinX > toMaxX) {
				fromOffsetX=fromMinX - fromX;
				fromOffsetY=fromMinY - fromY;
				toOffsetX=toMaxX - toX;
				toOffsetY=toMaxY - toY;

				if(this.judgeIsGate(fromMetaNodeModel)){ 
					fromOffsetX=Math.round(fromWidth/2);
					fromOffsetY=0;
				}
				if(this.judgeIsGate(toMetaNodeModel)){
					toOffsetX=Math.round(toWidth/2);
					toOffsetY=toHeight; 
				}
				return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
                //return [new Point(fromMinX - fromX, fromMinY - fromY), new Point(toMaxX - toX, toMaxY - toY)];
            } else {
				//来源在目标的左边
                if (fromMaxX < toMinX) {
					fromOffsetX=fromMaxX - fromX;
					fromOffsetY=fromMinY - fromY;
					toOffsetX=toMinX - toX;
					toOffsetY=toMaxY - toY;
					
				 

					if(this.judgeIsGate(fromMetaNodeModel)){  
						fromOffsetX=Math.round(fromWidth/2);
						fromOffsetY=0;
					}
					if(this.judgeIsGate(toMetaNodeModel)){
						 
						toOffsetX=Math.round(toWidth/2);
						toOffsetY=toHeight; 
					} 
					return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
                    //return [new Point(fromMaxX - fromX, fromMinY - fromY), new Point(toMinX - toX, toMaxY - toY)];
                }
            }
        }
    }

    //来源与 目标 高度有重叠 或者 完全重叠
    if ((fromMaxY > toMinY) && (fromMinY < toMaxY)) {
        var min = Math.max(fromMinY, toMinY);
        var max = Math.min(fromMaxY, toMaxY);
        var y = Math.round((min + max) / 2);
		// 来源与目标 高度有重叠 左右也有重叠  两个合在一起
        if ((fromMaxX >= toMinX) && (fromMinX <= toMaxX)) {
            var min = Math.max(fromMinX, toMinX);
            var max = Math.min(fromMaxX, toMaxX);
            var x = Math.round((min + max) / 2);
 
			fromOffsetX=x - fromX;
			fromOffsetY=y - fromY;
			toOffsetX=x - toX;
			toOffsetY=y - toY;

			if(this.judgeIsGate(fromMetaNodeModel)){ 
				if(fromOffsetX<xxxfromWidth){
					fromOffsetX=0;
				}else if(fromOffsetX>=xxxfromWidth&&fromOffsetX<=xxxfromWidth*3){
					fromOffsetX=2*xxxfromWidth;
				}else{
					fromOffsetX=fromWidth;
				}
				
				fromOffsetY=Math.round(fromHeight/2);
			}
			if(this.judgeIsGate(toMetaNodeModel)){
				if(toOffsetX<xxxtoWidth){
					toOffsetX=0;
				}else if(toOffsetX>=xxxtoWidth&&toOffsetX<=xxxtoWidth*3){
					toOffsetX=Math.round(toWidth/2);
				}else{
					toOffsetX=toWidth;
				} 
				toOffsetY=Math.round(toHeight/2);
			}
			return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)]; 
            //return [new Point(x - fromX, y - fromY), new Point(x - toX, y - toY)];
        } else {
			// 来源在目标的 右边
            if (fromMinX > toMaxX) {
				fromOffsetX=fromMinX - fromX;
				fromOffsetY=y - fromY;
				toOffsetX=toMaxX - toX;
				toOffsetY=y - toY;

				if(this.judgeIsGate(fromMetaNodeModel)){ 
					fromOffsetX=0;
					fromOffsetY=Math.round(fromHeight/2);
                    /*
					if(fromOffsetY<yyyfromHeight){
						fromOffsetY=0;
					}else if(fromOffsetY>=yyyfromHeight&&fromOffsetY<=yyyfromHeight*3){
						fromOffsetY=Math.round(fromHeight/2);
					}else{
						fromOffsetY=fromHeight;
					} */
				}
				if(this.judgeIsGate(toMetaNodeModel)){
					toOffsetX=toWidth;
					toOffsetY=Math.round(toHeight/2);
					/*if(fromOffsetY<yyytoHeight){
						fromOffsetY=0;
					}else if(fromOffsetY>=yyytoHeight&&fromOffsetY<=yyytoHeight*3){
						fromOffsetY=Math.round(toHeight/2);
					}else{
						fromOffsetY=toHeight;
					}  */
				}
				return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
                //return [new Point(fromMinX - fromX, y - fromY), new Point(toMaxX - toX, y - toY)];
            } else {
				// 来源在目标的 左边
                if (fromMaxX < toMinX) {
					fromOffsetX=fromMaxX - fromX;
					fromOffsetY=y - fromY;
					toOffsetX=toMinX - toX;
					toOffsetY=y - toY;

					if(this.judgeIsGate(fromMetaNodeModel)){ 
						fromOffsetX=fromWidth; 
						fromOffsetY=Math.round(fromHeight/2);
						/*if(fromOffsetY<yyyfromHeight){
							fromOffsetY=0;
						}else if(fromOffsetY>=yyyfromHeight&&fromOffsetY<=yyyfromHeight*3){
							fromOffsetY=Math.round(fromHeight/2);
						}else{
							fromOffsetY=fromHeight;
						} */
					}
					if(this.judgeIsGate(toMetaNodeModel)){
						toOffsetX=0;
						toOffsetY=Math.round(toHeight/2);
						/*if(toOffsetY<yyytoHeight){
							toOffsetY=0;
						}else if(toOffsetY>=yyytoHeight&&toOffsetY<=yyytoHeight*3){
							toOffsetY=Math.round(toHeight/2);
						}else{
							toOffsetY=toHeight;
						}*/  
					}
					return [new Point(fromOffsetX, fromOffsetY), new Point(toOffsetX, toOffsetY)];
                    //return [new Point(fromMaxX - fromX, y - fromY), new Point(toMinX - toX, y - toY)];
                }
            }
        }
    }

    //
    return [new Point(Math.round(fromWidth / 2), fromHeight), new Point(Math.round(toWidth / 2), 0)];
};


//如果是菱形
TransitionCompass.getOffset_new = function (fromMetaNodeModel, fromOffset) {
	if (!fromOffset) {
		return fromOffset;
	} 

	//解决 padding问题 
	var _x=6;
	var _y=2; 
	if(Toolkit.isIE()){
		_x=0;
		_y=0;
	}
 
    //
    var fromPoint = fromMetaNodeModel.getPosition();
    var fromX = fromPoint.getX()-_x;
    var fromY = fromPoint.getY()-_y;
    var fromSize = fromMetaNodeModel.getSize();
    var fromWidth = fromSize.getWidth()+2*_x;
    var fromHeight = fromSize.getHeight()+2*_y;
    var fromMinX = fromX;
    var fromMinY = fromY;
    var fromMaxX = fromX + fromWidth;
    var fromMaxY = fromY + fromHeight;


    alert("fromWidth:"+fromWidth+":"+fromHeight);

	var x=fromOffset.getX();
	var y=fromOffset.getY(); 
	var xxxfromWidth=Math.round(fromWidth/4);
	var yyyfromHeight=Math.round(fromHeight/4); 
    
   alert("fromWidth:"+x+":"+y+"xxxfromWidth:"+xxxfromWidth+"yyyfromHeight:"+yyyfromHeight);
    
	//alert(x+":"+y);
    if(x<xxxfromWidth){
	    x=0;
	}
	if(x>=xxxfromWidth&&x<=xxxfromWidth*3){
	    x=xxxfromWidth*2;
	}
	if(x>xxxfromWidth*3){
	    x=xxxfromWidth*4;
	}

 
    if(y<yyyfromHeight){
	    y=0;
	}
	if(y>=yyyfromHeight&&x<=yyyfromHeight*3){
	    y=yyyfromHeight*2;
	}
	if(y>yyyfromHeight*3){
	    y=yyyfromHeight*4;
	}

	if(x==0&&y==0){
		x=0;
		y=yyyfromHeight*2;
	}
	
	if(x==0&&y==yyyfromHeight*4){
		x=0;
		y=yyyfromHeight*2;
	}
    
	fromOffset.setX(x);
	fromOffset.setY(y);
	return fromOffset; 
};


TransitionCompass.getFromOffset = function (fromMetaNodeModel, toMetaNodeModel) {
    if ((!fromMetaNodeModel) || (!toMetaNodeModel)) {
        return null;
    }

    //
    var size = fromMetaNodeModel.getSize();
    return new Point(size.getWidth() / 2, size.getHeight());
};
TransitionCompass.getToOffset = function (fromMetaNodeModel, toMetaNodeModel) {
    if ((fromMetaNodeModel == null) || (toMetaNodeModel == null)) {
        return null;
    }
    var size = toMetaNodeModel.getSize();
    return new Point(size.getWidth() / 2, 0);
};
TransitionCompass.convertOffsetToPoint = function (metaNodeModel, offset) {
    var point = metaNodeModel.getPosition();
    return new Point(point.getX() + offset.getX(), point.getY() + offset.getY());
};

