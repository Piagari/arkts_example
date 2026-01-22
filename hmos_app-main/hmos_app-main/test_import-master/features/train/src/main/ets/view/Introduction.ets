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
import { IntroObj,IntroInfoEnum,IntroInfo } from '../viewmodel/TrainInfoModel'

interface ListItemType {
  name: string,
  value: string,
  code: string,
}

@Entry
@Component
export struct IntroductionComponent {
  @State message: string = '简介';
  @State list: ListItemType[] = []

  aboutToAppear(): void {
    for (const key of Object.keys(IntroObj)) {
      if (key !== 'startTime' && key !== 'endTime') {
        let obj: ListItemType = {
          name: IntroInfoEnum[key],
          value: Reflect.get(IntroObj, key),
          code: key,
        }
        this.list.push(obj)
      }
    }
    let timeObj: ListItemType = {
      name: '起止时间',
      value: `${IntroObj.startTime}至${IntroObj.endTime}`,
      code: 'time',
    }
    this.list.push(timeObj)
  }

  build() {
    Column() {
      Row() {
        Text()
          .width(8)
          .height(8)
          .backgroundColor($r('app.color.blue_text_color'))
          .borderRadius(4)
          .margin({
            right: 5
          })
        Text('基本信息')
          .fontWeight(FontWeight.Bold)
      }
      .margin({
        bottom: 10
      })

      List() {
        ForEach(this.list, (item: ListItemType) => {
          ListItem() {
            Row() {
              Text(`${item.name}: `)
                .fontSize(14)
              Text(item.value)
                .fontColor($r('app.color.blue_text_color'))
                .fontSize(14)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width(TrainConstants.FULL_WIDTH)
            .alignItems(VerticalAlign.Top)
          }
          .margin({
            top: 5,
            bottom: 5
          })
        }, (item: ListItemType) => JSON.stringify(item))
      }
      .layoutWeight(1)

      Text('学识证明')
        .padding({
          top: 6,
          bottom: 6,
          left: 10,
          right: 10
        })
        .fontColor(Color.White)
        .fontSize(px2vp(16 * 3.5))
        .fontWeight(500)
        .backgroundColor('#0A59F7')
        .alignSelf(ItemAlign.Center)
        .textAlign(TextAlign.Center)
        .borderRadius(px2vp(20 * 3.5))
        .width(px2vp(120 * 3.5))
        .height(px2vp(40 * 3.5))
    }
    .width(TrainConstants.FULL_WIDTH)
    .height(TrainConstants.FULL_HEIGHT)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(15)
    .padding(15)
  }
}