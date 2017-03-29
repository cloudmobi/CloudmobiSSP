

#import "CTView.h"
@implementation CTView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:191/255.0 blue:1 alpha:1];
        self.backgroundColor = [UIColor whiteColor];
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width / 1.9)];
        self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 16, 0, 16, 16)];//广告标识
        self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(7, frame.size.width / 1.9 - 23, 40, 40)];//icon
        self.iconImage.layer.cornerRadius = 6.5;
        [self.iconImage.layer setMasksToBounds:YES];
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(55, frame.size.width / 1.9 - 20, frame.size.width-200, 20)];//标题
        self.titleLable.font = [UIFont systemFontOfSize:14];
        self.titleLable.textColor = [UIColor whiteColor];
        self.button.frame = CGRectMake(frame.size.width-60, frame.size.width / 1.9 - 23, 60, 20);
        self.button.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.button.backgroundColor = [UIColor colorWithRed:254/255.0 green:99/255.0 blue:66/255.0 alpha:0.7];
        self.descLable = [[UILabel alloc]initWithFrame:CGRectMake(55, frame.size.width / 1.9 - 3 , frame.size.width - 55, 20)];
        self.descLable.textColor = [UIColor blackColor];
        self.descLable.font = [UIFont systemFontOfSize:14];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.imageImage];
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.width / 1.9 - 23, frame.size.width, 43)];
        back.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];;
        [self addSubview:back];
        [self addSubview:self.logoImage];
        [self addSubview:self.titleLable];
        [self addSubview:self.iconImage];
        [self addSubview:self.descLable];
        [self addSubview:self.button];
    }
    return self;
}

@end
