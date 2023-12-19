//
//  AppDelegate.swift
//  RxSwift-MVVM-Scaffold
//
//  Created by 冯顺 on 2023/12/19.
//

import UIKit
import Toast_Swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let libsManager = LibsManager.shared
        libsManager.setupLibs()
        
        if Configs.Network.useStaging == true {
            // Logout
//            User.removeCurrentUser()
//            AuthManager.removeToken()

            // Use Green Dark theme
            var theme = ThemeType.currentTheme()
            if theme.isDark != true {
                theme = theme.toggled()
            }
            theme = theme.withColor(color: .green)
            themeService.switch(theme)

        } else {
            connectedToInternet().skip(1).subscribe(onNext: { [weak self] (connected) in
                var style = ToastManager.shared.style
                style.backgroundColor = connected ? UIColor.Material.green: UIColor.Material.red
                let message = connected ? "连接已恢复": "连接已断开"
                let image = connected ? R.image.icon_toast_success(): R.image.icon_toast_warning()
                if let view = self?.window?.rootViewController?.view {
                    view.makeToast(message, position: .bottom, image: image, style: style)
                }
            }).disposed(by: rx.disposeBag)
        }
        
        // Show initial screen
        Application.shared.presentInitialScreen(in: window!)
        return true
    }


}

