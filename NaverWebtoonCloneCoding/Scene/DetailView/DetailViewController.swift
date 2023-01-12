//
//  DetailViewController.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2022/11/09.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController{
    var isbn: String?
    var user: User?
    private var item: Item?
    var detailItem: DetailItems?
    var currentPage = 1
    var opened = false
    //미리보기 목록
    var closedCellQuantity = 3
    
    //navigationItem
    //스크롤 내릴 때만 표시할 제목 라벨
    //    let leftLabel: UIBarButtonItem = {
    //        let label = UIBarButtonItem()
    //        label.title = "제목"
    ////        label.isEnabled = false
    //
    //        label.tintColor = .label
    //
    //        return label
    //    }()
    
    lazy var rightLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.setTitle("관심", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame.size = CGSize(width: 70, height: 30)
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(addLike), for: .touchUpInside)
        
        //        let button = UIBarButtonItem(customView: b)
        
        return button
    }()
    var rightAlarmButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "bell.fill") //bell.slash
        button.action = #selector(rightAlarmButtonTap)
        
        return button
    }()
    var rightAlartButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "line.3.horizontal")
        button.action = #selector(rightAlartButtonTap)
        
        return button
    }()
    
    //tableViewHeader
    lazy var headerView: UIView = {
        var headerView = UIView()
        headerView.layer.shadowPath = nil
        headerView.layer.shadowColor = UIColor.systemGray.cgColor
        headerView.layer.shadowRadius = 0.5  //반지름 - 범위?
        headerView.layer.shadowOpacity = 0.4 //투명도 0~1
        headerView.layer.shadowOffset = CGSize(width: 0, height: 0.5) //위치이동 - 아래로 2 이동
        headerView.clipsToBounds = false    //서브뷰(cell)가 경계를 넘어가도 잘리지 않게
        
        return headerView
    }()
    let backgroundView: UIView = {
        var imageView = UIView()
        imageView.backgroundColor = .systemBlue
        
        return imageView
    }()
    let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.layer.zPosition = 1
        
        return imageView
    }()
    let likeLabel: UILabel = {
        var label = PaddingLabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = "+ 관심 999"
        label.layer.cornerRadius = 14
        label.layer.backgroundColor = UIColor.systemBlue.cgColor
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowRadius = 2.0  //반지름 - 범위?
        label.layer.shadowOpacity = 1.0 //투명도 0~1
        label.layer.shadowOffset = CGSize(width: 0, height: 1) //위치이동 - 아래로 2 이동
        label.isUserInteractionEnabled = true
        
        return label
    }()
    let titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "제목"
        
        return label
    }()
    let authorLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "작가"
        label.isUserInteractionEnabled = true
        
        return label
    }()
    let updateDayLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "몇요웹툰"
        
        return label
    }()
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "설명"
        label.numberOfLines = 1
        label.sizeToFit()
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    lazy var publisherLabel: UILabel = {
        var label = PaddingLabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.text = "#태그"
        label.isHidden = true
        label.layer.backgroundColor = UIColor.darkGray.cgColor
        label.layer.cornerRadius = 2
        
        return label
    }()
    
    let iconLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"chevron.down")
        imageView.tintColor = .systemGray
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    //tableView
    let tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(TopTableViewCell.self, forCellReuseIdentifier: "TopTableViewCell")
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        tableView.register(FoldTableViewCell.self, forCellReuseIdentifier: "FoldTableViewCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setLayout()
        setNavigation()
        setData()
        setTableView()
        
        likeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.addLike)))
        authorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.searchAuthor)))
        descriptionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.openedDescription)))
        iconLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailViewController.openedDescription)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.navigationController?.visibleViewController is SearchViewController || self.navigationController?.visibleViewController is WebViewController {
            return
        }
        
        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "")
    }
        
    func setData(){
        user = Const.Util.getUserData()
        item = Const.Util.getItemData(isbn: self.isbn!)
        
        detailItem = Const.Util.getDetailItemsData(isbn: item!.isbn)
        
        if detailItem == nil {
            let detailData = Const.Util.getDetailData(day: item!.updateDay).sorted(by: {$1.uploadDate<$0.uploadDate})
            detailItem = DetailItems(isbn: item!.isbn, title: item!.title, detailData: detailData)
            
            let recentUploadDate =  detailData.filter{$0.uploadDate <= Date.now}.first?.uploadDate
            item!.recentUploadDate = recentUploadDate!
            
            Const.Util.setDetailItemsData(data: detailItem!)
            Const.Util.setItemData(data: item!)
        }
        
        closedCellQuantity = (detailItem?.detailData.filter{$0.uploadDate > Date.now}.count)!
        
        let idx = user?.likeItems.firstIndex(where: {$0.isbn == item?.isbn})
        rightLikeButton.setImage(UIImage(systemName: idx == nil ? "plus.circle" : "checkmark.circle.fill"), for: .normal)
        
        if idx != nil {
            self.navigationItem.rightBarButtonItems?.insert(rightAlarmButton, at: 1)
            if user?.likeItems[idx!].isAlarm ?? true {
                rightAlarmButton.image = UIImage(systemName: "bell.fill") //bell.slash
            }
            else{
                rightAlarmButton.image = UIImage(systemName: "bell.slash")
            }
        }
        
                
        imageView.kf.setImage(with: URL(string: item!.image))
        backgroundView.backgroundColor = imageView.image?.getPixelColor(pos: CGPoint(x: 0, y: 0))
        likeLabel.layer.backgroundColor = imageView.image?.getPixelColor(pos: CGPoint(x: 0, y: 0)).cgColor
        likeLabel.textColor = Const.Color.setColor(color: UIColor(cgColor: likeLabel.layer.backgroundColor!))
        likeLabel.text = "+ 관심 \(Const.Number.setIntToString(number: item!.like))"
        titleLabel.text = item!.title
        authorLabel.text = "\(item!.author)>"
        updateDayLabel.text = " \(item!.updateDay)요웹툰"
        descriptionLabel.text = item!.description
        publisherLabel.text = "#\(item!.publisher)"
    }
    
    func setNavigation(){
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(systemName: "house"), for: .bottom, barMetrics: .default)
        
        self.navigationItem.rightBarButtonItems = [rightAlartButton, UIBarButtonItem(customView: rightLikeButton)]
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "")
        
//        rightLikeButton.target = self
        rightAlartButton.target = self
        rightAlarmButton.target = self
//
//
//
//        var navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.backgroundImage = imageView.image//.backgroundColor = .systemBlue
//        navigationBarAppearance.backgroundImageContentMode = .scaleAspectFill
//        navigationController?.navigationBar.clipsToBounds = true
////
//        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
//        navigationController?.navigationBar.prefersLargeTitles = true

//        navigationController?.navigationBar.layer.zPosition = 3
    }
    
    func setLayout(){
        view.addSubview(tableView)

        [backgroundView, imageView, likeLabel, titleLabel, authorLabel, updateDayLabel, iconLabel, descriptionLabel, publisherLabel].forEach{
            headerView.addSubview($0)
        }
        
        backgroundView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(-90)//.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(-90)//.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(240)
        }
        likeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(imageView).offset(-5)
        }
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        authorLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        updateDayLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel)
            $0.leading.equalTo(authorLabel.snp.trailing).offset(5)
        }
        iconLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(18)
        }
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(iconLabel.snp.leading)
        }
        publisherLabel.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 220)
        tableView.tableHeaderView = headerView
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 0)
    }
    
    ///
    func showResultAlert(title: String){
        let resultAlert = UIAlertController(title: title, message: "\(title)를 선택하였습니다.", preferredStyle: .alert)
        
        resultAlert.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        present(resultAlert, animated:  true)
    }
    
    ///
    @objc func rightAlartButtonTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "첫화보기", style: .default, handler: {_ in self.showResultAlert(title: "첫화보기")} ))
        alert.addAction(UIAlertAction(title: "공유하기", style: .default, handler: {_ in self.showResultAlert(title: "공유하기")} ))
        alert.addAction(UIAlertAction(title: "임시저장", style: .default, handler: {_ in self.showResultAlert(title: "임시저장")} ))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated:  true)
    }
    
    //알림 유무
    @objc func rightAlarmButtonTap(){
        let idx = user?.likeItems.firstIndex(where: {$0.isbn == item?.isbn})
        if user?.likeItems[idx!].isAlarm ?? true {
            rightAlarmButton.image = UIImage(systemName: "bell.slash")
            user?.likeItems[idx!].isAlarm = false
        }
        else{
            rightAlarmButton.image = UIImage(systemName: "bell.fill")
            user?.likeItems[idx!].isAlarm = true
        }
        
        Const.Util.setUserData(data: user!)
    }
    
    ///관심 추가
    @objc func addLike(){
        //my db에 like 작품인지 확인
        let idx = user?.likeItems.firstIndex(where: {$0.isbn == item?.isbn})
        if idx == nil {
            item?.like += 1
            likeLabel.text = "+ 관심 \(Const.Number.setIntToString(number: item!.like))"
            user?.likeItems.append(LikeItem(isbn: item!.isbn, title: item!.title)) //item: item!))
            
            rightLikeButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
            rightAlarmButton.image = UIImage(systemName: "bell.fill")
            self.navigationItem.rightBarButtonItems?.insert(rightAlarmButton, at: 1)
        }
        else {
            item?.like -= 1
            likeLabel.text = "+ 관심 \(Const.Number.setIntToString(number: item!.like))"
            user?.likeItems.remove(at: idx!)
            
            rightLikeButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            
            self.navigationItem.rightBarButtonItems?.remove(at: 1)
        }
        
        Const.Util.setUserData(data: user!)
        Const.Util.setItemData(data: item!)
    }
    
    ///작가 검색
    @objc func searchAuthor(){
        //검색 화면으로 이동 & 작가 검색결과 제공
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        searchViewConntroller?.bookSearchController.textField.text = authorLabel.text?.replacingOccurrences(of: ">", with: "")
        searchViewConntroller?.textFieldShouldReturn((searchViewConntroller?.bookSearchController.textField)!)
        
        navigationController?.pushViewController(searchViewConntroller!, animated: true)
    }
    
    ///설명 접기/펴기 이벤트
    @objc func openedDescription(){
        descriptionLabel.numberOfLines = descriptionLabel.numberOfLines == 1 ? 0 : 1
        descriptionLabel.sizeToFit()
        
        publisherLabel.isHidden = descriptionLabel.numberOfLines == 1
        
        headerView.frame.size.height = 200 + descriptionLabel.frame.height + (publisherLabel.isHidden ? 0 : 40)
        tableView.tableHeaderView = headerView
        
    }
}


//MARK: TableView Delegate & DataSource

@available(iOS 16.0, *)
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if opened{
                return closedCellQuantity + 1
            }else{
                return 1
            }
        }else{
            return (detailItem?.detailData.count)! - closedCellQuantity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return closedCellQuantity == 0 ? 0 : 55.0 //미리보기 접기
        }else{
            return 70.0
        }
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            if indexPath.row == 0 {
                if closedCellQuantity == 0 { return UITableViewCell()}
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopTableViewCell", for: indexPath) as? TopTableViewCell else { return UITableViewCell()}
                cell.setData(oppend: opened, closedCellQuantity: closedCellQuantity)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoldTableViewCell", for: indexPath) as? FoldTableViewCell else { return UITableViewCell()}
                cell.setData(data: (detailItem?.detailData[indexPath.row - 1])!)

                return cell
            }
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
            cell.setData(data: detailItem!.detailData[indexPath.row + closedCellQuantity])
            
            if indexPath.row == detailItem!.detailData.count - closedCellQuantity - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section{
        case 0:
            if indexPath.row == 0{
                opened = !opened
                //해당 섹션만 새로고침
                tableView.reloadSections([indexPath.section], with: .none)
            }
        case 1:
            let webView = WebViewController()
            webView.search = item!.title
            
            navigationController?.pushViewController(webView, animated: true)
        default:
            break
        }
    }
}


extension DetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerConstant = scrollView.contentOffset.y

        if headerConstant > 90  {
//            self.navigationController?.navigationBar.backItem?.title = String(titleLabel.text!.dropLast(titleLabel.text!.count > 15 ? titleLabel.text!.count - 15 : 0))
//            backItem.title = String(titleLabel.text!.dropLast(titleLabel.text!.count > 17 ? titleLabel.text!.count - 17 : 0))
            self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: titleLabel.text)
        }
        else{
            self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "")
        }
    }
}
