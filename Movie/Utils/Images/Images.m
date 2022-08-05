//
//  Images.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "Images.h"

@implementation Images

+ (UIImage *)getHeartImage{
    NSString *url =  @"heart";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getGridMenuImage{
    NSString *url =  @"gridMenu";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getListMenuImage{
    NSString *url =  @"listMenu";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getMenuHamburgerImage{
    NSString *url =  @"menuHamburger";
    UIImage *image = [UIImage imageNamed:url];
    return image;
    
}

+ (UIImage *)getStarImage{
    NSString *url =  @"star";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getAboutImage{
    NSString *url =  @"infor";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getSettingImage{
    NSString *url =  @"setting";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getHomeImage{
    NSString *url =  @"home";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getPlaceholderImage{
    NSString *url =  @"placeholder";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getFilledStar{
    NSString *url =  @"star_filled";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}
@end
