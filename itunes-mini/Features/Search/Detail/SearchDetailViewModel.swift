//
//  SearchDetailViewModel.swift
//  itunes-mini
//
//  Created by dopamint on 8/10/24.
//

import Foundation
import RxSwift


class SearchDetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    let viewWillAppear = PublishSubject<Void>()
    let screenShotData = BehaviorSubject<[String]>(value: [])
    
//        var screenShotUrlList: Observable<[URL]>
    var screenShotUrlList = PublishSubject<[URL]>()
    
    init() {
        // 스크린샷 데이터를 url 배열로 변환 뒤 보내주기
//        screenShotUrlList = viewWillAppear
//            .withLatestFrom(screenShotData)
////            .map { strings in strings.compactMap { URL(string: $0) }}
//            .map { strings in strings.compactMap(URL.init) }
////            .share(replay: 1, scope: .whileConnected)
        
        viewWillAppear
            .withLatestFrom(screenShotData)
            .map { strings in strings.compactMap(URL.init) }
            .bind(to: screenShotUrlList)
            .disposed(by: disposeBag)
        
        // 줄이기 전
//        viewWillAppear
//            .bind(with: self) { owner, _ in
//                owner.screenShotData
//                    .map { array in
//                        array.compactMap { URL(string: $0) }
//                    }
//                    .bind(with: self) { owner, value in
//                        owner.screenShotUrlList.onNext(value)
//                    }
//                    .disposed(by: owner.disposeBag)
//            }
//            .disposed(by: disposeBag)
        
    }
}
