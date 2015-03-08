//
//  ViewController.h
//  SFUPA
//
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mainScreenLoginButton; // also the logout button
- (IBAction)pressedMainScreenLoginButton:(id)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
