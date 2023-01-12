//
//  MainNavigationView.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import UIKit
import SnapKit
import SwiftUI

class MainNavigationView: UINavigationController{  
    
    var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cup.and.saucer", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
//        button.contentVerticalAlignment = .fill
//        button.contentHorizontalAlignment = .fill
        button.isUserInteractionEnabled = true
        button.sizeToFit()
//        button.layer.zPosition = 1
        
        
        return button
        }()
    
    var leftView: UIView = {
        let view = UIView()
        var label = UILabel()
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.left.fill")
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.text = "무료!"
        label.textColor = .green
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.layer.zPosition = 1
        
        label.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        
        return view
    }()
    
    var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
//        button.contentVerticalAlignment = .fill
//        button.contentHorizontalAlignment = .fill
        button.isUserInteractionEnabled = true
//        button.layer.zPosition = 1
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        leftButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cookieButtonTap)))
        rightButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchButtonTap)))
        
        var navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
        navigationBarAppearance.largeTitleTextAttributes =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
//        
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationBar.isTranslucent = true
        
//        self.navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: animated)
        
        //hidden << 네비게이션 뷰 사용 유무
        //animated << 이게.. 커스텀뷰 아이콘 사용 유무
        
//        if self.topViewController is MainViewController{
        let isMain = topViewController is MainViewController
        self.leftView.subviews.forEach{ $0.isHidden = !isMain }
        self.leftView.isHidden = !isMain
        self.leftButton.isHidden = !isMain
        self.rightButton.isHidden = !isMain
//        }
        if !(self.topViewController is MainViewController){
            leftButton.snp.makeConstraints{
                $0.top.equalTo(navigationBar)
                $0.height.equalTo(navigationBar)
            }
            
            view.bringSubviewToFront(leftButton)
            view.bringSubviewToFront(rightButton)
        }

        
        
//        super.setNavigationBarHidden(hidden, animated: animated)
//
//        if self.topViewController is MainViewController{
//
//            self.leftView.isHidden = hidden
//            self.leftButton.tintColor = hidden ? .white : .label
//            self.rightButton.tintColor = hidden ? .white : .label
//        }
//
//        if self.topViewController is SearchViewController{
//            super.setNavigationBarHidden(hidden, animated: false)
//
//            self.leftView.subviews.forEach{ $0.isHidden = hidden }
//            self.leftView.isHidden = hidden
//            self.leftButton.isHidden = hidden
//            self.rightButton.isHidden = hidden
//
//            leftButton.snp.makeConstraints{
//                $0.top.equalTo(navigationBar)
//                $0.height.equalTo(navigationBar)
//            }
//
//            view.bringSubviewToFront(leftButton)
//            view.bringSubviewToFront(rightButton)
//        }
//
//        if self.topViewController is DetailViewController{
//
//            self.leftView.subviews.forEach{ $0.isHidden = hidden }
//            self.leftView.isHidden = hidden
//            self.leftButton.isHidden = hidden
//            self.rightButton.isHidden = hidden
//
//            leftButton.snp.makeConstraints{
//                $0.top.equalTo(navigationBar)
//                $0.height.equalTo(navigationBar)
//            }
//
//            view.bringSubviewToFront(leftButton)
//            view.bringSubviewToFront(rightButton)
//        }
    }
    
    func setNavigationViewHidden(hidden: Bool){
        self.leftView.isHidden = hidden
        self.leftButton.tintColor = hidden ? .white : .label
        self.rightButton.tintColor = hidden ? .white : .label
    }
    
    func setLayout(){
        [leftButton, leftView, rightButton].forEach{
            view.addSubview($0)
        }

        leftButton.snp.makeConstraints{
            $0.top.equalTo(navigationBar.snp.top)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(navigationBar)
            //$0.edges.equalToSuperview()
        }
        
        leftView.snp.makeConstraints{
            $0.top.equalTo(leftButton)
            $0.leading.equalTo(leftButton.snp.trailing).offset(10)
            $0.height.equalTo(leftButton)
        }

        rightButton.snp.makeConstraints{
            $0.top.equalTo(leftButton)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(leftButton)
        }
    }
}


extension MainNavigationView{
    @objc func cookieButtonTap(){
        
    }
    
    @objc func searchButtonTap(){
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        
        pushViewController(searchViewConntroller!, animated: true)
    }
}


//class CustomNavigationBar: UINavigationBar {
//
//    // NavigationBar height
//    var customHeight : CGFloat = 64
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let y = UIApplication.shared.statusBarFrame.height
//        frame = CGRect(x: frame.origin.x, y:  y, width: frame.size.width, height: customHeight)
//
//        for subview in self.subviews {
//            var stringFromClass = NSStringFromClass(subview.classForCoder)
//            if stringFromClass.contains("BarBackground") {
//                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
//                subview.backgroundColor = self.backgroundColor
//            }
//
//            stringFromClass = NSStringFromClass(subview.classForCoder)
//            if stringFromClass.contains("BarContent") {
//                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight)
//                subview.backgroundColor = self.backgroundColor
//            }
//        }
//    }
//
//}
