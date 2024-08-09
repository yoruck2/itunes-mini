//
//  BaseViewController.swift
//  Photofolio
//
//  Created by dopamint on 7/22/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }

    override func loadView() {
        view = rootView
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureNavigationBar()
        configureViewController()
    }
    
    func configureViewController() {}
    func bindViewModel() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

