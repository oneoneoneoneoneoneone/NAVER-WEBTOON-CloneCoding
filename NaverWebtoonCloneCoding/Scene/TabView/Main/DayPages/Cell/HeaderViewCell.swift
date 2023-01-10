//
//  StickyHeaderViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import UIKit
import SnapKit

class HeaderCollectionViewCell: UICollectionViewCell{
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"house")
        imageView.tintColor = .systemBackground
        imageView.backgroundColor = .orange

        return imageView
    }()
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .orange
        stackView.layer.borderWidth = 1
        
        return stackView
    }()
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.text = "분류"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemGray6.cgColor
        label.layer.cornerRadius = 3
        
        return label
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "제목"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(imageView)
        addSubview(stackView)
                  
        [categoryLabel, titleLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.width.equalToSuperview()
            $0.height.width.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).inset(40)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(40)
//            $0.top.equalTo(stackView.snp.top).offset(10)
//            $0.bottom.equalTo(stackView.snp.bottom).offset(10)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setData(item: Item){
        titleLabel.text = item.title
        categoryLabel.text = item.description
    }
}
