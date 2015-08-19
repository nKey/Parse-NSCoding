
#import <Parse/Parse.h>
#import "PFFileState.h"

@interface PFFileState (NSCoding)

- (void)encodeWithCoder:(NSCoder*)encoder;
- (id)initWithCoder:(NSCoder*)aDecoder;

@end
