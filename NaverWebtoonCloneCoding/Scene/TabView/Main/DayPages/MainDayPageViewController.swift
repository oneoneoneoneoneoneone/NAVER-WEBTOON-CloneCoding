//
//  MainDayPageViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/07.
//

import UIKit
import SnapKit

class MainDayPageViewController: UIViewController{
    final var basicCellHieght: CGFloat = 210
    final var aiCellHieght: CGFloat = 215
    final var updateCellHieght: CGFloat = 120
    final var headerCellHieght: CGFloat = 50

    var contents: [CalendarContent] = []//mainviewcontr

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //Autoresizing - superview가 커지거나 줄어듦에 따라 subview의 크기나 위치를 조정. autolayout에서 같이 사용된다면 충돌이 날 수 있음
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //스크롤뷰안에 콜렉션뷰가 들어가기 때문에 콜렉션뷰 스크롤 방지
        collectionView.isScrollEnabled = false

        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: "BasicCollectionViewCell")
        collectionView.register(AiCollectionViewCell.self, forCellWithReuseIdentifier: "AiCollectionViewCell")
        collectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: "RankCollectionViewCell")
        collectionView.register(UpdateCollectionViewCell.self, forCellWithReuseIdentifier: "UpdateCollectionViewCell")

        collectionView.register(AiCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AiCollectionViewHeader")
        collectionView.register(UpdateCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UpdateCollectionViewHeader")

        return collectionView
    }()
    
    required init()
    {
        super.init(nibName: nil, bundle: nil)
        
        setLayout()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = setCollectionViewLayout()
        self.collectionView.layer.backgroundColor = UIColor.systemBackground.cgColor

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    public func oldLoad(){
//        self.collectionView.contentOffset.y = 0
        
    }

    public func newLoad(){
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        if self.navigationController!.isNavigationBarHidden{
//            self.navigationController?.setNavigationBarHidden(true, animated: false)
//        }else{
//            self.navigationController?.setNavigationBarHidden(false, animated: false)
////                        NotificationCenter.default.post(name: NSNotification.Name("scrollPage"), object: nil)
//        }
    }
    
    public func reload(){
        DispatchQueue.main.async {
            super.reloadInputViews()
            self.collectionView.reloadData()// reloadData()// reloadData()
        }
    }
}


//MARK: Private Method
extension MainDayPageViewController{
    func setLayout(){

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

    }

}


//MARK: CompositionalLayout
extension MainDayPageViewController{
    func setCollectionViewLayout() -> UICollectionViewLayout{
        //UICollectionViewCompositionalLayout(section: section)

        return UICollectionViewCompositionalLayout{[weak self] sectionNumber, Environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}

            switch self.contents[sectionNumber].sectionType{
            case .basic:
                return self.createBasicTypeSection()
            case .ai:
                return self.createAiTypeSection()
            case .rank:
                return self.createAiTypeSection()
            case .update:
                return self.createUpdateTypeSection()
            }
        }
    }

    //Section 설정
    func createBasicTypeSection() -> NSCollectionLayoutSection{
        let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 가로로 나란히 3개의 셀을 볼 수 있는 비율
        let groupFractionalHeightFraction = 1.0 / 3.0 // vertical 세로로 나란히 3개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 3
        let sectionInset: CGFloat = 10

        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemInset, bottom: 0, trailing: itemInset)

        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(basicCellHieght))//groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)

        return section
    }

    func createAiTypeSection() -> NSCollectionLayoutSection{
        let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 가로로 나란히 3개의 셀을 볼 수있는 비율. group에 count 값을 설정하면 의미 없음
        let groupFractionalHeightFraction = 1.0 / 3.0 // vertical 세로로 나란히 3개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 5
        let sectionInset: CGFloat = 10

        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemInset, bottom: 0, trailing: itemInset)

        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(aiCellHieght))//.fractionalHeight(groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])//, count: 3) //count - 한번에 볼 수 있는 cell 수

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)
        section.orthogonalScrollingBehavior = .continuous   //자연스러운 스크롤

        let sectionHeader = self.createSectionHeaader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
    func createUpdateTypeSection() -> NSCollectionLayoutSection{
        let groupFractionalWidthFraction = 4.0 / 5.0 // horizontal 가로로 나란히 3개의 셀을 볼 수 있는 비율
        let groupFractionalHeightFraction = 2.0 / 3.0 // vertical 세로로 나란히 3개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 3
        let sectionInset: CGFloat = 10

        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)

        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidthFraction), heightDimension: .absolute(updateCellHieght * 3))// .fractionalHeight(groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)
        section.orthogonalScrollingBehavior = .continuous

        let sectionHeader = self.createSectionHeaader()
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    func createSectionHeaader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionInset: CGFloat = 10

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(headerCellHieght))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)

        return sectionHeader
    }

}


//MARK: UICollectionViewDataSource
extension MainDayPageViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailViewController = DetailViewController()
        let seletedItem = contents[indexPath.section].contentItem[indexPath.row]
        detailViewController.isbn = seletedItem.isbn
        detailViewController.navigationController?.modalPresentationStyle = .fullScreen

        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return contents[section].contentItem.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch contents[indexPath.section].sectionType{
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCollectionViewCell", for: indexPath) as? BasicCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])

            return cell ?? UICollectionViewCell()

        case .update:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpdateCollectionViewCell", for: indexPath) as? UpdateCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])

            return cell ?? UICollectionViewCell()

        case .ai:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AiCollectionViewCell", for: indexPath) as? AiCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])

            return cell ?? UICollectionViewCell()

        case .rank:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankCollectionViewCell", for: indexPath) as? RankCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row], rank: indexPath.row+1)

            return cell ?? UICollectionViewCell()
        }
    }

    //@@@@섹션 개수 설정 필수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    //헤더뷰 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{

            switch contents[indexPath.section].sectionType{
            case .update:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UpdateCollectionViewHeader", for: indexPath) as? UpdateCollectionViewHeader else { fatalError("Error") }

                headerView.titleLabel.text = "@@님님의 취향 저격 웹툰 신작 놓치지 마쇼"

                return headerView
            case .ai:

                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AiCollectionViewHeader", for: indexPath) as? AiCollectionViewHeader else { fatalError("Error") }

                headerView.iconLabel.text = "Ai"
                headerView.iconLabel.layer.backgroundColor = UIColor.red.cgColor
                headerView.titleLabel.text = "@@님님의 취향 저격 웹툰 Ai가 골라주"

                return headerView
            case .rank:
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AiCollectionViewHeader", for: indexPath) as? AiCollectionViewHeader else { fatalError("Error") }

                headerView.iconLabel.text = "♡"
                headerView.iconLabel.layer.backgroundColor = UIColor.green.cgColor
                headerView.titleLabel.text = "##독자님이 좋아하는 웹툰 랭킹!!!"

                return headerView
            default:
                let headerView = UICollectionReusableView()

                return headerView
            }
        } else {
            return UICollectionReusableView()
        }
    }

}


//MARK: UICollectionViewDelegateFlowLayout

extension MainDayPageViewController: UICollectionViewDelegateFlowLayout {

}

