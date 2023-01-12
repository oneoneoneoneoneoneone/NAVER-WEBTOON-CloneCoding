//
//  MainTopPageViewController.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/10/25.
//

import UIKit
import SnapKit

class MainTopPageViewController: UICollectionViewCell{//UIViewController{
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"house")

        return imageView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.backgroundColor = .gray
        stackView.layer.shadowColor = UIColor.gray.cgColor
        stackView.layer.shadowRadius = 2.0  //반지름 - 범위?
        stackView.layer.shadowOpacity = 1.0 //투명도 0~1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 1) //위치이동 - 아래로 2 이동
        
        return stackView
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.text = "분류"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemGray6.cgColor
        label.layer.cornerRadius = 4
        
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "제목"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
        addSubview(imageView)
        addSubview(stackView)
                  
        [categoryLabel, titleLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
//            $0.height.equalTo(150)
//            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).inset(40)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
//        categoryLabel.snp.makeConstraints{
//            $0.leading.top.bottom.equalToSuperview().inset(10)
//            $0.width.equalTo(40)
////            $0.top.equalTo(stackView.snp.top).offset(10)
////            $0.bottom.equalTo(stackView.snp.bottom).offset(10)
//            $0.centerY.equalToSuperview()
//        }
//        titleLabel.snp.makeConstraints{
//            $0.leading.equalTo(categoryLabel.snp.trailing).offset(10)
//            $0.centerY.equalToSuperview()
//        }
    }
    
    func setData(bannar: Bannar){
        imageView.image = UIImage(named: bannar.imageName)
        categoryLabel.text = bannar.category
        titleLabel.text = bannar.title
    }
}
