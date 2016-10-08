

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AlignLeftJustifiedListener(xiorkFlow) {
    this.xiorkFlow = xiorkFlow;
}
AlignLeftJustifiedListener.prototype.actionPerformed = function (obj) {
    var xiorkFlowModel = this.xiorkFlow.getWrapper().getModel();
    xiorkFlowModel.leftJustified();
};