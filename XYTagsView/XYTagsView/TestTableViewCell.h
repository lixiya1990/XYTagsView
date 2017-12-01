//
//  TestTableViewCell.h
//  XYTagsView
//
//  Created by lxy on 2017/11/30.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTagsView.h"

@interface TestTableViewCell : UITableViewCell

@property (nonatomic ,strong) XTagsView *v_1;
@property (nonatomic ,strong) NSMutableArray *dataList;

+ (CGFloat)heightWithTags:(NSMutableArray *)tags;
@end
