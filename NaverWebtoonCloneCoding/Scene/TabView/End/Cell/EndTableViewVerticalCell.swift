//
//  EndTableViewVerticalCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit
import Kingfisher

class EndTableViewVerticalCell: UITableViewCell{
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
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
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "설명"
        
        return label
    }()
    let ectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "새 미리보기+"
        
        return label
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderColor = UIColor.systemGray6.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        contentView.clipsToBounds = true
        
        setLayout()
    }
    
    func setLayout(){
        
        [thumbnailImageView, titleLabel, authorLabel,
         descriptionLabel, ectLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(120)
        }
     
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(Const.Layout.LeadingTrailingInset)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            //$0.width.equalTo(size)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(titleLabel)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        ectLabel.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(titleLabel)
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
