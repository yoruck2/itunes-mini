//
//  SearchDetailView.swift
//  itunes-mini
//
//  Created by dopamint on 8/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchDetailView: BaseView {
    
    private let scrollView = UIScrollView()
    private let contentView = BaseView()
    
    private let appIconImageView = UIImageView().then {
        $0.layer.borderColor = UIColor(named: "lightGray")?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let appNameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
    }
    private let companyNameLabel = UILabel().then {
        $0.textColor = .gray
    }
    // TODO: filled 로 타이틀 안들어가네.. or 색 바꾸는법
    private let downloadButton = DownloadButton("받기", style: .filled())
    private let whatsNewLabel = UILabel().then {
        $0.text = "새로운 소식"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    private let versionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .gray
    }
    private let releaseNoteTextView = UILabel().then {
        $0.numberOfLines = 0
    }
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: detailCollectionViewLayout())
    
    private func detailCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width * 0.7

        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width * 1.4)
        layout.scrollDirection = .horizontal

        return layout
    }
    
    func setUpViewData(data: Application) {
        let url = URL(string: data.artworkUrl100)
        appIconImageView.kf.setImage(with: url)
        appNameLabel.text = data.trackName
        companyNameLabel.text = data.artistName
        versionLabel.text = "버전 \(data.version)"
        releaseNoteTextView.text = data.releaseNotes
        descriptionLabel.text = data.description
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    convenience init(data: Application) {
//        self.init()
//        let url = URL(string: data.artworkUrl100)
//        appIconImageView.kf.setImage(with: url)
//        appNameLabel.text = data.trackName
//        companyNameLabel.text = data.artistName
//        versionLabel.text = "버전 \(data.version)"
//        releaseNoteTextView.text = data.releaseNotes
//        descriptionLabel.text = data.description
//    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appIconImageView)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(whatsNewLabel)
        contentView.addSubview(versionLabel)
        contentView.addSubview(releaseNoteTextView)
        contentView.addSubview(detailCollectionView)
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(appIconImageView.snp.width)
        }
        
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView).inset(10)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(10)
        }
        companyNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(appNameLabel)
            make.centerY.equalTo(appIconImageView)
        }
        downloadButton.snp.makeConstraints { make in
            make.leading.equalTo(appNameLabel)
            make.bottom.equalTo(appIconImageView)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        whatsNewLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView)
            make.top.equalTo(appIconImageView.snp.bottom).offset(15)
            
        }
        versionLabel.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView)
            make.top.equalTo(whatsNewLabel.snp.bottom).offset(10)
            
        }
        releaseNoteTextView.snp.makeConstraints { make in
            make.leading.equalTo(appIconImageView)
            make.top.equalTo(versionLabel.snp.bottom).offset(10)
            
        }
        detailCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(releaseNoteTextView.snp.bottom).offset(20)
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(detailCollectionView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
