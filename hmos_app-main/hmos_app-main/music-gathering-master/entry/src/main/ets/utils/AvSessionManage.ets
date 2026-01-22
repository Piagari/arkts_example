import AvSession from '@ohos.multimedia.avsession'

export class AvSessionManage {
  static session: AvSession.AVSession // 媒体会话对象
  static controller: AvSession.AVSessionController // 控制器

  static async init(context: Context) {
    // 拿到会话对象
    AvSessionManage.session = await AvSession.createAVSession(context, "bgOlay", "audio")
    AvSessionManage.controller = await AvSessionManage.session.getController() // 拿到控制器
  }
}