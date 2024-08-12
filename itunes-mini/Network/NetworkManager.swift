//
//  NetworkManager.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa



final class NetworkManager {
    
    enum APIError: Error {
        case invalidURL
        case unknownResponse
        case statusError
        case decodingError
    }
    
    let disposeBag = DisposeBag()
    static let shared = NetworkManager()
    private init() {}
    
    //    func requestSearch(api: APIURL) -> Observable<Search> {
    //
    //        var component = URLComponents()
    //        component.scheme = api.scheme
    //        component.host = api.host
    //        component.path = api.path
    //        component.queryItems = api.parameter
    //
    //        let result = Observable<Search>.create { observer in
    //
    //            guard let url = component.url else {
    //                observer.onError(APIError.invalidURL)
    //                return Disposables.create()
    //            }
    //            let defaultSession = URLSession(configuration: .default)
    //            defaultSession.dataTask(with: url) { data, response, error in
    //
    //                if error != nil {
    //                    observer.onError(APIError.unknownResponse)
    //                    return
    //                }
    //                guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
    //                    observer.onError(APIError.statusError)
    //                    return
    //                }
    //                if let data = data,
    //                   let appData = try? JSONDecoder().decode(Search.self, from: data) {
    //                    observer.onNext(appData)
    //                    observer.onCompleted()
    //                } else {
    //
    //                    observer.onError(APIError.decodingError)
    //                }
    //            }.resume()
    //            return Disposables.create()
    //        }
    ////            .debug("아이튠즈")
    //        return result
    //    }
    
    // MARK: Single 버전 -
    func requestSearch(api: APIURL) -> Single<Search> {
        return Single<Search>.create { single in
            var component = URLComponents()
            component.scheme = api.scheme
            component.host = api.host
            component.path = api.path
            component.queryItems = api.parameter
            
            guard let url = component.url else {
                single(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    single(.failure(APIError.statusError))
                    return
                }
                
                guard let data = data else {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                
                do {
                    let appData = try JSONDecoder().decode(Search.self, from: data)
                    single(.success(appData))
                } catch {
                    single(.failure(APIError.decodingError))
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        .debug("아이튠즈")
    }
}
