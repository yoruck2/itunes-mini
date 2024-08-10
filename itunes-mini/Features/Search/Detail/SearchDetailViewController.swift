//
//  SearchDetailViewController.swift
//  itunes-mini
//
//  Created by dopamint on 8/10/24.
//

import UIKit

class SearchDetailViewController: BaseViewController<SearchDetailView> {
    
    var data: Application? = nil {
        didSet {
            print(data)
        }
    }
    
}
