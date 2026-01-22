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

import { ResManager } from '@safe/basic';
import { errorModels } from '../viewmodel/MineLocalData';
import { MineErrorModel } from '../viewmodel/MineErrorModel';

@Entry
@Component
export struct MineErrorPage {
  @State message: string = 'Hello World';
  @StorageLink('topRectHeight') topRectHeight: number = 0
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;

  @Builder
  testListItem(model: MineErrorModel, index: number) {
    Flex({ direction: FlexDirection.Column }) {
      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
        Text('判断题')
          .fontWeight(FontWeight.Normal)
          .fontColor('#ffffff')
          .width(80)
          .height(25)
          .borderRadius(5)
          .backgroundColor('#409eff')
          .textAlign(TextAlign.Center)

        Image($r('app.media.delete'))
          .objectFit(ImageFit.Cover)
          .height($r('app.float.list_icon_height'))
          .width($r('app.float.list_icon_height'))
      }.margin({ left: 10, right: 10 })

      Text(model.title)
        .fontWeight(FontWeight.Medium)
        .fontColor('333333').margin({ top: 10, left: 10, right: 10 })

      Flex({ direction: FlexDirection.Column }) {
        ForEach(model.ques, ((item: string) => {
          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
            Text(item)
              .fontColor('#3333333').margin({ left: 5 })

          }.backgroundColor('#eeeeeee').height(50)
          .margin({ top: 8 })
          .borderRadius(5)

        }))
      }.margin({ left: 10, right: 10 })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
        Text() {
          Span('正确选项:')
          Span(model.rightQues).fontColor(Color.Red)
        }

        Text() {
          Span('您的选项:')
          Span(model.anwer).fontColor(Color.Red)
        }
      }.margin({ left: 10, right: 10, top: 8 })

      Text('解析:')
        .fontWeight(FontWeight.Normal)
        .fontColor('#666666').margin({ top: 10, left: 10, right: 10 })

    }
  }

  @Builder
  ListViewBuild() {
    List({
      space: 10
    }) {
      ForEach(errorModels, (item: MineErrorModel, index: number) => {
        ListItem() {
          this.testListItem(item, index)
        }
      }, (item: MineErrorModel) => JSON.stringify(item))
    }.layoutWeight(1)
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
            Text('错题集').alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: 'back', align: VerticalAlign.Center },
            }).fontWeight(FontWeight.Medium).fontColor('333333').id('text')
          }
        }
        .width('100%').backgroundColor(Color.White).height(vp2px(10))

        this.ListViewBuild()

      }
    }.hideTitleBar(true).margin({top:this.topRectHeight})
  }
}

@Builder
export function MineErrorPageBuilder() {
  MineErrorPage();
}
