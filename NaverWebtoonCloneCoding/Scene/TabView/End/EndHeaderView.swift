//
//  EndHeaderView.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndHeaderView: UIView{//UICollectionReusableView{
    var items: [Item] = []
    var delegate: CollectionViewCellDelegate?
    
    var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 상하간격
//        layout.minimumInteritemSpacing = 0 // 좌우간격
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.register(EndCollectionViewTopCell.self, forCellWithReuseIdentifier: "EndCollectionViewTopCell")
        
        return collectionView
    }()
    
    let label: UILabel = {
        let label = PaddingLabel()
        label.text = "헤더입니다."
        
        return label
    }()
    
    private var circleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()//UICollectionViewCompositionalLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .systemGray6
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(EndCollectionViewHorizontalCircleCell.self, forCellWithReuseIdentifier: "EndCollectionViewHorizontalCircleCell")
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        backgroundColor = .systemGray6
        
        setLayout()
        setData()
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        circleCollectionView.delegate = self
        circleCollectionView.dataSource = self
    }
    
    func setData(){
        let user = Const.Util.getUserData()
        items = Const.Util.getItemsData().suffix(10)//[0...3]
        
        label.text = "\(user!.id)님, 무료 대여권이 생겼어요!"
    }
    
    func setLayout(){
        addSubview(topCollectionView)
        addSubview(label)
        addSubview(circleCollectionView)
        
        topCollectionView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(topCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        circleCollectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
//            $0.edges.equalToSuperview()
        }
    }
}

extension EndHeaderView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView{
            return CGSize(width: collectionView.frame.width, height: 200)
        }
        else{
            return CGSize(width: 60, height: 100)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == topCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//        else{
//            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EndCollectionViewTopCell", for: indexPath) as? EndCollectionViewTopCell
            
            return cell ?? UICollectionViewCell()
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EndCollectionViewHorizontalCircleCell", for: indexPath) as? EndCollectionViewHorizontalCircleCell
            cell?.setData(item: items[indexPath.row])
            
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == circleCollectionView{
            let detailViewController = DetailViewController()
            
            detailViewController.isbn = items[indexPath.row].isbn
            detailViewController.navigationController?.modalPresentationStyle = .fullScreen
            
            delegate!.pushViewController(detailViewController)
        }
    }
}
