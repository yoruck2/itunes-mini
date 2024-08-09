//
//  SearchView.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    lazy var searchCollectionView: UICollectionView = {
            let layout = self.searchCollectionViewLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            return collectionView
        }()
    let searchBar = UISearchBar()
    
    func searchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 10
        layout.itemSize = CGSize(width: width, height: width * 0.22)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(searchCollectionView)
    }
    override func configureLayout() {
        searchCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
