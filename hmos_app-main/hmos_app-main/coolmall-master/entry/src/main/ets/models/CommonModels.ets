/**
 * 通用数据模型
 */

/**
 * 轮播图数据模型
 */
export interface Banner {
  id: number;
  pic: string;
  link?: string;
}

/**
 * 商品数据模型
 */
export interface Goods {
  id: number;
  name: string;
  mainPic: string;
  price: number;
  originalPrice?: number;
  sales?: number;
  tag?: string;
}

/**
 * 分类数据模型
 */
export interface Category {
  id: number;
  name: string;
  pic: string;
}

/**
 * 分类树数据模型
 */
export interface CategoryTree {
  id: number;
  name: string;
  children: CategoryChild[];
}

/**
 * 子分类数据模型
 */
export interface CategoryChild {
  id: number;
  name: string;
  pic: string;
}

/**
 * 优惠券数据模型
 */
export interface Coupon {
  id: number;
  title: string;
  amount: number;
  minAmount: number;
  validDays: number;
}

/**
 * 购物车数据模型
 */
export interface Cart {
  goodsId: number;
  goodsName: string;
  goodsMainPic: string;
  spec: CartSpec[];
}

/**
 * 购物车商品规格
 */
export interface CartSpec {
  id: number;
  specName: string;
  price: number;
  count: number;
  stock: number;
}

/**
 * 用户数据模型
 */
export interface User {
  id?: number;
  nickName: string;
  phone?: string;
  avatarUrl?: string;
}

/**
 * 订单统计数据模型
 */
export interface OrderCount {
  pendingPayment: number;
  pendingShipment: number;
  pendingReceive: number;
  pendingReview: number;
  refunding: number;
  refunded: number;
}

/**
 * 足迹数据模型
 */
export interface Footprint {
  id: number;
  goodsId: number;
  goodsMainPic: string;
  viewTime: string;
}

