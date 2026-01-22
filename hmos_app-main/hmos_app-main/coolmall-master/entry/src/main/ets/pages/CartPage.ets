/**
 * 购物车页
 */
import { TopAppBar } from '../components/TopAppBar';
import { AppColors } from '../theme/AppColors';
import { AppDimensions } from '../theme/AppDimensions';
import { AppTypography } from '../theme/AppTypography';
import { mockCart } from '../data/MockData';
import { Cart, CartSpec } from '../models/CommonModels';

@Component
export struct CartPage {
  @State cartItems: Cart[] = mockCart;
  @State isEmpty: boolean = false;
  @State isEditing: boolean = false;
  @State selectedItems: Map<number, Set<number>> = new Map(); // goodsId -> Set<specId>
  @State isAllSelected: boolean = false;
  @State selectedCount: number = 0;
  @State totalAmount: number = 0;

  aboutToAppear() {
    this.isEmpty = this.cartItems.length === 0;
  }

  build() {
    Column() {
      // 顶部标题栏
      TopAppBar({
        title: '购物车',
        actions: () => {
          if (!this.isEmpty) {
            this.TopBarActions()
          }
        }
      })

      if (this.isEmpty) {
        // 空购物车
        this.EmptyCart()
      } else {
        // 有商品的购物车
        Column() {
          // 商品列表
          this.CartList()

          // 底部结算栏
          this.BottomBar()
        }
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  // 顶部栏操作按钮
  @Builder
  TopBarActions() {
    Text(this.isEditing ? '完成' : '编辑')
      .fontSize(AppTypography.fontSizeMedium)
      .fontColor(AppColors.textPrimary)
      .onClick(() => {
        this.isEditing = !this.isEditing;
      })
  }

  // 空购物车
  @Builder
  EmptyCart() {
    Column({ space: AppDimensions.spaceLarge }) {
      Text('🛒')
        .fontSize(80)
        .opacity(0.3)

      Text('购物车是空的')
        .fontSize(AppTypography.fontSizeLarge)
        .fontColor(AppColors.textSecondary)

      Text('快去添加商品吧')
        .fontSize(AppTypography.fontSizeMedium)
        .fontColor(AppColors.textTertiary)
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }

  // 购物车列表
  @Builder
  CartList() {
    List({ space: AppDimensions.spaceMedium }) {
      ForEach(this.cartItems, (cart: Cart) => {
        ListItem() {
          this.CartItem(cart)
        }
      })
    }
    .layoutWeight(1)
    .padding(AppDimensions.paddingMedium)
    .scrollBar(BarState.Off)
  }

  // 购物车商品项
  @Builder
  CartItem(cart: Cart) {
    Column({ space: AppDimensions.spaceSmall }) {
      ForEach(cart.spec, (spec: CartSpec) => {
        Row({ space: AppDimensions.spaceMedium }) {
          // 选择框
          Checkbox()
            .select(this.isSpecSelected(cart.goodsId, spec.id))
            .onChange((value: boolean) => {
              this.toggleSpecSelection(cart.goodsId, spec.id);
            })

          // 商品图片
          Image(cart.goodsMainPic)
            .width(80)
            .height(80)
            .borderRadius(AppDimensions.radiusSmall)
            .objectFit(ImageFit.Cover)

          // 商品信息
          Column({ space: AppDimensions.spaceSmall }) {
            Text(cart.goodsName)
              .fontSize(AppTypography.fontSizeMedium)
              .fontColor(AppColors.textPrimary)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(spec.specName)
              .fontSize(AppTypography.fontSizeSmall)
              .fontColor(AppColors.textSecondary)
              .padding(AppDimensions.paddingXSmall)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppDimensions.radiusSmall)

            Row() {
              Text(`¥${(spec.price / 100).toFixed(2)}`)
                .fontSize(AppTypography.fontSizeLarge)
                .fontColor(AppColors.price)
                .fontWeight(AppTypography.fontWeightBold)

              Blank()

              // 数量控制器
              Row({ space: AppDimensions.spaceSmall }) {
                Text('−')
                  .fontSize(20)
                  .fontColor(spec.count > 1 ? AppColors.textPrimary : AppColors.textTertiary)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .border({ width: 1, color: AppColors.border, radius: 4 })
                  .onClick(() => {
                    if (spec.count > 1) {
                      spec.count--;
                      this.calculateTotal();
                    }
                  })

                Text(spec.count.toString())
                  .fontSize(AppTypography.fontSizeMedium)
                  .fontColor(AppColors.textPrimary)
                  .width(30)
                  .textAlign(TextAlign.Center)

                Text('+')
                  .fontSize(20)
                  .fontColor(spec.count < spec.stock ? AppColors.textPrimary : AppColors.textTertiary)
                  .width(24)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .border({ width: 1, color: AppColors.border, radius: 4 })
                  .onClick(() => {
                    if (spec.count < spec.stock) {
                      spec.count++;
                      this.calculateTotal();
                    }
                  })
              }
            }
            .width('100%')
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppDimensions.radiusMedium)
        .padding(AppDimensions.paddingMedium)
      })
    }
  }

  // 底部结算栏
  @Builder
  BottomBar() {
    Row() {
      // 全选
      Row({ space: AppDimensions.spaceSmall }) {
        Checkbox()
          .select(this.isAllSelected)
          .onChange((value: boolean) => {
            this.toggleSelectAll();
          })

        Text('全选')
          .fontSize(AppTypography.fontSizeMedium)
          .fontColor(AppColors.textPrimary)
      }

      Blank()

      if (!this.isEditing) {
        // 结算模式
        Row({ space: AppDimensions.spaceSmall }) {
          Text('合计:')
            .fontSize(AppTypography.fontSizeMedium)
            .fontColor(AppColors.textPrimary)

          Text(`¥${(this.totalAmount / 100).toFixed(2)}`)
            .fontSize(AppTypography.fontSizeXLarge)
            .fontColor(AppColors.price)
            .fontWeight(AppTypography.fontWeightBold)

          Button(this.selectedCount > 0 ? `结算(${this.selectedCount})` : '结算')
            .fontSize(AppTypography.fontSizeMedium)
            .backgroundColor(this.selectedCount > 0 ? AppColors.primary : AppColors.textTertiary)
            .fontColor(AppColors.onPrimary)
            .borderRadius(AppDimensions.radiusLarge)
            .padding({
              left: AppDimensions.paddingLarge,
              right: AppDimensions.paddingLarge
            })
            .enabled(this.selectedCount > 0)
        }
      } else {
        // 编辑模式
        Button(this.selectedCount > 0 ? `删除(${this.selectedCount})` : '删除')
          .fontSize(AppTypography.fontSizeMedium)
          .backgroundColor(this.selectedCount > 0 ? AppColors.error : AppColors.textTertiary)
          .fontColor(AppColors.onPrimary)
          .borderRadius(AppDimensions.radiusLarge)
          .padding({
            left: AppDimensions.paddingLarge,
            right: AppDimensions.paddingLarge
          })
          .enabled(this.selectedCount > 0)
          .onClick(() => {
            this.deleteSelected();
          })
      }
    }
    .width('100%')
    .height(60)
    .backgroundColor(AppColors.surface)
    .padding({
      left: AppDimensions.paddingLarge,
      right: AppDimensions.paddingLarge
    })
    .border({
      width: { top: 1 },
      color: AppColors.border
    })
  }

  // 判断规格是否选中
  isSpecSelected(goodsId: number, specId: number): boolean {
    const specs = this.selectedItems.get(goodsId);
    return specs ? specs.has(specId) : false;
  }

  // 切换规格选中状态
  toggleSpecSelection(goodsId: number, specId: number) {
    if (!this.selectedItems.has(goodsId)) {
      this.selectedItems.set(goodsId, new Set());
    }
    const specs = this.selectedItems.get(goodsId)!;
    if (specs.has(specId)) {
      specs.delete(specId);
    } else {
      specs.add(specId);
    }
    this.calculateTotal();
    this.checkAllSelected();
  }

  // 切换全选
  toggleSelectAll() {
    this.isAllSelected = !this.isAllSelected;
    if (this.isAllSelected) {
      // 全选
      this.cartItems.forEach(cart => {
        const specs = new Set<number>();
        cart.spec.forEach(spec => specs.add(spec.id));
        this.selectedItems.set(cart.goodsId, specs);
      });
    } else {
      // 取消全选
      this.selectedItems.clear();
    }
    this.calculateTotal();
  }

  // 检查是否全选
  checkAllSelected() {
    let totalSpecs = 0;
    let selectedSpecs = 0;
    this.cartItems.forEach(cart => {
      totalSpecs += cart.spec.length;
      const specs = this.selectedItems.get(cart.goodsId);
      if (specs) {
        selectedSpecs += specs.size;
      }
    });
    this.isAllSelected = totalSpecs > 0 && totalSpecs === selectedSpecs;
  }

  // 计算总价和数量
  calculateTotal() {
    let count = 0;
    let amount = 0;
    this.selectedItems.forEach((specs, goodsId) => {
      const cart = this.cartItems.find(c => c.goodsId === goodsId);
      if (cart) {
        cart.spec.forEach(spec => {
          if (specs.has(spec.id)) {
            count += spec.count;
            amount += spec.price * spec.count;
          }
        });
      }
    });
    this.selectedCount = count;
    this.totalAmount = amount;
  }

  // 删除选中项
  deleteSelected() {
    this.cartItems = this.cartItems.filter(cart => {
      const specs = this.selectedItems.get(cart.goodsId);
      if (!specs) return true;
      cart.spec = cart.spec.filter(spec => !specs.has(spec.id));
      return cart.spec.length > 0;
    });
    this.selectedItems.clear();
    this.isEmpty = this.cartItems.length === 0;
    this.isEditing = false;
    this.calculateTotal();
  }
}

