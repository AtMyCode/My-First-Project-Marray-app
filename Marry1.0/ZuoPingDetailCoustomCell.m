//
//  ZuoPingDetailCoustomCell.m
//  Marry1.0
//
//  Created by apple on 14-10-3.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "ZuoPingDetailCoustomCell.h"

@implementation ZuoPingDetailCoustomCell
@synthesize imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
