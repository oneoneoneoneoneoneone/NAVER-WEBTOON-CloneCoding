//
//  MyPageViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/02.
//

import UIKit
import SnapKit
import SwiftUI

class MyPageViewController: UIViewController{
    var headerView = MyTableViewHeader()
    var user: User?
    private var items: [Item] = []
    private var likeItems: [LikeItem] = []
    
    lazy private var tableView: UITableView = {
        let view = UITableView()
        view.tableHeaderView = headerView
        view.tableHeaderView?.frame.size.height = 40
//        view.register(MyTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MyTableViewHeader")
        view.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setLayout()
        
        headerView.leftSortButton.addTarget(self, action: #selector(leftSortButtonTap), for: .touchUpInside)
        headerView.rightSettingButton.addTarget(self, action: #selector(rightSettingButtonTap), for: .touchUpInside)
        
        //presented 뷰가 닫힐 때 호출할 ..?
        NotificationCenter.default.addObserver(self, selector: #selector(sendPopoverDismissed), name: NSNotification.Name(rawValue: "reLoad"), object: nil)//str)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = Const.Util.getUserData()
        items = []
        user?.likeItems.forEach{
            items.append(Const.Util.getItemData(isbn: $0.isbn))
        }
        
        //업데이트일자 기준 정렬
        items = items.sorted(by: {$0.recentUploadDate > $1.recentUploadDate})
        
        likeItems = []
        items.forEach{ item in
            likeItems.append(user!.likeItems.first(where: {$0.isbn == item.isbn})!)
        }
        
        headerView.leftLabel.text = "전체 \(likeItems.count)"
        
        tableView.reloadData()
    }
    
    @objc func sendPopoverDismissed(notification: NSNotification){
        let selectedRow = notification.object as! [String]
        var editItems: [Item] = []
        
        selectedRow.forEach{ isbn in
            //user에서 좋아하는 작품 삭제
            self.user?.likeItems.removeAll(where: {$0.isbn == isbn})
            //item의 좋아요 수 삭제
            var item = self.items.first(where: {$0.isbn == isbn})
            item?.like -= 1
            
            editItems.append(item!)
        }

        Const.Util.setUserData(data: self.user)
        editItems.forEach{
            Const.Util.setItemData(data: $0)
        }
        
        viewWillAppear(true)
    }
        
    public func oldLoad(){
        self.tableView.contentOffset.y = 0
    }

}


//MARK: Private Method

extension MyPageViewController{
    func setLayout(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func leftSortButtonTap() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "업데이트순", style: .default, handler: { _ in
            self.likeItems = []
            self.items.forEach{ item in
                self.likeItems.append(self.user!.likeItems.first(where: {$0.isbn == item.isbn})!)
            }
            self.headerView.leftSortButton.setTitle("업데이트순 ▼", for: .normal)
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "최근등록순", style: .default, handler: { _ in
            self.likeItems = self.likeItems.sorted(by: {$0.addDate > $1.addDate})
            self.headerView.leftSortButton.setTitle("최근등록순 ▼", for: .normal)
            self.tableView.reloadData()
            
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alertController, animated: true)
    }
                                                
    @objc private func rightSettingButtonTap() {
        let tvController = MyEditTableViewController()
        tvController.user = user

        present(tvController, animated: true, completion:{
            tvController.viewDidLoad()
        })
    }
    
    @objc func accessoryButtonTap(sender: UIButton){//tableView: UITableView, indexPath: IndexPath){
        //확잉ㄴ 후
        if likeItems[sender.tag].isAlarm{
            likeItems[sender.tag].isAlarm = false
        }else{
            likeItems[sender.tag].isAlarm = true
        }
        user?.likeItems = likeItems
        Const.Util.setUserData(data: user)
        
        tableView.reloadData()
    }   
}

//MARK: UITableViewDelegate && UITableViewDataSource

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accessoryButton = UIButton()
        accessoryButton.tag = indexPath.row
        
        if likeItems[indexPath.row].isAlarm{
            accessoryButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
            accessoryButton.imageView?.tintColor = .green
        }
        else{
            accessoryButton.setImage(UIImage(systemName: "bell.slash"), for: .normal)
            accessoryButton.imageView?.tintColor = .gray
        }
        //버튼 크기설정 (lyout을 잡아주지 않음)
        accessoryButton.sizeToFit()
        accessoryButton.addTarget(self, action: #selector(accessoryButtonTap(sender:)), for: .touchUpInside)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else { return UITableViewCell() }
        cell.setData(item: Const.Util.getItemData(isbn: likeItems[indexPath.row].isbn))
        cell.accessoryView = accessoryButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        //let seletedItem = contents[indexPath.section].contentItem[indexPath.row]
        detailViewController.isbn = likeItems[indexPath.row].isbn
        detailViewController.navigationController?.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
