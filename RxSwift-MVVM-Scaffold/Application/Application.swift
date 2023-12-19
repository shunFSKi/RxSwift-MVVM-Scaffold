//
//  Application.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/14.
//

import UIKit

class Application: NSObject {
    static let shared = Application()

    var window: UIWindow?
    
    var provider: RemoteHearingAPI?
    let navigator: Navigator
    
    private override init() {
        navigator = Navigator.default
        super.init()
        updateProvider()
    }
    
    private func updateProvider() {
        let staging = Configs.Network.useStaging
        let baseProvider = staging ? BaseNetworking.stubbingNetworking(): BaseNetworking.defaultNetworking()
        let restApi = RestApi(baseProvider: baseProvider)
        provider = restApi

//        if let token = authManager.token, Configs.Network.useStaging == false {
//            switch token.type() {
//            case .oAuth(let token), .personal(let token):
//                provider = GraphApi(restApi: restApi, token: token)
//            default: break
//            }
//        }
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        updateProvider()
        guard let window = window, let provider = provider else { return }
        self.window = window

//        presentTestScreen(in: window)
//        return

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            if let user = User.currentUser(), let login = user.login {
//                analytics.identify(userId: login)
//                analytics.set(.name(value: user.name ?? ""))
//                analytics.set(.email(value: user.email ?? ""))
//            }
//            let authorized = self?.authManager.token?.isValid ?? false
            let viewModel = HomeTabBarViewModel(authorized: true, provider: provider)
            self?.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
        }
    }
    
}
