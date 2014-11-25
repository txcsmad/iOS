//
//  GL.m
//  It's Raining
//
//  Created by Brad Zeis on 11/4/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import "GL.h"

GLKVector2 GLKVector2FromValues(NSArray *values)
{
    return GLKVector2Make(((NSNumber *)values[0]).floatValue,
                          ((NSNumber *)values[1]).floatValue);
}

GLKVector3 GLKVector3FromValues(NSArray *values)
{
    return GLKVector3Make(((NSNumber *)values[0]).floatValue,
                          ((NSNumber *)values[1]).floatValue,
                          ((NSNumber *)values[2]).floatValue);
}

GLKVector4 GLKVector4FromValues(NSArray *values)
{
    return GLKVector4Make(((NSNumber *)values[0]).floatValue,
                          ((NSNumber *)values[1]).floatValue,
                          ((NSNumber *)values[2]).floatValue,
                          ((NSNumber *)values[3]).floatValue);
}

SKUniform *uniform2f(NSString *name, NSArray *values)
{
    return [SKUniform uniformWithName:name
                         floatVector2:GLKVector2FromValues(values)];
}

SKUniform *uniform3f(NSString *name, NSArray *values)
{
    return [SKUniform uniformWithName:name
                         floatVector3:GLKVector3FromValues(values)];
}

SKUniform *uniform4f(NSString *name, NSArray *values)
{
    return [SKUniform uniformWithName:name
                         floatVector4:GLKVector4FromValues(values)];
}
