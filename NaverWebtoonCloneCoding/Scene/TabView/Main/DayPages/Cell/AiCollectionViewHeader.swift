//
//  AiCollectionViewHeader.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/14.
//

import UIKit
import SnapKit

class AiCollectionViewHeader: UICollectionReusableView{
    let iconLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.text = "Ai"
        label.layer.backgroundColor = UIColor.red.cgColor
        label.layer.cornerRadius = 12
        
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        label.text = "@@님이 조아하는\n Ai가 골라준다~~"
        
        return label
    }()
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "exclamationmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray4
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [iconLabel, titleLabel, rightButton].forEach{
            addSubview($0)
        }
        
        iconLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalTo(iconLabel.snp.trailing).offset(5)
            $0.trailing.equalTo(rightButton.snp.leading).offset(5)
            $0.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

