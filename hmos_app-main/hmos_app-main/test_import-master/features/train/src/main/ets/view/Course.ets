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
import { CourseInfo, CourseList } from '../viewmodel/TrainInfoModel';
import { CourseListComponent } from '../view/CourseList';
import { ItemRestriction, SegmentButton, SegmentButtonOptions, SegmentButtonTextItem } from '@kit.ArkUI';

interface TabBarInfo {
  title: string;
  index: number;
}

@Component
export struct CourseComponent {
  @State List: CourseInfo[] = []
  @State @Watch('getList') currentIndex: number = 0;
  @State tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttons: [{ text: '全部' }, { text: '未完成' }, {
      text: '已完成'
    }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundColor: '#E5E5E5',
    selectedBackgroundColor: '#FFFFFF',
    textPadding: {
      top: 10,
      right: 10,
      bottom: 10,
      left: 10
    },
  })
  @State tabSelectedIndexes: number[] = [0]
  private tabsController: TabsController = new TabsController()
  private TabBarList: TabBarInfo[] = [
    {
      title: '全部',
      index: 0
    },
    {
      title: '未完成',
      index: 1
    },
    {
      title: '已完成',
      index: 2
    }
  ]

  aboutToAppear(): void {
    this.getList()
  }

  getList() {
    if (this.currentIndex === 0) {
      this.List = CourseList
    } else if (this.currentIndex === 1) {
      this.List = CourseList.filter(v => v.finished === 1) //未完成
    } else if (this.currentIndex === 2) {
      this.List = CourseList.filter(v => v.finished === 0) //未完成
    }
  }

  @Builder
  TabBarBuilder(title: string, targetIndex: number) {
    Text(title)
      .fontWeight(targetIndex === this.currentIndex ? FontWeight.Bold : FontWeight.Normal)
      .padding(5)
      .border(targetIndex === this.currentIndex ? {
        width: { bottom: 2 },
        color: { bottom: $r('app.color.blue_text_color') },
        style: {
          bottom: BorderStyle.Solid
        }
      } : {
        width: { bottom: 0 },
      })
      .margin({ left: 10, right: 10 })
      .onClick(() => {
        this.tabsController.changeIndex(targetIndex)
      })
  }

  build() {
    Column() {
      SegmentButton({ options: this.tabOptions, selectedIndexes: $tabSelectedIndexes })
        .borderRadius(px2vp(20 * 3.5))
        .width(px2vp(328 * 3.5))
        .margin({top:px2vp(22 * 3.5)})


      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {

        ForEach(this.TabBarList, (item: TabBarInfo) => {
          TabContent() {
            CourseListComponent({
              CourseList: this.List
            })
              .width('92%')
          }

        }, (item: TabBarInfo) => JSON.stringify(item))
      }
      .width(TrainConstants.FULL_WIDTH)
      .margin({
        top: 10
      })
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .backgroundColor('#F1F3F5')
    .width(TrainConstants.FULL_WIDTH)
    .height(TrainConstants.FULL_HEIGHT)
  }
}