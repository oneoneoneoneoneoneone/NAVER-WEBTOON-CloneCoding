//
//  menuCollectionViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/21.
//

import UIKit
import SnapKit

class menuCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .thin)

        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "검색"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [imageView, titleLabel].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(frame.width/2)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setData(data: AddCollectionViewCellData){
        imageView.image = UIImage(systemName: data.icon)
        titleLabel.text = data.title
    }
}

