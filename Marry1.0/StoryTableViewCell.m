//
//  StoryTableViewCell.m
//  Marry1.0
//
//  Created by Ibokan on 14-10-8.
//  Copyright (c) 2014年 lj. All rights reserved.
//

#import "StoryTableViewCell.h"

@implementation StoryTableViewCell
@synthesize myImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, KScreenWidth-10, 180)];
        [self.contentView addSubview:myImageView];
        myImageView.layer.cornerRadius
        = 15;//(值越大，角就越圆)
        
        myImageView.layer.masksToBounds= YES;
        
       
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
