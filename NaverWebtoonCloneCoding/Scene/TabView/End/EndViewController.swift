//
//  EndViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2023/01/04.
//

import UIKit
import SnapKit

protocol CollectionViewCellDelegate {
    func pushViewController(_ vc: UIViewController)
}

class EndViewController: UIViewController{
    private final let cellHeight = 120.0
    private var tableHeightConstraint: NSLayoutConstraint?

    let headerString = ["##독자님들이 이번주 많이 본 추천완결 신작", "## 독자들이 좋아하는 추천완결", "## 독자들이 좋아하는 추천완결2"]
    var sortStandard = ["인기순", "업데이트순", "별점순"]
    var categoryStandard = ["전체 장르", "순정", "액션", "스포츠", "스릴러", "판타지", "드라마"]
    var currentSortStandard = 0
    var currentCategoryStandard = 0
    
    var items: [Item] = []
    
    lazy var rightSearchButotn: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        button.action = #selector(searchButtonTap)
        button.target = self
        
        return button
    }()
    
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
    
    var headerView: EndHeaderView = {
        let view = EndHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var settingView: EndSettingView = {
        let view = EndSettingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.leftSortButton.addTarget(self, action: #selector(sortButtonTap), for: .touchUpInside)
        view.leftCategoryButton.addTarget(self, action: #selector(categoryButtonTap), for: .touchUpInside)
        
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(EndTableViewVerticalCell.self, forCellReuseIdentifier: "EndTableViewVerticalCell")
        tableView.register(EndTableViewAllCategoryCell.self, forCellReuseIdentifier: "EndTableViewAllCategoryCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemGray6
        
        setNavigation()
        setLayout()
        setData(sort: currentSortStandard, category: currentCategoryStandard)
        
        headerView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setLayout(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(settingView)
        contentView.addSubview(tableView)


        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview() //세로 스크롤을 위해
        }
        
        headerView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        settingView.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
                
        tableView.snp.makeConstraints{
            $0.top.equalTo(settingView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 250)
        tableHeightConstraint?.isActive = true

    }
        
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .systemBackground
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)]

        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        self.navigationItem.rightBarButtonItem = rightSearchButotn

        self.navigationItem.title = "추천완결"
    }
    
    private func setData(sort: Int, category: Int){
        items = Repository.getItemsData()
        
        if category != 0{
            items = items.filter{$0.publisher == categoryStandard[currentCategoryStandard]}
        }
        
        switch sort{
        case 0:
            items = items.sorted(by: {$0.like > $1.like})
        case 1:
            items = items.sorted(by: {$0.recentUploadDate < $1.recentUploadDate})
        case 2:
            items = items.sorted(by: {$0.score > $1.score})
        default:
            break
        }
        
        settingView.leftSortButton.setTitle("\(sortStandard[currentSortStandard]) ▼", for: .normal)
        settingView.leftCategoryButton.setTitle("\(categoryStandard[currentCategoryStandard]) ▼", for: .normal)
        settingView.rightLabel.text = "총 \(items.count) 작품"

        tableHeightConstraint?.constant = CGFloat(210*headerString.count + (items.count-headerString.count)*120)
        tableView.reloadData()
    }
    
    @objc func sortButtonTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        sortStandard.forEach{ str in
            alert.addAction(UIAlertAction(title: "\(str) \(currentSortStandard == sortStandard.firstIndex(of: str) ? " ✓" : "")", style: .default, handler: {_ in
                self.currentSortStandard = self.sortStandard.firstIndex(of: str)!
                self.setData(sort: self.currentSortStandard, category: self.currentCategoryStandard)
            }))
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
                                  
    @objc func categoryButtonTap(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        categoryStandard.forEach{ str in
            alert.addAction(UIAlertAction(title: "\(str) \(currentCategoryStandard == categoryStandard.firstIndex(of: str) ? " ✓" : "")", style: .default, handler: {_ in
                self.currentCategoryStandard = self.categoryStandard.firstIndex(of: str)!
                self.setData(sort: self.currentSortStandard, category: self.currentCategoryStandard)
            }))
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                            
        present(alert, animated: true)
    }
    
    @objc func searchButtonTap(){
        let searchViewConntroller = SearchViewController(coder: NSCoder())
        searchViewConntroller?.navigationController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(searchViewConntroller!, animated: true)
    }
}

extension EndViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row + 1) % 5 != 0 || (indexPath.row + 1) / 5 > headerString.count{
            return cellHeight
        }
        else{
            return 210
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row + 1) % 5 != 0 || (indexPath.row + 1) / 5 > headerString.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewVerticalCell", for: indexPath) as? EndTableViewVerticalCell
            cell?.setData(item: items[indexPath.row])
            
            return cell ?? UITableViewCell()
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewAllCategoryCell", for: indexPath) as? EndTableViewAllCategoryCell
            cell?.delegate = self
            cell?.items = items
            cell?.setData(text: headerString[(indexPath.row + 1) / 5 - 1])
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row + 1) % 5 != 0 || (indexPath.row + 1) / 5 > headerString.count{
            let detailViewController = DetailViewController()
            
            detailViewController.isbn = items[indexPath.row].isbn
            detailViewController.navigationController?.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}


extension EndViewController: CollectionViewCellDelegate{
    func pushViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
