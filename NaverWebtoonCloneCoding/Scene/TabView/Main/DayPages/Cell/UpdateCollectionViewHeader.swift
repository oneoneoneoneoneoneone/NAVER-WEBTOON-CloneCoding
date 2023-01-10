//
//  UpdateCollectionViewHeader.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/21.
//

import UIKit
import SnapKit

class UpdateCollectionViewHeader: UICollectionReusableView{
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        label.text = "@@님`~~~~~~~~~~~~~~~~~~~~~"
        
        return label
    }()
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [titleLabel, rightButton].forEach{
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalTo(rightButton.snp.leading).offset(5)
            $0.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

