//
//  downloadButton.swift
//  itunes-mini
//
//  Created by dopamint on 8/11/24.
//

import UIKit

class DownloadButton: UIButton {
    
    init(_ text: String, style: UIButton.Configuration) {
        super.init(frame: .zero)
        configuration = style
        configuration?.cornerStyle = .capsule
        
        if style == .filled() {
            configuration?.baseForegroundColor = UIColor.white
        } else if style == .gray() {
            configuration?.baseForegroundColor = UIColor.systemBlue
        }
        var title = AttributedString(text)
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        configuration?.attributedTitle = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
