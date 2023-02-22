//
//  MainViewController.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/09/21.
//

import UIKit
import SnapKit
import SwiftUI
import ScalingHeaderScrollView

class MainViewController: UIViewController {
    final var statusBarMargin: CGFloat = 22.0
    final var sortStandard = ["인기순", "업데이트순", "별점순"]
    final var days = ["신작", "월", "화", "수", "목", "금", "토", "일", "매일+", "완결"]
    final var bannars = [Bannar(title: "최고의 작품 추천합니다.", description: "지금보러가기", category: "웹툰", imageName: "book_banner3"),
               Bannar(title: "최고의 작품 추천바랍니다.", description: "설명", category: "투표", imageName: "book_banner4"),
               Bannar(title: "쿠키를 충전하십시오", description: "설명", category: "광고", imageName: "book_banner5")]
    
    var user: User?
    var contents: [Content] = []
    var dataSource: [MainCollectionViewModel] = []
    
    var topPages: [MainTopPageViewController] = []
    var dayPages: [MainDayPageViewController] = []
    
    private var pageViewHeightConstraint: NSLayoutConstraint?
    
    var currentStandard = 0
    var dayCurrentPage: Int = 0 {
        didSet {
            bind(pageViewController: dayPageViewController, oldValue: oldValue, newValue: dayCurrentPage, animated: true)
        }
    }

    //navigation
    var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cup.and.saucer", withConfiguration: UIImage.SymbolConfiguration(weight: .regular)), for: .normal)
        button.isUserInteractionEnabled = true
        button.layer.zPosition = 1
        
        
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
        button.layer.zPosition = 1
        
        return button
    }()
    
    var centerView: UIView = {
        let view = UIView()
        view.tintColor = .label

        return view
    }()
        
    lazy var centerLeftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("◀︎", for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(centerLeftButtonTap), for: .touchUpInside)

        button.sizeToFit()

        return button
    }()

    lazy var centerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("인기순", for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(centerButtonTap), for: .touchUpInside)
        button.sizeToFit()

        return button
    }()

    lazy var centerRightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("▶︎", for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(centerRightButtonTap), for: .touchUpInside)
        button.sizeToFit()

        return button
    }()
    
    //
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 상하간격
//        layout.minimumInteritemSpacing = 0 // 좌우간격
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.register(MainTopPageViewController.self, forCellWithReuseIdentifier: "MainTopPageViewController")
        
        return collectionView
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

        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "DayCollectionViewCell")

        return collectionView
    }()

    lazy var dayPageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    //MARK: override

    override func viewDidLoad() {
        super.viewDidLoad()

        login()
        setData(standard: currentStandard)

        setNavigation()
        setLayout()
        setupDataSource()
        setupPageViewControllers()
        
        scrollView.delegate = self
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self

        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self

        dayPageViewController.dataSource = self
        dayPageViewController.delegate = self

        //페이지 초기화 - 현재 요일 보여줌
//        topCurrentPage = 0
        dayCurrentPage = Calendar.current.component(.weekday, from: Date())// - 1
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let nv = self.navigationController as! MainNavigationView
        
        if scrollView.contentOffset.y > Const.Size.HeaderMinHeight{// .setNavigationViewHidden(false)//, animated: false)
            nv.setNavigationViewHidden(hidden: false)
            self.navigationController?.navigationBar.layer.position.y = self.view.safeAreaInsets.top - statusBarMargin
            
        }
        else{
            nv.setNavigationViewHidden(hidden: true)
//            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.layer.position.y = -statusBarMargin
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let nv = self.navigationController as! MainNavigationView
        
        nv.setNavigationViewHidden(hidden: true)
    }
}


//MARK: private

extension MainViewController{
    private func login(){
        user = Const.Util.getUserData()

        if user == nil {
            user = User(id: "hana", cookieQty: 10, likeItems: [])

            Const.Util.setUserData(data: user)
        }
    }

    private func setLayout(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addChild(dayPageViewController)
        
        [topCollectionView, dayPageViewController.view, dayCollectionView].forEach{
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        topCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()//-91)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        dayCollectionView.snp.makeConstraints{
            $0.top.equalTo(topCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }

        dayPageViewController.view.snp.makeConstraints{
            $0.top.equalTo(dayCollectionView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pageViewHeightConstraint = dayPageViewController.view.heightAnchor.constraint(equalToConstant: 250)
        pageViewHeightConstraint?.isActive = true

        [centerButton, centerLeftButton, centerRightButton].forEach{
            centerView.addSubview($0)
        }
        
        //uiview 터치가 안되서 크기를 줌
        self.navigationItem.titleView?.snp.makeConstraints{
            $0.width.height.equalTo(200)
        }

        centerButton.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
        centerLeftButton.snp.makeConstraints{
            $0.trailing.equalTo(centerButton.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }
        centerRightButton.snp.makeConstraints{
            $0.leading.equalTo(centerButton.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
    }

    private func setNavigation(){

//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.backgroundColor = .systemBackground
//        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .light)]

//        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationItem.titleView = centerView
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setData(standard: Int){
        var items = Const.Util.getItemsData()

        switch standard{
        case 0:
            items = items.sorted(by: {$0.like > $1.like})
        case 1:
            items = items.sorted(by: {$0.recentUploadDate < $1.recentUploadDate})
        case 2:
            items = items.sorted(by: {$0.score > $1.score})
        default:
            break
        }

        days.forEach { day in// for day in 0..<days.count {
            var calenderContent: [CalendarContent] = []

            calenderContent.append(CalendarContent(sectionType: .basic, contentItem: items.filter{$0.updateDay == day}))
            calenderContent.append(CalendarContent(sectionType: .ai, contentItem: items.filter{$0.updateDay == day}))
            calenderContent.append(CalendarContent(sectionType: .rank, contentItem: items.filter{$0.updateDay == day}))
            calenderContent.append(CalendarContent(sectionType: .update, contentItem: items.filter{$0.updateDay == day}))

            contents.append(Content(day: day, data: calenderContent))
        }
    }

    // viewDidLoad에서 호출
    private func setupPageViewControllers() {
        dayPages = []

        dataSource.forEach { model in
            let vc = MainDayPageViewController()
            vc.viewDidLoad()
            vc.id = user!.id
            vc.randomTitle = user?.likeItems.randomElement()?.title ?? ""

            contents.forEach{ item in
                if model.title == item.day{
                    vc.contents = item.data
                }
            }
            dayPages += [vc]
//            vc.reload()
        }
    }

    ///dataSource에 MyCollectionViewModel 셋팅
    private func setupDataSource() {
        for i in 0...(days.count - 1) {
            var model = MainCollectionViewModel(id: i)
            model.title = days[i]
            dataSource += [model]
        }
            
//        let arr = ["신작", "일", "월", "화", "수", "목", "금", "토", "매일+", "완결"]
////        for i in 0...[(days.count - 1) {
//        arr.forEach{str in
//            var model = MainCollectionViewModel(id: arr.firstIndex(of: str)!)
//            model.title = str//days[arr.firstIndex(of: str)!]
//            dataSource += [model]
//        }
    }

    ///현재 페이지가 변경될 때 각 컨트롤(페이지뷰, 콜렉션뷰)에 업데이트
    private func bind(pageViewController: UIPageViewController, oldValue: Int, newValue: Int, animated: Bool) {
        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse

        if pageViewController == dayPageViewController{
            if oldValue == newValue{
                dayPageViewController.setViewControllers(
                    [dayPages[dayCurrentPage]],
                    direction: direction,
                    animated: animated,
                    completion: nil)
                
                return
            }
            let count = dayPages[dayCurrentPage].contents.first?.contentItem.count ?? 0
            
            if count > 0{
                pageViewHeightConstraint?.constant = CGFloat(3*60 + 215*2 + 130*(count > 3 ? 3 : count) + ((count-1)/3 + 1) * 210)
                
//                    pageViewHeightConstraint?.constant = CGFloat(
//                        Const.Size.headerCellHieght*3 +
//                        Const.Size.aiCellHieght*2 +
//                        Const.Size.updateCellHieght*a +
//                        a*Const.Size.basicCellHieght   // ((count-1)/3 + 1)*
            }
            else{
                pageViewHeightConstraint?.constant = CGFloat(3*60 + 210)
            }
                
            dayPageViewController.setViewControllers(
                [dayPages[dayCurrentPage]],
                direction: direction,
                animated: animated,
                completion: nil)
                        
            // pageViewController에서 paging한 경우
            dayCollectionView.selectItem(
                at: IndexPath(item: dayCurrentPage, section: 0), animated: animated, scrollPosition: .centeredHorizontally)
            
            if scrollView.contentOffset.y > 0{
                scrollView.contentOffset.y = 200 - self.view.safeAreaInsets.top
            }
//            dayPages[oldValue].oldLoad()
//            dayPages[newValue].newLoad()
        }
    }

    ///ColelctionViewCell안에 요소를 tap할 때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
        dayCurrentPage = indexPath.item
    }

    func setSortStandard(curr: Int){
        currentStandard = curr
        centerButton.setTitle(sortStandard[currentStandard], for: .normal)

        setData(standard: currentStandard)
        setupPageViewControllers()
        bind(pageViewController: dayPageViewController, oldValue: dayCurrentPage, newValue: dayCurrentPage, animated: false)
    }

    @objc func centerButtonTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        sortStandard.forEach{ str in
            alert.addAction(UIAlertAction(title: "\(str)\(currentStandard == sortStandard.firstIndex(of: str) ? " ✓" : "")", style: .default, handler: {_ in
                self.setSortStandard(curr: self.sortStandard.firstIndex(of: str)!)
            }))
        }

        alert.addAction(UIAlertAction(title: "취소", style: .cancel))

        present(alert, animated: true)
    }

    @objc func centerLeftButtonTap(){
        if currentStandard == 0 {return}

        currentStandard -= 1

        setSortStandard(curr: currentStandard)
    }

    @objc func centerRightButtonTap(){
        if currentStandard == sortStandard.count - 1 {return}

        currentStandard += 1

        setSortStandard(curr: currentStandard)
    }
}


//MARK: CollectionView Delegate & DataSource

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView{
            return bannars.count
        }
        else{
            return days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        else{
            return CGSize(width: collectionView.frame.width/CGFloat(days.count), height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainTopPageViewController", for: indexPath) as? MainTopPageViewController
            cell?.setData(bannar: bannars[indexPath.row])
            
            return cell ?? UICollectionViewCell()
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell
            cell?.model = dataSource[indexPath.item]
            
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCollectionView{
            return
        }
        self.didTapCell(at: indexPath)
    }
}


//MARK: PageViewController Delegate & DataSource

extension MainViewController: UIPageViewControllerDataSource{
    //뒤로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController : UIViewController) -> UIViewController? {
        if pageViewController == dayPageViewController {
            guard let index = dayPages.firstIndex(of: viewController as! MainDayPageViewController),
            index + 1 < dayPages.count   //마지막페이지 이상 넘어가면
            else { return nil }
            return dayPages[index + 1]
        }
        return UIViewController()
    }
    //앞으로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageViewController == dayPageViewController {
            guard let index = dayPages.firstIndex(of: viewController as! MainDayPageViewController) else { return nil}
            let previousIndex = index - 1
            if previousIndex < 0{
                return nil
            }
            return dayPages[previousIndex]
        }
        return UIViewController()
    }
}

extension MainViewController: UIPageViewControllerDelegate{
    //현재 페이지 로드가 끝났을 때 호출
    //pageViewController에서 값이 변경될 때 collectionView에도 적용
    //@@@@@@@@@@@위 dataSource에서 처리하면 캐싱이 되어 index값이 모두 불리지 않으므로, delegate에서 따로 처리가 필요 @@@@ <이건 먼소리고 캐싱??
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if pageViewController == dayPageViewController {
            guard let currentVC = pageViewController.viewControllers?.first,
                  let currentIndex = dayPages.firstIndex(of: currentVC as! MainDayPageViewController) else { return }
            dayCurrentPage = currentIndex
        }
    }
}


//MARK: UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0{
            scrollView.contentOffset.y = 0

            return
        }

        //iphone 14
        //view.safeAreaInsets.bottom = 83 ?
        //view.safeAreaInsets.top = 91 ?
        //navigationController?.navigationBar.layer.position.y 안보이는 높이 = -22 // 0은 찔끔 보임..
        //navigationController?.navigationBar.frame.height = 44
        //HeaderMaxHeight = view.safeAreaInsets.top - 22 = 69
        //view.window?.windowScene?.statusBarManager?.statusBarFrame.height = 47
        //self.navigationController?.navigationBar.layer.position.y = 47.0
        
        //iphone 14 Pro
        //view.safeAreaInsets.top = 97.66666666666667
        //view.window?.windowScene?.statusBarManager?.statusBarFrame.height = 54
        //self.navigationController?.navigationBar.layer.position.y = 53.6
        

        if scrollView.contentOffset.y > 200 - view.safeAreaInsets.top{
            dayCollectionView.frame.origin.y = scrollView.contentOffset.y + view.safeAreaInsets.top
            
            
            let nv = self.navigationController as! MainNavigationView
            
            nv.setNavigationViewHidden(hidden: false)
//            navigationController?.setNavigationBarHidden(false ,animated: false)
        }
        else{
            dayCollectionView.frame.origin.y = 200// - statusBarHeight
            
            let nv = self.navigationController as! MainNavigationView
            
            nv.setNavigationViewHidden(hidden: true)
//            navigationController?.setNavigationBarHidden(true ,animated: false)
        }

        var headerConstant = scrollView.contentOffset.y - statusBarMargin
        
        headerConstant = headerConstant > view.safeAreaInsets.top - statusBarMargin ? view.safeAreaInsets.top - statusBarMargin : (headerConstant - Const.Size.HeaderMinHeight)
        
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.navigationBar.layer.position.y = headerConstant// < -15 ? -22 : headerConstant
//        }, completion: nil)

    }
    


    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate{ //가동범위를 넘겼는지 여부. 불필요한 스크롤 여백 제거
            return
        }
        if scrollView.contentOffset.y <= 0{
            scrollView.contentOffset.y = 0

            return
        }

        let headerConstant = scrollView.contentOffset.y


        if headerConstant >= Const.Size.HeaderMinHeight && headerConstant < 200 - view.safeAreaInsets.top{
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                scrollView.contentOffset.y = 200 - self.view.safeAreaInsets.top
                
                let nv = self.navigationController as! MainNavigationView
                
                nv.setNavigationViewHidden(hidden: false)
//                self.navigationController?.setNavigationBarHidden(false ,animated: false)
            }, completion: nil)
        }

        
    }
}
