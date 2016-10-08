/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AlignUpJustifiedListener(xiorkFlow) {
    this.xiorkFlow = xiorkFlow;
}
AlignUpJustifiedListener.prototype.actionPerformed = function (obj) {
    var xiorkFlowModel = this.xiorkFlow.getWrapper().getModel();
    xiorkFlowModel.upJustified();
};