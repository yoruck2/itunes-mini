//
//  PhotofolioTabBarController.swift
//  Photofolio
//
//  Created by dopamint on 7/22/24.
//

import UIKit


final class ItunesTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayVC = ItunesNavigationController(TodayViewController())
        let gameVC = ItunesNavigationController(GameViewController())
        let applicationVC = ItunesNavigationController(ApplicationViewController())
        let arcadeVC = ItunesNavigationController(ArcadeViewController())
        let searchVC = ItunesNavigationController(SearchViewController())
        
        setViewControllers([todayVC, gameVC, applicationVC, arcadeVC, searchVC], animated: true)
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
//        tabBarController?.selectedIndex = 3
        if let items = tabBar.items {
            items[0].image = UIImage(systemName: "book")
            items[0].title = "투데이"
            items[1].image = UIImage(systemName: "gamecontroller")
            items[1].title = "게임"
            items[2].image = UIImage(systemName: "square.stack.fill")
            items[2].title = "앱"
            items[3].image = UIImage(systemName: "star")
            items[3].title = "즐겨찾기"
            items[4].image = UIImage(systemName: "magnifyingglass")
            items[4].title = "검색"
        }
    }
}
