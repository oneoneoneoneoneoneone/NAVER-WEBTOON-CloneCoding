//
//  EndSettingView.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndSettingView: UIView{
    
    let leftSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("인기순 ▼", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        return button
    }()
    
    let leftCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 장르 ▼", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        return button
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "총 10 작품"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
        
        setLayout()
    }
    
    func setLayout(){
        [leftSortButton, leftCategoryButton, rightLabel].forEach{
            addSubview($0)
        }
        
        leftSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        leftCategoryButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leftSortButton.snp.trailing).offset(10)
        }
        rightLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func setCount(count: Int){
        rightLabel.text = "총 \(count) 작품"
    }
    
}
