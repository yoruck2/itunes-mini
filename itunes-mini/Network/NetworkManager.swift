//
//  NetworkManager.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import Foundation
import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case decodingError
}

final class NetworkManager {
    
    let disposeBag = DisposeBag()
    static let shared = NetworkManager()
    private init() {}
    
    func requestSearch(api: APIURL) -> Observable<Search> {
        
        var component = URLComponents()
        component.scheme = api.scheme
        component.host = api.host
        component.path = api.path
        component.queryItems = api.parameter
        
        let result = Observable<Search>.create { observer in
            
            guard let url = component.url else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            let defaultSession = URLSession(configuration: .default)
            defaultSession.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                /*
            https://itunes.apple.com/search?parameterkeyvalue&term=%EC%B9%B4%EC%B9%B4%EC%98%A4&country=KR&media=software//            https://itunes.apple.com/search?parameterkeyvalue&query=%EC%B9%B4%EC%B9%B4%EC%98%A4&country=KR&media=software
                 */
                guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    print(response)
                    return
                }
                print(response)
                if let data = data,
                   let appData = try? JSONDecoder().decode(Search.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    observer.onError(APIError.decodingError)
                }
            }.resume()
            return Disposables.create()
        }
            .debug("아이튠즈")
        return result
    }
}
