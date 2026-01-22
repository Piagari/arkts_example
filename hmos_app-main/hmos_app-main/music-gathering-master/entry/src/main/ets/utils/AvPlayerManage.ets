// 用来播放音乐 切换音乐 暂停音乐 进度调整 后台播放音乐
import { media } from '@kit.MediaKit'
import { SONG_KEY } from '../constants'
import { songItemType } from '../models/music'
import { PlayStateType } from '../models/playState'
import { router } from '@kit.ArkUI'
import { AvSessionManage } from './AvSessionManage'
import { backgroundTaskManager } from '@kit.BackgroundTasksKit'
import { wantAgent } from '@kit.AbilityKit'
import SongManager from './songManager'

export class AvPlayerManage {
  static player: media.AVPlayer | null = null // 播放器对象
  static currentSong: PlayStateType = new PlayStateType() //记录当前歌曲

  // 初始化播放器
  static async init() {
    // 保证只有一个播放器 不重复创建不浪费资源
    if (!AvPlayerManage.player) {
      AvPlayerManage.player = await media.createAVPlayer()
    }
    AvPlayerManage.player.on("stateChange", (state) => {
      switch (state) {
        case "initialized":
          AvPlayerManage.player?.prepare() //准备
          break;
        case "prepared":
          if (AppStorage.get("firstPlay") === 1) {
            // 说明上次直接播放了
            AppStorage.setOrCreate("firstPlay", 0)
          } else {
            AvPlayerManage.currentSong.isPlay = true // 正在播放
            AvPlayerManage.player?.play() // 播放
          }

          break;
        case "completed": // 监听进度条播放完毕
          AvPlayerManage.nextPlay(AvPlayerManage.currentSong.playMode === "repeat") // 直接调用下一首播放
          break;
      }
    })

    // 监听播放时长的变化
    AvPlayerManage.player.on("durationUpdate", (duration) => {
      AvPlayerManage.currentSong.duration = duration // 记录当前歌曲的时长
      AppStorage.setOrCreate<PlayStateType>(SONG_KEY, AvPlayerManage.currentSong) // 状态设置到全局
    })
    // 进度更新
    AvPlayerManage.player.on("timeUpdate", (time) => {
      AvPlayerManage.currentSong.time = time
      AppStorage.setOrCreate<PlayStateType>(SONG_KEY, AvPlayerManage.currentSong) // 状态设置到全局
    })
  }

  // 点击某个歌曲播放
  static singlePlay(song: songItemType) {
    AvPlayerManage.startBackgroundTask()

    AvPlayerManage.player!.url = song.url
    // 做判断
    // 判断歌曲在不在播放列表
    const inList = AvPlayerManage.currentSong.playList.some(item => item.id === song.id)
    if (inList) {
      // 说明在列表里
      if (AvPlayerManage.currentSong.url === song.url) {
        AvPlayerManage.player?.play() // 继续播放
        AvPlayerManage.currentSong.isPlay = true // 正在播放
      } else {
        // 点的和正在播的不是同一个
        AvPlayerManage.currentSong.playIndex =
          AvPlayerManage.currentSong.playList.findIndex(item => item.id === song.id)
        AvPlayerManage.changePlay() // 切换播放
      }
    } else {
      AvPlayerManage.currentSong.playList.unshift(song) // 顶部添加
      AvPlayerManage.currentSong.playIndex = 0 // 波第一个
      AvPlayerManage.changePlay() // 切换播放
    }
    AppStorage.setOrCreate<PlayStateType>(SONG_KEY, AvPlayerManage.currentSong) // 状态设置到全局
  }

  // 切换播放的方法
  static async changePlay() {
    // 重置播放
    await AvPlayerManage.player?.reset() // 重置播放其 会将当前音乐暂停
    AvPlayerManage.currentSong.duration = 0 // 音乐的播放时长归零
    AvPlayerManage.currentSong.time = 0 // 播放时间归零
    AvPlayerManage.currentSong.img = AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex].img
    AvPlayerManage.currentSong.name = AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex].name
    AvPlayerManage.currentSong.url = AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex].url
    AvPlayerManage.currentSong.author = AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex].author

    AvPlayerManage.player!.url = AvPlayerManage.currentSong.url

    // 只要切歌就推送
    SongManager.updateSong(JSON.stringify((AvPlayerManage.currentSong)))
  }

  // 暂停
  static pause() {
    AvPlayerManage.player?.pause() // 播放器暂停
    AvPlayerManage.currentSong.isPlay = false // 状态暂停

    AppStorage.setOrCreate<PlayStateType>(SONG_KEY, AvPlayerManage.currentSong) // 状态设置到全局
  }

  //上一首
  static prevPlay() {
    // 判断一下情况 当前的播放模式
    if (AvPlayerManage.currentSong.playMode === "random") {
      // 通过随机数 找一个歌曲
      AvPlayerManage.currentSong.playIndex = Math.floor(Math.random() * AvPlayerManage.currentSong.playList.length)
    } else {
      // 除了随机 都是 切到下一个
      AvPlayerManage.currentSong.playIndex--
      // 有可能为 -1
      // AvPlayerManage.currentSong.playIndex =
      //   (AvPlayerManage.currentSong.playIndex + AvPlayerManage.currentSong.playList.length) %
      //   AvPlayerManage.currentSong.playList.length
      if (AvPlayerManage.currentSong.playIndex === -1) {
        AvPlayerManage.currentSong.playIndex = AvPlayerManage.currentSong.playList.length - 1
      }
    }
    AvPlayerManage.singlePlay(AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex])
    // 播放当前歌曲
  }

  // 下一首
  static nextPlay(repeat?: boolean) {
    // 如果不是单曲循环 就需要且下一首
    if (!repeat) {
      // 判断一下情况 当前的播放模式
      if (AvPlayerManage.currentSong.playMode === "random") {
        // 通过随机数 找一个歌曲
        AvPlayerManage.currentSong.playIndex = Math.floor(Math.random() * AvPlayerManage.currentSong.playList.length)
      } else {
        // 除了随机 都是 切到下一个
        AvPlayerManage.currentSong.playIndex++

        if (AvPlayerManage.currentSong.playIndex > AvPlayerManage.currentSong.playList.length - 1) {
          AvPlayerManage.currentSong.playIndex = 0
        }
      }
    }

    AvPlayerManage.singlePlay(AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex])
    // 播放当前歌曲
  }

  // 删除歌曲
  static remove(index: number) {
    if (index === AvPlayerManage.currentSong.playIndex) {
      if (AvPlayerManage.currentSong.playList.length > 1) {
        AvPlayerManage.currentSong.playList.splice(index, 1) // 先删除
        // 说明至少还有一个
        AvPlayerManage.currentSong.playIndex =
          (AvPlayerManage.currentSong.playIndex + AvPlayerManage.currentSong.playList.length) %
          AvPlayerManage.currentSong.playList.length
        AvPlayerManage.singlePlay(AvPlayerManage.currentSong.playList[AvPlayerManage.currentSong.playIndex])
      } else {
        // 说明删光了
        router.back()
        AvPlayerManage.currentSong = new PlayStateType()
        AvPlayerManage.player?.reset() // 因为歌曲都没有了 直接重置
      }
    } else {
      // 如果删除的歌曲 索引小于 正在播的歌曲
      if (AvPlayerManage.currentSong.playIndex > index) {
        AvPlayerManage.currentSong.playIndex--
      }
      AvPlayerManage.currentSong.playList.splice(index, 1)
    }
    AppStorage.setOrCreate<PlayStateType>(SONG_KEY, AvPlayerManage.currentSong) // 状态设置到全局

  }

  // 开启后台尝试任务
  static async startBackgroundTask() {
    // 会话对象只要有就说明不用开启了
    if (AvSessionManage.session.sessionId) {
      // 如果已经有会话了 就不用开启了
      return
    }
    try {
      // want的信息组成 目的是点击播控中心的时候 可以进入应用
      let wantAgentInfo: wantAgent.WantAgentInfo = {
        wants: [
          {
            bundleName: "com.example.heimacloudmusic",
            abilityName: "EntryAbility"
          }
        ],
        operationType: wantAgent.OperationType.START_ABILITIES,
        requestCode: 0,
        wantAgentFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
      }
      const want = await wantAgent.getWantAgent(wantAgentInfo)
      // 申请 长时任务
      await backgroundTaskManager.startBackgroundRunning(getContext(),
        backgroundTaskManager.BackgroundMode.AUDIO_PLAYBACK,
        want
      )
    } catch (e) {
      AlertDialog.show({ message: e.message })
    }

  }
}