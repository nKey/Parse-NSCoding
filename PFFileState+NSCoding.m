
#import "PFFileState+NSCoding.h"
#import "NSObject+Properties.h"
#import <objc/runtime.h>

#define kPFFileStateIvars @"ivars"

@implementation PFFileState (NSCoding)

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:[self ivars] forKey:kPFFileStateIvars];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    NSDictionary* ivars = [aDecoder decodeObjectForKey:kPFFileStateIvars];
    
    self = [[PFFileState alloc] init];
    if (self) {
        for (NSString* key in [ivars allKeys]) {
            [self setValue:ivars[key] forKey:key];
        }
    }
    return self;
}

- (NSDictionary *)ivars
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    unsigned int outCount;
    Ivar* ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++){
        Ivar ivar = ivars[i];
        NSString* ivarNameString = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSValue* value = [self valueForKey:ivarNameString];
        if ([NSObject canEncodeObject:value]) {
            [dict setValue:value forKey:ivarNameString];
        }
    }
    
    free(ivars);
    return dict;
}

@end
