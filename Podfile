platform :ios, '13.0'

use_frameworks!
inhibit_all_warnings!

target 'RxSwift-MVVM-Scaffold' do
# Pods for RxSwift-MVVM-Scaffold

	# Networking
	pod 'Moya/RxSwift', '~> 15.0'  # https://github.com/Moya/Moya
  
  # Rx Extensions
  pod 'RxDataSources', '~> 5.0'  # https://github.com/RxSwiftCommunity/RxDataSources
  pod 'RxSwiftExt', '~> 6.0'  # https://github.com/RxSwiftCommunity/RxSwiftExt
  pod 'NSObject+Rx', '~> 5.0'  # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxViewController', '~> 2.0'  # https://github.com/devxoul/RxViewController
  pod 'RxGesture', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxGesture
  pod 'RxOptional', '~> 5.0'  # https://github.com/RxSwiftCommunity/RxOptional
  pod 'RxTheme', '~> 6.0'  # https://github.com/RxSwiftCommunity/RxTheme
  
  # JSON Mapping
  pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/p-rob/Moya-ObjectMapper.git', :branch => 'master'  # https://github.com/ivanbruel/Moya-ObjectMapper

  # Image
  pod 'Kingfisher', '~> 7.0'  # https://github.com/onevcat/Kingfisher

  # Date
  pod 'DateToolsSwift', '~> 5.0'  # https://github.com/MatthewYork/DateTools
  pod 'SwiftDate', '~> 7.0'  # https://github.com/malcommac/SwiftDate
  
  # Tools
  pod 'R.swift', '~> 7.0'  # https://github.com/mac-cain13/R.swift
  pod 'SwiftLint', '0.51.0'  # https://github.com/realm/SwiftLint

  # Keychain
  pod 'KeychainAccess', '~> 4.0'  # https://github.com/kishikawakatsumi/KeychainAccess
  
  # UI
  pod 'SVProgressHUD', '~> 2.0'  # https://github.com/SVProgressHUD/SVProgressHUD
  pod 'ImageSlideshow/Kingfisher', :git => 'https://github.com/khoren93/ImageSlideshow.git', :branch => 'master'   # https://github.com/zvonicek/ImageSlideshow
  pod 'DZNEmptyDataSet', '~> 1.0'  # https://github.com/dzenbot/DZNEmptyDataSet
  pod 'Hero', '~> 1.6'  # https://github.com/lkzhao/Hero
  pod 'Localize-Swift', '~> 3.0'  # https://github.com/marmelroy/Localize-Swift
  pod 'RAMAnimatedTabBarController', '~> 5.0'  # https://github.com/Ramotion/animated-tab-bar
  pod 'KafkaRefresh', '~> 1.0'  # https://github.com/OpenFeyn/KafkaRefresh
  pod 'DropDown', '~> 2.0'  # https://github.com/AssistoLab/DropDown
  pod 'Toast-Swift', '~> 5.0'  # https://github.com/scalessec/Toast-Swift
  pod 'HMSegmentedControl', '~> 1.0'  # https://github.com/HeshamMegid/HMSegmentedControl
  
  # Keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.0'  # https://github.com/hackiftekhar/IQKeyboardManager

  # Auto Layout
  pod 'SnapKit', '~> 5.0'  # https://github.com/SnapKit/SnapKit

  # Code Quality
  pod 'FLEX', '~> 5.0', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX
  pod 'SwifterSwift', '~> 5.0'  # https://github.com/SwifterSwift/SwifterSwift
  pod 'BonMot', '~> 6.0'  # https://github.com/Rightpoint/BonMot

  # Logging
  pod 'CocoaLumberjack/Swift', '~> 3.0'  # https://github.com/CocoaLumberjack/CocoaLumberjack
  
end

post_install do |installer|
    # Cocoapods optimization, always clean project after pod updating
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
    
    # Enable tracing resources
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
    
    # To hide deployment target warnings
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
end
