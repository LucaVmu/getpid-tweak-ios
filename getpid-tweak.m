#import <UIKit/UIKit.h>
#include <unistd.h>

__attribute__((constructor))
static void initLibrary() {
    pid_t pid = getpid();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"App PID"
                                                                       message:[NSString stringWithFormat:@"%d", pid]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
        [alert addAction:ok];

        UIViewController *root = UIApplication.sharedApplication.keyWindow.rootViewController;
        if (root.presentedViewController) {
            root = root.presentedViewController;
        }

        if (root) {
            [root presentViewController:alert animated:YES completion:nil];
        }
    });
}
