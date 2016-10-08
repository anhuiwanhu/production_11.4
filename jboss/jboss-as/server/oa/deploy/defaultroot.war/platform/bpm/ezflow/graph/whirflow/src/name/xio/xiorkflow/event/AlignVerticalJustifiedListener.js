/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AlignVerticalJustifiedListener(xiorkFlow) {
    this.xiorkFlow = xiorkFlow;
}
AlignVerticalJustifiedListener.prototype.actionPerformed = function (obj) {
    var xiorkFlowModel = this.xiorkFlow.getWrapper().getModel();
    xiorkFlowModel.verticalJustified();
};