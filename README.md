# 有妖气仿写

闲来无事，App Store 里随便抓了一个爱派派进行一些仿写。 

> 首先声明：如有冒犯或侵权行为，请随时联系告知，我会立刻删除相关文件或资源。

本次仿写是通过 `charles` 进行接口抓包， 然后代码是 MVC 格式进行书写；为了练习一下布局方式， 该项目采用了三种第三方库进行布局,，分别是`Masonry` 、`SDAutoLayout`、`YogaKit` 。 

**各自的特点** ：

 - Masonry：适用于大部分情况下的布局，易操作。缺点是代码量稍微多。
 - SDAutoLayout：在自适应 cell 行高的情况下，具有优势。
 - YogaKit：前端的`flexbox`布局方式，在普通视图中，如果不想事先设置视图的高度或宽度，可以考虑用该布局方式，代码清晰明了，易于理解。缺点是代码繁琐。

示例代码：
Masonry：

```
[self.img_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
 }];
```

SDAutoLayout：

```
self.img_cover.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(296.0/504.0);
```

YogaKit：

```

    UIView *v_header2 = [UIView new];
    [v_header addSubview:v_header2];
    [v_header2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignCenter;
        layout.flexDirection = YGFlexDirectionRow;
        layout.marginHorizontal = YGPointValue(12);
        layout.position = YGPositionTypeAbsolute;
    }];
```

**该项目实现的功能点**：

 1. 选项卡的应用。
 2. tableView 多种cell 的应用。
 3. 广告页的应用。
 4. 皮肤切换的应用。
 5. 对网络请求的封装。
 6. 对普通 tableView 页面的封装。
 7. 对一些第三方库的应用。

**效果图如下**：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20181220143340823.gif)

[项目地址](https://github.com/ZJQian/YouYaoQi)



