//
//  ViewController.m
//  json解析复杂
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "WJVideo.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


/*TableView的数据源*/
@property(nonatomic, strong) NSArray *videos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [WJVideo setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id"
                 };
    }];
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=JSON"];
    
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    //3.发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //4.解析数据
        NSDictionary *dictM = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [dictM writeToFile:@"/Users/apple/Desktop/video.plist" atomically:YES];

        NSArray *arrayM = dictM[@"videos"];
        
        
        //字典转模型
//        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:arrayM.count];
//        
//        for (NSDictionary *dict in arrayM) {
//            [arr addObject:[WJVideo videoWithDict:dict]];
//            
//        }
        
        self.videos = [WJVideo mj_objectArrayWithKeyValuesArray:arrayM];
        //字典数组
//        self.videos = arr;
        NSLog(@"----%@",self.videos);
        
        
        
        //刷新tableview
        [self.tableView reloadData];
    }];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    
    //创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID]
    ;
    //拿到该行cell对应的数据
//    NSDictionary *videoDict = self.videos[indexPath.row];
    
    WJVideo *video = self.videos[indexPath.row];
    

    //设置cell的数据
//    cell.textLabel.text = videoDict[@"name"];
//    NSString *detailStr = [NSString stringWithFormat:@"%@",videoDict[@"length"]];
//    cell.detailTextLabel.text = detailStr;
//    
//    NSString *baseUrl = @"http://120.25.226.186:32812/";
//    NSURL *imageUrl = [NSURL URLWithString:[baseUrl stringByAppendingPathComponent:videoDict[@"image"]]];
    
    
    cell.textLabel.text = video.name;
    
    NSString *detailStr = [NSString stringWithFormat:@"%zd",video.length];
    cell.detailTextLabel.text = detailStr;
    
    NSString *baseUrl = @"http://120.25.226.186:32812/";
    NSURL *imageUrl = [NSURL URLWithString:[baseUrl stringByAppendingPathComponent:video.image]];
    
    
    
    [cell.imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"abc"]];
    
    NSLog(@"ID---%@",video.ID);
    
    //返回cell
    return cell;
    
}


#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.拿到数据
//    NSDictionary *videoDict = self.videos[indexPath.row];
    
    WJVideo *video = self.videos[indexPath.row];
    NSString *baseUrl = @"http://120.25.226.186:32812/";
    NSURL *mpUrl = [NSURL URLWithString:[baseUrl stringByAppendingPathComponent:video.url]];

    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:mpUrl];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


@end
