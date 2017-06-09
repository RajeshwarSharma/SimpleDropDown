//
//  DropDownView.m
//  KrishnaDropDown
//
//  Created by daffolapmac on 17/05/17.
//  Copyright © 2017 daffolapmac. All rights reserved.
//

#import "SimpleDropDownView.h"
#import "SimpleDropDownCell.h"
@implementation SimpleDropDownView

- (id)init{
    SimpleDropDownView *dropDownView = [[[NSBundle mainBundle] loadNibNamed:@"SimpleDropDownView" owner:nil options:nil] firstObject];
   return dropDownView;

}


-(void)setDropDownOnView:(UIView *)onView belowView:(UIView *)belowView andData:(NSArray *)dataArry{
    self.dataArry  = [NSArray array];
    [self.tableView reloadData];
    self.dataArry = dataArry;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    
    CGRect frameOnView = [belowView convertRect:belowView.bounds toView:onView];
    CGFloat topMargin = frameOnView.origin.y + frameOnView.size.height;
    CGFloat difference = screenHeight - topMargin;
    if(difference < 170){
        self.frame = CGRectMake(frameOnView.origin.x, frameOnView.origin.y - 171, frameOnView.size.width, 170);
    }else{
        self.frame = CGRectMake(frameOnView.origin.x, frameOnView.origin.y + frameOnView.size.height, frameOnView.size.width, 170);
    }
    [self removeFromSuperview];
    _onView = onView;
    _belowView = belowView;
    [onView addSubview:self];
    [self.tableView reloadData];
}

-(void)awakeFromNib{
    _isVisible = false;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-2, 2);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 0.5;
    
  [self.tableView registerNib:[UINib nibWithNibName:@"SimpleDropDownCell" bundle:nil] forCellReuseIdentifier:@"SimpleDropDownCell"];
    [super awakeFromNib];
}

- (void)toggle{
    if (_isVisible){
        _isVisible = false;
        [self setHidden:true];
    }
    else{
        _isVisible = true;
        [self setHidden:false];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    if(_dataArry.count == 0){
        return 0;
    }
    
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0){
//        return 1;
//    }
//    NSDictionary *dic =  [_dataArry objectAtIndex:section-1];
//    NSArray *namesArry = [dic objectForKey:@"names"];
    return _dataArry.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SimpleDropDownCell";
    
    // Similar to UITableViewCell, but
    SimpleDropDownCell *cell = (SimpleDropDownCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SimpleDropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Just want to test, so I hardcode the data
//    if (indexPath.section == 0){
//        cell.labelName.text = @"Select Property";
//    }
//    else{
        NSString *name =  [_dataArry objectAtIndex:indexPath.row];
    
        cell.labelName.text = name;
    //}
    
    
   // cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Calculate a height based on a cellret
    
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView;
    
    sectionHeaderView = [[UIView alloc] initWithFrame:
                         CGRectMake(0, 0, tableView.frame.size.width, 35)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(10,5, sectionHeaderView.frame.size.width-10, 25)];
    
    headerLabel.text = @"Purpose";
    headerLabel.textColor = [UIColor lightGrayColor];
    [sectionHeaderView addSubview:headerLabel];
    return sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _isVisible = false;
   NSString *name =  [_dataArry objectAtIndex:indexPath.row];
    
    [_delegate selectedName:name andContainerView:_belowView];
    [self removeFromSuperview];
}
@end
