//
//  MyEditTableViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/06.
//

import UIKit

class MyEditTableViewController: UITableViewController{
    var headerView = MyTableViewHeader()
    var user: User?
//    private var likeItems: [LikeItem] = []
    var selectedRow: [String] = []
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("취소", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        
        return button
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("선택삭제", for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    let footerView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually    //배분
        view.spacing = 0                    //간격
    
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.frame.size.height = 40
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.layer.position.y = view.frame.height - 60
        tableView.tableFooterView?.frame.size.height = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        headerView.leftLabel.isHidden = true
        headerView.leftSortButton.isHidden = true
        headerView.rightSettingButton.setTitle("선택", for: .normal)
        headerView.rightSettingButton.addTarget(self, action: #selector(RightSettingButtonTap(sender:)), for: .touchUpInside)
        
        [cancelButton, deleteButton].forEach{
            footerView.addArrangedSubview($0)
        }
    }
    
    @objc private func cancelButtonTap(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func deleteButtonTap(){
        if selectedRow.count == 0{
            let alert = Const.Alert.getDefaultAlert(title: "[알림]", message: "삭제 선택한 웹툰이 없습니다.")
            present(alert, animated: true)
            return
        }
        else{
            let resultAlert = UIAlertController(title: "삭제", message: "관심웹툰에서 삭제하시겠습니까?", preferredStyle: .alert)
            
            resultAlert.addAction(UIAlertAction(title: "아니요", style: .cancel))
            resultAlert.addAction(UIAlertAction(title: "예", style: .default, handler: {_ in
                self.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reLoad"), object: self.selectedRow)
                })
            }))

            present(resultAlert, animated: true)
        }
    }
    
    @objc private func RightSettingButtonTap(sender: UIButton) {
        
        if sender.titleLabel?.text == "선택"{
            sender.setTitle("선택해제", for: .normal)
            
            for row in 0..<tableView.numberOfRows(inSection: 0){
                let accessoryCheckBox = tableView.cellForRow(at: IndexPath(row: row, section: 0))?.accessoryView as? UIImageView
                accessoryCheckBox?.tintColor = .white
                
                tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .none)
                
                selectedRow.append(user!.likeItems[row].isbn)
            }
        }
        else{
            sender.setTitle("선택", for: .normal)
            
            for row in 0..<tableView.numberOfRows(inSection: 0){
                let accessoryCheckBox = tableView.cellForRow(at: IndexPath(row: row, section: 0))?.accessoryView as? UIImageView
                accessoryCheckBox?.tintColor = .gray
                
                tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
                
                selectedRow.removeAll(where: {$0 == user!.likeItems[row].isbn})
            }
        }
    }
    
}


extension MyEditTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user!.likeItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accessoryCheckBox = UIImageView()
        accessoryCheckBox.tag = indexPath.row
        accessoryCheckBox.image = UIImage(systemName: "checkmark.circle")
        accessoryCheckBox.tintColor = .gray
        //버튼 크기설정 (lyout을 잡아주지 않음)
        accessoryCheckBox.sizeToFit()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else { return UITableViewCell() }
        cell.setData(item: Const.Util.getItemData(isbn: user!.likeItems[indexPath.row].isbn))
        cell.accessoryView = accessoryCheckBox
        cell.backgroundColor = .systemBackground
        
        let bgView = UIView()
        bgView.backgroundColor = .green
        cell.selectedBackgroundView = bgView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accessoryCheckBox = tableView.cellForRow(at: indexPath)?.accessoryView as? UIImageView
        accessoryCheckBox?.tintColor = .white
        
        selectedRow.append(user!.likeItems[indexPath.row].isbn)
        
        if selectedRow.count > 0 {
            headerView.rightSettingButton.setTitle("선택해제", for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let accessoryCheckBox = tableView.cellForRow(at: indexPath)?.accessoryView as? UIImageView
        accessoryCheckBox?.tintColor = .gray
        
        selectedRow.removeAll(where: {$0 == user!.likeItems[indexPath.row].isbn})

        if selectedRow.count == 0 {
            headerView.rightSettingButton.setTitle("선택", for: .normal)
        }
    }
}
