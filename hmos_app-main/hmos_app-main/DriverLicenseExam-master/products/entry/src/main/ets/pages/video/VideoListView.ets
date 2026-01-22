import { ExamService, Video} from '@ohos_agcit/driver_license_exam_datasource'
import { CommonConstants, CommonModel } from '@ohos_agcit/driver_license_exam_commonlib'

@Builder
export function VideoListViewBuild() {
  VideoListView()
}

@ComponentV2
struct VideoListView {
  vm: CommonModel = CommonModel.instance;
  examService: ExamService = ExamService.instance;
  @Local videoList:Video[] = this.examService.getVideList();
  @Local bottomRectHeight: number = 0;
  @Local topRectHeight: number = 0;

  aboutToAppear(): void {
    this.bottomRectHeight = AppStorage.get('bottomRectHeight') || 0;
    this.topRectHeight = AppStorage.get('topRectHeight') || 0;
  }

  build() {
    NavDestination() {
      Column() {
        List({space:12}) {
          ForEach(this.videoList, (item:Video) => {
            ListItem() {
              Row({space:12}) {
                RelativeContainer() {
                  Image(item.poster)
                    .height(CommonConstants.FULL_HEIGHT)
                    .width(CommonConstants.FULL_WIDTH)
                    .borderRadius(8)

                  Image($r('app.media.player_btn_list'))
                    .height(24)
                    .height(24)
                    .alignRules({
                      bottom:{anchor:'__container__', align:VerticalAlign.Center},
                      left:{anchor:'__container__', align:HorizontalAlign.Center}
                    })
                    .offset({
                      x: -12,
                      y: 12
                    })

                  Text(item.time)
                    .fontSize(10)
                    .fontColor(Color.White)
                    .alignRules({
                      bottom:{anchor:'__container__', align: VerticalAlign.Bottom},
                      right: {anchor:'__container__',align: HorizontalAlign.End}
                    })
                    .offset({
                      x: -8,
                      y: -10,
                    })
                }
                .height(CommonConstants.FULL_HEIGHT)
                .width(124)

                Column({space:8}) {
                  Text(item.simpleDescription)
                    .fontSize(16)
                    .fontColor('rgba(0,0,0,0.9)')
                    .fontWeight(FontWeight.Medium)
                    .width(CommonConstants.FULL_WIDTH)
                    .textOverflow({
                      overflow:TextOverflow.Ellipsis
                    })
                    .ellipsisMode(EllipsisMode.END)
                    .maxLines(1)
                  Text(item.description)
                    .fontSize(14)
                    .fontColor('rgba(0,0,0,0.6)')
                    .fontWeight(FontWeight.Regular)
                    .textOverflow({
                      overflow:TextOverflow.Ellipsis
                    })
                    .ellipsisMode(EllipsisMode.END)
                    .maxLines(3)
                }
                .layoutWeight(1)
              }
              .height(106)
              .width(CommonConstants.FULL_WIDTH)
              .backgroundColor(Color.White)
              .borderRadius(16)
              .padding(12)
              .onClick(() => {
                this.vm.navStack.pushPathByName('videoDetailView', item)
              })
            }

          }, (item:Video) => JSON.stringify(item))
        }
        .scrollBar(BarState.Off)
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({
        top:12,
        left: 16,
        right: 16
      })
    }
    .title('视频课程')
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .padding({
      top:px2vp(this.topRectHeight),
      bottom: px2vp(this.bottomRectHeight)
    })
    .backgroundColor('#F1F3F5')
  }
}