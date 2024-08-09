//
//  searchCollectionViewCell.swift
//  itunes-mini
//
//  Created by dopamint on 8/9/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class SearchCollectionViewCell: BaseCollectionViewCell {

    let appStackView = UIStackView().then {
        $0.spacing = 5
        $0.distribution = .fillProportionally
        $0.alignment = .center
    }
    let appIconImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "star")
    }
    let appTitleLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    let downloadButton = UIButton().then {
        var configuration = UIButton.Configuration.gray()
        configuration.cornerStyle = .capsule
        configuration.baseForegroundColor = UIColor.systemBlue
        var text = AttributedString("받기")
        text.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        configuration.attributedTitle = text
        $0.configuration = configuration
    }
    
    let infoStackView = UIStackView().then {
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    let ratingLabel = InfoLabel()
    let companyLabel = InfoLabel()
    let categoryLabel = InfoLabel()
    
    func setupCellData(data: Search) {
//        appIconImageView.kf.setImage(with: Source?)
    }
    
    override func configureHierarchy() {
        addSubview(appStackView)
        appStackView.addArrangedSubview(appIconImageView)
        appStackView.addArrangedSubview(appTitleLabel)
        appStackView.addArrangedSubview(downloadButton)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(ratingLabel)
        infoStackView.addArrangedSubview(companyLabel)
        infoStackView.addArrangedSubview(categoryLabel)
    }
    
    override func configureLayout() {
        appStackView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(60)
        }
        appIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        appTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        downloadButton.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(appStackView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
