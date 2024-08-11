//
//  InfoLabel.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import UIKit

final class InfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        textColor = .gray
        font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
