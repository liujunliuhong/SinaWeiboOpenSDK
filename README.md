# SinaWeiboOpenSDK
<div>
<a href="https://open.weibo.com/wiki/%E9%A6%96%E9%A1%B5">新浪微博官方文档</a>
</div>
<div>
<a href="https://github.com/sinaweibosdk/weibo_ios_sdk">新浪微博官方SDK下载页面</a>
</div>
<br>


&emsp;&emsp;新浪微博`SDK`支持`pod`导入，但不支持`Swift module`，我根据官方`SDK`，制作了一个`pod`，以支持`Swift module`。<br><br>
&emsp;&emsp;支持`Swift`。<br><br>
&emsp;&emsp;我只是一个搬运工😄

## 当前pod库支持的微博官方SDK版本
```
3.3.2
```

## 版本要求
根据官方`SDK`的`podspec`文件，发现微博官方`SDK`支持版本必须是`9.0`及以上

## 安装
推荐使用`CocoaPods`

```
pod 'SinaWeiboOpenSDK-iOS'
```

或者指定git源

```
pod 'SinaWeiboOpenSDK-iOS', :git => "https://github.com/liujunliuhong/SinaWeiboOpenSDK.git" 
```

## 使用
Swift

```
import SinaWeiboSDK
```

OC

```
@import SinaWeiboSDK;
```

或者

```
#import <SinaWeiboSDK/WeiboSDK.h>
```

## 说明
- `pod`版本和新浪微博官方版本保持一致，比如`pod`版本是`3.3.2`，表示当前使用的官方`SDK`版本也是`3.3.2`
- 我只是一个搬运工，`pod`库的更新依赖于新浪微博官方官方，即官方更新了`SDK`，我的`pod`库才会更新