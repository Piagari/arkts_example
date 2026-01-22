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
import { OnlineListModel } from '../viewmodel/OnlineListModel';
import { onlineList } from '../viewmodel/OnlineLocalData';

//路由info
class NavInfo {
  title: string; //标题
  params: string; //参数

  constructor(title: string, params: string) {
    this.title = title
    this.params = params
  }
}

@Component
export struct OnlineIndex {
  @State isBackShow: boolean = false;
  scroller: Scroller = new Scroller()
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack

  @Builder
  MineListItem(model: OnlineListModel) {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.Start,
    }) {
      Column() {
        Text(model.name)
          .fontSize(16)
          .fontColor('#333333')
          .margin({ left: ResManager.getVp_eight(), top: ResManager.getVp_eight() })
        Text(model.timer)
          .fontSize(12)
          .fontColor('#aaaaaa')
          .margin({ left: ResManager.getVp_eight(), bottom: ResManager.getVp_eight(), top: ResManager.getVp_eight() })
      }.justifyContent(FlexAlign.SpaceBetween).alignItems(HorizontalAlign.Start)
      .padding({ top: ResManager.getVp_eight(), bottom: ResManager.getVp_eight() })
    }
  }

  @Builder
  ListBuilder() {
    List({ scroller: this.scroller }) {
      ForEach(onlineList, (item: OnlineListModel) => {
        ListItem() {
          this.MineListItem(item)
        }
      }, (item: OnlineListModel) => item.key)
    }
    .scrollBar(BarState.Off)
    .divider({ strokeWidth: 1, color: '#f5f5f5' })
    .width(StyleConstants.FULL_WIDTH)
    .layoutWeight(1)

  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          if (this.isBackShow) {
            Image($r('app.media.back'))
              .width(16)
              .height(16)
              .onClick(() => {
                this.pathStack.pop()
              })
          }
          Text('在线帮助')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .margin({
              right: this.isBackShow ? 16 : 0
            })
            .height(100)
        }
        .width(StyleConstants.FULL_WIDTH).padding({
          left: 10,
          right: 10
        }).backgroundColor(Color.White)

        Column() {
          this.ListBuilder()
        }.layoutWeight(1)
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .backgroundColor(Color.White)
    }
    .hideTitleBar(true)
    .onReady((ctx: NavDestinationContext) => {
      //判断是否展示返回按钮
      //{"name":"OnlineIndex","param":{"title":"在线帮助","params":""}}
      if (ctx?.pathInfo?.param) {
        let param = ctx?.pathInfo?.param;
        if (param == '在线帮助') {
          this.isBackShow = true;
        }
      }
    })

  }
}

@Builder
export function OnlineIndexBuilder() {
  OnlineIndex()
}