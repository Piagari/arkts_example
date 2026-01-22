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

export class TabBarDataType {
  id: number;
  defaultIcon: ResourceStr;
  selectedIcon: ResourceStr;
  title: string;

  constructor(id: number, defaultIcon: ResourceStr, selectedIcon: ResourceStr, title: string) {
    this.id = id;
    this.defaultIcon = defaultIcon;
    this.selectedIcon = selectedIcon;

    this.title = title
  }
}

export const tabInfo: TabBarDataType[] = [
  new TabBarDataType(0, $r('app.media.ic_public_home_filled_1'), $r('app.media.tab_icon_01'), '首页'),
  new TabBarDataType(1, $r('app.media.ic_public_appstore_filled'), $r('app.media.tab_icon_02'), '培训'),
  new TabBarDataType(3, $r('app.media.message'), $r('app.media.tab_icon_03'), '消息'),
  new TabBarDataType(4, $r('app.media.mine'), $r('app.media.tab_icon_04'), '我的'),
];

@Component
export struct CustomTabBar {
  @Link currentTabIndex: number;

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
      ForEach(tabInfo, (item: TabBarDataType, tabIndex: number) => {
        // 单独一个TabBar组件
        TabItem({
          tabBarIndex: tabIndex,
          currentTabIndex: $currentTabIndex,
        })

      })
    }
    .height(60)
    .margin({ bottom: 0 })
  }
}

@Component
export struct TabItem {
  @StorageLink('bottomRectHeight') bottomRectHeight: number = 0
  @Prop tabBarIndex: number; // tabBar下标
  @Link currentTabIndex: number; // 初始化被选定的tabBar下标

  build() {
    Column() {
      // 判断tab的下标是否为2 高于其他tab
      if (this.tabBarIndex === 10) {
        Column() {
          Image(this.currentTabIndex === this.tabBarIndex ? tabInfo[this.tabBarIndex].selectedIcon :
          tabInfo[this.tabBarIndex].defaultIcon)
            .size({ width: 43, height: 43 })
        }
        .width(52)
        .height(52)
        .borderRadius(24)
        .margin({ top: -20 })
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Center)

        Text(tabInfo[this.tabBarIndex].title)
          .fontColor(this.currentTabIndex === this.tabBarIndex ? $r('app.color.tab_choose_image') : '#A8AAAB')
          .fontSize(12)
          .margin({ top: 8 })
      } else {
        Column() {
          Image(tabInfo[this.tabBarIndex].defaultIcon)
            .size({ width: 28, height: 28 })
            .fillColor(this.currentTabIndex === this.tabBarIndex ? $r('app.color.tab_choose_image') : '#A8AAAB')
          Text(tabInfo[this.tabBarIndex].title)
            .fontColor(this.currentTabIndex === this.tabBarIndex ? $r('app.color.tab_choose_image') : '#A8AAAB')
            .fontSize(12)
            .margin({ top: 5 })
        }
        .height(60)
        .justifyContent(FlexAlign.Center)
      }
    }
    .height(40)
    .onClick(() => {
      // 更新被选中的tabBar下标
      this.currentTabIndex = this.tabBarIndex;

    })
  }
}