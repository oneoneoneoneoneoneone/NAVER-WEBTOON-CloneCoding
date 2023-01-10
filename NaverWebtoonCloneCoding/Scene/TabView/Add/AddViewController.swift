//
//  AddViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/20.
//

import UIKit
import SwiftUI

class AddViewController: UIViewController{
    var data: [AddCollectionViewCellData] = []
    var user: User?
    
    var idLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .label
        label.text = "ID님"
                
        return label
    }()
    
    var idButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("로그인계정설정>", for: .normal)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    var cookieView: UIView = {
        var view = UIView()
//        view.axis = .horizontal
//        view.alignment = .center //axis 반대방향
//        view.distribution = .fillProportionally   //axis 방향
//        view.spacing = 8
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    var cookieIcon: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: "cup.and.saucer.fill")
        
        return image
    }()
    var cookieLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = "내 쿠키"
        
        return label
    }()
    var cookieQtyLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.textColor = .green
        label.text = "0개"
        
        return label
    }()
    var cookieButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle("충전하기", for: .normal)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    lazy var menuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width/5, height: view.frame.width/5)
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(menuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setNavigation()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        idButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(IdButtonTab)))
        cookieButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CookieButtonTab)))
        
        data = [AddCollectionViewCellData(icon: "magnifyingglass", title: "검색"),//, action: SearchButtonTab),
                AddCollectionViewCellData(icon: "cup.and.saucer", title: "쿠키오븐"),//, action: showResultAlert(),
                AddCollectionViewCellData(icon: "rectangle.3.group.bubble.left", title: "갯짤"),//, action: showResultAlert),
                AddCollectionViewCellData(icon: "p.square", title: "PLAY"),//, action: showResultAlert),
                AddCollectionViewCellData(icon: "megaphone", title: "공지사항"),//, action: showResultAlert),
                AddCollectionViewCellData(icon: "gearshape", title: "설정")//, action: showResultAlert)
                ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = Const.Util.getUserData()
        
        idLabel.text = user?.id
        cookieQtyLabel.text = "\(user?.cookieQty ?? 0)개"
    }
    
    func setNavigation(){
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "더보기"
    }
    
    func setLayout(){
        [idLabel, idButton,
         cookieView, menuCollectionView].forEach{
            view.addSubview($0)
        }
        
        [cookieIcon, cookieLabel, cookieQtyLabel, cookieButton].forEach{
            cookieView.addSubview($0)
        }
        
        idLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }
        idButton.snp.makeConstraints{
            $0.top.equalTo(idLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        cookieView.snp.makeConstraints{
            $0.top.equalTo(idButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        cookieIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        cookieLabel.snp.makeConstraints{
            $0.leading.equalTo(cookieIcon.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
        cookieQtyLabel.snp.makeConstraints{
            $0.leading.equalTo(cookieLabel.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
        cookieButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        menuCollectionView.snp.makeConstraints{
            $0.top.equalTo(cookieView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
    }
    func showResultAlert(title: String){
        present(Const.Alert.getDefaultAlert(title: title), animated:  true)
    }
    
    @objc func IdButtonTab(){
        self.showResultAlert(title: "로그인계정설정")
    }
    
    @objc func CookieButtonTab(){
        self.showResultAlert(title: "충전하기")
    }
    
    @objc func SearchButtonTab(){
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(searchViewConntroller!, animated: true)
    }
    
}


extension AddViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch data[indexPath.row].title{
        case "검색": SearchButtonTab()
            default:  self.showResultAlert(title: data[indexPath.row].title)
        }
    }
}

extension AddViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCollectionViewCell", for: indexPath) as? menuCollectionViewCell
        cell?.setData(data: data[indexPath.row])
                
        return cell ?? UICollectionViewCell()
    }
    
    
}
