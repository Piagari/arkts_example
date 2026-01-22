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

import HomeViewModel, { BusinessInfo } from './HomeViewModel';
import { CommonConstants } from './CommonConstants';

@Component
export struct HomeView {
  @Prop currentPoint: string = CommonConstants.BREAK_POINT_SM;
  @StorageLink('bottomRectHeight') bottomRectHeight: number = 0
  private scrollY: number = 0;
  private offsetValue: number = 0;
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack

  build() {
    NavDestination() {
      Row() {
        Column() {
          Row({ space: CommonConstants.TITLE_ROW_SPACE }) {
            Text('首页')
              .fontSize(px2vp(24 * 3.5))
              .fontColor(Color.Black)
              .fontWeight(700)

            Blank()
            Image($r('app.media.add'))
              .width(px2vp(40 * 3.5))
              .height(px2vp(40 * 3.5))
              .fillColor(Color.Black)
          }
          .width('100%')
          .height(120)

          Scroll() {
            Column() {

              this.buildMainBusiness()

              Row() {
                Text($r('app.string.home_fortune_picks'))
                  .fontSize(px2vp(18 * 3.5))
                  .lineHeight($r('app.float.pick_text_height'))
                  .fontWeight(700)


                Blank()
                Text($r('app.string.home_fortune_all'))
                  .fontColor('#0A59F7')
                  .fontSize(px2vp(14 * 3.5))
                  .fontWeight(500)
                  .onClick(() => {
                    //在线帮助
                    this.pathStack.pushPathByName('OnlineIndex', 'aa');
                  })
              }
              .justifyContent(FlexAlign.Start)
              .width(CommonConstants.FULL_WIDTH_PERCENT)
              .margin({ top: px2vp(40 * 3.5) })

              this.GridBuilder()

            }
          }
          .padding({
            top: $r('app.float.scroll_margin_top')
          })
          .scrollBar(BarState.Off)
          .onScroll((xOffset: number, yOffset: number) => {
            this.offsetValue = this.offsetValue - yOffset;
            if (this.offsetValue > 0) {
              this.offsetValue = 0;
            }
            this.scrollY = vp2px(this.offsetValue)
          })
        }
        .height('100%')
      }
      .alignItems(VerticalAlign.Top)
      .height('95%')
      .width('100%')
      .padding({
        // top: $r('app.float.content_padding_top'),
        left: $r('app.float.padding_common'),
        right: $r('app.float.padding_common')
      })
    }
    .margin({bottom:this.bottomRectHeight*2})
    .hideTitleBar(true)
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize({ width: px2vp(360 * 3.5), height: px2vp(780 * 3.5) })
  }

  @Builder
  buildMainBusiness() {
    Row() {
      ForEach(HomeViewModel.getMainBusiness(), (item: BusinessInfo, index: number) => {
        if (this.currentPoint === CommonConstants.BREAK_POINT_SM) {
          Column({ space: CommonConstants.MAIN_ROW_SPACE }) {
            Image(item.icon)
              .width(px2vp(30 * 3.5))
              .height(px2vp(30 * 3.5))
              .margin({ top: px2vp(10 * 3.5) })
            Text(item.text)
              .fontSize(px2vp(12 * 3.5))
              .fontWeight(500)
              .margin({ bottom: px2vp(15 * 3.5) })
          }
          .backgroundColor(Color.White)
          .borderRadius(px2vp(8 * 3.5))
          .width(px2vp(73 * 3.5))
          .height(px2vp(66 * 3.5))
          .onClick(() => {
            if (index == 3) {
              //注册
              this.pathStack.pushPathByName('RegisterView', null);
            } else {
              this.pathStack.pushPathByName('SecondPage', null);
            }
          })
        } else {
          Row() {
            Image(item.iconBig)
              .width($r('app.float.main_image_big'))
              .height($r('app.float.main_image_big'))
            Text(item.text)
              .fontSize($r('app.float.main_business_size'))
              .fontColor(Color.Black)
              .margin({
                left: CommonConstants.BUSINESS_ROW_SPACE_MD
              })
          }
          .width(CommonConstants.MAIN_BUSINESS_WIDTH)
          .height($r('app.float.business_row_height_md'))
          .alignSelf(ItemAlign.Center)
          .justifyContent(FlexAlign.Center)
          .borderRadius($r('app.float.business_row_radius'))
          .backgroundColor($r('app.color.business_background'))
          .onClick(() => {
            let pathInfo: NavPathInfo = new NavPathInfo('IconPage', '')
            this.pathStack.pushDestination(pathInfo, true);
          })
        }
      }, (item: BusinessInfo, index: number) => index + JSON.stringify(item))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: px2vp(180 * 3.5) })
    .width(CommonConstants.FULL_WIDTH_PERCENT)
  }

  @Builder
  GridBuilder() {
    // 网格
    Grid() {
      ForEach(HomeViewModel.getListBusiness(), (item: BusinessInfo) => {
        GridItem() {
          Column() {
            Image(item.icon)
              .width(px2vp(155* 3.5))
              .height(px2vp(95* 3.5))
              .borderRadius(px2vp(14 * 3.5))
            Text(item.text)
              .fontSize(px2vp(14 * 3.5))
              .fontWeight(400)
              .margin({ top: px2vp(10 * 3.5) })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .height(px2vp(135* 3.5))
      }, (Item: BusinessInfo, index: number) => JSON.stringify(Item))
    }
    .height(px2vp(405 * 3.5))
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr')
    .columnsGap(px2vp(10 * 3.5))
    .margin({ top: px2vp(4 * 3.5) })
  }
}


@Builder
export function HomeViewBuilder() {
  HomeView()
}
