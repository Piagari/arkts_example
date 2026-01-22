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

import web_webview from '@ohos.web.webview';
import { ResManager } from '../common/resources/ResManager ';

@Component
export struct PolicyAgreement {
  @State message: string = 'Hello World';
  controller: web_webview.WebviewController = new web_webview.WebviewController();
  //隐私申明H5链接，下面链接仅做示意
  @State web_url: string =
    'https://privacy.consumer.huawei.com/legal/huawei-developer-app/privacy-statement.htm?&code=CN&language=zh-CN&branchid=0'
  pathStack: NavPathStack = AppStorage.get('pathStack') as NavPathStack;

  aboutToAppear(): void {

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
            Text('隐私协议').alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: 'back', align: VerticalAlign.Center },
            }).fontWeight(FontWeight.Medium).fontColor('333333').id('text')
          }
        }
        .width('100%').backgroundColor(Color.White).height(vp2px(10))

        Divider().strokeWidth(5).color('f5f5f5')
        Web({ src: this.web_url, controller: this.controller }).onPageEnd((res) => {
        }).onErrorReceive((err) => {
        }).height('100%').width('100%')
      }
    }
    .hideTitleBar(true)
  }
}

@Builder
export function PolicyAgreementBuilder() {
  PolicyAgreement()
}