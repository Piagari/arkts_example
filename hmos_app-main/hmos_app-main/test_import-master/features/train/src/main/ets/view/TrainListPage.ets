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
import {EmptyComponent} from './Empty'
import { NavInfo,IdInfo } from '../viewmodel/NavInfoModel'
@Entry
@Component
export struct TrainListPage {
  @Prop dataList: TrainInfo[] = TrainList
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack

  //跳转详情页
  goToDetail(id: number) {
    let obj: IdInfo = new IdInfo(id)
    let params = new NavInfo('课程', JSON.stringify(obj))
    this.pathStack.pushPathByName('TrainDetailPage', params)
  }

  build() {
    NavDestination() {
      Column() {
        if (this.dataList.length > 0) {
          List({
            space: 10
          }) {
            ForEach(this.dataList, (item: TrainInfo, index: number) => {
              ListItem() {
                Column() {
                  Stack({
                    alignContent: Alignment.BottomStart
                  }) {
                    Image(item.img)
                      .width('100%')
                      .height(100)
                      .objectFit(ImageFit.Cover)
                    Text(`${item.count}`)
                      .fontColor(Color.White)
                      .fontSize(14)
                      .linearGradient({
                        direction: GradientDirection.Right,
                        colors: [
                          ['#00c6ff', 0.0],
                          ['#0072ff', 1.0],
                        ]
                      })
                      .borderRadius({
                        topLeft: 5,
                        topRight: 5,
                        bottomRight: 5
                      })
                      .padding({
                        top: 2,
                        right: 8,
                        bottom: 2,
                        left: 8
                      })
                  }
                  .width(TrainConstants.FULL_WIDTH)
                  .height(100)
                  .backgroundColor(Color.Pink)

                  Column() {
                    Text(item.title)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .textAlign(TextAlign.Start)
                      .width(TrainConstants.FULL_WIDTH)
                      .lineHeight(20)
                    Text(`起始时间：${item.startTime} 至 ${item.startTime}`)
                      .textAlign(TextAlign.Start)
                      .wordBreak(WordBreak.BREAK_ALL)
                      .width(TrainConstants.FULL_WIDTH)
                      .fontSize(14)
                      .margin({
                        top: 8,
                        bottom: 5
                      })
                    Text(`已有${item.applyNum}人报名`)
                      .textAlign(TextAlign.Start)
                      .fontColor('#aaaaaa')
                      .width(TrainConstants.FULL_WIDTH)
                      .fontSize(12)
                  }
                  .padding(10)

                }
              }
              .width('100%')
              .backgroundColor(Color.White)
              .onClick(() => {
                this.goToDetail(item.id)
              })

            }, (item: TrainInfo) => JSON.stringify(item))
          }
          .lanes(TrainConstants.LIST_LANES_NUM, 10)
          .alignListItem(ListItemAlign.End)
        } else {
          //缺省图
          EmptyComponent({
            message: '暂无数据'
          })
        }
      }
      .width(TrainConstants.FULL_WIDTH)
      .height(TrainConstants.FULL_HEIGHT)
    }
    .hideTitleBar(true)
  }
}