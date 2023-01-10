//
//  DetailTableViewCell.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/11/09.
//

import UIKit

class ListTableViewCell: UITableViewCell{
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
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
        label.font = .systemFont(ofSize: 8, weight: .medium)
        label.textAlignment = .center
        label.text = "UP"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 5
        
        return label
    }()
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "★8.99"
        
        return label
    }()
    let uploadDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "22.11.08"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [thumbnailImageView, titleLabel, isUpdateLabel,
         scoreLabel, uploadDateLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(90)
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(thumbnailImageView).offset(-5)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
        }
        isUpdateLabel.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(18)
            $0.height.equalTo(11)
        }
        scoreLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        uploadDateLabel.snp.makeConstraints{
            $0.top.equalTo(scoreLabel)
            $0.leading.equalTo(scoreLabel.snp.trailing).offset(5)
        }
        
    }
    
    func setData(data: DetailData){
        thumbnailImageView.image = UIImage(systemName: data.thumbnailImage)
        titleLabel.text = data.title
        isUpdateLabel.isHidden = Const.DateFormet.getNumberOfDays(from: data.uploadDate, to: Date.now) != 0// data.uploadDate != Const.DateFormet.setDateFormet(date: Date.now)
        scoreLabel.text = "★\(data.score)"
        uploadDateLabel.text =  Const.DateFormet.setDateToString(date: data.uploadDate)
    }
}
