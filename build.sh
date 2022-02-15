#!/bin/bash

echo "===============================Begin Build======================================"

SDK_DIRECTORY="libWeiboSDK"

MY_PODSPEC_FILE_NAME="SinaWeiboOpenSDK-iOS.podspec"
MY_PODSPEC_PATH="${MY_PODSPEC_FILE_NAME}"
MY_PODSPEC_NAME="SinaWeiboOpenSDK-iOS"
MY_PODSPEC_MODULE_NAME="SinaWeiboOpenSDK"
LAST_MY_PODSPEC_VERSION=""

WEIBO_GIT_PATH="https://github.com/sinaweibosdk/weibo_ios_sdk.git"
WEIBO_DIRECTORY="weibo_ios_sdk"
WEIBO_PODSPEC_FILE_NAME="Weibo_SDK.podspec"
WEIBO_PODSPEC_PATH="${WEIBO_DIRECTORY}/${WEIBO_PODSPEC_FILE_NAME}"
WEIBO_PODSPEC_VERSION=""

function getMyPodVersion() {
    if [ -f "${MY_PODSPEC_PATH}" ]; then
        pattern=".*\.version.*\'.*\'.*"
        version=$(cat ${MY_PODSPEC_PATH} | grep "${pattern}")
        version="${version#*\'}" # 从左向右截取第一个'后的字符串
        version="${version%\'*}" # 从右向左截取第一个'后的字符串
        echo "获取${MY_PODSPEC_PATH}的pod版本成功，版本：${version}"
        # echo -e "\n"
        LAST_MY_PODSPEC_VERSION=${version}
    else
        echo "${MY_PODSPEC_PATH}不存在"
        # echo -e "\n"
    fi
}

getMyPodVersion

function getWeiboPodVersion() {
    if [ -f "${WEIBO_PODSPEC_PATH}" ]; then
        pattern=".*\.version.*\".*\""
        version=$(cat ${WEIBO_PODSPEC_PATH} | grep "${pattern}")
        version="${version#*\"}" # 从左向右截取第一个"后的字符串
        version="${version%\"*}" # 从右向左截取第一个"后的字符串
        echo "获取${WEIBO_PODSPEC_PATH}的pod版本成功，版本：${version}"
        # echo -e "\n"
        WEIBO_PODSPEC_VERSION=${version}
    else
        echo "${WEIBO_PODSPEC_PATH}不存在"
        # echo -e "\n"
    fi
}

rm -rf "${SDK_DIRECTORY:?}/"*
rm -rf ${SDK_DIRECTORY}

rm -rf ${WEIBO_DIRECTORY}
git clone ${WEIBO_GIT_PATH}
rm -rf ${WEIBO_DIRECTORY}/.git

cp -r ${WEIBO_DIRECTORY}/libWeiboSDK ${SDK_DIRECTORY}

touch ${SDK_DIRECTORY}/empty.swift
echo "// This is a empty swift file" >>${SDK_DIRECTORY}/empty.swift

getWeiboPodVersion

if [ "${LAST_MY_PODSPEC_VERSION}" != "${WEIBO_PODSPEC_VERSION}" ]; then
    echo "版本号不相等，重新创建podspec文件"
    rm -rf ${MY_PODSPEC_PATH}
    cat <<-EOF >${MY_PODSPEC_PATH}
Pod::Spec.new do |spec|
    spec.name                     = '${MY_PODSPEC_NAME}'
    spec.version                  = '${WEIBO_PODSPEC_VERSION}' # 版本号和微博官方的保持一致
    spec.homepage                 = 'https://github.com/liujunliuhong/SinaWeiboOpenSDK'
    spec.source                   = { :git => 'https://github.com/liujunliuhong/SinaWeiboOpenSDK.git', :tag => spec.version }
    spec.summary                  = 'Sina weibo open SDK'
    spec.license                  = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                   = { 'liujunliuhong' => '1035841713@qq.com' }
    spec.platform                 = :ios, '9.0'
    spec.ios.deployment_target    = '9.0'
    spec.module_name              = '${MY_PODSPEC_MODULE_NAME}'
    spec.requires_arc             = true
    spec.static_framework         = true
    spec.swift_version            = '5.0'
    spec.source_files             = '${SDK_DIRECTORY}/*.{swift,h,m}'
    spec.vendored_libraries 	  = '${SDK_DIRECTORY}/*.a'
    spec.resource                 = '${SDK_DIRECTORY}/*.bundle'
    spec.frameworks               = 'Photos', 'ImageIO', 'SystemConfiguration', 'CoreText', 'QuartzCore', 'Security', 'UIKit', 'Foundation', 'CoreGraphics','CoreTelephony','WebKit'
    spec.libraries                = 'sqlite3', 'z'
    spec.pod_target_xcconfig      = {
        'OTHER_LDFLAGS' => '-all_load',
        'VALID_ARCHS' => 'x86_64 armv7 arm64'
    }
end
EOF
else
    echo "版本号相等，不再重新创建podspec文件"
fi

cat ${MY_PODSPEC_FILE_NAME}

echo "开始验证pod..."
pod lib lint --allow-warnings
echo "pod验证完毕"
echo "请手动执行pod trunk push --allow-warnings"

echo "===============================End Build======================================"
