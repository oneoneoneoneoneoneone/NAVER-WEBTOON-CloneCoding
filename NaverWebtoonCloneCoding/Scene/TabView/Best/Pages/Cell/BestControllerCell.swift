//
//  BestControllerCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/03.
//

import UIKit
import SnapKit
import Kingfisher

class BestControllerCell: UICollectionViewCell{
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        
        return imageView
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
        label.font = .systemFont(ofSize: 9, weight: .light)
        label.textAlignment = .center
        label.text = "UP"
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 6
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "작가"
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "설명"
        
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "★8.99"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [
        imageView, titleLabel, isUpdateLabel,
        authorLabel, descriptionLabel, scoreLabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        let str  = titleLabel.text!.dropLast(titleLabel.text!.count > 19 ? titleLabel.text!.count - 19 : 0)
        let size = (str as NSString).size(withAttributes: [NSAttributedString.Key.font : titleLabel.font!]).width   //string, font로 size 구하기
        
        imageView.snp.makeConstraints{
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(120)//frame.height*3/4)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalTo(imageView).offset(size + 10.0)
            $0.width.equalTo(size)
        }
        isUpdateLabel.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.width.equalTo(18)
            $0.height.equalTo(11)
        }
        
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
    }
    
    func setData(item: Item){
        imageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        isUpdateLabel.isHidden = !item.isUpdate
        authorLabel.text = item.author
        descriptionLabel.text = item.description
        scoreLabel.text = "★\(item.score)"
    }
}
