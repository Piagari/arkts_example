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

import TrainConstants from '../common/constants/TrainConstants'
import { TrainInfo, TrainList } from '../viewmodel/TrainInfoModel'
import {IntroductionComponent} from '../view/Introduction'
import {ExaminationComponent} from '../view/Examination'
import {CourseComponent} from '../view/Course'
import { NavInfo,IdInfo } from '../viewmodel/NavInfoModel'
@Entry
@Component
export struct TrainDetailPage {
  private detailInfo: TrainInfo = new TrainInfo()
  private tabsController: TabsController = new TabsController()
  @State currentIndex: number = 0;
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;
  @State params: NavInfo = new NavInfo('培训', '')
  @State title: string = '详情'
  @StorageLink('topRectHeight') topRectHeight: number = 0
  goToExaminationDetail() {
    this.pathStack.pushPathByName('ExaminationDetailPage', null);
  }

  @Builder
  TabBarBuilder(title: string, targetIndex: number) {
    Text(title)
      .fontSize(px2vp(14 * 3.5))
      .fontWeight(500)
      .fontColor(targetIndex === this.currentIndex ?'#FFFFFF':'#000000')
      .width(px2vp(60 * 3.5))
      .height(px2vp(36 * 3.5))
      .borderRadius(px2vp(21 * 3.5))
      .textAlign(TextAlign.Center)
      .backgroundColor(targetIndex === this.currentIndex ?'#0A59F7' : '#E5E5E5')
      .padding(5)
      .border(targetIndex === this.currentIndex ? {
        width: { bottom: 2 },
        color: { bottom: $r('app.color.blue_text_color') },
        style: {
          bottom: BorderStyle.Solid
        }
      } : {
        width: { bottom: 0 },
      })
      .margin({ left: 10, right: 10 })
      .onClick(() => {
        this.tabsController.changeIndex(targetIndex)
      })
  }

  build() {
    NavDestination() {
      Column() {
        Column() {
          Text(this.detailInfo.title)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .textAlign(TextAlign.Start)
            .width(TrainConstants.FULL_WIDTH)
            .lineHeight(22)
          Row() {
            Row() {
              Image(this.detailInfo.img)
                .width(120)
                .height('auto')
              Column() {
                Text(`已有${this.detailInfo.applyNum}报名`)
                  .textAlign(TextAlign.Start)
                  .fontColor($r('app.color.gray_color'))
                  .fontSize(14)
                  .margin({
                    bottom: 10
                  })
                  .width(TrainConstants.FULL_WIDTH)
                Row() {
                  Text(`￥`)
                    .fontColor(Color.Red)
                    .fontSize(12)
                  Text(`${this.detailInfo.money}`)
                    .fontColor(Color.Red)
                    .fontSize(20)
                }
                .width(TrainConstants.FULL_WIDTH)
              }
              .margin({
                left: 10
              })
              .layoutWeight(1)

            }
            .layoutWeight(1)

            Text('取消报名')
              .padding({
                top: 6,
                bottom: 6,
                left: 10,
                right: 10
              })
              .fontColor(Color.White)
              .fontSize(14)
              .backgroundColor($r('app.color.blue_text_color'))
              .borderRadius(100)
          }
          .width(TrainConstants.FULL_WIDTH)
          .margin({
            top: 10,
            bottom: 10
          })

          //tab
          Flex({ direction: FlexDirection.Row }) {
            this.TabBarBuilder('简介', 0)
            this.TabBarBuilder('课程', 1)
            this.TabBarBuilder('考试', 2)
          }
        }
        .width(TrainConstants.FULL_WIDTH)
        .backgroundColor('#F1F3F5')
        .padding({
          top: 6,
          left: 10,
          bottom: 0,
          right: 10
        })

        //tab内容
        Column() {
          Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
            TabContent() {
              //简介
              IntroductionComponent()
                .width(TrainConstants.FULL_WIDTH)
                .height(TrainConstants.FULL_HEIGHT)
                .padding(10)
            }

            TabContent() {
              //课程
              CourseComponent()
                .width(TrainConstants.FULL_WIDTH)
                .height(TrainConstants.FULL_HEIGHT)
              // .padding(10)
            }

            TabContent() {
              //考试  传方法过去
              ExaminationComponent({
                onClickItem: (): void => this.goToExaminationDetail()
              })
                .width(TrainConstants.FULL_WIDTH)
                .height(TrainConstants.FULL_HEIGHT)
                .padding(10)
            }

          }.onChange((index: number) => {
            this.currentIndex = index;
          })
          .width(TrainConstants.FULL_WIDTH)
          .height(TrainConstants.FULL_HEIGHT)
          .barHeight(0)
        }
        .layoutWeight(1)
        .backgroundColor($r('app.color.page_gray_color'))

      }
      .width(TrainConstants.FULL_WIDTH)
      .height(TrainConstants.FULL_HEIGHT)
    }
    .margin({top:this.topRectHeight})
    .backgroundColor('#FFFFFF')
    .title(this.title)
    .onReady((ctx: NavDestinationContext) => {
      this.params = (ctx?.pathInfo?.param as NavInfo);
      this.title = this.params.title
      let id = (JSON.parse(this.params.params) as IdInfo).id
      this.detailInfo = TrainList.find(v => v.id == id) as TrainInfo
    })
  }
}

@Builder
export function TrainDetailPageBuilder() {
  TrainDetailPage()
}