//
//  MyViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/01.
//

import UIKit
import SnapKit
import SwiftUI

class MyViewController: UIViewController {        
    var dataSource: [MainCollectionViewModel] = []
    var days = ["관심웹툰", "최근 본", "임시저장", "댓글"]
    
    var myPages: [MyPageViewController] = []
      
    var myCurrentPage: Int = 0 {
        didSet {
            bind(pageViewController: myPageViewController, oldValue: oldValue, newValue: myCurrentPage)
        }
    }
    
    lazy var leftCookieButotn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "쿠키샵"
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], for: .normal)
        button.action = #selector(cookieButtonTap)
        button.target = self
        
        return button
    }()
    lazy var rightSearchButotn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        button.action = #selector(searchButtonTap)
        button.target = self
        
        return button
    }()

    //day콜렉션 메뉴
    lazy var dayCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.layer.shadowPath = nil
        collectionView.layer.shadowColor = UIColor.systemGray.cgColor
        collectionView.layer.shadowRadius = 0.5  //반지름 - 범위?
        collectionView.layer.shadowOpacity = 0.4 //투명도 0~1
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0.5) //위치이동 - 아래로 2 이동
        collectionView.clipsToBounds = false    //서브뷰(cell)가 경계를 넘어가도 잘리지 않게
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
//        view.register(MyTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MyTableViewHeader")
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "DayCollectionViewCell")
        
        return collectionView
    }()

    lazy var myPageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    //MARK: override

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setData()
        
        setNavigation()
        setupDataSource()
        setupPageViewControllers()

        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        
        myPageViewController.dataSource = self
        myPageViewController.delegate = self
        view.addSubview(dayCollectionView)
        
        addChild(myPageViewController)
        view.addSubview(myPageViewController.view)
        
        dayCollectionView.snp.makeConstraints{
            //$0.edges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        myPageViewController.view.snp.makeConstraints{
            $0.top.equalTo(dayCollectionView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        myCurrentPage = 0
    }
    
    @objc func cookieButtonTap(){
        
    }
    
    @objc func searchButtonTap(){
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(searchViewConntroller!, animated: true)
    }
}


//MARK: private

extension MyViewController{
    
    private func setData(){
        
        //data
        //userdefualt에서 가저욤
        
//        if let savedData = UserDefaults.standard.object(forKey: "user") as? Foundation.Data{
//            user = try! JSONDecoder().decode(User.self, from: savedData)
//        }
//
//        guard let savedData = UserDefaults.standard.object(forKey: "user") as? Foundation.Data else {return}
//        user = try! JSONDecoder().decode(User.self, from: savedData)
    }
            
    private func setNavigation(){
        navigationController?.isNavigationBarHidden = false
        
        var navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]
        
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationItem.leftBarButtonItem = leftCookieButotn
        self.navigationItem.rightBarButtonItem = rightSearchButotn
        
        self.navigationItem.title = "MY"
    }

    // viewDidLoad에서 호출
    private func setupPageViewControllers() {
        dataSource.forEach { model in
            let vc = MyPageViewController()
            
//            contents.forEach{ item in
//                if model.id == item.day{
//                    vc.contents = item.data
//                }
//            }
            myPages += [vc]
        }
    }
    
    ///dataSource에 MyCollectionViewModel 셋팅
    private func setupDataSource() {
        for i in 0...(days.count - 1) {
            var model = MainCollectionViewModel(id: i)
            model.title = days[i]
            dataSource += [model]
        }
    }
    
    ///현재 페이지가 변경될 때 각 컨트롤(페이지뷰, 콜렉션뷰)에 업데이트
    private func bind(pageViewController: UIPageViewController, oldValue: Int, newValue: Int) {

        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        
        if pageViewController == myPageViewController{
            myPageViewController.setViewControllers(
                [myPages[myCurrentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )

            // pageViewController에서 paging한 경우
            dayCollectionView.selectItem(
                at: IndexPath(item: myCurrentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            
            myPages[oldValue].oldLoad()
        }
    }
    
    ///ColelctionViewCell안에 요소를 tap할 때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
        myCurrentPage = indexPath.item
    }
    
    @objc func setRightButtonTab(){
        
    }
}


//MARK: CollectionView Delegate & DataSource

extension MyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/CGFloat(days.count)*2/3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = collectionView.frame.width/CGFloat(days.count)*2/3 * CGFloat(days.count)
        let totalSpacingWidth = 10.0 * CGFloat(days.count - 1)

        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: leftInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didTapCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell
        cell?.model = dataSource[indexPath.item]

        return cell ?? UICollectionViewCell()
    }
    
}


//MARK: PageViewController Delegate & DataSource

extension MyViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    //뒤로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController : UIViewController) -> UIViewController? {
        guard let index = myPages.firstIndex(of: viewController as! MyPageViewController),
        index + 1 < myPages.count   //마지막페이지 이상 넘어가면
        else { return nil }
        return myPages[index + 1]
    }
    
    //앞으로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myPages.firstIndex(of: viewController as! MyPageViewController) else { return nil}
        let previousIndex = index - 1
        if previousIndex < 0{
            return nil
        }
        return myPages[previousIndex]
    }
    
    //현재 페이지 로드가 끝났을 때 호출
    //pageViewController에서 값이 변경될 때 collectionView에도 적용
    //@@@@@@@@@@@위 dataSource에서 처리하면 캐싱이 되어 index값이 모두 불리지 않으므로, delegate에서 따로 처리가 필요 @@@@ <이건 먼소리고 캐싱??
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = myPages.firstIndex(of: currentVC as! MyPageViewController) else { return }
        myCurrentPage = currentIndex
    }
}
