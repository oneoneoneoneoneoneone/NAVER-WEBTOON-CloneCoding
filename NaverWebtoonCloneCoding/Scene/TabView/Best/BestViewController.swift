//
//  BestViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/03.
//

import UIKit

class BestViewController: UIViewController {
    final var days = ["전체", "순정", "액션", "스포츠", "스릴러", "판타지", "드라마"]
    
    var items: [Item] = []
    var dataSource: [MainCollectionViewModel] = []
    var pages: [BestPageViewController] = []
    
    private var pageViewHeightConstraint: NSLayoutConstraint?
    
    var currentPage: Int = 0 {
        didSet {
            bind(pageViewController: pageViewController, oldValue: oldValue, newValue: currentPage, animated: true)
        }
    }

    lazy var rightSearchButotn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        button.action = #selector(searchButtonTap)
        button.target = self
        
        return button
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let topLabel: UILabel = {
        let label = PaddingLabel()
        label.text = "오늘의 인기 베스트"
        
        return label
    }()
    
    let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        
        collectionView.backgroundColor = .systemBackground
        collectionView.layer.backgroundColor = UIColor.systemBackground.cgColor
        collectionView.layer.shadowPath = nil
        collectionView.layer.shadowColor = UIColor.systemGray.cgColor
        collectionView.layer.shadowRadius = 0.5  //반지름 - 범위?
        collectionView.layer.shadowOpacity = 0.4 //투명도 0~1
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 0.5) //위치이동 - 아래로 2 이동
        collectionView.clipsToBounds = false    //서브뷰(cell)가 경계를 넘어가도 잘리지 않게

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: "TopCollectionViewCell")
        
        return collectionView
    }()
    
    let categoryCollectionView: UICollectionView = {
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
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setLayout()
        setData()
        setupDataSource()
        setupPageViewControllers()
        
        scrollView.delegate = self
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        currentPage = 1
    }
    
    func setLayout(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addChild(pageViewController)
        
        [topLabel, topCollectionView, pageViewController.view, categoryCollectionView].forEach{
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.top.equalToSuperview().inset(91)//view.safeAreaInsets.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        topCollectionView.snp.makeConstraints{
            $0.top.equalTo(topLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.height/5)
        }
        
        categoryCollectionView.snp.makeConstraints{
            //$0.edges.equalToSuperview()
            $0.top.equalTo(topCollectionView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }

        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pageViewHeightConstraint = pageViewController.view.heightAnchor.constraint(equalToConstant: 250)
        pageViewHeightConstraint?.isActive = true
        
    }
    
    func setData(){
        items = Repository.getItemsData()
//        days.forEach { day in// for day in 0..<days.count {
//            var calenderContent: [CalendarContent] = []
//
//            calenderContent.append(CalendarContent(sectionType: .basic, contentItem: items.filter{$0.updateDay == day}))
//            calenderContent.append(CalendarContent(sectionType: .ai, contentItem: items.filter{$0.updateDay == day}))
//            calenderContent.append(CalendarContent(sectionType: .rank, contentItem: items.filter{$0.updateDay == day}))
//            calenderContent.append(CalendarContent(sectionType: .update, contentItem: items.filter{$0.updateDay == day}))
//
//            contents.append(Content(day: day, data: calenderContent))
//        }
    }
    
    private func setNavigation(){
        navigationController?.isNavigationBarHidden = false

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]

        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        self.navigationItem.rightBarButtonItem = rightSearchButotn

        self.navigationItem.title = "베스트도전"
    }
    
    ///dataSource에 MyCollectionViewModel 셋팅
    private func setupDataSource() {
        for i in 0...(days.count - 1) {
            var model = MainCollectionViewModel(id: i)
            model.title = days[i]
            dataSource += [model]
        }
    }
    
    // viewDidLoad에서 호출
    private func setupPageViewControllers() {
        pages = []

        dataSource.forEach { model in
            let vc = BestPageViewController()
            vc.viewDidLoad()
            var tempItem: [Item] = []

            self.items.forEach{ item in
                if model.id == Const.DateFormet.getWeekDay(day: item.updateDay)-1{
                    tempItem.append(item)
                }
            }
            vc.items = tempItem
            pages += [vc]
        }
    }
    
    ///현재 페이지가 변경될 때 각 컨트롤(페이지뷰, 콜렉션뷰)에 업데이트
    private func bind(pageViewController: UIPageViewController, oldValue: Int, newValue: Int, animated: Bool) {
        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse

        if oldValue == newValue{
            return
        }
        
        let count = pages[currentPage].items.count
        pageViewHeightConstraint?.constant = CGFloat(40 + 110 * count)
        
        self.pageViewController.setViewControllers(
            [pages[currentPage]],
            direction: direction,
            animated: animated,
            completion: nil
        )

        // pageViewController에서 paging한 경우
        categoryCollectionView.selectItem(
            at: IndexPath(item: currentPage, section: 0),
            animated: animated,
            scrollPosition: .centeredHorizontally)

        pages[oldValue].oldLoad()
        pages[newValue].newLoad()
    }
    ///ColelctionViewCell안에 요소를 tap할 때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }

    @objc func searchButtonTap(){
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(searchViewConntroller!, animated: true)
    }
}


extension BestViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return days.count
        }
        else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView{
            return CGSize(width: collectionView.frame.width/CGFloat(days.count), height: collectionView.frame.height)
        }
        else{
            return CGSize(width: collectionView.frame.width/CGFloat(3) - 15, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell
            cell?.model = dataSource[indexPath.item]
            
            return cell ?? UICollectionViewCell()
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as? TopCollectionViewCell
            cell?.setData(item: items.randomElement()!)
            
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            self.didTapCell(at: indexPath)
        }
        else{
            let detailViewController = DetailViewController()
            let cell = collectionView.cellForItem(at: indexPath) as? TopCollectionViewCell
            detailViewController.isbn = cell?.isbn
            detailViewController.navigationController?.modalPresentationStyle = .fullScreen

            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

//MARK: PageViewController Delegate & DataSource

extension BestViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    //뒤로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController : UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! BestPageViewController),
        index + 1 < pages.count   //마지막페이지 이상 넘어가면
        else { return nil }
        return pages[index + 1]
    }
    //앞으로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! BestPageViewController) else { return nil}
        let previousIndex = index - 1
        if previousIndex < 0{
            return nil
        }
        return pages[previousIndex]
    }

    //현재 페이지 로드가 끝났을 때 호출
    //pageViewController에서 값이 변경될 때 collectionView에도 적용
    //@@@@@@@@@@@위 dataSource에서 처리하면 캐싱이 되어 index값이 모두 불리지 않으므로, delegate에서 따로 처리가 필요 @@@@ <이건 먼소리고 캐싱??
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentVC as! BestPageViewController) else { return }
        currentPage = currentIndex

    }
}


extension BestViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0{
            scrollView.contentOffset.y = 0

            return
        }

        if scrollView.contentOffset.y > 200 {//}- view.safeAreaInsets.top{
            categoryCollectionView.frame.origin.y = scrollView.contentOffset.y + view.safeAreaInsets.top
        }
        else{
            categoryCollectionView.frame.origin.y = 200 + view.safeAreaInsets.top
        }
    }
}
