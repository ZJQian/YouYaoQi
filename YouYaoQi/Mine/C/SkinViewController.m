//
//  SkinViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SkinViewController.h"
#import "SkinModel.h"
#import "SkinTableViewCell.h"
#import <ZipArchive/ZipArchive.h>

@interface SkinViewController ()<UINavigationControllerDelegate,SkinTableViewCellDelegate>

@end

@implementation SkinViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.isCustomNav = YES;
    self.navView.lb_left.text = @"我的";
    self.navView.lb_navTitle.text = @"个性皮肤";
    self.cTableView.frame = CGRectMake(0, self.navView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navView.bottom);
    self.cTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.y_rowheight = SCREEN_WIDTH*0.4;
    self.cTableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.08];
    [self.view addSubview:self.cTableView];
    
    __weak typeof(self) weakSelf = self;
    self.cellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id  _Nonnull cell) {
        SkinModel *m = weakSelf.dataArray[indexPath.row];
        SkinTableViewCell *c = cell;
        c.delegate = weakSelf;
        c.model = m;
    };
    self.didSelectCellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        
    };
    [self headerRefresh:YES];
    [self beginHeaderRefresh];
}

- (void)downLoadSkin:(SkinModel *)model {
    NSString *zipUrl     = model.address;
    NSURL    *url        = [NSURL URLWithString:zipUrl];
    NSString *md5        = [zipUrl md5String];//将下载链接转为md5 后面当做文件夹的名字
    NSArray  *pathes     = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path       = [pathes objectAtIndex:0];//大文件放在沙盒下的Library/Caches
    NSString *finishPath = [NSString stringWithFormat:@"%@/zipDownload/%@",path,md5];//保存解压后文件的文件夹的路径
    NSString *zipPath    = [NSString stringWithFormat:@"%@/%@.zip",path,md5];//下载的zip包存放路径
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:finishPath];
    if (!isExist) {//本地不存在文件 下载
        
        
        dispatch_queue_t queue0 =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_async(queue0, ^{
            NSError *error = nil;
            NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
            if(!error) {
                [data writeToFile:zipPath options:0 error:nil];
                //解压zip文件
                ZipArchive *zip= [[ZipArchive alloc]init];
                
                if([zip UnzipOpenFile:zipPath]){//将解压缩的内容写到缓存目录中
                    BOOL ret = [zip UnzipFileTo:finishPath overWrite:YES];
                    if(!ret)
                    {
                        [zip UnzipCloseFile];
                    }
                    //解压完成 删除压缩包
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    [fileManager removeItemAtPath:zipPath error:nil];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self changeSkin:model finishPath:finishPath addPath:[NSString stringWithFormat:@"/zipDownload/%@/%@",md5,model.name]];
                });
                
                
            }
        });
        
        
    }else{
        [self changeSkin:model finishPath:finishPath addPath:[NSString stringWithFormat:@"/zipDownload/%@/%@",md5,model.name]];
    }
}


- (void)changeSkin:(SkinModel *)model finishPath:(NSString *)finishPath addPath:(NSString *)addPath {
    
    NSString *dicName = model.name;
    NSString *thepath = [[finishPath stringByAppendingPathComponent:dicName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",model.packageName]];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:thepath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    DLog(@"%@",dic);
    
    NSString *path = [finishPath stringByAppendingPathComponent:dicName];
    /// 保存皮肤
    [DefaultsUtil saveSkin:@{@"packageDic":dic,@"addPath": addPath}];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeSkin object:@{@"packageDic":dic,@"path":path}];
}


- (void)loadNewData {
    
    
    [CNetWorking getWithUrl:skinList params:@{@"skin_UI_version": @"400002"} success:^(id  _Nonnull response) {
        SkinModel *model = [SkinModel mj_objectWithKeyValues:@{@"skinName":@"官方默认",@"skinType": @1,@"cover":@"theme_default_184x184_"}];
        NSMutableArray *array = [SkinModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"skinList"]];
        [array insertObject:model atIndex:0];
        self.dataArray = array;
        [self endRefresh];
    } failed:^(id  _Nonnull error) {
        [self endRefresh];
    }];
}


#pragma mark - delegate

- (void)clickWithCell:(SkinTableViewCell *)skinCell {
    
    NSIndexPath *indexPath = [self.cTableView indexPathForCell:skinCell];
    SkinModel *m = self.dataArray[indexPath.row];
    if (indexPath.row != 0) {
        [self downLoadSkin:m];
    }else{
        [DefaultsUtil removeSkin];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeSkin object:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[SkinViewController class]];
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
}


@end
