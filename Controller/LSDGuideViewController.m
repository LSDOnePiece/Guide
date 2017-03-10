//
//  LSDGuideViewController.m
//  CloodForSafeHomeSecurity
//
//  Created by yosemite on 16/7/21.
//  Copyright © 2016年 刘帅. All rights reserved.
//

#import "LSDGuideViewController.h"
#import "UIView+Frame.h"
#import "LSDGuideCollectionViewCell.h"
#import "MyLoginViewController.h"

@interface LSDGuideViewController ()
@property (weak, nonatomic) UIImageView* imageViewLarge;
@property (weak, nonatomic) UIImageView* textImageViewLarge;
@property (weak, nonatomic) UIImageView* textImageViewSmall;

@property (assign, nonatomic) int page;

@end

@implementation LSDGuideViewController
static NSString* const reuseIdentifier = @"guide_cell";

- (instancetype)init
{
    
    // 创建流水布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置item大小
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 间距
    layout.minimumLineSpacing = 0;
    
    // 横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LSDGuideCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    // 不显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧
    self.collectionView.bounces = NO;
    // 分页
    self.collectionView.pagingEnabled = YES;
    
    // 获取图片
    UIImage* imageLarge = [UIImage imageNamed:@"guide1"];
    UIImage* textLarge = [UIImage imageNamed:@"guideLargeText1"];
    UIImage* textSmall = [UIImage imageNamed:@"guideSmallText1"];
    
    // 创建图片框
    UIImageView* imageViewLarge = [[UIImageView alloc] initWithImage:imageLarge];
    UIImageView* textImageViewLarge = [[UIImageView alloc] initWithImage:textLarge];
    UIImageView* textImageViewSmall = [[UIImageView alloc] initWithImage:textSmall];
    
    // 添加介绍图片
    [self.collectionView addSubview:imageViewLarge];
    [self.collectionView addSubview:textImageViewLarge];
    [self.collectionView addSubview:textImageViewSmall];
    
    // 修改位置
    textImageViewLarge.y = [UIScreen mainScreen].bounds.size.height * 0.75;
    textImageViewSmall.y = [UIScreen mainScreen].bounds.size.height * 0.85;
    
    // 添加波浪线
    UIImage* guideLine = [UIImage imageNamed:@"guideLine"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:guideLine];
    [self.collectionView addSubview:imageView];
    
    imageView.x = -203;
    
    // 给全局属性赋值
    self.imageViewLarge = imageViewLarge;
    self.textImageViewLarge = textImageViewLarge;
    self.textImageViewSmall = textImageViewSmall;
    
    // 添加立即体验的按钮
    UIButton* enterButton = [[UIButton alloc] init];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [enterButton sizeToFit];
    enterButton.x = 1 * ScreenWidth + (ScreenWidth - enterButton.w) * 0.5;
    enterButton.y =  ScreenHeight * 0.83;
    // 监听点击 - 进入tabbar
    [enterButton addTarget:self action:@selector(enterClcik) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView addSubview:enterButton];
}

// 进入主程序
- (void)enterClcik
{
    
     [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:KIsFirstLanuch];
    
    MyLoginViewController *loginVC = [[MyLoginViewController alloc]init];
    
    UINavigationController*navi=[[UINavigationController alloc]initWithRootViewController:loginVC];
    [UIApplication sharedApplication].keyWindow.backgroundColor=[UIColor whiteColor];
    [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:KChangeViewState];
    
}

// scrollView 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取页数
    int page = offsetX / [UIScreen mainScreen].bounds.size.width;
    
    // 对比记录的页数和当前的页数 用来判断方向
    if (page > self.page) {
        // 从右往左
        self.imageViewLarge.x = offsetX + [UIScreen mainScreen].bounds.size.width;
        self.textImageViewLarge.x = offsetX + [UIScreen mainScreen].bounds.size.width;
        self.textImageViewSmall.x = offsetX + [UIScreen mainScreen].bounds.size.width;
    }
    else {
        // 从左往右
        self.imageViewLarge.x = offsetX - [UIScreen mainScreen].bounds.size.width;
        self.textImageViewLarge.x = offsetX - [UIScreen mainScreen].bounds.size.width;
        self.textImageViewSmall.x = offsetX - [UIScreen mainScreen].bounds.size.width;
    }
    
    // 获取新图片
    UIImage* imageLarge = [UIImage imageNamed:[NSString stringWithFormat:@"guide%zd", page + 1]];
    UIImage* textLarge = [UIImage imageNamed:[NSString stringWithFormat:@"guideLargeText%zd", page + 1]];
    UIImage* textSmall = [UIImage imageNamed:[NSString stringWithFormat:@"guideSmallText%zd", page + 1]];
    
    // 更换图片
    self.imageViewLarge.image = imageLarge;
    self.textImageViewLarge.image = textLarge;
    self.textImageViewSmall.image = textSmall;
    
    // 加特技
    [UIView animateWithDuration:1
                     animations:^{
                         self.imageViewLarge.x = offsetX;
                         self.textImageViewLarge.x = offsetX;
                         self.textImageViewSmall.x = offsetX;
                     }];
    
    // 记录page
    self.page = page;
}

// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

// 某一组有多少行
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

// cell长啥样
- (LSDGuideCollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // 缓存池zhao
    LSDGuideCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 获取引导页的背景图
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%zdBackground", indexPath.row + 1]];
    
    // 把图片传到cell中
    cell.image = image;
    
    return cell;
}

- (UIColor*)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0); //0.0 to 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
