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
import { CourseInfo} from '../viewmodel/TrainInfoModel'
import {EmptyComponent} from '../view/Empty'
import { NavInfo,IdInfo } from '../viewmodel/NavInfoModel'
@Component
export struct CourseListComponent {
  @Link CourseList: CourseInfo[]
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack

  goToDetail(id: number) {
    let obj: IdInfo = new IdInfo(id)
    let params = new NavInfo('培训', JSON.stringify(obj));
    this.pathStack.pushPathByName('CourseDetailPage', params);
  }

  build() {
    Column() {
      if (this.CourseList.length > 0) {
        List({
          space: 10
        }) {
          ForEach(this.CourseList, (item: CourseInfo, index: number) => {
            ListItem() {
              Row() {
                Stack({
                  alignContent: Alignment.TopStart
                }) {
                  Image(item.img)
                    .width(120)
                    .height(70)
                    .borderRadius(10)
                    .objectFit(ImageFit.Cover)
                  Text(item.type == 0 ? '选修' : '必修')
                    .fontColor(Color.White)
                    .fontSize(14)
                    .linearGradient({
                      direction: GradientDirection.Right,
                      angle: 90,
                      colors: [
                        ['#ffab01', 0.0],
                        ['#fdc700', 0.5],
                        ['#fefb41', 1.0],
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
                .width(120)
                .height(70)
                .backgroundColor(Color.Pink)
                .borderRadius(10)
                .margin({
                  right: 10
                })

                Column() {
                  Text(item.title)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .textAlign(TextAlign.Start)
                    .width(TrainConstants.FULL_WIDTH)
                    .lineHeight(20)
                    .width(TrainConstants.FULL_WIDTH)
                  Row() {
                    Text(`教师：${item.name}`)
                      .fontColor($r('app.color.gray_color'))
                      .fontSize(14)
                      .margin({
                        right: 20
                      })
                    Text(`学时：${item.hour}`)
                      .fontColor($r('app.color.gray_color'))
                      .fontSize(14)

                  }
                  .margin({
                    top: 15,
                    bottom: 5
                  })
                  .width(TrainConstants.FULL_WIDTH)

                  Text(`进度：${item.process}%`)
                    .width(TrainConstants.FULL_WIDTH)
                    .fontColor($r('app.color.gray_color'))
                    .fontSize(14)
                }
                .layoutWeight(1)
              }
            }
            .backgroundColor(Color.White)
            .padding(10)
            .borderRadius(10)
            .onClick(() => {
              this.goToDetail(item.id)
            })

          }, (item: CourseInfo) => JSON.stringify(item))
        }
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
    .backgroundColor($r('app.color.page_gray_color'))
  }
}