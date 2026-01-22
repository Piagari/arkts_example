/**
 * 主页面 - 包含底部导航栏和四个主要Tab页面
 */
import { HomePage } from './HomePage';
import { CategoryPage } from './CategoryPage';
import { CartPage } from './CartPage';
import { MePage } from './MePage';
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';

@Entry
@Component
struct MainPage {
  @State currentTabIndex: number = 0;

  // Tab 配置
  private tabItems: TabItem[] = [
    { name: '首页', icon: $r('app.media.ic_home'), selectedIcon: $r('app.media.ic_home') },
    { name: '分类', icon: $r('app.media.ic_category'), selectedIcon: $r('app.media.ic_category') },
    { name: '购物车', icon: $r('app.media.ic_cart'), selectedIcon: $r('app.media.ic_cart') },
    { name: '我的', icon: $r('app.media.ic_person'), selectedIcon: $r('app.media.ic_person') }
  ];

  @Builder
  TabItemBuilder(item: TabItem, index: number) {
    Column({ space: AppDimensions.spaceXSmall }) {
      // 使用文字图标代替SVG图标
      Text(this.getTabIcon(index))
        .fontSize(24)
        .fontColor(this.currentTabIndex === index ? AppColors.primary : AppColors.textSecondary)

      Text(item.name)
        .fontSize(AppTypography.fontSizeSmall)
        .fontColor(this.currentTabIndex === index ? AppColors.primary : AppColors.textSecondary)
        .fontWeight(this.currentTabIndex === index ? AppTypography.fontWeightMedium : AppTypography.fontWeightNormal)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  // 获取Tab图标（使用Emoji作为临时方案）
  getTabIcon(index: number): string {
    const icons = ['🏠', '📱', '🛒', '👤'];
    return icons[index] || '';
  }

  build() {
    Column() {
      // 主内容区域 - 使用Tabs实现页面切换
      Tabs({
        index: this.currentTabIndex,
        barPosition: BarPosition.End
      }) {
        // 首页
        TabContent() {
          HomePage()
        }
        .tabBar(this.TabItemBuilder(this.tabItems[0], 0))

        // 分类
        TabContent() {
          CategoryPage()
        }
        .tabBar(this.TabItemBuilder(this.tabItems[1], 1))

        // 购物车
        TabContent() {
          CartPage()
        }
        .tabBar(this.TabItemBuilder(this.tabItems[2], 2))

        // 我的
        TabContent() {
          MePage()
        }
        .tabBar(this.TabItemBuilder(this.tabItems[3], 3))
      }
      .width('100%')
      .height('100%')
      .barMode(BarMode.Fixed)
      .barHeight(AppDimensions.bottomBarHeight)
      .barBackgroundColor(AppColors.surface)
      .onChange((index: number) => {
        this.currentTabIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

/**
 * Tab项数据结构
 */
interface TabItem {
  name: string;
  icon: Resource;
  selectedIcon: Resource;
}

