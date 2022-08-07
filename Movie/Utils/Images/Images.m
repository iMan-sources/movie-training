//
//  Images.m
//  Movie
//
//  Created by AnhVT12.REC on 7/27/22.
//

#import "Images.h"

@implementation Images

+ (UIImage *)getHeartImage{
//    NSString *url =  @"heart";
//    UIImage *image = [UIImage imageNamed:url];
    UIImage *image = [UIImage systemImageNamed:@"heart.fill"];

    return image;
}

+ (UIImage *)getGridMenuImage{
//    NSString *url =  @"gridMenu";
//    UIImage *image = [UIImage imageNamed:url];
    UIImage *image = [UIImage systemImageNamed:@"square.grid.2x2.fill"];
    return image;
}

+ (UIImage *)getListMenuImage{
//    NSString *url =  @"listMenu";
//    UIImage *image = [UIImage imageNamed:url];
    
    UIImage *image = [UIImage systemImageNamed:@"list.bullet"];
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
//    NSString *url =  @"infor";
//    UIImage *image = [UIImage imageNamed:url];
    UIImage *image = [UIImage systemImageNamed:@"info.circle.fill"];
    return image;
}

+ (UIImage *)getSettingImage{
//    NSString *url =  @"setting";
//    UIImage *image = [UIImage imageNamed:url];
    UIImage *image = [UIImage systemImageNamed:@"gearshape.fill"];
    return image;
}

+ (UIImage *)getHomeImage{
//    NSString *url =  @"home";
//    UIImage *image = [UIImage imageNamed:url];
    UIImage *image = [UIImage systemImageNamed:@"house.fill"];
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

+ (UIImage *)getFilledBlackRound{
    NSString *url =  @"filledRound";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+(UIImage *)getFilledWhiteRound{
    NSString *url =  @"filledWhiteRound";
    UIImage *image = [UIImage imageNamed:url];
    return image;
}

+ (UIImage *)getCalendarImage{
    UIImage *image = [UIImage systemImageNamed:@"calendar"];
    return image;
}

+(UIImage *)getEmailImage{
    UIImage *image = [UIImage systemImageNamed:@"envelope.fill"];
    return image;
}

+(UIImage *) getPersonImage{
    UIImage *image = [UIImage systemImageNamed:@"person.fill"];
    return image;
}
@end
