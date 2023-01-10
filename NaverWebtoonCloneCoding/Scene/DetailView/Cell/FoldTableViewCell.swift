//
//  FoldTableViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/11.
//

import UIKit

class FoldTableViewCell: UITableViewCell{
    let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
        imageView.tintColor = .white
        
        return imageView
    }()
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"1.square.fill")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        imageView.alpha = 0.5
        
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "제목"
        
        return label
    }()
    let uploadDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "1일 후 무료"
        
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "쿠키 2개"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [thumbnailImageView, clockImageView, titleLabel,
         uploadDateLabel, priceLabel].forEach{
            contentView.addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(90)
        }
        clockImageView.snp.makeConstraints{
            $0.centerX.centerY.equalTo(thumbnailImageView)
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(thumbnailImageView).offset(-5)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
        }
        uploadDateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        priceLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    func setData(data: DetailData){
        thumbnailImageView.image = UIImage(systemName: data.thumbnailImage)
        titleLabel.text = data.title
        uploadDateLabel.text = "\(Const.DateFormet.getNumberOfDays(to: data.uploadDate))일 후 무료"
    }
}
