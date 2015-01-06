MHAgileFramework
================
MHAgileFramework 是什么
================
MHAgileFramework 设计初衷是做一个快速、敏捷的开发框架，使用者使用后只需要关心UI层和简要写一下UI控制层，就可以快速开发出一款APP。那么，它拥有强大且完善的数据层，并且集成了多个三方框架or便利工具，steven也经常喜欢把他自己常用的便利工具加入到里面。

gitHub:https://github.com/sevenblue/MHAgileFramework.git

@Attention: MHAgileFramework使用CocoaPods管理三方类库，如果您不想用CocoaPods，请手动将AFNetworking、FMDB、JSONKit、RMMapper、SVProgressHUD引入到项目中，并且放于Vendor文件夹中

================
MHAgileFramework 的文件结构
================
想更好的应用这个framework，首先我们来了解一下他的文件结构。

Define:      需要全局引用的宏定义、URL和公共类这里加入

DAO:         数据库访问接口，可直接访问，也可通过Manager中的MHFMDBManager访问数据库

Manager:     网络请求Manager:        MHAFNetworkingManager(实现AFNetworking断点续传和再封装队列管理);
             数据库访问Manager:      MHFMDBManager(可实现NSObject对象单个和批量 增删改查 到SQL数据库);
             左右滑动侧边栏Manager:   MHSlidingManager

DataSource:  JSON数据解析接口，应用JSON TO Object，动态解析json数据，并动态生成model对象存储解析后数据

Base:        Model、viewController、TableViewController的父类，封装常用功能

Util:        常用工具包，包括UIKit扩展包和OBJ扩展包

Vendor:      三方类库文件夹（ps：不支持cocoaPods的三方类库，其余的在cocoaPods中包含）

Resource:    用于存放文件资源，eg.MP3、doc...
