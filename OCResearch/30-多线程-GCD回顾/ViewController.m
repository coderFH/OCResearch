//
//  ViewController.m
//  30-多线程-GCD回顾
//
//  Created by wangfh on 2019/10/29.
//  Copyright © 2019 wangfh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIImageView *imageView;

@end

/*
 01 异步函数+并发队列：开启多条线程，并发执行任务
 02 异步函数+串行队列：开启一条线程，串行执行任务
 03 同步函数+并发队列：不开线程，串行执行任务
 04 同步函数+串行队列：不开线程，串行执行任务
 05 异步函数+主队列：不开线程，在主线程中串行执行任务
 06 同步函数+主队列：不开线程，串行执行任务（注意死锁发生）
 07 注意同步函数和异步函数在执行顺序上面的差异
 阶段性总结：
 1. 开不开线程，由执行任务方法决定，同步不开线程，异步肯定开线程
 2. 开多少线程，由队列决定，串行 最多 开一个线程， 并发可以开多个线程。 具体开多少个，有GCD底层决定，程序猿不能控制
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark ---- 异步函数+并发队列:会开启多个新的线程,并发执行 -----
- (IBAction)asyncConcurrent:(id)sender {
    //创建并发队列
    /*
     第一个参数:C语言字符串,标签
     第二个参数:
     DISPATCH_QUEUE_CONCURRENT:并发队列
     DISPATCH_QUEUE_SERIAL:串行队列
     */
//    dispatch_queue_t queue =  dispatch_queue_create("wangfh", DISPATCH_QUEUE_CONCURRENT);
    
    /*
     获取全局并发队列
     第一个参数: DISPATCH_QUEUE_PRIORITY_DEFAULT  对应的值是0
     第二个参数: 永远传0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
   
    /**
    全局队列跟并发队列的区别
    1. 全局队列没有名称 并发队列有名称
    2. 全局队列，是供所有的应用程序共享。
    3. 在MRC开发，并发队列，创建完了，需要释放。 全局队列不需要我们管理
    */

    dispatch_async(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
    NSLog(@"%@---主线程任务结束",[NSThread currentThread]);
}

#pragma mark ---- 异步函数+串行队列:会开启一条线程,任务串行执行 -----
-(IBAction)asyncSerial {
    //创建串行队列
    /*
     第一个参数:C语言字符串,标签
     第二个参数:
     DISPATCH_QUEUE_CONCURRENT:并发队列
     DISPATCH_QUEUE_SERIAL:串行队列
     */
    dispatch_queue_t queue =  dispatch_queue_create("wangfh", DISPATCH_QUEUE_SERIAL);
   
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
    NSLog(@"%@---主线程任务结束",[NSThread currentThread]);
}

#pragma mark ---- 同步函数+并发队列:不会开线程,任务串行执行 ----
- (IBAction)syncConcurrent {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    NSLog(@"--syncConcurrent--start-");
   
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
   
    NSLog(@"--syncConcurrent--end-");
}

#pragma mark ---- 同步函数+串行队列:不会开线程,任务串行执行 ----
- (IBAction)syncSerial {
    dispatch_queue_t queue =  dispatch_queue_create("wangfh", DISPATCH_QUEUE_SERIAL);
   
    dispatch_sync(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
    NSLog(@"%@---主线程任务结束",[NSThread currentThread]);
}

#pragma mark ---- 异步函数+主队列:不会开线程,任务串行执行 ----
/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 异步执行： 会开新线程，在新线程执行
 结果: 不开线程， 只能在主线程上面，顺序执行!
 */
- (IBAction)asyncMain{
    //1.获得主队列
    dispatch_queue_t queue =  dispatch_get_main_queue();
   
    //2.异步函数
    dispatch_async(queue, ^{
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_async(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
    NSLog(@"%@---主线程任务结束",[NSThread currentThread]);
}

#pragma mark ---- 同步函数+主队列:死锁 ----
/**
  主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
  同步执行：要马上执行
  结果：死锁
 */
- (IBAction)syncMain {
    NSLog(@"----");
    //1.获得主队列
    dispatch_queue_t queue =  dispatch_get_main_queue();
   
    //2.同步函数
    dispatch_sync(queue, ^{
        NSLog(@"我是主队列任务,我需要马上执行,但是主线程的任务还没结束,我只能等待它结束,它在等待我结束,就互相等待形成死锁");
        NSLog(@"---download1---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download2---%@",[NSThread currentThread]);
    });
   
    dispatch_sync(queue, ^{
        NSLog(@"---download3---%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"---download4---%@",[NSThread currentThread]);
    });
    NSLog(@"我是主线程的任务,我也在主队列中,我都没执行完毕,现在又要马上去执行你的任务");
}

#pragma mark ---- 全局队列 ----
/**
 全局队列跟并发队列的区别
 1. 全局队列没有名称 并发队列有名称
 2. 全局队列，是供所有的应用程序共享。
 3. 在MRC开发，并发队列，创建完了，需要释放。 全局队列不需要我们管理
 */
- (IBAction)gcdTest8 {
    // 获得全局队列
    /**
     参数：第一个参数，一般 写 0（可以适配 iOS 7 & 8）
     iOS 7
     DISPATCH_QUEUE_PRIORITY_HIGH 2  高优先级
     DISPATCH_QUEUE_PRIORITY_DEFAULT 0  默认优先级
     DISPATCH_QUEUE_PRIORITY_LOW (-2) 低优先级
     DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN 后台优先级
    
     iOS 8
     QOS_CLASS_DEFAULT  0
    
     第二个参数：保留参数 0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
   
    // 添加异步任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}


#pragma mark ---- GCD线程间通信 ----
- (IBAction)threadIPC {
    //0.获取一个全局的队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //1.先开启一个线程，把下载图片的操作放在子线程中处理
    dispatch_async(queue, ^{
        //2.下载图片
        NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/6a63f6246b600c3320b14bb3184c510fd8f9a185.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"下载操作所在的线程--%@",[NSThread currentThread]);
        //3.回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            //打印查看当前线程
            NSLog(@"刷新UI---%@",[NSThread currentThread]);
        });
   });
}

#pragma mark ---- 同步任务的作用 ----
- (IBAction)gcdTest7 {
    
    // 并发队列
    dispatch_queue_t  queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
   
    /**
     例子：有一个小说网站
     - 必须登录，才能下载小说
    
     有三个任务：
     1. 用户登录
     2. 下载小说A
     3. 下载小说B
     */
    // 添加任务
    // 同步任务，需要马上执行。 不开新线程
    dispatch_sync(queue, ^{
        NSLog(@"用户登录 %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载小说A %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载小说B %@", [NSThread currentThread]);
    });
}

#pragma mark ------------- GCD常用函数 #pragma mark -------------
#pragma mark ---- 栅栏函数(控制任务的一个执行顺序) ----
- (IBAction)barrier {
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("wfh", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"%zd-download1--%@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"%zd-download2--%@",i,[NSThread currentThread]);
        }
    });
    
    //祈祷分割的作用
    dispatch_barrier_async(queue, ^{
        NSLog(@"我是一个栅栏函数");
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"%zd-download3--%@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i++) {
            NSLog(@"%zd-download4--%@",i,[NSThread currentThread]);
        }
    });
}

#pragma mark ---- 延时函数 ----
- (IBAction)delay {
    /**
     参数:
     now 0
     NSEC_PER_SEC: 很大的数字
     */
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
   
    // 参数:when : 表示从现在开始，经过多少纳秒以后
    // queue:在哪一个队列里面执行后面的任务
    
//    dispatch_after(when, dispatch_get_main_queue(), ^{
//        NSLog(@"点我了-- %@", [NSThread currentThread]);
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        <#code to be executed after a specified delay#>
//    });
    dispatch_after(when, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"点我了-- %@", [NSThread currentThread]);
    });
}

#pragma mark ----- 一次性执行 -----
- (IBAction)once {
    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);
   
    dispatch_once(&onceToken, ^{
        NSLog(@"%----ld", onceToken);
        NSLog(@"真的执行一次么？");
    });
    NSLog(@"完成");
}

#pragma mark ----- 快速迭代 -----
- (IBAction)applay {
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("wfh", DISPATCH_QUEUE_CONCURRENT);
    /*
     迭代的次数
     在哪个队列执行
     block要执行的任务
     */
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index,[NSThread currentThread]);
    });
}
          
#pragma mark ------------- GCD组 -------------
#pragma mark ----- 调度组(分组) -----
- (IBAction)group1 {
      //创建队列组
      dispatch_group_t group =  dispatch_group_create();
     
      //1.开子线程下载图片
      //创建队列(并发)
      dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     
      dispatch_group_async(group, queue, ^{
          //1.获取url地址
          NSURL *url = [NSURL URLWithString:@"http://www.huabian.com/uploadfile/2015/0914/20150914014032274.jpg"];
         
          //2.下载图片
          NSData *data = [NSData dataWithContentsOfURL:url];
         
          //3.把二进制数据转换成图片
//          self.image1 = [UIImage imageWithData:data];
         
//          NSLog(@"1---%@",self.image1);
      });

      //下载图片2
      dispatch_group_async(group, queue, ^{
          //1.获取url地址
          NSURL *url = [NSURL URLWithString:@"http://img1.3lian.com/img2011/w12/1202/19/d/88.jpg"];
         
          //2.下载图片
          NSData *data = [NSData dataWithContentsOfURL:url];
         
          //3.把二进制数据转换成图片
//          self.image2 = [UIImage imageWithData:data];
//          NSLog(@"2---%@",self.image2);
         
      });
     
      //合成
      dispatch_group_notify(group, queue, ^{
         
          //开启图形上下文
          UIGraphicsBeginImageContext(CGSizeMake(200, 200));
         
          //画1
//          [self.image1 drawInRect:CGRectMake(0, 0, 200, 100)];
         
          //画2
//          [self.image2 drawInRect:CGRectMake(0, 100, 200, 100)];
         
          //根据图形上下文拿到图片
          UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
         
          //关闭上下文
          UIGraphicsEndImageContext();
         
          dispatch_async(dispatch_get_main_queue(), ^{
              self.imageView.image = image;
              NSLog(@"%@--刷新UI",[NSThread currentThread]);
          });
      });
}

- (IBAction)group2 {
      /**
       应用场景：
       开发的时候，有的时候出现多个网络请求都完成以后（每一个网络请求的事件长短不一定），再统一通知用户
      
       比如： 下载小说：三国演义， 红楼梦， 金X梅
       */
      // 实例化一个调度组
      dispatch_group_t group = dispatch_group_create();
     
      // 队列
      dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     
      // 任务添加到队列queue
      dispatch_group_async(group, queue, ^{
          NSLog(@"下载小说A---%@", [NSThread currentThread]);
      });
     
      dispatch_group_async(group, queue, ^{
          NSLog(@"下载小说B---%@", [NSThread currentThread]);
      });
     
      dispatch_group_async(group, queue, ^{
          NSLog(@"下载小说X---%@", [NSThread currentThread]);
      });
     
      // 获得所有调度组里面的异步任务完成的通知
    //    dispatch_group_notify(group, queue, ^{
    //        NSLog(@"下载完成，请观看%@", [NSThread currentThread]); // 异步的
    //    });
      //注意点： 在调度组完成通知里，可以跨队列通信
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
          // 更新UI，在主线程
          NSLog(@"下载完成，请观看%@", [NSThread currentThread]); // 异步的
      });
}

@end
