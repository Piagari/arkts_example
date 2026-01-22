import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { SONG_KEY } from '../constants';
import { AvPlayerManage } from '../utils/AvPlayerManage';
import { AvSessionManage } from '../utils/AvSessionManage';
import SongManager from '../utils/songManager';


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    AvPlayerManage.init() // 初始化播放器

    AvSessionManage.init(this.context) // 初始化
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    const win = await windowStage.getMainWindow()
    win.setWindowLayoutFullScreen(true)
    AppStorage.setOrCreate("topHeight", px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      .topRect.height))
    AppStorage.setOrCreate("bottomHeight", px2vp(win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
      .bottomRect.height))
    const childWin = await windowStage.createSubWindow("ad_win") // 创建广告子窗口
    await childWin.showWindow()
    await childWin.setUIContent("pages/Start/Start")
    //从首选项读取缓存的播放列表
    SongManager.context = this.context
    const currentSong = await SongManager.getSong() // 给播放器
    currentSong.isPlay = false //  不论什么情况肯定都是关的
    AvPlayerManage.currentSong = currentSong

    if (AvPlayerManage.currentSong.url) {
      AvPlayerManage.player!.url = AvPlayerManage.currentSong.url // 会自动播放
      AppStorage.setOrCreate("firstPlay", 1)
    }


    AppStorage.setOrCreate(SONG_KEY, AvPlayerManage.currentSong) // 更新全局状态
    windowStage.loadContent("pages/Index/Index")
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
