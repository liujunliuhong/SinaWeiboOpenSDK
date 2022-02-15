Pod::Spec.new do |spec|
    spec.name                     = 'SinaWeiboOpenSDK-iOS'
    spec.version                  = '3.3.2' # 版本号和微博官方的保持一致
    spec.homepage                 = 'https://github.com/liujunliuhong/SinaWeiboOpenSDK'
    spec.source                   = { :git => 'https://github.com/liujunliuhong/SinaWeiboOpenSDK.git', :tag => spec.version }
    spec.summary                  = 'Sina weibo open SDK'
    spec.license                  = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                   = { 'liujunliuhong' => '1035841713@qq.com' }
    spec.platform                 = :ios, '9.0'
    spec.ios.deployment_target    = '9.0'
    spec.module_name              = 'SinaWeiboOpenSDK' # 模块名和微信保持一致
    spec.requires_arc             = true
    spec.static_framework         = true
    spec.swift_version            = '5.0'
    spec.source_files             = 'libWeiboSDK/*.{swift,h,m}'
    spec.vendored_libraries 	  = 'libWeiboSDK/*.a'
    spec.resource                 = 'libWeiboSDK/*.bundle'
    spec.frameworks               = 'Photos', 'ImageIO', 'SystemConfiguration', 'CoreText', 'QuartzCore', 'Security', 'UIKit', 'Foundation', 'CoreGraphics','CoreTelephony','WebKit'
    spec.libraries                = 'sqlite3', 'z'
    spec.pod_target_xcconfig      = {
        'OTHER_LDFLAGS' => '-all_load',
        'VALID_ARCHS' => 'x86_64 armv7 arm64'
    }
end
