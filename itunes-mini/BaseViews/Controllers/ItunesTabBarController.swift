//
//  PhotofolioTabBarController.swift
//  Photofolio
//
//  Created by dopamint on 7/22/24.
//

import UIKit


final class ItunesTabBarController: UITabBarController {
    
    private enum Tab: CaseIterable {
            case today, game, application, arcade, search
            
            var viewController: UIViewController {
                let vc: UIViewController
                switch self {
                case .today: vc = TodayViewController()
                case .game: vc = GameViewController()
                case .application: vc = ApplicationViewController()
                case .arcade: vc = ArcadeViewController()
                case .search: vc = SearchViewController()
                }
                return ItunesNavigationController(vc)
            }
            
            var tabBarItem: (image: String, title: String) {
                switch self {
                case .today: return ("book", "투데이")
                case .game: return ("gamecontroller", "게임")
                case .application: return ("square.stack.fill", "앱")
                case .arcade: return ("star", "즐겨찾기")
                case .search: return ("magnifyingglass", "검색")
                }
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViewControllers()
            setupTabBar()
        }
        
        private func setupViewControllers() {
            viewControllers = Tab.allCases.map { $0.viewController }
        }
        
        private func setupTabBar() {
            tabBar.tintColor = .systemBlue
            tabBar.backgroundColor = .white
            selectedIndex = 4
            guard let items = tabBar.items else { return }
            
            for (index, tab) in Tab.allCases.enumerated() {
                let item = items[index]
                item.image = UIImage(systemName: tab.tabBarItem.image)
                item.title = tab.tabBarItem.title
            }
        }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let todayVC = ItunesNavigationController(TodayViewController())
//        let gameVC = ItunesNavigationController(GameViewController())
//        let applicationVC = ItunesNavigationController(ApplicationViewController())
//        let arcadeVC = ItunesNavigationController(ArcadeViewController())
//        let searchVC = ItunesNavigationController(SearchViewController())
//        
//        setViewControllers([todayVC, gameVC, applicationVC, arcadeVC, searchVC], animated: true)
//        tabBar.tintColor = .systemBlue
//        tabBar.backgroundColor = .white
////        tabBarController?.selectedIndex = 3
//        if let items = tabBar.items {
//            items[0].image = UIImage(systemName: "book")
//            items[0].title = "투데이"
//            items[1].image = UIImage(systemName: "gamecontroller")
//            items[1].title = "게임"
//            items[2].image = UIImage(systemName: "square.stack.fill")
//            items[2].title = "앱"
//            items[3].image = UIImage(systemName: "star")
//            items[3].title = "즐겨찾기"
//            items[4].image = UIImage(systemName: "magnifyingglass")
//            items[4].title = "검색"
//        }
//    }
}
