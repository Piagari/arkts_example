@ObservedV2
export class ExamController {
  private static _instance: ExamController;

  public static get instance() {
    if (!ExamController._instance) {
      ExamController._instance = new ExamController();
    }
    return ExamController._instance;
  }

  // Swiper控制器
  swiperController: SwiperController = new SwiperController();
  // 是否显示下一页
  showNext: boolean = false;
  // 字体大小
  @Trace fontSize: number = 14;
  // 按返回键时打开模拟考试弹窗
  @Trace isShowMockExamDialog: boolean = false;
  // 仅用于答题卡，点击清空记录按钮后，对RadioComponent视图重新渲染
  @Trace renderView: boolean = false;
}