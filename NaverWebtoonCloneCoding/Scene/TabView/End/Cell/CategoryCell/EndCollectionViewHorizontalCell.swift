//
//  EndCollectionViewHorizontalCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndCollectionViewHorizontalCell: UICollectionViewCell{
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "제목"
        
        return label
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "작가"
        
        return label
    }()
//    let isUpdateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .red
//        label.font = .systemFont(ofSize: 8, weight: .medium)
//        label.textAlignment = .center
//        label.text = "UP"
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.red.cgColor
//        label.layer.cornerRadius = 5
//
//        return label
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    func setLayout(){
        
        [thumbnailImageView, titleLabel, authorLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(thumbnailImageView)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(thumbnailImageView)
        }
    }
    
    func setData(item: Item){
        thumbnailImageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        authorLabel.text = item.author
//        isUpdateLabel.isHidden = Const.DateFormet.getNumberOfDays(from: item.recentUploadDate, to: Date.now) != 0
//        uploadDateLabel.text = Const.DateFormet.setDateToString(date: item.recentUploadDate)
        //ectLabel.text = ""
    }
    
}
