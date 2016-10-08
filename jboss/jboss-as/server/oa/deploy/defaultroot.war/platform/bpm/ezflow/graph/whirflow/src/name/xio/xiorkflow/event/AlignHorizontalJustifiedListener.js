/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AlignHorizontalJustifiedListener(xiorkFlow) {
    this.xiorkFlow = xiorkFlow;
}
AlignHorizontalJustifiedListener.prototype.actionPerformed = function (obj) {
    var xiorkFlowModel = this.xiorkFlow.getWrapper().getModel();
    xiorkFlowModel.horizontalJustified();
};