//
//  SearchViewModel.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
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
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .map { "\($0)" }
            .flatMapLatest { [weak self] value in
                NetworkManager.shared.requestSearch(api: APIURL.search(term: value))
                    .catch { error in
                        print("검색 에러 발생: \(error)")
                        self?.isSearchResultEmpty.onNext(true)
                        return Observable.just(Search(resultCount: 0, results: []))
                    }
            }
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] result in
                        self?.isSearchResultEmpty.onNext(result.resultCount == 0)
                    })
            .map { $0.results }
            .bind(to: searchResult)
            .disposed(by: disposeBag)
        
//        tap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withLatestFrom(text)
//            .filter { !$0.isEmpty }
//            .distinctUntilChanged()
//            .map { "\($0)" }
//            .flatMapLatest { [weak self] value in
//                NetworkManager.shared.requestSearch(api: APIURL.search(term: value))
//                    .catch { error in
//                        print("검색 에러 발생: \(error)")
//                        self?.isSearchResultEmpty.onNext(true)
//                        return Observable.just(Search(resultCount: 0, results: []))
//                    }
//            }
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self) { owner, result in
//                if result.resultCount == 0 {
//                    owner.isSearchResultEmpty.onNext(true)
//                } else {
//                    owner.isSearchResultEmpty.onNext(false)
//                }
//                owner.searchResult.onNext(result.results)
//            }
//            .disposed(by: disposeBag)
    }
    
    
    
    private func selectItem(_ data: ControlEvent<Application>) -> Observable<SearchDetailViewController> {
        data.map {
            let nextVC = SearchDetailViewController(data: $0)
            return nextVC
        }
    }
}
