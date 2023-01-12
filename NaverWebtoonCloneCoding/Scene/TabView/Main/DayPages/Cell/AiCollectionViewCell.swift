//
//  CalendarAiViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/13.
//

import UIKit
import SnapKit

class AiCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.cornerRadius = 5
        imageView.tintColor = .label
        imageView.clipsToBounds = true
        
        return imageView
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
        label.text = "설명"
        label.numberOfLines = 2
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [imageView, titleLabel, descriptionLabel].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
            //$0.height.equalTo(160)
            //$0.width.equalTo(100)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(imageView)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(imageView)
        }
    }
    
    func setData(item: Item){
        imageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

