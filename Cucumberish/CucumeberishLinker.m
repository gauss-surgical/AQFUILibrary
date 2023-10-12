//
//  CucumeberishLinker.m
//  TritonLDUITests
//
//  Created by Sandesh Basnet on 6/10/21.
//  Copyright © 2021 Gauss Surgical. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Cucumberish.h"
#import "TritonAI_SurgicountUITests-Swift.h"
        __attribute__((constructor))
        void CucumberishInit()
        {
            [CucumberishInitializer CucumberishSwiftInit];
        }

