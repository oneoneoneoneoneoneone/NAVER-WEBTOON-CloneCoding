//
//  UpdateCollectionViewCell.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/19.
//

import UIKit
import SnapKit

class UpdateCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        imageView.tintColor = .label
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "새 이야기 10+"
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "제목"
        
        return label
    }()
    
    let isUpdateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.text = "UP"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 5
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.text = "제목"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [imageView, descriptionLabel, titleLabel, isUpdateLabel, authorLabel].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(5)
            $0.trailing.equalTo(isUpdateLabel.snp.leading)
        }
        descriptionLabel.snp.makeConstraints{
            $0.bottom.equalTo(titleLabel.snp.top).offset(-5)
            $0.leading.equalTo(imageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(5)
        }
        isUpdateLabel.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(5)
            $0.width.equalTo(30)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(imageView.snp.trailing).offset(5)
        }
    }
    
    func setData(item: Item){
        imageView.kf.setImage(with: URL(string: item.image))
        //descriptionLabel.text = item.description
        titleLabel.text = item.title
        isUpdateLabel.isHidden = !item.isUpdate
        authorLabel.text = item.author
    }
}

