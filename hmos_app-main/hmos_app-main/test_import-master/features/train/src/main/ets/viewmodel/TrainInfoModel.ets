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


//培训列表info
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
const TrainList: TrainInfo[] = [
  {
    id: 1,
    img: $r('app.media.train_pic01'),
    count: 24,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2023-09-28',
    endTime: '2024-12-31',
    applyNum: 13658,
    money: 1000
  },
  {
    id: 2,
    img: $r('app.media.train_pic02'),
    count: 14,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2023-09-28',
    endTime: '2024-12-31',
    applyNum: 25879,
    money: 866
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    count: 256,
    title: '行业模板专题宣传培训-行业模板使用培训班',
    startTime: '2024-02-05',
    endTime: '2024-12-31',
    applyNum: 6894,
    money: 356
  },

]


//培训列表info
class IntroInfo {
  type?: string; //培训类型
  startTime?: string; //开始时间
  endTime?: string; //截止时间
  count?: number; //课程数量
  hour?: number; //规定学时
  company?: string; //主办单位
  trainingObject?: string; //培训对象
  process?: string; //学习进度
  requiredProcess?: string; //必修学习进度
  demand?: string; //考核要求

  constructor(type: string, startTime: string, endTime: string, count: number, hour: number, company: string,
    trainingObject: string, process: string, requiredProcess: string, demand: string) {
    this.type = type
    this.startTime = startTime
    this.endTime = endTime
    this.count = count
    this.hour = hour
    this.company = company
    this.trainingObject = trainingObject
    this.process = process
    this.requiredProcess = requiredProcess
    this.demand = demand
  }
}

//培训列表info 枚举
enum IntroInfoEnum {
  type = '培训类型',
  startTime = '开始时间',
  endTime = '截止时间',
  count = '课程数量',
  hour = '规定学时',
  company = '主办单位',
  trainingObject = '培训对象',
  process = '学习进度',
  requiredProcess = '必修学习进度',
  demand = '考核要求',
}

const IntroObj =
  new IntroInfo('行业模板宣传培训-行业模板专用培训班', '2023-09-28', '2024-12-31', 24, 7, '', '', '0.0%', '100.0%', '')


//课程info
class CourseInfo {
  id: number = 0
  img?: Resource; //图片
  hour?: number; //时长
  title?: string; //标题
  process?: string; //时间
  type?: number = 0; //类型  0:选修
  finished?: number = 0; //0：已完成  1：未完成
  name?: string; //教师-课程名称
}

//考课程列表数据
const CourseList: CourseInfo[] = [
  {
    id: 1,
    img: $r('app.media.train_pic01'),
    hour: 0.5,
    title: '行业模板学习准则',
    process: '0.00',
    type: 0,
    finished: 0,
    name: '动画'
  },
  {
    id: 2,
    img: $r('app.media.train_pic02'),
    hour: 0.5,
    title: '行业模板学习准则',
    process: '0.00',
    type: 1,
    finished: 1,
    name: '案例'
  },
  {
    id: 3,
    img: $r('app.media.train_pic03'),
    hour: 1,
    title: '行业模板学习准则',
    process: '0.00',
    type: 1,
    finished: 1,
    name: '案例'
  },
]

//考试info
class ExaminationInfo {
  id: number = 0
  hour?: number; //时长
  title?: string; //标题
  text?:string;
}

//考试列表数据
const ExaminationList: ExaminationInfo[] = [
  {
    id: 1,
    hour: 30,
    title: '考试1',
    text:'去考试'
  },
  {
    id: 2,
    hour: 30,
    title: '考试1',
    text:'去考试'
  },
  {
    id: 3,
    hour: 30,
    title: '考试1',
    text:'去考试'
  },
]


//课程评价info
class CourseEvaluateInfo {
  id: number = 0
  img?: Resource; //头像
  name?: string; //姓名
  content?: string; //内容
  time?: string; //时间
  starCount?: number = 0; //类型  0:选修
}

const CourseEvaluateList: CourseEvaluateInfo[] = [
  {
    id: 1,
    img: $r('app.media.pic'),
    name: '陆亿壹',
    content: '学到可知识，学到可知识学到可知识学到可知识学到可知识学到可知识学到可知识学到可知识',
    time: '2023-09-28',
    starCount: 3
  },
  {
    id: 2,
    img: $r('app.media.pic'),
    name: '陆亿壹',
    content: '学到可知识',
    time: '2023-09-28',
    starCount: 4
  },
  {
    id: 3,
    img: $r('app.media.pic'),
    name: '陆亿壹',
    content: '挺好',
    time: '2023-09-28',
    starCount: 2
  }
]


export { TrainInfo,
  TrainList,
  IntroObj,
  IntroInfoEnum,
  IntroInfo,
  ExaminationInfo,
  ExaminationList,
  CourseInfo,
  CourseList,
  CourseEvaluateInfo,
  CourseEvaluateList }


