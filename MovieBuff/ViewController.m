//
//  ViewController.m
//  MovieBuff
//
//  Created by BICS-Mac Mini-1 on 30/08/17.
//  Copyright © 2017 BICS. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"


@interface ViewController ()
{
    NSArray *NowPlaying_title;
    NSArray *NowPlaying_img;
    NSArray *Popular_title;
    NSArray *Popular_img;
    NSArray *TopRated_title;
    NSArray *TopRated_img;
    
    NSString *topRatedUrl;
    NSString *popularUrl;
    NSString *nowPlayingUrl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"MOVIE BUFF";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
      topRatedUrl = @"https://api.themoviedb.org/3/movie/top_rated?region=en-US&page=1&language=en-US&api_key=dc4a9136b4a481e78080c353a938c90b";
      popularUrl = @"https://api.themoviedb.org/3/movie/popular?api_key=dc4a9136b4a481e78080c353a938c90b&language=en-US&page=1&region=US";
      nowPlayingUrl = @"https://api.themoviedb.org/3/movie/now_playing?api_key=dc4a9136b4a481e78080c353a938c90b&language=en-US&page=1&region=US";
    
    [self serviceHandler:nowPlayingUrl];
    [self serviceHandler:popularUrl];
    [self serviceHandler:topRatedUrl];
}


#pragma mark Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0)
    {
        [cell reloadCollectionView:NowPlaying_title forImg:NowPlaying_img];
    }
    
    else if (indexPath.section == 1)
    {
        [cell reloadCollectionView:Popular_title forImg:Popular_img];
    }
    
    else
    {
        [cell reloadCollectionView:TopRated_title forImg:TopRated_img];
    }
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Now Playing";
            break;
        case 1:
            sectionName = @"Popular";
            break;
        case 2:
            sectionName = @"Top Rated Movies";
            break;
        default:
            sectionName = @"";
            break;
    }
    
    return sectionName;
}




- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    }
    
    return 60;
}

#pragma mark webService
-(void)serviceHandler: (NSString *)Url
{
    NSData *postData = [[NSData alloc] initWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        
                                                        NSLog(@"%@", error);
                                                    }
                                                    else {
                                                        
                                                        NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:NSJSONReadingMutableContainers
                                                                                                                  error:&error];
                                                      
                                                        NSDictionary *result = [jsonObj objectForKey:@"results"];
                                                        
                                                        if ([Url isEqualToString:nowPlayingUrl]) {
                                                            
                                                            NowPlaying_title = [result valueForKey:@"title"];
                                                            NowPlaying_img = [result valueForKey: @"poster_path"];
                                                            
                                                           
                                                        }
                                                        else if ([Url isEqualToString:popularUrl])
                                                        {
                                                            Popular_title = [result valueForKey:@"title"];
                                                            Popular_img = [result valueForKey: @"poster_path"];
                                                            
                                                        
                                                        }
                                                        else
                                                        {
                                                            TopRated_title = [result valueForKey:@"title"];
                                                            TopRated_img = [result valueForKey: @"poster_path"];
                                                            
                                                        }
                                                        [self.table reloadData];
                                                    }
                                                }];
    [dataTask resume];
    
}

@end
