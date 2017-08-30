//
//  TableViewCell.h
//  MovieBuff
//
//  Created by BICS-Mac Mini-1 on 30/08/17.
//  Copyright © 2017 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(strong, nonatomic) NSArray *NP_title;
@property(strong, nonatomic) NSArray *Np_img;

- (void)reloadCollectionView:(NSArray *)titleArr forImg:(NSArray *)imgArr;
@end
