//
//  SearchViewModel.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    private let searchResult = PublishSubject<[Application]>()
    private var isSearchResultEmpty = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonClicked: ControlEvent<Void>
        let itemSelected: ControlEvent<Application>
    }
    
    struct Output {
        let searchResultList: PublishSubject<[Application]>
        let isSearchResultEmpty: PublishSubject<Bool>
        let itemSelected: Observable<SearchDetailViewController>
    }
    
    func transform(input: Input) -> Output {
        searchClicked(input.searchButtonClicked , text: input.searchText)
        return Output(searchResultList: searchResult,
                      isSearchResultEmpty: isSearchResultEmpty,
                      itemSelected: selectItem(input.itemSelected))
    }
}

extension SearchViewModel {
    
    private func searchClicked(_ tap: ControlEvent<Void>, text: ControlProperty<String>) {
        
        tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(text)
            .distinctUntilChanged()
            .map { "\($0)" }
            .flatMap { value in
                NetworkManager.shared.requestSearch(api: APIURL.search(term: value))
            }
            .subscribe(with: self) { [weak self] owner, result in
                if result.resultCount == 0 {
                    self?.isSearchResultEmpty.onNext(true)
                } else {
                    self?.isSearchResultEmpty.onNext(false)
                }
                self?.searchResult.onNext(result.results)
            } onError: { owner, error in
                print("\(error)")
            } onCompleted: { owner in
                print("completed")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func selectItem(_ data: ControlEvent<Application>) -> Observable<SearchDetailViewController> {
        data.map {
            let nextVC = SearchDetailViewController()
            nextVC.data = $0
            return nextVC
        }
    }
}
