/*
 *  Copyright (c) 2025 Huawei Device Co., Ltd.
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

import { ResManager, StyleConstants } from '@safe/basic'
import { errorModels } from '../viewmodel/MineLocalData'
import { MineErrorModel } from '../viewmodel/MineErrorModel'
import { LogoutDialog } from './LogoutDialog'

@Entry
@Component
export struct MineStartTestPage {
  @State message: string = 'Hello World';
  textTimerController: TextTimerController = new TextTimerController()
  @State format: string = 'mm:ss'
  @State currentModel: MineErrorModel | undefined = undefined
  @State currentIndex: number = 0
  @State nextBtnText: string = '下一题'
  @StorageProp('MyCount') count: number = 0
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;
  elapsedTime: number = 0;
  tjDialog: CustomDialogController = new CustomDialogController({
    builder: LogoutDialog({
      cancel: () => {
      },
      confirm: () => {
        this.pathStack.pushPathByName('MineTestResPage', null);
        AppStorage.setOrCreate('MyCount', 0);
      },
      message: '是否提交试卷?'
    }),
    autoCancel: true,
    gridCount: 4,
    customStyle: false
  })

  onCancel() {
  }

  onConfirm = () => {

  }

  pushToPage() {

  }

  aboutToAppear(): void {
    let myCount: number | undefined = AppStorage.get('MyCount');
    if (myCount != undefined && myCount != 0) {
      // AppStorage有值
      this.count = myCount;
    } else {
      this.count = 30000;
    }
    this.currentModel = errorModels[this.currentIndex];
  }

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

  build() {
    NavDestination() {
      Column() {
        Column() {
          Column() {
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
            Divider().strokeWidth('#f5f5f5').strokeWidth(1)
          }.height(60).justifyContent(FlexAlign.SpaceAround).margin({ left: 10, right: 10 })

          Text(this.currentModel!.title)
            .fontWeight(FontWeight.Medium)
            .fontColor('333333').margin({ top: 10, left: 10, right: 10 })

          Column() {
            ForEach(this.currentModel!.ques, ((item: string) => {
              Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
                Text(item)
                  .fontColor('#3333333').margin({ left: 5 })
              }.backgroundColor('#eeeeeee').height(50)
              .margin({ top: 8 })
              .borderRadius(5)
            }))
          }.margin({ left: 10, right: 10 })

          Stack({ alignContent: Alignment.Bottom }) {
            Row() {
              Button('上一题', { buttonStyle: ButtonStyleMode.NORMAL })
                .width(80)
                .height(30)
                .borderStyle(BorderStyle.Solid)
                .borderWidth(1)
                .borderColor(Color.Blue)
                .borderRadius(10)
                .backgroundColor(Color.White)
                .fontColor(Color.Blue)
                .onClick(() => {
                  if (this.currentIndex > 0) {
                    this.currentIndex -= 1
                    this.currentModel = errorModels[this.currentIndex]
                  }
                })
                .margin({ left: 10 })

              Text() {
                Span('试题').fontColor('#666666').fontSize(14)
                Span((this.currentIndex + 1).toString() + '/' + errorModels.length.toString())
                  .fontColor('#333333')
                  .fontSize(14)
              }

              Button(this.nextBtnText, { buttonStyle: ButtonStyleMode.NORMAL })
                .backgroundColor(Color.White)
                .width(80)
                .height(30)
                .borderStyle(BorderStyle.Solid)
                .borderWidth(1)
                .borderColor(Color.Blue)
                .borderRadius(10)
                .fontColor(Color.Blue)
                .onClick(() => {
                  this.submit(false);
                })
                .margin({ right: 10 })
            }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween).width('100%')
          }.width('100%').layoutWeight(1)
        }.layoutWeight(1)

      }.width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
    }
    .title('考试标题xxxxx')
    .margin({top:this.topRectHeight})
  }
}

@Builder
export function MineStartTestPageBuilder() {
  MineStartTestPage()
}