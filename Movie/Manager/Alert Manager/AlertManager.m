//
//  AlertManager.m
//  Movie
//
//  Created by AnhVT12.REC on 8/2/22.
//

#import "AlertManager.h"

@implementation AlertManager

- (void)showRemoveMovieAlertWithName:(NSString *)name inVC:(UIViewController *)vc withYesSelection:(void (^)(void))yesCompletion withNoSelection:(void (^)(void))noCompletion{
    NSString *message = [NSString stringWithFormat:@"Are you sure you want to remove %@ from Favorites", name];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        noCompletion();
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        yesCompletion();
    }];
    
    [alertController addAction:noAction];
    [alertController addAction:yesAction];
    
    [vc presentViewController:alertController animated:true completion:nil];
}

- (void)showErrorMessageWithDescription:(NSString *) msg inVC:(UIViewController *)vc withSelection:(void (^)(void)) completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okSelection = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertController addAction:okSelection];
    [vc presentViewController:alertController animated:true completion:nil];
}
@end
