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

    private let appStackView = UIStackView().then {
        $0.spacing = 5
        $0.distribution = .equalCentering
        $0.alignment = .center
    }
    private let appIconImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "star")
    }
    private let appTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    private let downloadButton = DownloadButton("받기", style: .gray())
    
    private let infoStackView = UIStackView().then {
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    private let ratingLabel = InfoLabel()
    private let companyLabel = InfoLabel()
    private let categoryLabel = InfoLabel()
    
    func setupCellData(data: Application) {
        let url = URL(string: data.artworkUrl60)
        appIconImageView.kf.setImage(with: url)
        appTitleLabel.text = data.trackName
        
        // TODO: 별은 init 시점에 미리 만들어두고 통신 받았을떄 평점 append는 안되나??
        let attachmentImage = NSTextAttachment()
        attachmentImage.image = UIImage(systemName: "star.fill")?.withTintColor(.systemBlue)
        attachmentImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(attachment: attachmentImage))
        let ratingString = NSAttributedString(
            string: String(format: " %.1f", data.averageUserRating),
            attributes: [
                .baselineOffset: 4, // 텍스트의 베이스라인 조정
                .font: UIFont.systemFont(ofSize: 16) // 폰트 크기 지정
            ]
        )
        attributedString.append(ratingString)
        ratingLabel.attributedText = attributedString
        
        companyLabel.text = data.artistName
        categoryLabel.text = data.genres.first
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
