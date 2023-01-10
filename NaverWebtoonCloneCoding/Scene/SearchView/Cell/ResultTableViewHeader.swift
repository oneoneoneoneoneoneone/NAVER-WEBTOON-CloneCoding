//
//  ResultTableViewHeader.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/04.
//

import Foundation
import UIKit

class ResultTableViewHeader: UITableViewHeaderFooterView{
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "웹툰 1"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    private func setLayout(){
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
    }
    
    func setData(menu: String, count: Int){
        titleLabel.text = "\(menu) \(count)"
    }
}
