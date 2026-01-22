# 教育类行业实践

## 简介

本设计为教育类HarmonyOS应用架构设计实践，提供教育类应用常见的图文学习、音视频学习、考试等功能。

## 效果预览

<img src="./Screenshots/education.gif" height=400>

## 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。

2. HarmonyOS系统：HarmonyOS 5.0.1 Release及以上。

3. DevEco Studio版本：DevEco Studio 5.0.1 Release及以上。

4. HarmonyOS SDK版本：HarmonyOS 5.0.1 Release SDK及以上。

## 使用说明

- 首页采用各类APP常用的页面导航布局，底部通过Tabs组件设置导航样式 。
- 行业特色功能页面，如：课程展示、课程学习、学习进度跟踪、考试练习等。
- 课程展示：根据不同的分类，通过列表、宫格的形式展示可学习的课程。
- 课程学习：查看课程相关的内容，包含图文课程或音视频课程。
- 考试练习：提供题目进行在线考试，包含考试时间等。
  运行时需设置引用所有HSP模块。点击Run > Edit Configurations，选择Deploy Multi Hap标签页，勾选Deploy Multi Hap Packages，
  选择使用方模块（Entry）和所有HSP模块，点击OK。单击Run > Run “模块名称”（如Run “Entry”）或来启动应用/服务的编译构建。

## 实现思路

视频播放代码实现

```
// features/train/src/ets/view/AVPlayerDemo.ets 
createAVPlayer() {
  media.createAVPlayer().then((video: media.AVPlayer) => {
    if (video != null) {
      this.avPlayer = video;
      this.setAVPlayerCallback(this.avPlayer);
      if (this.avPlayer) {
        //当前链接为参考链接
        this.avPlayer.url =
          `https://vd3.bdstatic.com/mda-pdc2kmwtd2vxhiy4/cae_h264/1681502407203843413/mda-pdc2kmwtd2vxhiy4.mp4` // 示例，参考连接
      }
    } else {
    }
  }).catch((error: BusinessError) => {
  });
}

// features/train/src/ets/view/AVPlayerDemo.ets 
Stack() {
  if (!this.isPlay) {
    Image($r('app.media.ic_public_play'))
      .width(50)
      .height(50)
      .zIndex(2)
      .onClick(() => {
        this.play();
      });
  }

  Column() {
    Stack({ alignContent: Alignment.TopStart }) {
      XComponent({
        id: '',
        type: XComponentType.SURFACE,
        libraryname: '',
        controller: this.xComponentController
      })
        .onLoad(() => {
          this.xComponentController.setXComponentSurfaceSize({
            surfaceWidth: 1920,
            surfaceHeight: 1080
          });
          this.surfaceID = this.xComponentController.getXComponentSurfaceId();
        })
        .width('100%')
        .height('100%')
        .onClick(() => {
          this.iconOnclick();
        })
    }
  }
  .zIndex(1)
  .onClick(() => {
    this.playOrPause();
  })
}

```

在线考试代码实现

```
// features/mine/src/ets/views/MineStartTestPage.ets
TextTimer({ isCountDown: true, count: this.count, controller: this.textTimerController })
  .format(this.format)
  .fontColor(Color.Black)
  .fontSize(30)
  .onTimer((utc: number, elapsedTime: number) => {
    this.elapsedTime = this.count - elapsedTime * 1000;
    if (elapsedTime * 1000 === this.count) {
      //倒计时结束
      this.submit(true);
    }
  })
  .onAppear(() => {
    this.textTimerController.start();
  })
  .onDisAppear(() => {
    //页面切换，保存当前的值
    AppStorage.setOrCreate('MyCount', this.elapsedTime);
  })

```

考试时间结束会自动交卷等逻辑操作：

```
// features/mine/src/ets/views/MineStartTestPage.ets
submit(force: Boolean): void {
  if (force) {
    //考试时间到，强制提交
    this.pathStack.pushPathByName('MineTestResPage', null);
    AppStorage.setOrCreate('MyCount', 0);
  } else {
    this.currentIndex += 1
    if ((this.currentIndex + 1) < errorModels.length) {
      this.currentModel = errorModels[this.currentIndex]
    } else {
      //弹窗展示
      this.nextBtnText = '交卷'
      this.tjDialog.open()
    }
  }
}

```

## 工程目录

```
├── common/basic/src/main/ets                           // 公共模块
│   ├── constants
│   │   ├── CommonConstants.ets                         // 公共样式
│   │   └── StyleConstants.ets                          // 常用宽高样式
│   ├── resources
│   │   └── ResManager.ets                              // 公共模块导出资源
│   └── utils
│       ├── BreakpointUtil.ets 
│       ├── Logger.ets  
│       ├── MyGlobalContext.ets  
│       └── PreferencesUtil.ets     
├── entry/src/main/ets                                   // 主页面
│   ├── entryability
│   │   └── EntryAbility.ets                             // 程序入口
│   ├── pages
│   │   ├── Index.ets                                    // 首页配置tabBar
│   │   └── Tab.ets                                      // 自定义tab页
│   └── viewmodel
│       └── ConstantsInterface.ets
├── features
│   ├── home/src/main/ets                                // 首页
│   │   ├── secondary                                    //二级跳转页面
│   │   │   ├── HomePage.ets                             // 首页组件
│   │   │   └── JumpPage.ets                             // 模板列表页
│   │   ├── utils
│   │   │   └── Calc.ets 
│   │   └── views
│   │       ├── BreakpointUtil.ets      
│   │       ├── CommonConstants.ets
│   │       ├── HomeView.ets      
│   │       ├── HomeViewModel.ets                         // 首页数据模型
│   │       └── SecondView.ets       
│   ├── login/src/main/ets                               
│   │   ├── common
│   │   │   ├── constants   
│   │   │   │   └── AccountConstants.ets                 
│   │   │   └── resources  
│   │   │       └── ResManager.ets                    
│   │   ├── constants
│   │   │   └── StyleConstants.ets 
│   │   ├── dialog
│   │   │   └── districtTownDialog.ets 
│   │   ├── viewmodel
│   │   │   ├── AccountInfo.ets 
│   │   │   └── ConstantsInterface.ets
│   │   └── views
│   │       ├── LoginView.ets      
│   │       ├── LogoutNextView.ets
│   │       ├── LogoutView.ets      
│   │       ├── ModifyPasswordView.ets                         
│   │       ├── PolicyAgreement.ets    
│   │       └── RegisterView.ets 
│   ├── mine/src/main/ets                                   // 我的
│   │   ├── utils
│   │   │   └── Calc.ets   
│   │   ├── viewmodel
│   │   │   ├── MineCourseListModel.ets                     // 我的课程模型
│   │   │   ├── MineErrorModel.ets                          // 我的错题模型
│   │   │   ├── MineListModel.ets                           // 我的页面模型
│   │   │   ├── MineLocalData.ets                           // 我的本地数据
│   │   │   ├── MineOnlineTestModel.ets                     // 考试模型
│   │   │   └── MineSetListModel.ets                        // 设置数据模型
│   │   └── views
│   │       ├── LogoutDialog.ets                            // 退出登录 弹窗
│   │       ├── MineCoursePage.ets                          // 课程
│   │       ├── MineErrorPage.ets                           // 错题
│   │       ├── MineModiPersonPage.ets
│   │       ├── MineOnlineTestPage.ets
│   │       ├── MinePage.ets                                // 我的tab页
│   │       ├── MineSetPage.ets                             // 设置页面
│   │       ├── MineStartTestPage.ets
│   │       ├── MineTestResPage.ets
│   │       └── MineTrainPage.ets                           // 培训
│   ├── online/src/main/ets                                 // 消息
│   │   ├── utils
│   │   │   └── Calc.ets
│   │   ├── viewmodel
│   │   │   ├── OnlineListModel.ets                          // 消息模型类
│   │   │   └── OnlineLocalData.ets                          // 消息本地数据
│   │   └── views
│   │       └── OnlineIndexView.ets          
│   └── train/src/main/ets                                   // 培训
│       ├── common
│       │   └── constants           
│       │       └── TrainConstants.ets
│       ├── pages
│       │   ├── CourseDetailPage.ets                         // 课程详情
│       │   ├── ExaminationDetailPage.ets                    // 考试页面
│       │   ├── Index.ets                                    // 培训首页
│       │   └── TrainDetailPage.ets                          // 培训详情
│       ├── utils
│       │   └── Calc.ets
│       ├── view
│       │   ├── AVPlayerDemo.ets                             // 播放组件
│       │   ├── Course.ets                                   // 课程组件
│       │   ├── CourseEvaluate.ets                           // 评价组件
│       │   ├── CourseIntroduce.ets                          // 介绍组件
│       │   ├── CourseList.ets                               // 课程列表组件
│       │   ├── Empty.ets                                    // 无数据组件
│       │   ├── Examination.ets
│       │   ├── Introduction.ets
│       │   └── TrainListPage.ets                            // 培训列表组件
│       └── viewmodel
│           ├── ExaminationInfoModel.ets                     // 考试本地数据
│           ├── NavInfoModel.ets                             // 导航传参
│           └── TrainInfoModel.ets                           // 培训数据
└──entry/src/main/resources                                  // 资源文件目录


```

## 模块依赖

无

## 参考资料

无

## ChangeLog

| 修改内容     | 时间         |
|----------|------------|
| readme修改 | 2025年1月23日 |
