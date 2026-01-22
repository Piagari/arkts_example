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
import { ExaminationDetailObj } from '../viewmodel/ExaminationInfoModel';


interface GridItemType {
  img: Resource,
  name: string,
  value: string,
  code: string,
}

//培训列表info 枚举
enum ExaminationDetailInfoEnum {
  totalScore = '试卷总分',
  score = '及格分数',
  hours = '考试时长',
  topicNum = '题目数量'

}

@Entry
@Component
export struct ExaminationDetailPage {
  @State message: string = 'Hello World';
  @State GridList: GridItemType[] = []
  @State count: number = (ExaminationDetailObj.examNum as number) - (ExaminationDetailObj.useExamNum as number)
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;
  @StorageLink('topRectHeight') topRectHeight: number = 0
  build() {
    NavDestination() {
      Column() {
        Stack({
          alignContent: Alignment.TopStart
        }) {
          Image($r('app.media.ic_app_background'))
            .width('100%')
          Column() {
            Text('理论测试复习')
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .margin({
                top: 40,
                bottom: 40
              })
            Grid() {
              ForEach(this.GridList, (item: GridItemType, index: number) => {
                GridItem() {
                  Row() {
                    Image(item.img)
                      .width(24)
                      .height(24)
                      .margin({
                        right: 10
                      })
                    Column() {
                      Text(item.name)
                        .fontColor($r('app.color.gray_color'))
                      Text(`${item.value}`)
                        .fontWeight(FontWeight.Bold)
                        .margin({
                          top: 5
                        })
                    }
                  }
                }
                .height(60)
                .width('100%')
                .border({
                  width: { bottom: index == 0 || index == 1 ? 1 : 0, right: index == 0 || index == 2 ? 1 : 0 },
                  color: { bottom: '#eeeeee', right: '#eeeeee' },
                  style: {
                    bottom: BorderStyle.Solid
                  }
                })
              }, (item: GridItemType) => JSON.stringify(item))
            }
            .width('92%')
            .height(160)
            .padding(20)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .columnsTemplate('1fr 1fr ')
            .rowsTemplate('1fr 1fr')


            Row() {
              Image($r('app.media.course'))
                .width(16)
                .height(16)
                .margin({
                  right: 8
                })
              Text(`本期考试已考${ExaminationDetailObj.useExamNum}次，还剩${this.count}次机会，最高分${ExaminationDetailObj.highScore}分`)
                .fontSize(12)
                .fontSize(12)

            }
            .backgroundColor('#fdf6ec')
            .borderRadius(10)
            .padding({
              top: 8,
              bottom: 8,
              left: 10,
              right: 10
            })
            .width('92%')
            .margin({
              top: 20,
              bottom: 20
            })

            Column() {
              Column() {
                Row() {
                  Text()
                    .width(4)
                    .height(14)
                    .backgroundColor('#ffab01')
                    .margin({
                      right: 6
                    })
                  Text('考试时间')
                    .fontColor($r('app.color.gray_color'))
                    .fontSize(14)
                }
                .width(TrainConstants.FULL_WIDTH)

                Text(`${ExaminationDetailObj.startTime}-${ExaminationDetailObj.endTime}`)
                  .fontSize(14)
                  .width(TrainConstants.FULL_WIDTH)
                  .margin({
                    top: 8, bottom: 15
                  })
              }

              Column() {
                Row() {
                  Text()
                    .width(4)
                    .height(14)
                    .backgroundColor('#ffab01')
                    .margin({
                      right: 6
                    })
                  Text('考试说明')
                    .fontColor($r('app.color.gray_color'))
                    .fontSize(14)
                }
                .width(TrainConstants.FULL_WIDTH)

                Text(`${ExaminationDetailObj.content}`)
                  .fontSize(14)
                  .width(TrainConstants.FULL_WIDTH)
                  .margin({
                    top: 8, bottom: 15
                  })
              }

            }
            .width('92%')

            Button('开始考试')
              .width('92%')
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
              .margin({
                top: 30
              })
              .onClick(() => {
                this.pathStack.pushPathByName('MineStartTestPage', null);
              })
          }
          .width(TrainConstants.FULL_WIDTH)
          .height(TrainConstants.FULL_HEIGHT)
        }
        .width(TrainConstants.FULL_WIDTH)
        .height(TrainConstants.FULL_HEIGHT)
      }
      .width(TrainConstants.FULL_WIDTH)
      .height(TrainConstants.FULL_HEIGHT)
      .backgroundColor(Color.White)
    }
    .title('考试详情')
    .margin({top:this.topRectHeight})
    .onReady((ctx: NavDestinationContext) => {
      for (const key of Object.keys(ExaminationDetailObj)) {
        if (key == 'totalScore') {
          let obj: GridItemType = {
            img: $r('app.media.course'),
            name: ExaminationDetailInfoEnum[key],
            value: `${Reflect.get(ExaminationDetailObj, key)}分`,
            code: key
          }
          this.GridList.push(obj)

        } else if (key == 'score') {
          let obj: GridItemType = {
            img: $r('app.media.course'),
            name: ExaminationDetailInfoEnum[key],
            value: `${Reflect.get(ExaminationDetailObj, key)}分`,
            code: key
          }
          this.GridList.push(obj)

        } else if (key == 'hours') {
          let obj: GridItemType = {
            img: $r('app.media.course'),
            name: ExaminationDetailInfoEnum[key],
            value: `${Reflect.get(ExaminationDetailObj, key)}分钟`,
            code: key
          }
          this.GridList.push(obj)

        } else if (key == 'topicNum') {
          let obj: GridItemType = {
            img: $r('app.media.course'),
            name: ExaminationDetailInfoEnum[key],
            value: `${Reflect.get(ExaminationDetailObj, key)}题`,
            code: key
          }
          this.GridList.push(obj)
        }
      }
    })

  }
}

@Builder
export function ExaminationDetailPageBuilder() {
  ExaminationDetailPage()
}