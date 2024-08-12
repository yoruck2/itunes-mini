//
//  BaseViewModel.swift
//  itunes-mini
//
//  Created by dopamint on 8/12/24.
//

import Foundation

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
