//
//  SearchView.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchGuideLabel = UILabel().then {
        $0.text = "찾으시는 앱을 검색해주세요."
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy var searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
    
    let searchBar = UISearchBar()
    
    func searchCollectionViewLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 15
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - spacing

        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 0.22)
        layout.scrollDirection = .vertical

        return layout
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(searchCollectionView)
        addSubview(searchGuideLabel)
    }
    override func configureLayout() {
        searchGuideLabel.snp.makeConstraints { make in
            make.center.equalTo(searchCollectionView)
        }
        searchCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
