//
//  EndCollectionViewHorizontalCircleCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndCollectionViewHorizontalCircleCell: UICollectionViewCell{
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.cornerRadius = 30
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    func setLayout(){
        
        [thumbnailImageView, titleLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func setData(item: Item){
        thumbnailImageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
//        isUpdateLabel.isHidden = Const.DateFormet.getNumberOfDays(from: item.recentUploadDate, to: Date.now) != 0
//        uploadDateLabel.text = Const.DateFormet.setDateToString(date: item.recentUploadDate)
        //ectLabel.text = ""
    }
    
}
