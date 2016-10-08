/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AlignRightJustifiedListener(xiorkFlow) {
    this.xiorkFlow = xiorkFlow;
}
AlignRightJustifiedListener.prototype.actionPerformed = function (obj) {
    var xiorkFlowModel = this.xiorkFlow.getWrapper().getModel();
    xiorkFlowModel.rightJustified();
};