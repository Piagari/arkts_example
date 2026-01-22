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
import { TrainList } from '../viewmodel/TrainInfoModel'
import { TrainListPage } from '../view/TrainListPage'

@Entry
@Component
export struct TrainPage {
  build() {
    NavDestination() {
      Column() {
        Text('我的培训')
          .height(100)
          .backgroundColor(Color.White)
          .textAlign(TextAlign.Center)
          .width(TrainConstants.FULL_WIDTH)
        Column() {
          TrainListPage({
            dataList: TrainList
          })
        }
        .padding(15)
        .backgroundColor('#f7f7f7')
        .layoutWeight(1)
      }
      .width(TrainConstants.FULL_WIDTH)
      .height(TrainConstants.FULL_HEIGHT)
      .backgroundColor(Color.White)
    }
    .hideTitleBar(true)
  }
}