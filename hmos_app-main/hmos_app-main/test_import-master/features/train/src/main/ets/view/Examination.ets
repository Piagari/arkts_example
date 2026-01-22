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

import TrainConstants from '../common/constants/TrainConstants';
import { ExaminationInfo, ExaminationList } from '../viewmodel/TrainInfoModel';

@Component
export struct ExaminationComponent {
  @State message: string = '课程';
  private onClickItem = () => {
  };

  build() {
    Column() {
      List() {
        ForEach(ExaminationList, (item: ExaminationInfo) => {
          ListItem() {
            Row() {
              Image($r('app.media.highlight'))
                .width(px2vp(24 * 3.5))
                .height(px2vp(24 * 3.5))
                .margin({
                  right: 10
                })
              Column() {
                Text(item.title)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width(TrainConstants.FULL_WIDTH)
                  .fontSize(px2vp(16 * 3.5))
                  .fontWeight(500)
                Row(){
                  Text(`时长：${item.hour}分钟 `)
                    .fontColor($r('app.color.gray_color'))
                    .fontSize(px2vp(14 * 3.5))
                    .fontWeight(400)

                }
                .width(TrainConstants.FULL_WIDTH)
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({top:5})

              }
              .width(px2vp(92 * 3.5))
              Button(item.text)
                .fontSize(px2vp(14 * 3.5))
                .fontWeight(500)
                .fontColor('#0A59F7')
                .width(px2vp(84 * 3.5))
                .height(px2vp(28 * 3.5))
                .borderRadius(px2vp(14 * 3.5))
                .backgroundColor('#E5E5E5')
                .onClick(() => {
                  if (this.onClickItem !== undefined) {
                    this.onClickItem();
                  }
                })
                .margin({left:px2vp(90 * 3.5)})
            }
            .width(px2vp(336 * 3.5))
          }
          .padding({
            top:10,
            bottom: 8
          })
        }, (item: ExaminationInfo) => JSON.stringify(item))
      }
    }
    .width(px2vp(332 * 3.5))
    .height(px2vp(200 * 3.5))
    .backgroundColor(Color.White)
    .borderRadius(px2vp(12 * 3.5))
    .padding(15)
    .margin({top:px2vp(10 * 3.5)})
  }
}