//
//  BestSettingView.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2023/01/10.
//

import UIKit

class BestSettingView: UIView{
    
    let updateSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("업데이트순", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.tag = 0
        
        return button
    }()
    
    let viewSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("관심순", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.tag = 1
        
        return button
    }()
    
    let scoreSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("별점순", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.tag = 2
        
        return button
    }()
    
    let titleSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("제목순", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.tag = 3
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = UIColor.systemBackground.cgColor
        layer.shadowPath = nil
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowRadius = 0.5  //반지름 - 범위?
        layer.shadowOpacity = 0.4 //투명도 0~1
        layer.shadowOffset = CGSize(width: 0, height: 0.5) //위치이동 - 아래로 2 이동
        clipsToBounds = false    //서브뷰(cell)가 경계를 넘어가도 잘리지 않게
        
        setLayout()
    }
    
    func setLayout(){
        [updateSortButton, viewSortButton, scoreSortButton, titleSortButton].forEach{
            addSubview($0)
        }
        
        updateSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        viewSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(updateSortButton.snp.trailing).offset(10)
        }
        scoreSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(viewSortButton.snp.trailing).offset(10)
        }
        titleSortButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(scoreSortButton.snp.trailing).offset(10)
        }
    }
    
    func selectedButton(button: UIButton){
//        oldButton.setTitleColor(UIColor.gray, for: .normal)
        [updateSortButton, viewSortButton, scoreSortButton, titleSortButton].forEach{
           $0.setTitleColor(UIColor.gray, for: .normal)
        }
        button.setTitleColor(UIColor.green, for: .normal)
    }
    
}
