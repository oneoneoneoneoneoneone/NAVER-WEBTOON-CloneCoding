//
//  ResultTableViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/25.
//

import UIKit

class ResultTableViewCell: UITableViewCell{
    let thumbnailImageView: UIImageView = {
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
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "작가"
        
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
        
        [thumbnailImageView, titleLabel, authorLabel, scoreLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(90)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(authorLabel.snp.top)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
        }
        authorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel)
        }
        scoreLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        
    }
    
    func setData(item: Item){
        thumbnailImageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        authorLabel.text = item.author
        scoreLabel.text = "★\(item.score)"
    }
}
