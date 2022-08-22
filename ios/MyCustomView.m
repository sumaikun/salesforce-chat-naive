//
//  MyCustomView.m
//  fleetTest
//
//  Created by jesus vega on 12/08/22.
//

#import <React/RCTViewManager.h>
 
@interface RCT_EXTERN_MODULE(RCTMyCustomViewManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(status, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)
 
@end
