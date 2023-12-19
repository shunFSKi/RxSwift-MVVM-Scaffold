//
//  LibsManager.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/14.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import DropDown
import NSObject_Rx
import Toast_Swift
import KafkaRefresh
import IQKeyboardManagerSwift
import Kingfisher
import CocoaLumberjack
import NSObject_Rx
import RxViewController
import RxOptional
import RxGesture
#if DEBUG
import FLEX
#endif

class LibsManager: NSObject {
    static let shared = LibsManager()
    
    private override init() {
        super.init();
    }
    
    func setupLibs() {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupTheme()
        libsManager.setupKafkaRefresh()
        libsManager.setupFLEX()
        libsManager.setupKeyboardManager()
        libsManager.setupDropDown()
        libsManager.setupToast()
    }
    
    func setupTheme() {
        UIApplication.shared.theme.statusBarStyle = themeService.attribute { $0.statusBarStyle }
    }

    func setupDropDown() {
        themeService.typeStream.subscribe(onNext: { (themeType) in
            let theme = themeType.associatedObject
            DropDown.appearance().backgroundColor = theme.primary
            DropDown.appearance().selectionBackgroundColor = theme.primaryDark
            DropDown.appearance().textColor = theme.text
            DropDown.appearance().selectedTextColor = theme.text
            DropDown.appearance().separatorColor = theme.separator
        }).disposed(by: rx.disposeBag)
    }

    func setupToast() {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.position = .top
        var style = ToastStyle()
        style.backgroundColor = UIColor.Material.red
        style.messageColor = UIColor.Material.white
        style.imageSize = CGSize(width: 20, height: 20)
        ToastManager.shared.style = style
    }
    
    func setupKafkaRefresh() {
        if let defaults = KafkaRefreshDefaults.standard() {
            defaults.headDefaultStyle = .replicatorAllen
            defaults.footDefaultStyle = .replicatorDot
            defaults.theme.themeColor = themeService.attribute { $0.secondary }
        }
    }

    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }

    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }

    func setupCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance)
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    func setupFLEX() {
        #if DEBUG
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        #endif
    }
}

extension LibsManager {

    func showFlex() {
        #if DEBUG
        FLEXManager.shared.showExplorer()
        #endif
    }

    func removeKingfisherCache() -> Observable<Void> {
        return ImageCache.default.rx.clearCache()
    }

    func kingfisherCacheSize() -> Observable<Int> {
        return ImageCache.default.rx.retrieveCacheSize()
    }
}
