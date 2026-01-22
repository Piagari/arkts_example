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

import { TrainList,TrainListPage } from "@safe/train"

@Entry()
@Component
export struct JumpPage {
  private arr: string[] = ['行业模板', '机械加工', '食品安全', '可回收', '烟花爆竹','公共交通']
  @State color: string[] = ['#83ABFB', '#83ABFB', '#83ABFB', '#83ABFB', '#83ABFB', '#83ABFB']
  @State flag: boolean = false
  @State flagTab: boolean = true
  @State currentSelect: number = -1
  @State currentIndex: number = -1
  @State i: number = 0;
  @StorageLink('topRectHeight') topRectHeight: number = 0
  build() {
    NavDestination() {
      Row() {
        Column() {
          Column() {
            Row() {
              Text('企业类别')
                .fontColor(Color.White)
                .fontWeight(500)
                .fontSize(px2vp(14* 3.5))
                .height(px2vp(36 * 3.5))
                .width(px2vp(112* 3.5))
                .textAlign(TextAlign.Center)
                .borderRadius(px2vp(21 * 3.5))
                .backgroundColor('#0A59F7')
                .margin({ right: 10 })
              Scroll() {
                Row() {
                  ForEach(this.arr, (item: string, index: number) => {
                    Text(item)
                      .height(px2vp(36 * 3.5))
                      .width(px2vp(88* 3.5))
                      .textAlign(TextAlign.Center)
                      .borderRadius(px2vp(21 * 3.5))
                      .fontColor(Color.Black)
                      .fontWeight(500)
                      .fontSize(px2vp(14* 3.5))
                      .margin({ right: 10 })
                      .backgroundColor(this.currentSelect === index ? '#0A59F7' : '#E5E5E5')
                      .padding({ left: 5, right: 5 })
                      .onClick(() => {
                        this.i++
                        if (this.i > 1) {
                          this.currentIndex = -1
                        }
                        this.currentSelect = index
                        this.flag = true
                      })
                  }, (item: string) => item)
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('80%')
              .height(40)
              Image($r('app.media.more'))
                .width(px2vp(40* 3.5))
                .height(px2vp(40* 3.5))
            }
            .width('100%')

          }
          .width('100%')
          .padding({ left: '4%', right: '4%' })


          Column() {
            if (this.flagTab) {
              TrainListPage({
                dataList: TrainList
              })

            }
          }
          .width('100%')
          .height('95%')
          .padding(15)
          .backgroundColor('#f7f7f7')

        }
        .width('100%')
      }
      .height('100%')
    }
    .title('在线培训')
    .margin({top:this.topRectHeight})
  }

}

@Builder
export function JumpPageBuilder() {
  JumpPage();
}