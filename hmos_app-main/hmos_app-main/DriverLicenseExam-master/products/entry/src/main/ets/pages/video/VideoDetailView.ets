
import { CommonConstants, CommonModel } from '@ohos_agcit/driver_license_exam_commonlib'
import { Video } from '@ohos_agcit/driver_license_exam_datasource';

@Builder
export function VideoDetailViewBuilder() {
  VideoDetailView()
}


@ComponentV2
struct VideoDetailView {
  vm: CommonModel = CommonModel.instance;
  @Local videUrl: string = ''
  @Local videoParam: Video | undefined = undefined;
  @Local bottomRectHeight: number = 0;
  @Local topRectHeight: number = 0;

  aboutToAppear(): void {
    this.bottomRectHeight = AppStorage.get('bottomRectHeight') || 0;
    this.topRectHeight = AppStorage.get('topRectHeight') || 0;
  }

  build() {
    NavDestination() {
      if (this.videoParam !== undefined) {
        Scroll() {
          Column() {
            Stack({alignContent:Alignment.TopStart}) {
              Video({
                src: this.videoParam.url,
              })
                .width(CommonConstants.FULL_WIDTH)
                .height(204)

              Image($r('app.media.title_bar'))
                .height(56)
                .width(252)
                .margin({
                  left: 16
                })
                .onClick(() => {
                  this.vm.navStack.pop()
                })
            }
            .width(CommonConstants.FULL_WIDTH)
            .height(204)

            Column({space:24}) {
              Text(this.videoParam.simpleDescription)
                .fontSize(18)
                .fontColor('rgba(0,0,0,0.9)')
                .fontWeight(FontWeight.Bold)
                .width(CommonConstants.FULL_WIDTH)
              Text(this.videoParam.description)
                .fontSize(14)
                .fontColor('rgba(0,0,0,0.9)')
                .lineHeight(21)
                .width(CommonConstants.FULL_WIDTH)
              Text(this.videoParam.copyrightNotice)
                .fontSize(14)
                .fontColor('rgba(0,0,0,0.6)')
                .width(CommonConstants.FULL_WIDTH)
            }
            .padding({
              top:8,
              left:16,
              right:16
            })
          }
        }
        .scrollBar(BarState.Off)
      }
    }
    .height(CommonConstants.FULL_HEIGHT)
    .width(CommonConstants.FULL_WIDTH)
    .padding({
      top:px2vp(this.topRectHeight),
      bottom: px2vp(this.bottomRectHeight)
    })
    .hideTitleBar(true)
    .backgroundColor('#F1F3F5')
    .onReady(() => {
      const preIndex = this.vm.navStack.size() - 1;
      const param: Video = this.vm.navStack.getParamByIndex(preIndex) as Video;
      this.videoParam = param;
    })

  }
}