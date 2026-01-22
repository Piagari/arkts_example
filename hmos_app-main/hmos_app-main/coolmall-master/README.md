## 一，安卓项目介绍
这是一个基于 Kotlin 和 Jetpack Compose 打造的开源电商学习项目，核心功能已基本完成。项目采用了 Google 推荐的应用架构和最佳实践，参考了 Now in Android 的架构设计，旨在展示如何运用现代 Android 开发技术构建一个完整的电商应用。项目具备完整的电商业务流程，包括用户认证、商品展示、购物车、订单支付等核心功能，适合开发者学习参考现代 Android 开发技术。
github地址：https://github.com/Joker-x-dev/CoolMallKotlin?tab=readme-ov-file
### 代码结构
安卓
```
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
JSON                            26              0              0         101441
Kotlin                         464           4620          17607          35661
Markdown                        16            790              3           2983
XML                            114            177            190           2954
Gradle                          26             75            151            446
Bourne Shell                     1             23             36            126
YAML                             1              0              1            121
TOML                             1             52            111            100
DOS Batch                        1             21              2             66
Properties                       3              2             28             10
ProGuard                         1              6             21              7
JSON5                            3              0              0              3
SVG                              1              0              0              1
-------------------------------------------------------------------------------
SUM:                           658           5766          18150         143919
-------------------------------------------------------------------------------
```
## 二，cursor迁移prompt
当前是一个购物类的安卓应用，我需要将其迁移到鸿蒙版本，请输出一个迁移文档，写明迁移计划，然后按照这个迁移文档进行迁移，鸿蒙工程我已经初始化成hello world工程，地址为：C:\Users\huawei\Desktop\dev\androidtoarkts\qingshangcheng\CoolMallArkts，首页UI样式，分类页面UI样式，购物车UI样式，我的页面UI样式遵循上传图片，约束：1，功能保持一致，2，UI布局保持一致
## 三，页面视图
### 首页对比
![Home页v1.png](https://raw.gitcode.com/user-images/assets/7370334/f71484dc-e99d-4fa9-b535-38e48f755f49/Home页v1.png 'Home页v1.png')                ![hm-首页v1.png](https://raw.gitcode.com/user-images/assets/7370334/ce3bc841-9ad1-458e-8086-b4f10d89b53e/hm-首页v1.png 'hm-首页v1.png')

### 分类页面对比
![分类页v1.png](https://raw.gitcode.com/user-images/assets/7370334/d78ba128-01b1-44f4-82b6-5590bd5f5e6e/分类页v1.png '分类页v1.png')![hm-分类页v1.png](https://raw.gitcode.com/user-images/assets/7370334/b58051a7-99ae-43f9-8afa-a9c08433b745/hm-分类页v1.png 'hm-分类页v1.png')

### 购物车比对
![购物车页面v1.png](https://raw.gitcode.com/user-images/assets/7370334/2e2ee4ea-22b4-4f21-aba0-14247d2b727b/购物车页面v1.png '购物车页面v1.png')![hm-购物车页v1.png](https://raw.gitcode.com/user-images/assets/7370334/7191d2ec-a7e4-451d-97dc-fa1aad585aae/hm-购物车页v1.png 'hm-购物车页v1.png')

### 我的页面比对
![我的页面v1.png](https://raw.gitcode.com/user-images/assets/7370334/b7a04b8b-afa3-4f43-9739-c987140626c7/我的页面v1.png '我的页面v1.png')![hm-我的v1.png](https://raw.gitcode.com/user-images/assets/7370334/ec3241f1-7331-419d-807c-53e077975ada/hm-我的v1.png 'hm-我的v1.png')

### 四，迁移功能总结
![cursor执行任务流程.jpg](https://raw.gitcode.com/user-images/assets/7370334/bce2e041-0f09-490c-961e-45e1e43167ba/cursor执行任务流程.jpg 'cursor执行任务流程.jpg')

创建框架 -> 创建组件库 -> 创建UI -> 生成逻辑 -> 编译验证
缺点：目前只遵从一级页面一致性，二级页面没有生成
原因：迁移文档提到二级页面功能优先级低，本次不实现（<span style="color:#e60000;">对于不实现或者mock的地方是否需要加粗显示，提醒开发者注意</span>）

![cursor迁移文档缺陷.jpg](https://raw.gitcode.com/user-images/assets/7370334/21085bde-a18c-4053-b93d-f34845eefe74/cursor迁移文档缺陷.jpg 'cursor迁移文档缺陷.jpg')
## 五，附件
迁移文档：<a href="https://gitcode.com/user-attachments/files/7538062/4d4d7903565245af91647c8aad1d0ca9.md" target="_blank">4d4d7903565245af91647c8aad1d0ca9.md</a>

迁移完成总结文档：<a href="https://gitcode.com/user-attachments/files/7538062/a0151f33434c4a47af3206207f352836.md" target="_blank">a0151f33434c4a47af3206207f352836.md</a>

安卓视频：