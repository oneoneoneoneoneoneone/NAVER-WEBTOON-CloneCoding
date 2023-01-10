//
//  MyTableViewHeader.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/02.
//

import UIKit

class MyTableViewHeader: UIView{
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 10"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    let leftSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("업데이트순 ▼", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        return button
    }()
    
    let rightSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
        
    }
    
    func setLayout(){
        [leftLabel, leftSortButton, rightSettingButton].forEach{
            addSubview($0)
        }
        
        leftLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Const.Layout.LeadingTrailingInset)
        }
        leftSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(leftLabel.snp.trailing).offset(10)
        }
        rightSettingButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Const.Layout.LeadingTrailingInset)
        }
    }
    
    func setCount(count: Int){
        leftLabel.text = "전체 \(count)"
    }
}
