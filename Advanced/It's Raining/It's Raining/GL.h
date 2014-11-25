//
//  GL.h
//  It's Raining
//
//  Created by Brad Zeis on 11/4/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

// Because unions are not supported in Swift, vector
// uniforms must be created in Objective-C.

// Look up GLKMathTypes.h in GLKit. Here's GLKVector2:

//union _GLKVector2
//{
//    struct { float x, y; };
//    struct { float s, t; };
//    float v[2];
//} __attribute__((aligned(8)));
//typedef union _GLKVector2 GLKVector2;

SKUniform *uniform2f(NSString *name, NSArray *values);
SKUniform *uniform3f(NSString *name, NSArray *values);
SKUniform *uniform4f(NSString *name, NSArray *values);
