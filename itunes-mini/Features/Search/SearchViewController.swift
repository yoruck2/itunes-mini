//
//  SearchViewController.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController<SearchView> {
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewController() {
        rootView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        navigationItem.titleView = rootView.searchBar
    }
    
    override func bindViewModel() {
        
        let input = SearchViewModel.Input(searchText: rootView.searchBar.rx.text.orEmpty, 
                                          searchButtonClicked: rootView.searchBar.rx.searchButtonClicked,
                                          itemSelected: rootView.searchCollectionView.rx.modelSelected(Application.self))
        
        let output = viewModel.transform(input: input)
        
        output.searchResultList
            .bind(to: rootView.searchCollectionView.rx.items(cellIdentifier: "SearchCollectionViewCell", cellType: SearchCollectionViewCell.self)) {
                (row, element, cell) in
                
                cell.setupCellData(data: element)
            }.disposed(by: disposeBag)
        
        output.isSearchResultEmpty
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, value in
                owner.rootView.searchGuideLabel.isHidden = !value
                owner.rootView.searchGuideLabel.text = "검색 결과가 없습니다."
            }.disposed(by: disposeBag)
        
        output.itemSelected
            .bind(with: self) { owner, vc in
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
}
