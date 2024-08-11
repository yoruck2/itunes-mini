//
//  PhotofolioNavigationController.swift
//  Photofolio
//
//  Created by dopamint on 7/28/24.
//

import UIKit

final class ItunesNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    convenience init(_ rootViewController: UIViewController) {
        self.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
