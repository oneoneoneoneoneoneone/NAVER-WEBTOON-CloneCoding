//
//  CustomSearchViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/30.
//

import UIKit

class CustomSearchViewController: UIView{
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목 또는 작가명 검색"
        textField.borderStyle = .line
        textField.textColor = .label
        textField.tintColor = .label
        textField.backgroundColor = .systemBackground
        textField.clearButtonMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        
        return button
    }()
    
    var segmentMenu: UISegmentedControl = {
        let segment = UnderlindSegmentedControl(items: ["전체", "웹툰", "베스트도전"])
        segment.backgroundColor = .systemBackground
        segment.layer.shadowPath = nil
        segment.layer.shadowColor = UIColor.systemGray.cgColor
        segment.layer.shadowRadius = 0  //반지름 - 범위?
        segment.layer.shadowOpacity = 0.4 //투명도 0~1
        segment.layer.shadowOffset = CGSize(width: 0, height: 0.5) //위치이동 - 아래로 2 이동
        segment.clipsToBounds = false    //서브뷰(cell)가 경계를 넘어가도 잘리지 않게
        segment.selectedSegmentIndex = 0
        segment.autoresizesSubviews = true
        segment.isHidden = true
        
        return segment
    }()
    
//    var segmentMenuIsHidden: Bool {
//        get{ return segmentMenu.isHidden}
//        set{ segmentMenu.isHidden = newValue}
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        [textField, cancelButton, segmentMenu].forEach{
            addSubview($0)
        }
        
        textField.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-5)
            $0.height.equalTo(35)
        }
        
        cancelButton.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(40)
        }
        
        segmentMenu.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
