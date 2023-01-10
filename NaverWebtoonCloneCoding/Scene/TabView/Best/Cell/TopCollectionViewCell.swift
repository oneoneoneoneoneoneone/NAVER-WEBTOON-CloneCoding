//
//  TopCollectionViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/03.
//

import UIKit
import SnapKit
import Kingfisher

class TopCollectionViewCell: UICollectionViewCell{
    var isbn: String = ""
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    let isUpdateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.text = "신규"
        
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [
        imageView, isUpdateLabel, titleLabel, authorLabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(frame.height*1/2)
            //$0.width.equalTo(frame.height/3)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(imageView)
        }
        
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(imageView)
        }

    }
    
    func setData(item: Item){
        isbn = item.isbn
        imageView.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        isUpdateLabel.isHidden = !item.isUpdate
        authorLabel.text = item.author
    }
}
