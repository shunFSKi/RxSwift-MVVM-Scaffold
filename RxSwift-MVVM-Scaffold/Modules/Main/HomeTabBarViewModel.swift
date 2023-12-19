//
//  HomeTabBarViewModel.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/18.
//

import UIKit
import RxCocoa
import RxSwift

class HomeTabBarViewModel: ViewModel, ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let tabBarItems: Driver<[HomeTabBarItem]>
    }
    
    let authorized: Bool
    
    init(authorized: Bool, provider: RemoteHearingAPI) {
        self.authorized = authorized
        super.init(provider: provider)
    }
    
    func transform(input: Input) -> Output {
        let tabBarItems = Observable.just(authorized).map { (authorized) -> [HomeTabBarItem] in
            if authorized {
                return [.home]
            } else {
                return [.home]
            }
        }.asDriver(onErrorJustReturn: [])
        
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: HomeTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .home:
            let viewModel = HomeViewModel(provider: provider)
            return viewModel
        }
    }
}
