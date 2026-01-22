import { CommonModel } from '@ohos_agcit/driver_license_exam_commonlib';
import { GuideView, GuideService } from '@ohos_agcit/driver_license_exam_guide'
import { Utils } from 'module_city_select'
@Builder
export function GuidePageBuilder() {
  GuidePage();
}

@ComponentV2
export struct GuidePage {
  vm: CommonModel = CommonModel.instance;
  guideService:GuideService = GuideService.instance;

  aboutToAppear(): void {
    Utils.applyLocationPermission().then((city) => {
      if (city) {
        this.guideService.updateCity(city)
      }
    })
  }

  build() {
    NavDestination() {
      GuideView({
        goCitySelectPage:() => {
          this.vm.navStack.pushPathByName('selectCityView', true)
        },
        completed:() => {
          this.vm.navStack.pop();
        }
      })
    }
    .height('100%')
    .width('100%')
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}