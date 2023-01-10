//
//  CalendarRankViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/13.
//

import UIKit
import SnapKit

class RankCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        imageView.tintColor = .label
        
        return imageView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "1"
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "제목"
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "설명"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [imageView, rankLabel, titleLabel, descriptionLabel].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
//            $0.height.equalTo(160)
//            $0.width.equalTo(100)
        }
        
        rankLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).inset(20)
            $0.leading.equalTo(imageView).offset(5)
            $0.width.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(5)
            $0.trailing.equalTo(imageView.snp.trailing).offset(5)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(imageView).offset(5)
        }
    }
    
    func setData(item: Item, rank: Int){
        imageView.kf.setImage(with: URL(string: item.image))
        rankLabel.text = "\(rank)"
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

