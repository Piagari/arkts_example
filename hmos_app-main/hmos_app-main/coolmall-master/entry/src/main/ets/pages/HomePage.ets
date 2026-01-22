/**
 * 首页
 */
import { AppCard } from '../components/AppCard';
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';
import { mockBanners, mockCategories, mockCoupons, mockGoods } from '../data/MockData';
import { Goods, Banner, Category, Coupon } from '../models/CommonModels';

@Component
@Entry
export struct HomePage {
  @State banners: Array<Banner> = mockBanners;
  @State categories: Array<Category> = mockCategories;
  @State coupons: Array<Coupon> = mockCoupons;
  @State goods: Goods[] = mockGoods;
  @State flashSaleGoods: Goods[] = mockGoods.slice(0, 5);
  @State recommendGoods: Goods[] = mockGoods.slice(0, 3);

  build() {
    Column() {
      // 顶部搜索栏
      this.SearchBar()

      // 主内容滚动区域
      Scroll() {
        Column({ space: AppDimensions.spaceMedium }) {
          // 轮播图
          this.BannerSwiper()

          // 优惠券
          this.CouponSection()

          // 分类
          this.CategoryGrid()

          // 限时精选
          this.FlashSaleSection()

          // 推荐商品
          this.RecommendSection()

          // 全部商品
          this.AllGoodsSection()
        }
        .padding(AppDimensions.paddingMedium)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  // 搜索栏
  @Builder
  SearchBar() {
    Row() {
      // Logo
      Image($r('app.media.startIcon'))
        .width(34)
        .height(34)
        .borderRadius(AppDimensions.radiusSmall)

      // 搜索框
      Row({ space: AppDimensions.spaceSmall }) {
        Text('🔍')
          .fontSize(16)

        Text('搜索商品')
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.textSecondary)
      }
      .layoutWeight(1)
      .height(38)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppDimensions.radiusMedium)
      .padding({ left: AppDimensions.paddingMedium, right: AppDimensions.paddingMedium })
      .margin({ left: AppDimensions.spaceMedium, right: AppDimensions.spaceMedium })
      .justifyContent(FlexAlign.Center)

      // GitHub 图标
      Text('↗')
        .fontSize(24)
        .fontColor(AppColors.onBackground)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.background)
    .padding({ left: AppDimensions.paddingMedium, right: AppDimensions.paddingMedium })
  }

  // 轮播图
  @Builder
  BannerSwiper() {
    Swiper() {
      ForEach(this.banners, (banner: Banner) => {
        Image(banner.pic)
          .width('100%')
          .aspectRatio(2)
          .borderRadius(AppDimensions.radiusMedium)
          .objectFit(ImageFit.Cover)
      })
    }
    .autoPlay(true)
    .interval(3000)
    .indicator(true)
    .loop(true)
    .width('100%')
    .aspectRatio(2)
    .borderRadius(AppDimensions.radiusMedium)
  }

  // 优惠券区域
  @Builder
  CouponSection() {
    Column() {
      Row() {
        // 优惠券内容
        Row({ space: AppDimensions.spaceSmall }) {
          Text('🎟️')
            .fontSize(16)

          Text(this.coupons[0]?.title || '')
            .fontSize(AppTypography.fontSizeMedium)
            .fontColor(AppColors.textPrimary)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
        .layoutWeight(1)

        // 分割线
        Divider()
          .vertical(true)
          .height(20)
          .color(AppColors.divider)
          .strokeWidth(0.5)
          .margin({ left: AppDimensions.spaceMedium, right: AppDimensions.spaceMedium })

        // 领取按钮
        Text('领取')
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingMedium)
  }

  // 分类网格
  @Builder
  CategoryGrid() {
    Column() {
      Grid() {
        ForEach(this.categories, (category: Category) => {
          GridItem() {
            Column({ space: AppDimensions.spaceXSmall }) {
              Image(category.pic)
                .width('80%')
                .aspectRatio(1)
                .borderRadius(AppDimensions.radiusRound)
                .objectFit(ImageFit.Cover)

              Text(category.name)
                .fontSize(AppTypography.fontSizeMedium)
                .fontColor(AppColors.textPrimary)
            }
            .width('100%')
            .padding(AppDimensions.paddingXSmall)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsGap(AppDimensions.spaceSmall)
      .columnsGap(AppDimensions.spaceSmall)
      .width('100%')
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)
  }

  // 限时精选
  @Builder
  FlashSaleSection() {
    Column() {
      Column({ space: AppDimensions.spaceMedium }) {
        // 标题行
        Row() {
          Row({ space: AppDimensions.spaceSmall }) {
            Text('⏰')
              .fontSize(20)

            Text('限时精选')
              .fontSize(AppTypography.fontSizeLarge)
              .fontWeight(AppTypography.fontWeightMedium)
              .fontColor(AppColors.textPrimary)
          }

          Blank()

          Text('查看全部')
            .fontSize(AppTypography.fontSizeMedium)
            .fontColor(AppColors.textSecondary)
        }
        .width('100%')

        // 商品列表
        List({ space: AppDimensions.spaceSmall }) {
          ForEach(this.flashSaleGoods, (goods: Goods) => {
            ListItem() {
              this.FlashSaleItem(goods)
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(180)
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)
  }

  // 限时精选商品项
  @Builder
  FlashSaleItem(goods: Goods) {
    Column({ space: AppDimensions.spaceSmall }) {
      Image(goods.mainPic)
        .width(120)
        .height(120)
        .borderRadius(AppDimensions.radiusSmall)
        .objectFit(ImageFit.Cover)

      Text(goods.name)
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(AppColors.textPrimary)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(120)

      Text(`¥${(goods.price / 100).toFixed(2)}`)
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(AppColors.price)
        .fontWeight(AppTypography.fontWeightBold)
    }
  }

  // 推荐商品
  @Builder
  RecommendSection() {
    Column({ space: AppDimensions.spaceMedium }) {
      this.SectionTitle('推荐商品')

      Column({ space: AppDimensions.spaceMedium }) {
        ForEach(this.recommendGoods, (goods: Goods) => {
          this.GoodsListItem(goods)
        })
      }
    }
  }

  // 全部商品
  @Builder
  AllGoodsSection() {
    Column({ space: AppDimensions.spaceMedium }) {
      this.SectionTitle('全部商品')

      // 使用WaterFlow瀑布流布局
      WaterFlow() {
        ForEach(this.goods, (goods: Goods) => {
          FlowItem() {
            this.GoodsGridItem(goods)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(AppDimensions.spaceMedium)
      .columnsGap(AppDimensions.spaceMedium)
      .width('100%')
    }
  }

  // 商品列表项
  @Builder
  GoodsListItem(goods: Goods) {
    Row({ space: AppDimensions.spaceMedium }) {
      Image(goods.mainPic)
        .width(100)
        .height(100)
        .borderRadius(AppDimensions.radiusSmall)
        .objectFit(ImageFit.Cover)

      Column({ space: AppDimensions.spaceSmall }) {
        Text(goods.name)
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.textPrimary)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: AppDimensions.spaceXSmall }) {
          Text(`¥${(goods.price / 100).toFixed(2)}`)
            .fontSize(AppTypography.fontSizeLarge)
            .fontColor(AppColors.price)
            .fontWeight(AppTypography.fontWeightBold)

          if (goods.originalPrice) {
            Text(`¥${(goods.originalPrice / 100).toFixed(2)}`)
              .fontSize(AppTypography.fontSizeSmall)
              .fontColor(AppColors.textTertiary)
              .decoration({ type: TextDecorationType.LineThrough })
          }
        }

        if (goods.sales) {
          Text(`已售 ${goods.sales}`)
            .fontSize(AppTypography.fontSizeSmall)
            .fontColor(AppColors.textSecondary)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingMedium)
  }

  // 商品网格项
  @Builder
  GoodsGridItem(goods: Goods) {
    Column({ space: AppDimensions.spaceSmall }) {
      Image(goods.mainPic)
        .width('100%')
        .aspectRatio(1)
        .borderRadius(AppDimensions.radiusSmall)
        .objectFit(ImageFit.Cover)

      Column({ space: AppDimensions.spaceXSmall }) {
        Text(goods.name)
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.textPrimary)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(`¥${(goods.price / 100).toFixed(2)}`)
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.price)
          .fontWeight(AppTypography.fontWeightBold)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingSmall)
  }

  // 分段标题
  @Builder
  SectionTitle(title: string) {
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
}
