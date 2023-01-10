//
//  EndTableViewAllCategoryCell.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit

class EndTableViewAllCategoryCell: UITableViewCell{// UITableViewHeaderFooterView{
    var items: [Item] = []
    var delegate: CollectionViewCellDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "헤더입니다."
        
        return label
    }()
    
    var row: Int = 0
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(EndCollectionViewHorizontalCell.self, forCellWithReuseIdentifier: "EndCollectionViewHorizontalCell")
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setLayout(){
        contentView.addSubview(label)
        addSubview(collectionView)
        
        label.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(text: String){
        label.text = text
    }
}


extension EndTableViewAllCategoryCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: collectionView.frame.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EndCollectionViewHorizontalCell", for: indexPath) as? EndCollectionViewHorizontalCell
        cell?.setData(item: items[indexPath.row])
            
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        
        detailViewController.isbn = items[indexPath.row].isbn
        detailViewController.navigationController?.modalPresentationStyle = .fullScreen
        
        delegate!.pushViewController(detailViewController)
    }
}
