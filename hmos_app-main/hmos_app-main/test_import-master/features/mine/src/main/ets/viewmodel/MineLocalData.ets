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

import { MineListModel } from './MineListModel'
import { MineSetListModel } from './MineSetListModel'
import { MineCourseListModel } from './MineCourseListModel'
import { MineOnlineTestModel } from './MineOnlineTestModel'
import { MineErrorModel } from './MineErrorModel'

const setListModels: MineSetListModel[][] = [
  [
    new MineSetListModel(
      $r('app.string.mine_set_grxx'),
      '0',
      'MineModiPersonPage'
    ),
    new MineSetListModel(
      $r('app.string.mine_set_xgmm'),
      '1',
      'ModifyPasswordView'
    ),
  ],
  [
    new MineSetListModel(
      $r('app.string.mine_set_ysxy'),
      '2',
      'PolicyAgreement'
    ),
    new MineSetListModel(
      $r('app.string.mine_set_qchc'),
      '3',
      '/clear'
    ),
    new MineSetListModel(
      $r('app.string.mine_set_zxzh'),
      '4',
      'LogoutView'
    ),
    new MineSetListModel(
      $r('app.string.mine_set_tcdl'),
      '5',
      '/logout'
    ),
  ]

]

const listModel: MineListModel[] = [
  new MineListModel(
    $r('app.media.mine_icon_1'),
    $r('app.string.mine_title_kc'),
    '0',
    'MineCoursePage',
    '#f56c6c'//蓝色
  ),
  new MineListModel(
    $r('app.media.mine_icon_2'),
    $r('app.string.mine_title_ks'),
    '1',
    'MineOnlineTestPage',
    '#409eff'
  ),
  new MineListModel(
    $r('app.media.mine_icon_3'),
    $r('app.string.mine_title_ct'),
    '2',
    'MineErrorPage',
    '#67c23a'
  ),
  new MineListModel(
    $r('app.media.mine_icon_4'),
    $r('app.string.mine_title_px'),
    '3',
    'MineTrainPage',
    '#e6a23c'
  ),
  new MineListModel(
    $r('app.media.mine_icon_4'),
    $r('app.string.mine_title_sz'),
    '4',
    'MineSetPage',
    '#409eff'//蓝色
  ),

]

const courseList: MineCourseListModel[] = [
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '1',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '2',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '3',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '4',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '5',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '6',
    0.6,
    '王老师',
    ''
  ),
  new MineCourseListModel(
    'placeHolder',
    '线性代数考试1',
    '7',
    0.6,
    '王老师',
    ''
  ),
]

class TrainInfo {
  id: number = 0
  img?: Resource; //图片
  count?: number; //课程数量
  title?: string; //标题
  startTime?: string; //开始时间
  endTime?: string; //截止时间
  applyNum?: number; //报名人数
  money?: number; //钱
}

//培训列表数据
const trainList: TrainInfo[] = [
  {
    id: 1,
    img: $r('app.media.train_pic01'),
    count: 24,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2023-09-28',
    endTime: '2024-12-31',
    applyNum: 13658,
    money: 1000
  },
  {
    id: 2,
    img: $r('app.media.train_pic02'),
    count: 14,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2023-09-28',
    endTime: '2024-12-31',
    applyNum: 25879,
    money: 866
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-注册用户专用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
]

const testList: MineOnlineTestModel[] = [
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '1',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '2',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '3',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '4',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '5',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '6',
    '05-26',
    '05-30',
    '100'
  ),
  new MineOnlineTestModel(
    '已结束',
    '行业模板安全规范学习，按照新的指导去规范学习行业模板开发',
    '7',
    '05-26',
    '05-30',
    '100'
  ),
]
// this.title = title;
// this.ques = ques;
// this.rightQues = rightQues;
// this.anwer = anwer;
// this.key = key
const errorModels: MineErrorModel[] = [
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错', 'C. 以上都对', 'C. 以上都错'],
    'A',
    'B',
    '1'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错', 'C. 以上都对', 'C. 以上都错'],
    'A',
    'B',
    '2'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错', 'C. 以上都对'],
    'A',
    'B',
    '3'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错'],
    'A',
    'B',
    '4'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错'],
    'A',
    'B',
    '5'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错'],
    'A',
    'B',
    '6'
  ),
  new MineErrorModel(
    '行业模板规范可以从以下那个渠道获取？',
    ['A.  对', 'B.  错'],
    'A',
    'B',
    '7'
  ),
]


export { listModel, setListModels, courseList, TrainInfo, trainList, errorModels, testList }