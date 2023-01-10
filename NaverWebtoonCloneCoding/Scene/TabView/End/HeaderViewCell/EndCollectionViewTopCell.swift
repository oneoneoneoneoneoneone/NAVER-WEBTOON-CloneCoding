//
//  EndCollectionViewTopCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndCollectionViewTopCell: UICollectionViewCell{
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .green
        
        setLayout()
    }
    
    func setLayout(){
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
