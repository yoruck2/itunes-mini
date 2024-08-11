//
//  SearchDetailViewController.swift
//  itunes-mini
//
//  Created by dopamint on 8/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchDetailViewController: BaseViewController<SearchDetailView> {
    
    private let disposeBag = DisposeBag()
    private let viewModel = SearchDetailViewModel()
    
    //init 이 먼저
    init(data: Application) {
        super.init()
//        view = SearchDetailView(data: data)
        rootView.setUpViewData(data: data)
        sendToViewModel(data: data.screenshotUrls)
        rootView.detailCollectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 그 다음 트리거
        viewModel.viewWillAppear.onNext(())
    }
    
    override func bindViewModel() {
        
        viewModel.screenShotUrlList
            .bind(to: rootView.detailCollectionView.rx.items(cellIdentifier: "DetailCollectionViewCell", cellType: DetailCollectionViewCell.self)) {
                row, element, cell in
                cell.setUpCellImage(data: element)
            }
            .disposed(by: disposeBag)
    }
    private func sendToViewModel(data: [String]) {
        viewModel.screenShotData.onNext(data)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
