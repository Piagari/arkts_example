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

import { ResManager, StyleConstants } from '@safe/basic';

@Entry
@Component
export struct MineTestResPage {
  @State message: string = 'Hello World';
  scroller: Scroller = new Scroller()
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;

  aboutToAppear(): void {
  }

  @Builder
  listBuild(title: string, arr: string[]) {
    Column() {
      Row() {

        Text('').width(2).height(12).backgroundColor(Color.Red).borderRadius(1)

        Text('判断题得分')
          .fontWeight(FontWeight.Normal)
          .fontColor('666666')
          .fontSize(15).margin({ left: 5 })
      }

      List({ scroller: this.scroller, space: 5 }) {
        ForEach(arr, (item: string) => {
          ListItem() {
            Text(item)
              .width(40)
              .height(40)
              .textAlign(TextAlign.Center)
              .borderStyle(BorderStyle.Solid)
              .borderWidth(1)
              .borderColor(Color.Red)
              .borderRadius(3)
              .backgroundColor(Color.White)
          }
        }, (item: string) => item)
      }.listDirection(Axis.Horizontal).height(50)
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').alignItems(HorizontalAlign.Start).height(80)
  }

  @Styles
  cardStyle(){
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor(Color.White)
    .borderRadius(ResManager.getVp_twelve())
    .margin({ bottom: ResManager.getVp_twelve() })

    .shadow({ color: 'f5f5f5', radius: ResManager.getVp_twelve() })
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          RelativeContainer() {
            Image(ResManager.getBackIcon())
              .width(ResManager.getVp_twenty())
              .height(ResManager.getVp_twenty())
              .alignRules({
                center: { anchor: '__container__', align: VerticalAlign.Center },
                left: { anchor: '__container__', align: HorizontalAlign.Start }
              })
              .id('back')
              .margin({ left: vp2px(5) })
              .onClick(() => {
                this.pathStack.pop()
              })
            Text('考试结果').alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: 'back', align: VerticalAlign.Center },
            }).fontWeight(FontWeight.Medium).fontColor('333333').id('text')
          }
        }.width('100%').backgroundColor(Color.White).height(vp2px(10))

        Stack({ alignContent: Alignment.Bottom }) {
          Stack({ alignContent: Alignment.Top }) {
            Image('')
              .width(StyleConstants.FULL_WIDTH)
              .height($r('app.float.personal_background_image_height'))
              .objectFit(ImageFit.Auto).backgroundColor(Color.Green)
            Flex({ direction: FlexDirection.Column }) {
              RelativeContainer() {
                Text('考试的title').fontColor(Color.White).alignRules({
                  top: { anchor: '__container__', align: VerticalAlign.Top },
                  middle: { anchor: '__container__', align: HorizontalAlign.Center }
                }).offset({
                  y: 10
                }).id('title')

                Text() {
                  Span('10   ').fontSize(30).fontColor(Color.Red)
                  Span('分').fontSize(20).fontColor(Color.Red)
                }.fontColor(Color.White).alignRules({
                  top: { anchor: 'title', align: VerticalAlign.Bottom },
                  middle: { anchor: '__container__', align: HorizontalAlign.Center }
                }).offset({
                  y: 30
                }).id('score')

                Text('未通过，再接再厉')
                  .alignRules({
                    top: { anchor: 'score', align: VerticalAlign.Bottom },
                    middle: { anchor: '__container__', align: HorizontalAlign.Center }
                  })
                  .fontWeight(FontWeight.Normal)
                  .fontColor('ffffff')
                  .width(160)
                  .height(40)
                  .borderRadius(5)
                  .backgroundColor(Color.Yellow)
                  .textAlign(TextAlign.Center)
                  .id('status')
                  .offset({
                    y: 50
                  })


              }
              .width(StyleConstants.FULL_WIDTH).height(160)

              Column() {
                Flex({
                  justifyContent: FlexAlign.SpaceEvenly,
                  alignItems: ItemAlign.Center
                }) {
                  Column() {
                    Text('答题用时').fontSize(12).fontColor('#666666')
                    Text('20分50秒').fontSize(16).fontColor('#333333')
                  }.justifyContent(FlexAlign.SpaceAround).height(60)

                  Column() {
                    Text('合格/总分').fontSize(12).fontColor('#666666')
                    Text('80/100').fontSize(16).fontColor('#333333')
                  }.justifyContent(FlexAlign.SpaceAround).height(60)

                  Column() {
                    Text('剩余可考').fontSize(12).fontColor('#666666')
                    Text('992').fontSize(16).fontColor('#333333')
                  }.justifyContent(FlexAlign.SpaceAround).height(60)
                }.height($r('app.float.icon_dock_height'))
                .cardStyle()
              }.padding({
                left: ResManager.getVp_twelve(),
                right: ResManager.getVp_twelve(),
              })

              Scroll() {
                Column() {
                  this.listBuild('单选题', ['1', '2', '3'])
                  this.listBuild('多选题', ['4', '5', '6'])
                  this.listBuild('判断题', ['7', '8', '9'])
                }.justifyContent(FlexAlign.Start).padding({
                  left: ResManager.getVp_twelve(),
                  right: ResManager.getVp_twelve(),
                })
              }.scrollBar(BarState.Off).margin({ top: 15 })
            }
          }

          Row() {
            Button('', { buttonStyle: ButtonStyleMode.NORMAL })
              .width('50%')
              .height(50)
              .backgroundColor(Color.White)
              .onClick(() => {

              })

            Button('再考一次', { type: ButtonType.Normal })
              .width('50%')
              .height(50)
              .backgroundColor(Color.Orange)
              .fontColor(Color.White)
              .onClick(() => {

              })
              .padding({ bottom: 10 })
          }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween).width('100%').layoutWeight(1)
        }.width('100%')
      }
    }.hideTitleBar(true)
  }
}

@Builder
export function MineTestResPageBuilder() {
  MineTestResPage()
}