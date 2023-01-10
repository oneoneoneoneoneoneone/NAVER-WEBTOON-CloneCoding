//
//  MyTableViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/02.
//

import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell{
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
    let uploadDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "22.11.08"
        
        return label
    }()
    let ectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "새 미리보기+"
        
        return label
    }()
    
//    var accessoryButton: UIButton = {
//        let button = UIButton()
//        button.tintColor = .green
//        button.backgroundColor = .blue
//        //버튼 크기설정 (lyout을 잡아주지 않음)
//        button.sizeToFit()
//
//        return button
//    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    func setLayout(){
        
        [thumbnailImageView, titleLabel, isUpdateLabel,
         uploadDateLabel, ectLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(Const.Layout.LeadingTrailingInset)
            $0.width.equalTo(90)
        }
        
        let str  = titleLabel.text!.dropLast(titleLabel.text!.count > 19 ? titleLabel.text!.count - 19 : 0)
        let size = (str as NSString).size(withAttributes: [NSAttributedString.Key.font : titleLabel.font!]).width   //string, font로 size 구하기
                
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(Const.Layout.LeadingTrailingInset)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(thumbnailImageView).offset(size + 10.0)
            $0.width.equalTo(size)
        }
        isUpdateLabel.snp.makeConstraints{
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.width.equalTo(18)
            $0.height.equalTo(11)
        }
        uploadDateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        
        ectLabel.snp.makeConstraints{
            $0.top.equalTo(uploadDateLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    func setData(item: Item){
        thumbnailImageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        isUpdateLabel.isHidden = Const.DateFormet.getNumberOfDays(from: item.recentUploadDate, to: Date.now) != 0
        uploadDateLabel.text = Const.DateFormet.setDateToString(date: item.recentUploadDate)
        //ectLabel.text = ""
    }
}
