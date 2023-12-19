//
//  HomeTabBarController.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/18.
//

import UIKit
import RAMAnimatedTabBarController
import RxSwift

enum HomeTabBarItem: Int {
    case home
    
    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController(viewModel: viewModel, navigator: navigator)
            return NavigationController(rootViewController: vc)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return R.image.icon_tab_home()
        }
    }
    
    var title: String {
        switch self {
        case .home: return "首页"
        }
    }
    
    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
        case .home: animation = RAMFlipLeftTransitionItemAnimations()
        }
        animation.theme.iconSelectedColor = themeService.attribute { $0.secondary }
        animation.theme.textSelectedColor = themeService.attribute { $0.secondary }
        return animation
    }
    
    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let vc = controller(with: viewModel, navigator: navigator)
        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
        item.animation = animation
        item.theme.iconColor = themeService.attribute { $0.text }
        item.theme.textColor = themeService.attribute { $0.text }
        vc.tabBarItem = item
        return vc
    }
}

class HomeTabBarController: RAMAnimatedTabBarController, Navigatable {
    var viewModel: HomeTabBarViewModel?
    var navigator: Navigator!
    
    init(viewModel: ViewModel?, navigator: Navigator!) {
        self.viewModel = viewModel as? HomeTabBarViewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {

        tabBar.theme.barTintColor = themeService.attribute { $0.primaryDark }

        themeService.typeStream.delay(DispatchTimeInterval.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (theme) in
                switch theme {
                case .light(let color), .dark(let color):
                    self.changeSelectedColor(color.color, iconSelectedColor: color.color)
                }
            }).disposed(by: rx.disposeBag)
        
        tabBar.isHidden = true
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        let input = HomeTabBarViewModel.Input()
        let output = viewModel.transform(input: input)

        output.tabBarItems.delay(.milliseconds(50)).drive(onNext: { [weak self] (tabBarItems) in
            if let strongSelf = self {
                let controllers = tabBarItems.map { $0.getController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by: rx.disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
