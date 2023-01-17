//
//  LSTestVM.m
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import "LSTestVM.h"
#import "LSTableViewCell.h"

@implementation LSTestVM

- (void)request{
    
    NSMutableArray<SCETRowItem *> *Items = [NSMutableArray new];
    
    SCETRowItem *textLinkItem = [SCETRowItem rowItemWithRowData:@"123" cellClassString:NSStringFromClass([LSTableViewCell class])];
    textLinkItem.cellHeight = 80;
    [Items addObject:textLinkItem];
    
    SCETSectionItem *scetionItem = [SCETSectionItem sc_sectionItemWithRowItems:Items];
    
    [self.sectionItems addObject:scetionItem];
    [self resetDataSource:self.sectionItems];
    
    if (self.reloadData) {
        self.reloadData();
    }
    
    //cell被点击回调
    if (self.didCellSelect){
        self.didCellSelect();
    }
    
}
@end
