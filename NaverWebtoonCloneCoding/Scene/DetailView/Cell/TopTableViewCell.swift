//
//  TopTableViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/11.
//

import UIKit

class TopTableViewCell: UITableViewCell{
    let QuantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "3개"
        
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "의 미리보기가 있습니다"
        
        return label
    }()
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"rect")
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = UIColor.black.cgColor
        
        return imageView
    }()
    let iconLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"chevron.down")
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [QuantityLabel, titleLabel,
         thumbnailImageView, iconLabel].forEach{
            contentView.addSubview($0)
        }
        
        QuantityLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints{
            $0.top.bottom.equalTo(QuantityLabel)
            $0.leading.equalTo(QuantityLabel.snp.trailing)
        }
        thumbnailImageView.snp.makeConstraints{
            $0.top.bottom.equalTo(QuantityLabel)
            $0.trailing.equalTo(iconLabel.snp.leading).offset(5)
        }
        iconLabel.snp.makeConstraints{
            $0.top.bottom.equalTo(QuantityLabel)
            $0.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    func setData(oppend: Bool, closedCellQuantity: Int){
        QuantityLabel.isHidden = oppend
        thumbnailImageView.isHidden = oppend
        
        QuantityLabel.text = oppend ? "" : "\(closedCellQuantity)개"
        titleLabel.text = oppend ? "미리보기 접기" : "의 미리보기가 있습니다"
        iconLabel.image = oppend ? UIImage(systemName:"chevron.up") : UIImage(systemName:"chevron.down")
    }
}
