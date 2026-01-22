/**
 * 顶部导航栏组件
 */
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';

@Component
export struct TopAppBar {
  // 标题
  title?: string = '';
  // 是否显示返回按钮
  showBackIcon?: boolean = false;
  // 返回按钮点击回调
  onBackClick?: () => void;
  // 右侧操作按钮插槽
  @BuilderParam actions?: () => void;
  // 背景色
  private barBackgroundColor: string | Resource = AppColors.background;

  build() {
    Row() {
      // 左侧：返回按钮或占位
      if (this.showBackIcon) {
        Text('‹')
          .fontSize(32)
          .fontColor(AppColors.onBackground)
          .width(AppDimensions.iconMedium)
          .height(AppDimensions.iconMedium)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            if (this.onBackClick) {
              this.onBackClick();
            }
          })
          .padding(AppDimensions.paddingSmall)
      } else {
        Row().width(AppDimensions.iconMedium + AppDimensions.paddingSmall * 2)
      }

      // 中间：标题
      Text(this.title)
        .fontSize(AppTypography.fontSizeLarge)
        .fontWeight(AppTypography.fontWeightMedium)
        .fontColor(AppColors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 右侧：操作按钮或占位
      Row() {
        if (this.actions) {
          this.actions();
        }
      }
      .width(AppDimensions.iconMedium + AppDimensions.paddingSmall * 2)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(AppDimensions.topBarHeight)
    .backgroundColor(this.barBackgroundColor)
    .padding({
      left: AppDimensions.paddingMedium,
      right: AppDimensions.paddingMedium
    })
  }
}

