//
//  Before8ViewController.m
//  SearchBarDemo
//
//  Created by 胡翔 on 2017/1/5.
//  Copyright © 2017年 胡翔. All rights reserved.
//

#import "Before8ViewController.h"

@interface Before8ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UITableView *tableView;
/**数据源*/
@property (nonatomic, strong) NSArray *dataArray;

/**经过搜索之后的数据源*/
@property (nonatomic, strong) NSArray *searchResultArray;

/**我们的UISearchDisplayController*/
@property (nonatomic, strong) UISearchDisplayController *displayer;

@end

@implementation Before8ViewController

- (NSArray *)getDataArray
{
    /**模拟一组数据*/
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< 20; i++) {
        NSString *dataString = [NSString stringWithFormat:@"%d",i];
        [resultArray addObject:dataString];
    }
    return resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UISearchBar";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupSearchBar];
    self.dataArray = [self getDataArray];
}

- (void)setupSearchBar{
    /**配置Search相关控件*/
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = searchBar;
    
    self.displayer = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    /**searchBar的delegate看需求进行配置*/
    searchBar.delegate = self;
    
    /**以下都比较重要，建议都设置好代理*/
    self.displayer.searchResultsDataSource = self;
    self.displayer.searchResultsDelegate = self;
    self.displayer.delegate = self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /**对TableView进行判断，如果是搜索结果展示视图，返回不同结果*/
    if (tableView == self.displayer.searchResultsTableView) {
        return self.searchResultArray.count;
    }
    else{
        return self.dataArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainCell"];
    }
    /**对TableView进行判断，如果是搜索结果展示视图，返回不同数据源*/
    if (tableView == self.displayer.searchResultsTableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.searchResultArray[indexPath.row]];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    }
    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"begin");
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"end");
    return  YES;
}

/**UISearchDisplayController的代理实现*/

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    /**通过谓词修饰的方式来查找包含我们搜索关键字的数据*/
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchString];
    self.searchResultArray = [self.dataArray filteredArrayUsingPredicate:resultPredicate];
    return  YES;
}

@end

