//
//  BestPageViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/03.
//

import UIKit

class BestPageViewController: UIViewController{
    final var cellHieght: CGFloat = 90
    
    var items: [Item] = []

    lazy var settingView: BestSettingView = {
        let view = BestSettingView()
        view.updateSortButton.addTarget(self, action: #selector(sortButtonTap), for: .touchUpInside)
        view.viewSortButton.addTarget(self, action: #selector(sortButtonTap), for: .touchUpInside)
        view.scoreSortButton.addTarget(self, action: #selector(sortButtonTap), for: .touchUpInside)
        view.titleSortButton.addTarget(self, action: #selector(sortButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false

        collectionView.register(BestControllerCell.self, forCellWithReuseIdentifier: "BestControllerCell")

        return collectionView
    }()
    
    required init()
    {
        super.init(nibName: nil, bundle: nil)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.layer.backgroundColor = UIColor.systemBackground.cgColor

//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        sortButtonTap(settingView.updateSortButton)
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self

//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setLayout(){
        
        [settingView, collectionView].forEach{
            view.addSubview($0)
        }
        
        settingView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(settingView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
//    func setData(standard: Int){
//        switch standard{
//        case 0:
//            items = items.sorted(by: {$0.recentUploadDate > $1.recentUploadDate})
//        case 1:
//            items = items.sorted(by: {$0.like < $1.like})
//        case 2:
//            items = items.sorted(by: {$0.score > $1.score})
//        case 3:
//            items = items.sorted(by: {$0.title > $1.title})
//        default:
//            break
//        }
//
//        settingView.selectedButton(button: sender)
//
//        collectionView.reloadData()
//    }
//
    public func oldLoad(){
        //self.collectionView.contentOffset.y = 0
    }

    public func newLoad(){
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func sortButtonTap(_ sender: UIButton){
        
        switch sender.tag{
        case 0:
            items = items.sorted(by: {$0.recentUploadDate > $1.recentUploadDate})
        case 1:
            items = items.sorted(by: {$0.like > $1.like})
        case 2:
            items = items.sorted(by: {$0.score > $1.score})
        case 3:
            items = items.sorted(by: {$0.title < $1.title})
        default:
            break
        }
        settingView.selectedButton(button: sender)
        
        collectionView.reloadData()
    }
}

extension BestPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: cellHieght)//collectionView.frame.height/CGFloat(3) - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestControllerCell", for: indexPath) as? BestControllerCell
        cell?.setData(item: items[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let seletedItem = items[indexPath.row]
        detailViewController.isbn = seletedItem.isbn
        detailViewController.navigationController?.modalPresentationStyle = .fullScreen

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
