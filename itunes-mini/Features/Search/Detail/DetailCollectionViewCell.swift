//
//  DetailCollectionViewCell.swift
//  itunes-mini
//
//  Created by dopamint on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailCollectionViewCell: BaseCollectionViewCell {
    
    let screenShotImageView = UIImageView()
    
    
    func setUpCellImage(data:URL) {
        screenShotImageView.kf.setImage(with: data)
    }
    
    override func configureHierarchy() {
        addSubview(screenShotImageView)
    }
    
    override func configureLayout() {
        screenShotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    override func configureView() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
