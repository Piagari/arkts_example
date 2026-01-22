
import { CommonConstants, CommonModel } from '@ohos_agcit/driver_license_exam_commonlib'
import { Chapter, ExamService, EXAM_MANAGER_TYPE, ROUTE_PARAM , WRONG_COLLECT} from '@ohos_agcit/driver_license_exam_datasource'
import { promptAction } from '@kit.ArkUI';


@Builder
export function CollectionViewBuilder() {
  CollectionView()
}

@Entry
@ComponentV2
struct CollectionView {
  vm: CommonModel = CommonModel.instance;
  @Local bottomRectHeight: number = 0;
  @Local topRectHeight: number = 0;
  examService: ExamService = ExamService.instance;
  @Local chapterList:Chapter[] = this.examService.getChapterListByType(WRONG_COLLECT.WRONG);
  @Local typeStatus: WRONG_COLLECT = WRONG_COLLECT.WRONG;
  @Local totalCount: number = 0;

  aboutToAppear(): void {
    this.bottomRectHeight = AppStorage.get('bottomRectHeight') || 0;
    this.topRectHeight = AppStorage.get('topRectHeight') || 0;
    this.getTotalCount();
  }

  @Styles
  cardStyle() {
    .width(CommonConstants.FULL_WIDTH)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
  }

  toggleWrongOrCollect(type: WRONG_COLLECT) {
    this.typeStatus = type;
    this.getTotalCount();
    this.chapterList = this.examService.getChapterListByType(type);
  }

  getTotalCount() {
    if (this.typeStatus === WRONG_COLLECT.WRONG) {
      this.totalCount = this.examService.getErrorCount();
    } else {
      this.totalCount = this.examService.getCollectCount();
    }
  }

  build() {
    NavDestination(){
      Column({space:12}) {
        Row() {
          Text('错题本')
            .width(86)
            .height(36)
            .fontColor(this.typeStatus === WRONG_COLLECT.WRONG?Color.White:'rgba(0,0,0,0.9)')
            .fontSize(14)
            .backgroundColor(this.typeStatus === WRONG_COLLECT.WRONG?'#64BB5C':'#E6E8E9')
            .borderRadius(16)
            .textAlign(TextAlign.Center)
            .margin({
              right:12
            })
            .onClick(() => {
              this.toggleWrongOrCollect(WRONG_COLLECT.WRONG)
            })
          Text('收藏题目')
            .width(86)
            .height(36)
            .fontColor(this.typeStatus === WRONG_COLLECT.COLLECT?Color.White:'rgba(0,0,0,0.9)')
            .fontSize(14)
            .backgroundColor(this.typeStatus === WRONG_COLLECT.COLLECT?'#64BB5C':'#E6E8E9')
            .borderRadius(16)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.toggleWrongOrCollect(WRONG_COLLECT.COLLECT)
            })
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Start)

        Column() {
          Row() {
            Text(this.typeStatus === WRONG_COLLECT.WRONG?'错题统计':'收藏统计')
              .fontSize(16)
              .fontColor('rgba(0,0,0,0.9)')
            Row() {
              Image($r('app.media.clear'))
                .width(24)
                .height(24)
              Text('清空')
                .fontSize(14)
                .fontColor('rgba(0,0,0,0.9)')
            }
            .onClick(() => {
                if (this.typeStatus === WRONG_COLLECT.WRONG) {
                  this.examService.clearWrongQuestion()
                } else {
                  this.examService.clearCollectQuestion();
                }
                this.toggleWrongOrCollect(this.typeStatus);
            })
          }
          .width(CommonConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            bottom: 12
          })
          Divider()
          Row() {
            Text(this.typeStatus === WRONG_COLLECT.WRONG?'错题总数':'收藏总数')
              .fontSize(14)
              .fontColor('rgba(0,0,0,0.9)')

            Row() {
              Text(String(this.totalCount))
                .fontSize(24)
                .fontColor('#64BB5C')
                .fontWeight(FontWeight.Bold)
                .margin({
                  right:8
                })

              Image($r('app.media.ic_right_arrow_lined'))
                .width(16)
                .height(16)
            }
          }
          .width(CommonConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            top: 12
          })
          .onClick(() => {
            if (this.totalCount === 0) {
              promptAction.showToast({
                message: this.typeStatus === WRONG_COLLECT.WRONG?'暂时没有错题':'暂时没有收藏的题目',
                duration: 1500,
              })
              return;
            }
            const param:ROUTE_PARAM = {
              title: this.typeStatus === WRONG_COLLECT.WRONG?'错题':'收藏',
              type: this.typeStatus === WRONG_COLLECT.WRONG?EXAM_MANAGER_TYPE.error:EXAM_MANAGER_TYPE.collect
            }
            this.vm.navStack.pushPathByName('practiceView', param)
          })
        }
        .cardStyle()

        Column() {
          Text(this.typeStatus === WRONG_COLLECT.WRONG?'错题分布':'收藏分布')
            .width(CommonConstants.FULL_WIDTH)
            .textAlign(TextAlign.Start)
            .fontSize(16)
            .fontColor('rgba(0,0,0,0.9)')
          List() {
            ForEach(this.chapterList, (item: Chapter, index: number) => {
              ListItem() {
                Row() {
                  Row() {
                    Text(String(index + 1))
                      .width(16)
                      .height(16)
                      .margin({
                        right:8
                      })
                      .fontSize(10)
                      .fontColor(Color.White)
                      .borderRadius('50%')
                      .backgroundColor(item.serialBgColor)
                      .textAlign(TextAlign.Center)

                    Text(item.title)
                      .fontSize(14)
                      .fontColor('rgba(0,0,0,0.9)')
                  }

                  Row() {
                    Text(String(item.examManger.total))
                      .fontSize(14)
                      .fontColor('rgba(0,0,0,0.6)')
                      .margin({
                        right: 4
                      })
                    Image($r('app.media.ic_right_arrow_lined'))
                      .width(16)
                      .height(16)

                  }
                }
                .width(CommonConstants.FULL_WIDTH)
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({
                  top:12,
                  bottom: 12
                })
                .onClick(() => {
                  const param:ROUTE_PARAM = {
                    title: item.title,
                    type: EXAM_MANAGER_TYPE.chapter_name,
                    wrongOrCollect: this.typeStatus,
                    keyword: item.title
                  }
                  this.vm.navStack.pushPathByName('practiceView', param)
                })
              }
              .width(CommonConstants.FULL_WIDTH)
            }, (item:Chapter) => JSON.stringify(item))
          }
          .width(CommonConstants.FULL_WIDTH)
          .divider({
            strokeWidth:1,
            color:'rgba(0,0,0,0.2)'
          })
        }
        .cardStyle()


      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
      .padding({
        top:12,
        bottom:12,
        right: 16,
        left: 16
      })
    }
    .title('错题收藏')
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .padding({
      top:px2vp(this.topRectHeight),
      bottom: px2vp(this.bottomRectHeight)
    })
    .backgroundColor('#F1F3F5')
  }
}