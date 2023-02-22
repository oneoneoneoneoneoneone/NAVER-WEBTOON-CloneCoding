//
//  SearchViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/11/16.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    var bookItems: [Item] = []
    var movieItems: [Item] = []
    var searchLog: [String] = []
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.register(ResultTableViewCell.self, forCellReuseIdentifier: "ResultTableViewCell")
        view.register(ResultTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ResultTableViewHeader")
        //tableView.isHidden = true

        return view
    }()

    var bookSearchController: CustomSearchViewController = {
        let searchController = CustomSearchViewController(frame: .zero)//searchResultsController: self)
        searchController.frame.size.height = 90

        return searchController
    }()
    
    private var isEditMode = true

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
        //UserDefault 읽기
        searchLog = Repository.getSearchLog()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setNavigation()
        setSearchController()
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
        
    }
    
    private func setNavigation(){
        //이전뷰의 네비게이션바를 가리지 않고 보이게할라믄 true
        definesPresentationContext = true//false
        
//        navigationController?.isNavigationBarHidden = true
        
        //let navigationView = self.navigationController as? MainNavigationView
//        navigationView?.setNavigationViewHidden(hidden: true)
        
    }
    
    private func setSearchController(){
        bookSearchController.textField.delegate = self
        bookSearchController.segmentMenu.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        bookSearchController.cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        
        
//        bookSearchController = UISearchController(searchResultsController: nil)
//        bookSearchController.obscuresBackgroundDuringPresentation = false //searchController가 실행됐을 때 아래 배경을 어둡게 표시하는 여부 (자동검색을 사용 안할때..)
//        bookSearchController.searchBar.placeholder = "제목 또는 작가명 검색"
//        bookSearchController.searchBar.delegate = self
//        bookSearchController.searchResultsUpdater = self
//        bookSearchController.delegate = self
//
//        //취소버튼 활성화
//        bookSearchController.searchBar.showsCancelButton = true
//        bookSearchController.searchBar.setValue("취소", forKey: "cancelButtonText")
////        //취소 버튼의 가시성을 관리하는지 여부
////        bookSearchController.automaticallyShowsCancelButton = true
////
////        //결과 컨트롤러의 가시성을 관리하는지 여부
////        bookSearchController.automaticallyShowsSearchResultsController = true
////        //활성화되었을 때 검색 결과 컨트롤러가 표시되는지 여부
////        bookSearchController.showsSearchResultsController = true
////
////
//        //스콥버튼 - 서치바 아래에 검색결과 or 빠른검색어를 분류하는 SegmentedControl 형태의 버튼
//        bookSearchController.searchBar.scopeButtonTitles = ["웹툰", "전체", "도전"]
//        bookSearchController.searchBar.showsScopeBar = true
//        bookSearchController.searchBar.autoresizesSubviews = true
//        //bookSearchController.searchBar.scopeBarButtonTitleTextAttributes(for: .normal)
//        //스콥버튼의 가시성을 관리하는지 여부
////        bookSearchController.automaticallyShowsScopeBar = true
////
////        //네비게이션바 표시 x
////        bookSearchController.hidesNavigationBarDuringPresentation = false
////
////        //??
////        bookSearchController.searchBar.enablesReturnKeyAutomatically = true
//
//        //navigationitem에 추가하지 않고, 테이블뷰 헤드에 추가/네비게이션뷰를 숨김
//        tableView.tableHeaderView = bookSearchController.searchBar
//
//        navigationItem.searchController = bookSearchController
//        //navigationItem.hidesSearchBarWhenScrolling = false
//
//        //검색어 입력시작햇을때1! searchbar를 활성화 시킴. 스콥버튼 숨기기 전에 미리 활성화 해야 버튼 공간이 확보되는..?
//        //searchBarTextDidBeginEditing(bookSearchController.searchBar)
//        searchBarShouldBeginEditing(bookSearchController.searchBar)
//        //bookSearchController.searchBar.autoresizingMask = .flexibleTopMargin
        
        tableView.tableHeaderView = bookSearchController
    }
    
    private func setLayout(){
        view.addSubview(tableView)

        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
            //$0.top.equalTo(view.safeAreaLayoutGuide)
        }
//        tableView.tableHeaderView!.snp.makeConstraints{
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
        
    }
    
    @objc func cancelButtonTap(){
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        
        //header.setData(menu: bookSearchController.segmentMenu.titleForSegment(at: bookSearchController.segmentMenu.selectedSegmentIndex)!, count: 3)
        
//        switch sender.selectedSegmentIndex {
//            case 0:
//                viewItems = searchItems
//            case 1:
//                viewItems = searchItems.filter{$0.id}
//            case 2:
//                viewItems = searchItems.filter{!$0.id}
//            default: break
//        }
        tableView.reloadData()
    }
}


//MARK: Delegate & DataSource


////Delegate 특정 이벤트에 대한 동작을 위임하는 프로토콜
//extension SearchViewController: UISearchBarDelegate{
//    //editing 시작을 델리게이트에 요청
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        return true
//    }
//
//    //검색창 입력 시작
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        //00searchBar.becomeFirstResponder()
//    }
//
//    //검색창 입력 끝
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        //searchBar.resignFirstResponder()
//    }
//
//    //검색어가 변경될 때
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }
//
//    //검색버튼 눌렀을 때
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        //searchLog에 현 검색어 제외, 현검색어 저장
//        searchLog = searchLog.filter{$0 != searchBar.text}
//        searchLog.append(searchBar.text ?? "")
//        //UserDefaults 변경사항 저장
//        UserDefaults.standard.setValue(searchLog, forKey: "searchLog")
//        //테이블뷰 새로고침
//        tableView.reloadData()
//    }
//
//    //취소버튼 클릭
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        //뒤로가기
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    //스콤선택이 바뀌었을때
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
////        fileteredData = scopedData.filter({ (scopedData:Data) -> Bool in
////            let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
////            return scopedData.main.lowercased().contains(searchController.searchBar.text!.lowercased()) && (scope == scopedData.detail.rawValue || scope == "All")
////        })
////        resultVC.tableView.reloadData()
//
//    }
//
//}
//
//// search controller가 present되거나 dismiss될 때의 메소드를 제공
//extension SearchViewController: UISearchControllerDelegate {
//    //?
//    func didPresentSearchController(_ searchController: UISearchController) {
//        DispatchQueue.main.async {
//            searchController.searchBar.becomeFirstResponder()
//        }
//    }
//}
//
//extension SearchViewController: UISearchResultsUpdating{
//    //search bar에 입력되는 정보에 따라 검색 결과를 업데이트
//    func updateSearchResults(for searchController: UISearchController) {
//        if searchController.searchBar.text == "" {
//            isEditMode
//            tableView.reloadData()
//        }
//
////        let scope = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
////        //return scopedData.main.lowercased().contains(searchController.searchBar.text!.lowercased()) && (scope == scopedData.detail.rawValue || scope == "All")
////
////        tableView.reloadData()
//    }
//}

//MARK: UITableViewDelegate && UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode) {
            switch bookSearchController.segmentMenu.selectedSegmentIndex {
            case 0:
                return 2
            case 1, 2:
                return 1
            default:
                return 0
            }
        }
        else if isEditMode {
            return 1
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode) {
            switch bookSearchController.segmentMenu.selectedSegmentIndex {
            case 0:
                return section == 1 ? movieItems.count : bookItems.count
            case 1:
                return bookItems.count
            case 2:
                return movieItems.count
            default:
                return 0
            }
        }
        else if isEditMode {
            return searchLog.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode) {
            return 80
        }
        else if isEditMode {
            return 40
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode) {
            isEditMode = false
            bookSearchController.segmentMenu.isHidden = false
            bookSearchController.frame.size.height = 90
            //bookSearchController.segmentMenu.frame

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as? ResultTableViewCell else { return UITableViewCell() }
            
            switch bookSearchController.segmentMenu.selectedSegmentIndex {
            case 0:
                cell.setData(item: indexPath.section == 1 ? movieItems[indexPath.row] : bookItems[indexPath.row])
            case 1:
                cell.setData(item: bookItems[indexPath.row])
            case 2:
                cell.setData(item: movieItems[indexPath.row])
            default:
                break
            }
            
            return cell
        }
        else if isEditMode {
            isEditMode = true
            bookSearchController.segmentMenu.isHidden = true
            bookSearchController.frame.size.height = 50

            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.accessoryView = UIButton(type: .close, primaryAction: UIAction(handler: { _ in
                //cell.delete(self)
                self.searchLog.remove(at: self.searchLog.count - indexPath.row - 1)
                //테이블뷰리로드 없이, 셀한개만 딜리트 시키
                tableView.deleteRows(at: [indexPath], with: .fade) //numberOfRowsInSection을 타서 결국 isEditMode 값 확인함.......
                tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows ?? [], with: .none)
                //UserDefaults 변경사항 저장
                Repository.setSearchLog(data: self.searchLog)
            }))
                
            cell.textLabel?.text = searchLog[searchLog.count - indexPath.row - 1]

            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.visibleCells is [ResultTableViewCell] {
            let detailViewController = DetailViewController()
            detailViewController.navigationController?.modalPresentationStyle = .fullScreen
            
            switch bookSearchController.segmentMenu.selectedSegmentIndex {
            case 0:
                detailViewController.isbn = indexPath.section == 1 ? movieItems[indexPath.row].isbn : bookItems[indexPath.row].isbn
            case 1:
                detailViewController.isbn = bookItems[indexPath.row].isbn
            case 2:
                detailViewController.isbn = movieItems[indexPath.row].isbn
            default:
                break
            }
            
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            bookSearchController.textField.text = searchLog[searchLog.count - indexPath.row - 1]
            textFieldShouldReturn(bookSearchController.textField)
        }
    }
    
    //header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode){
            return 30
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !(bookSearchController.textField.text!.isEmpty || isEditMode){
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ResultTableViewHeader") as? ResultTableViewHeader else{ return UITableViewHeaderFooterView() }
            
            
            switch bookSearchController.segmentMenu.selectedSegmentIndex {
            case 0:
                header.setData(menu: section == 1 ? "베스트 도전" : "웹툰", count: section == 1 ? movieItems.count : bookItems.count)
            case 1:
                header.setData(menu: bookSearchController.segmentMenu.titleForSegment(at: bookSearchController.segmentMenu.selectedSegmentIndex)!, count: bookItems.count)
            case 2:
                header.setData(menu: bookSearchController.segmentMenu.titleForSegment(at: bookSearchController.segmentMenu.selectedSegmentIndex)!, count: movieItems.count)
            default:
                break
            }
            
            return header
        }
        else{
            return UIView()
        }
    }
    
}

//MARK: UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            isEditMode = true
            tableView.reloadData()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isEditMode = false
        //searchLog에 현 검색어 제외, 현 검색어 저장
        searchLog = searchLog.filter{$0 != textField.text}
        searchLog.append(textField.text ?? "")
        //UserDefaults 변경사항 저장
        Repository.setSearchLog(data: self.searchLog)
        
        //검색결과 반영
        let searchItems = Repository.getItemsData().filter{$0.title.contains(textField.text!) || $0.author.contains(textField.text!)}
        
        bookItems = searchItems.filter{$0.id}
        movieItems = searchItems.filter{!$0.id}
        
        //세그먼트메뉴 선택이벤트(테이블뷰 새로고침)
        bookSearchController.segmentMenu.selectedSegmentIndex = 0
        segmentedControlValueChanged(bookSearchController.segmentMenu)
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isEditMode = true
        tableView.reloadData()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //textField.resignFirstResponder()
    }
    
}
