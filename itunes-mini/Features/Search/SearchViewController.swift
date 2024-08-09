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
        
        NetworkManager.shared.requestSearch(api: APIURL.search(term: "카카오"))
            .subscribe { value in
                print("next: \(value.resultCount)")
            } onError: { error in
                print("error: \(error)")
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
    }
    
    override func configureViewController() {
        rootView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        rootView.searchCollectionView.delegate = self
        rootView.searchCollectionView.dataSource = self
        navigationItem.titleView = rootView.searchBar
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.appTitleLabel.text = "sdf"
        cell.companyLabel.text = "sdfdfd"
        cell.ratingLabel.text = "sdf"
        cell.categoryLabel.text = "여행"
        return cell
    }
}
