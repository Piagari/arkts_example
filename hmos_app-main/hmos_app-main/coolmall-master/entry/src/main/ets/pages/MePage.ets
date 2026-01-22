/**
 * 我的页面
 */
import { AppCard } from '../components/AppCard';
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';
import { mockUser, mockOrderCount, mockFootprints } from '../data/MockData';
import { User, OrderCount, Footprint } from '../models/CommonModels';

@Component
export struct MePage {
  @State user: User = mockUser;
  @State orderCount: OrderCount = mockOrderCount;
  @State footprints: Footprint[] = mockFootprints;
  @State isLoggedIn: boolean = false;

  build() {
    Column() {
      Scroll() {
        Column({ space: AppDimensions.spaceMedium }) {
          // 用户信息区域
          this.UserInfoSection()

          // 会员权益卡片
          this.MembershipCard()

          // 订单管理
          this.OrderSection()

          // 我的足迹
          if (this.footprints.length > 0) {
            this.FootprintSection()
          }

          // 功能菜单
          this.FunctionMenu()
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

  // 用户信息区域
  @Builder
  UserInfoSection() {
    Row({ space: AppDimensions.spaceLarge }) {
      // 头像
      Text('👤')
        .fontSize(48)
        .width(72)
        .height(72)
        .borderRadius(AppDimensions.radiusRound)
        .backgroundColor(AppColors.surfaceVariant)
        .textAlign(TextAlign.Center)
        .padding({ top: 12 })

      // 用户信息
      Column({ space: AppDimensions.spaceXSmall }) {
        Text(this.isLoggedIn ? this.user.nickName : '未登录')
          .fontSize(AppTypography.fontSizeXLarge)
          .fontColor(AppColors.textPrimary)
          .fontWeight(AppTypography.fontWeightBold)

        Text(this.isLoggedIn && this.user.phone ? `手机号: ${this.user.phone}` : '点击登录')
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 箭头
      Text('›')
        .fontSize(24)
        .fontColor(AppColors.textTertiary)
    }
    .width('100%')
    .padding(AppDimensions.paddingLarge)
  }

  // 会员权益卡片
  @Builder
  MembershipCard() {
    Row({ space: AppDimensions.spaceMedium }) {
      Row({ space: AppDimensions.spaceSmall }) {
        Text('👑')
          .fontSize(18)

        Text('5 VIP Benefits!')
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.vip)
          .fontWeight(AppTypography.fontWeightBold)
      }

      Blank()

      Text('激活会员')
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(AppColors.vip)
        .padding({
          left: AppDimensions.paddingMedium,
          right: AppDimensions.paddingMedium,
          top: 6,
          bottom: 6
        })
        .border({
          width: 1,
          color: AppColors.vip,
          radius: AppDimensions.radiusLarge
        })
    }
    .width('100%')
    .padding(AppDimensions.paddingLarge)
    .backgroundColor(AppColors.vipBackground)
    .borderRadius(AppDimensions.radiusMedium)
  }

  // 订单管理
  @Builder
  OrderSection() {
    Column() {
      Column({ space: AppDimensions.spaceMedium }) {
        // 标题行
        Row() {
          Row({ space: AppDimensions.spaceSmall }) {
            Text('📋')
              .fontSize(18)

            Text('我的订单')
              .fontSize(AppTypography.fontSizeLarge)
              .fontWeight(AppTypography.fontWeightMedium)
              .fontColor(AppColors.textPrimary)
          }

          Blank()

          Row({ space: AppDimensions.spaceXSmall }) {
            Text('查看全部')
              .fontSize(AppTypography.fontSizeMedium)
              .fontColor(AppColors.textSecondary)

            Text('›')
              .fontSize(20)
              .fontColor(AppColors.textTertiary)
          }
        }
        .width('100%')

        // 订单状态图标
        Row() {
          this.OrderStatusItem('待付款', '💳', this.orderCount.pendingPayment)
          this.OrderStatusItem('待发货', '📦', this.orderCount.pendingShipment)
          this.OrderStatusItem('待收货', '🚚', this.orderCount.pendingReceive)
          this.OrderStatusItem('待评价', '💬', this.orderCount.pendingReview)
          this.OrderStatusItem('退款/售后', '↩️', this.orderCount.refunding + this.orderCount.refunded)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)
  }

  // 订单状态项
  @Builder
  OrderStatusItem(label: string, icon: string, count: number) {
    Column({ space: AppDimensions.spaceSmall }) {
      Stack({ alignContent: Alignment.TopEnd }) {
        Text(icon)
          .fontSize(24)

        if (count > 0) {
          Text(count > 99 ? '99+' : count.toString())
            .fontSize(10)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.error)
            .borderRadius(AppDimensions.radiusRound)
            .padding({ left: 4, right: 4, top: 1, bottom: 1 })
            .position({ x: 12, y: -6 })
        }
      }
      .width(24)
      .height(24)

      Text(label)
        .fontSize(AppTypography.fontSizeSmall)
        .fontColor(AppColors.textPrimary)
    }
  }

  // 我的足迹
  @Builder
  FootprintSection() {
    Column() {
      Column({ space: AppDimensions.spaceMedium }) {
        // 标题行
        Row() {
          Row({ space: AppDimensions.spaceSmall }) {
            Text('👣')
              .fontSize(18)

            Text('我的足迹')
              .fontSize(AppTypography.fontSizeLarge)
              .fontWeight(AppTypography.fontWeightMedium)
              .fontColor(AppColors.textPrimary)
          }

          Blank()

          Row({ space: AppDimensions.spaceXSmall }) {
            Text('查看全部')
              .fontSize(AppTypography.fontSizeMedium)
              .fontColor(AppColors.textSecondary)

            Text('›')
              .fontSize(20)
              .fontColor(AppColors.textTertiary)
          }
        }
        .width('100%')

        // 足迹列表
        List({ space: AppDimensions.spaceMedium }) {
          ForEach(this.footprints, (footprint: Footprint) => {
            ListItem() {
              Image(footprint.goodsMainPic)
                .width(100)
                .height(100)
                .borderRadius(AppDimensions.radiusSmall)
                .objectFit(ImageFit.Cover)
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .height(100)
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)
  }

  // 功能菜单
  @Builder
  FunctionMenu() {
    Column() {
      Column() {
        this.MenuItem('优惠券', '🎫', '#6A9BE6')
        Divider().color(AppColors.divider)
        this.MenuItem('收货地址', '📍', '#66BB6A')
        Divider().color(AppColors.divider)
        this.MenuItem('在线客服', '👨‍💼', '#F87C7B')
        Divider().color(AppColors.divider)
        this.MenuItem('意见反馈', '✏️', '#F3AF76')
        Divider().color(AppColors.divider)
        this.MenuItem('关于我们', 'ℹ️', '#9179F1', false)
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)

    Column() {
      this.MenuItem('设置', '⚙️', '#26A69A', false)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppDimensions.radiusMedium)
    .padding(AppDimensions.paddingLarge)
    .margin({ top: AppDimensions.spaceMedium })
  }

  // 菜单项
  @Builder
  MenuItem(title: string, icon: string, iconColor: string, showDivider: boolean = true) {
    Row({ space: AppDimensions.spaceMedium }) {
      Text(icon)
        .fontSize(20)

      Text(title)
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(AppColors.textPrimary)
        .layoutWeight(1)

      Text('›')
        .fontSize(20)
        .fontColor(AppColors.textTertiary)
    }
    .width('100%')
    .padding({
      top: AppDimensions.paddingLarge,
      bottom: AppDimensions.paddingLarge
    })
  }
}

