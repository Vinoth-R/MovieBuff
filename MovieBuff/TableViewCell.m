//
//  TableViewCell.m
//  MovieBuff
//
//  Created by BICS-Mac Mini-1 on 30/08/17.
//  Copyright © 2017 BICS. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return self.NP_title.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [self imgLoader:self.NP_title ImageArray:self.Np_img Index:indexPath Cell:cell];

    return cell;
}

- (void)reloadCollectionView:(NSArray *)titleArr forImg:(NSArray *)imgArr
{
    self.NP_title = titleArr;
    self.Np_img = imgArr;
    [self.collection reloadData];
}

-(void)imgLoader: (NSArray *)titleArray ImageArray:(NSArray *)imgArray Index: (NSIndexPath *)indexPath Cell: (UICollectionViewCell *)cell
{
   
    UIImageView *ImageView = (UIImageView *)[cell viewWithTag:100];
    ImageView.layer.masksToBounds = YES;
    ImageView.layer.cornerRadius = 10;
    if ([[imgArray objectAtIndex:indexPath.row] isEqual:[NSNull null]])
    {
        ImageView.image = [UIImage imageNamed:@"default.jpg"];
    }
    
    else
    {
        NSString *imgUrlStr = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",[imgArray objectAtIndex:indexPath.row]];
        NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:imgUrlStr];
        UIImage* image = [UIImage imageWithData:imageData];
        if (image == nil && imgUrlStr.length != 0)
        {
            NSURL *url = [NSURL URLWithString:imgUrlStr];
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:url]])];
            ImageView.image = [UIImage imageWithData:imageData];
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:imgUrlStr];
        }
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    label.text = [titleArray objectAtIndex:indexPath.row];
}

@end
