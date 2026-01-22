/**
 * 卡片组件
 */
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';

@Component
export struct AppCard {
  // 内容插槽
  @BuilderParam content: () => void;
  // 圆角大小
  private cardBorderRadius: number = AppDimensions.radiusMedium;
  // 内边距
  private cardPadding: number = AppDimensions.paddingLarge;
  // 背景色
  private cardBackgroundColor: string | Resource = AppColors.surface;
  // 边距
  private cardMargin: number = 0;

  build() {
    Column() {
      if (this.content) {
        this.content();
      }
    }
    .width('100%')
    .backgroundColor(this.cardBackgroundColor)
    .borderRadius(this.cardBorderRadius)
    .padding(this.cardPadding)
    .margin({ top: this.cardMargin, bottom: this.cardMargin })
  }
}

