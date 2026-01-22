/**
 * 模拟数据
 */
import { Banner, Goods, Category, CategoryTree, Coupon, Cart, User, OrderCount, Footprint } from '../models/CommonModels';

/**
 * 轮播图数据
 */
export const mockBanners: Banner[] = [
  {
    id: 1,
    pic: 'https://picsum.photos/800/400?random=1',
  },
  {
    id: 2,
    pic: 'https://picsum.photos/800/400?random=2',
  },
  {
    id: 3,
    pic: 'https://picsum.photos/800/400?random=3',
  }
];

/**
 * 分类数据
 */
export const mockCategories: Category[] = [
  { id: 1, name: '手机', pic: 'https://picsum.photos/100/100?random=11' },
  { id: 2, name: '服装', pic: 'https://picsum.photos/100/100?random=12' },
  { id: 3, name: '电脑', pic: 'https://picsum.photos/100/100?random=13' },
  { id: 4, name: '优惠', pic: 'https://picsum.photos/100/100?random=14' },
  { id: 5, name: '家电', pic: 'https://picsum.photos/100/100?random=15' },
  { id: 6, name: '户外', pic: 'https://picsum.photos/100/100?random=16' },
  { id: 7, name: '潮鞋', pic: 'https://picsum.photos/100/100?random=17' },
  { id: 8, name: '会员', pic: 'https://picsum.photos/100/100?random=18' },
  { id: 9, name: '包包', pic: 'https://picsum.photos/100/100?random=19' },
  { id: 10, name: '网络', pic: 'https://picsum.photos/100/100?random=20' }
];

/**
 * 分类树数据
 */
export const mockCategoryTrees: CategoryTree[] = [
  {
    id: 1,
    name: '手机',
    children: [
      { id: 101, name: '红米 K 系列', pic: 'https://picsum.photos/120/120?random=101' },
      { id: 102, name: '小米数字旗舰', pic: 'https://picsum.photos/120/120?random=102' },
      { id: 103, name: '红米数字系列', pic: 'https://picsum.photos/120/120?random=103' },
      { id: 104, name: 'iPhone', pic: 'https://picsum.photos/120/120?random=104' },
      { id: 105, name: 'OPPO', pic: 'https://picsum.photos/120/120?random=105' },
      { id: 106, name: 'vivo', pic: 'https://picsum.photos/120/120?random=106' }
    ]
  },
  {
    id: 2,
    name: '电脑',
    children: [
      { id: 201, name: '键盘', pic: 'https://picsum.photos/120/120?random=201' },
      { id: 202, name: 'Redmi 轻薄本', pic: 'https://picsum.photos/120/120?random=202' },
      { id: 203, name: '设计创作', pic: 'https://picsum.photos/120/120?random=203' },
      { id: 204, name: '商务办公', pic: 'https://picsum.photos/120/120?random=204' },
      { id: 205, name: '显示器', pic: 'https://picsum.photos/120/120?random=205' },
      { id: 206, name: '25 年新品', pic: 'https://picsum.photos/120/120?random=206' }
    ]
  },
  {
    id: 3,
    name: '服装',
    children: [
      { id: 301, name: '帽子', pic: 'https://picsum.photos/120/120?random=301' },
      { id: 302, name: 'T 恤', pic: 'https://picsum.photos/120/120?random=302' },
      { id: 303, name: '卫衣', pic: 'https://picsum.photos/120/120?random=303' },
      { id: 304, name: '外套', pic: 'https://picsum.photos/120/120?random=304' },
      { id: 305, name: '裤子', pic: 'https://picsum.photos/120/120?random=305' },
      { id: 306, name: '鞋子', pic: 'https://picsum.photos/120/120?random=306' }
    ]
  },
  {
    id: 4,
    name: '家电',
    children: [
      { id: 401, name: '电视', pic: 'https://picsum.photos/120/120?random=401' },
      { id: 402, name: '冰箱', pic: 'https://picsum.photos/120/120?random=402' },
      { id: 403, name: '洗衣机', pic: 'https://picsum.photos/120/120?random=403' },
      { id: 404, name: '空调', pic: 'https://picsum.photos/120/120?random=404' },
      { id: 405, name: '净水器', pic: 'https://picsum.photos/120/120?random=405' },
      { id: 406, name: '热水器', pic: 'https://picsum.photos/120/120?random=406' }
    ]
  },
  {
    id: 5,
    name: '户外',
    children: [
      { id: 501, name: '帐篷', pic: 'https://picsum.photos/120/120?random=501' },
      { id: 502, name: '睡袋', pic: 'https://picsum.photos/120/120?random=502' },
      { id: 503, name: '登山杖', pic: 'https://picsum.photos/120/120?random=503' },
      { id: 504, name: '背包', pic: 'https://picsum.photos/120/120?random=504' },
      { id: 505, name: '冲锋衣', pic: 'https://picsum.photos/120/120?random=505' },
      { id: 506, name: '登山鞋', pic: 'https://picsum.photos/120/120?random=506' }
    ]
  }
];

/**
 * 优惠券数据
 */
export const mockCoupons: Coupon[] = [
  { id: 1, title: '【满减券】全场满 100 减 99 元优惠券', amount: 99, minAmount: 100, validDays: 7 },
  { id: 2, title: '【新人券】新用户专享 50 元优惠券', amount: 50, minAmount: 200, validDays: 30 },
  { id: 3, title: '【品类券】数码产品满 500 减 100', amount: 100, minAmount: 500, validDays: 15 }
];

/**
 * 商品数据
 */
export const mockGoods: Goods[] = [
  { id: 1, name: 'Redmi 14C', mainPic: 'https://picsum.photos/300/300?random=1001', price: 49900, originalPrice: 59900, sales: 1523, tag: '新品' },
  { id: 2, name: 'Xiaomi 15 Ultra', mainPic: 'https://picsum.photos/300/300?random=1002', price: 649900, originalPrice: 699900, sales: 856 },
  { id: 3, name: 'Redmi K80', mainPic: 'https://picsum.photos/300/300?random=1003', price: 249900, sales: 2341, tag: '热卖' },
  { id: 4, name: 'Redmi Note 14', mainPic: 'https://picsum.photos/300/300?random=1004', price: 159900, originalPrice: 179900, sales: 4567 },
  { id: 5, name: 'Xiaomi 15 Pro', mainPic: 'https://picsum.photos/300/300?random=1005', price: 549900, sales: 1234, tag: '旗舰' },
  { id: 6, name: 'Redmi K70 Pro', mainPic: 'https://picsum.photos/300/300?random=1006', price: 329900, originalPrice: 349900, sales: 3456 },
  { id: 7, name: 'Xiaomi Pad 7', mainPic: 'https://picsum.photos/300/300?random=1007', price: 199900, sales: 987 },
  { id: 8, name: 'Redmi Buds 6', mainPic: 'https://picsum.photos/300/300?random=1008', price: 29900, originalPrice: 39900, sales: 5678, tag: '爆款' },
  { id: 9, name: 'Xiaomi Watch S4', mainPic: 'https://picsum.photos/300/300?random=1009', price: 149900, sales: 765 },
  { id: 10, name: 'Redmi Router AX3000', mainPic: 'https://picsum.photos/300/300?random=1010', price: 19900, sales: 8765 }
];

/**
 * 购物车数据
 */
export const mockCart: Cart[] = [
  {
    goodsId: 1,
    goodsName: 'Redmi 14C',
    goodsMainPic: 'https://picsum.photos/300/300?random=1001',
    spec: [
      { id: 1, specName: '星河蓝 8GB+256GB', price: 49900, count: 1, stock: 100 },
      { id: 2, specName: '曜石黑 12GB+512GB', price: 59900, count: 2, stock: 50 }
    ]
  },
  {
    goodsId: 2,
    goodsName: 'Xiaomi 15 Ultra',
    goodsMainPic: 'https://picsum.photos/300/300?random=1002',
    spec: [
      { id: 3, specName: '钛金灰 16GB+1TB', price: 649900, count: 1, stock: 30 }
    ]
  }
];

/**
 * 用户数据
 */
export const mockUser: User = {
  id: 1,
  nickName: '未登录用户',
  phone: '',
  avatarUrl: ''
};

/**
 * 订单统计数据
 */
export const mockOrderCount: OrderCount = {
  pendingPayment: 2,
  pendingShipment: 1,
  pendingReceive: 3,
  pendingReview: 5,
  refunding: 0,
  refunded: 1
};

/**
 * 足迹数据
 */
export const mockFootprints: Footprint[] = [
  { id: 1, goodsId: 1, goodsMainPic: 'https://picsum.photos/100/100?random=2001', viewTime: '2025-11-03 10:30' },
  { id: 2, goodsId: 2, goodsMainPic: 'https://picsum.photos/100/100?random=2002', viewTime: '2025-11-03 09:15' },
  { id: 3, goodsId: 3, goodsMainPic: 'https://picsum.photos/100/100?random=2003', viewTime: '2025-11-02 16:45' },
  { id: 4, goodsId: 4, goodsMainPic: 'https://picsum.photos/100/100?random=2004', viewTime: '2025-11-02 14:20' },
  { id: 5, goodsId: 5, goodsMainPic: 'https://picsum.photos/100/100?random=2005', viewTime: '2025-11-01 11:00' }
];

