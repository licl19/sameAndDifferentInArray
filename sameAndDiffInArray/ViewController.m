//
//  ViewController.m
//  sameAndDiffInArray
//
//  Created by lichanglai on 2018/3/5.
//  Copyright © 2018年 sankai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self method1];
    [self method2];
    [self method3];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)method1 {
    NSArray * arr2 = @[@4,@3,@2,@1];
    NSArray * arr1 = @[@2,@3,@4,@5];
    __block NSMutableArray *sameObject = [NSMutableArray arrayWithCapacity:5];
    [arr2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number1 = obj;
        [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([number1 isEqual:obj]) {
                [sameObject addObject:number1];
                *stop = YES;
            }
        }];
    }];
    NSLog(@"same:%@",sameObject);
    
    __block NSMutableArray *difObject = [NSMutableArray arrayWithCapacity:5];
    //找到arr2中有,arr1中没有的数据
    [arr2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number1 = obj;//[obj objectAtIndex:idx];
        __block BOOL isHave = NO;
        [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([number1 isEqual:obj]) {
                isHave = YES;
                *stop = YES;
            }
        }];
        if (!isHave) {
            [difObject addObject:obj];
        }
    }];
    //找到arr1中有,arr2中没有的数据
    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *number1 = obj;//[obj objectAtIndex:idx];
        __block BOOL isHave = NO;
        [arr2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([number1 isEqual:obj]) {
                isHave = YES;
                *stop = YES;
            }
        }];
        if (!isHave) {
            [difObject addObject:obj];
        }
    }];
    NSLog(@"diff:%@",difObject);
}

- (void)method2 {
    NSArray *arr2 = @[@4,@3,@2,@1];
    NSArray *arr1 = @[@2,@3,@4,@5];
    NSMutableSet *set1 = [NSMutableSet setWithArray:arr1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:arr2];
    [set1 intersectSet:set2];
    NSLog(@"same:%@",set1);
    
    {
        NSMutableSet *set1 = [NSMutableSet setWithArray:arr1];
        NSMutableSet *set2 = [NSMutableSet setWithArray:arr2];
        [set2 minusSet:set1];
        NSMutableSet *set3 = [NSMutableSet setWithArray:arr2];
        [set1 minusSet:set3];
        [set2 unionSet:set1];
        NSLog(@"diff:%@",set2);
    }
}

- (void)method3 {
    NSArray * arr2 = @[@4,@3,@2,@1];
    NSArray * arr1 = @[@2,@3,@4,@5];
    NSPredicate * filterPredicate_same = [NSPredicate predicateWithFormat:@"SELF IN %@",arr1];
    NSArray * filter_no = [arr2 filteredArrayUsingPredicate:filterPredicate_same];
    NSLog(@"same:%@",filter_no);
    
    //找到在arr2中不在数组arr1中的数据
    NSPredicate * filterPredicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
    NSArray * filter1 = [arr2 filteredArrayUsingPredicate:filterPredicate1];
    //找到在arr1中不在数组arr2中的数据
    NSPredicate * filterPredicate2 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr2];
    NSArray * filter2 = [arr1 filteredArrayUsingPredicate:filterPredicate2];
    //拼接数组
    NSMutableArray *array = [NSMutableArray arrayWithArray:filter1];
    [array addObjectsFromArray:filter2];
    NSLog(@"diff:%@",array);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
