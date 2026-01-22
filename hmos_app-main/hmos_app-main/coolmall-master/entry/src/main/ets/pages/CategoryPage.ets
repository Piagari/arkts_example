/**
 * 分类页
 */
import { TopAppBar } from '../components/TopAppBar';
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';
import { mockCategoryTrees } from '../data/MockData';
import { CategoryTree, CategoryChild } from '../models/CommonModels';

@Component
export struct CategoryPage {
  @State categoryTrees: CategoryTree[] = mockCategoryTrees;
  @State selectedIndex: number = 0;
  private rightScroller: Scroller = new Scroller();

  build() {
    Column() {
      // 顶部标题栏
      TopAppBar({ title: '分类' })

      // 左右分栏布局
      Row() {
        // 左侧分类列表
        this.LeftCategoryList()

        // 右侧内容区域
        this.RightCategoryContent()
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  // 左侧分类列表
  @Builder
  LeftCategoryList() {
    List() {
      ForEach(this.categoryTrees, (category: CategoryTree, index: number) => {
        ListItem() {
          this.LeftCategoryItem(category.name, index)
        }
      })
    }
    .width(100)
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }

  // 左侧分类项
  @Builder
  LeftCategoryItem(name: string, index: number) {
    Stack({ alignContent: Alignment.Start }) {
      // 背景
      Row()
        .width('100%')
        .height(50)
        .backgroundColor(this.selectedIndex === index ? AppColors.surface : AppColors.background)
        .borderRadius({
          topRight: this.selectedIndex === index || this.selectedIndex === index + 1 ? 0 : AppDimensions.radiusLarge,
          bottomRight: this.selectedIndex === index || this.selectedIndex === index - 1 ? 0 : AppDimensions.radiusLarge
        })

      // 左侧指示条
      if (this.selectedIndex === index) {
        Row()
          .width(3)
          .height(24)
          .backgroundColor(AppColors.primary)
      }

      // 文本内容
      Text(name)
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(this.selectedIndex === index ? AppColors.primary : AppColors.textSecondary)
        .fontWeight(this.selectedIndex === index ? AppTypography.fontWeightBold : AppTypography.fontWeightNormal)
    }
    .width('100%')
    .height(50)
    .onClick(() => {
      this.selectedIndex = index;
      // 滚动右侧内容到对应位置
      this.rightScroller.scrollToIndex(index);
    })
  }

  // 右侧内容区域
  @Builder
  RightCategoryContent() {
    List({ scroller: this.rightScroller }) {
      ForEach(this.categoryTrees, (categoryTree: CategoryTree, index: number) => {
        ListItem() {
          Column({ space: AppDimensions.spaceMedium }) {
            // 分类标题
            this.CategoryTitle(categoryTree.name)

            // 子分类网格
            this.SubCategoryGrid(categoryTree.children)
          }
          .width('100%')
          .padding(AppDimensions.paddingMedium)
        }
      })
    }
    .layoutWeight(1)
    .height('100%')
    .backgroundColor(AppColors.surface)
    .scrollBar(BarState.Off)
    .onScrollIndex((start: number) => {
      // 滚动时更新左侧选中项
      if (start !== this.selectedIndex) {
        this.selectedIndex = start;
      }
    })
  }

  // 分类标题
  @Builder
  CategoryTitle(title: string) {
    Row() {
      Divider()
        .strokeWidth(2)
        .color(AppColors.primary)
        .width(4)
        .vertical(false)

      Text(title)
        .fontSize(AppTypography.fontSizeLarge)
        .fontWeight(AppTypography.fontWeightMedium)
        .fontColor(AppColors.textPrimary)
        .margin({ left: AppDimensions.spaceSmall })
    }
    .width('100%')
  }

  // 子分类网格
  @Builder
  SubCategoryGrid(children: CategoryChild[]) {
    Grid() {
      ForEach(children, (child: CategoryChild) => {
        GridItem() {
          Column({ space: AppDimensions.spaceXSmall }) {
            Image(child.pic)
              .width('100%')
              .aspectRatio(1)
              .borderRadius(AppDimensions.radiusMedium)
              .objectFit(ImageFit.Cover)

            Text(child.name)
              .fontSize(AppTypography.fontSizeSmall)
              .fontColor(AppColors.textPrimary)
              .textAlign(TextAlign.Center)
              .width('100%')
          }
          .width('100%')
          .padding(AppDimensions.paddingSmall)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsGap(AppDimensions.spaceMedium)
    .columnsGap(AppDimensions.spaceMedium)
    .width('100%')
  }
}

