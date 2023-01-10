//
//  Stepper.swift
//  NaverWebtoon
//
//  Created by hana on 2022/12/12.
//

import Foundation
import UIKit

class CSStepper: UIControl{
    lazy var leftBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("◀︎", for: .normal)
        button.isUserInteractionEnabled = true
        
        button.sizeToFit()
        
        return button
    }()
    
    var centerLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.text = "인기순"
        
        return label
    }()
    
    lazy var rightBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("▶︎", for: .normal)
        button.isUserInteractionEnabled = true
        button.sizeToFit()
        
        return button
    }()
 
    var value: Int = 0 {
            didSet {
                self.centerLbl.text = String(value)
                
                // value값이 바뀌면 sendAcionts(for:)인 valueChanged이벤트를 발생시키라는 의미
     // ViewController.swift에서 CSStepper객체가 stepper이면,
     // stepper.addTarget(self, action: #selector(printValue(_:)), for: .valueChanged)와 같이 사용.
     //@objc func printValue(_ sender: CSStepper)에서 sender.value로 접근 가능
                self.sendActions(for: .valueChanged)
     
            }
        }

    // for storyboard
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.mySetup()
    }
    
    // for non-storyboard
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mySetup()
    }
    
    // for basis initializer
    init(){
        super.init(frame: CGRect.zero)
        self.mySetup()
    }
    
    // CGRect변화시 호출되는 메소드 (프로퍼티의 CGRect정보를 여기에 기입해도 가능)
    override public func layoutSubviews() {
        super.layoutSubviews()
        // set up property's CGRect
    }
    
    // custom realization
    private func mySetup() {
            
            self.leftBtn = UIButton()
            self.rightBtn = UIButton()
            self.centerLbl = UILabel()
            
            self.leftBtn.tag = -1
            self.leftBtn.setTitle("↓", for: .normal)
            self.leftBtn.setTitleColor(.black, for: .normal)
            self.leftBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.leftBtn.layer.borderWidth = 0.5
            self.leftBtn.layer.borderColor = UIColor.blue.cgColor
            
            self.rightBtn.tag = 1
            self.rightBtn.setTitle("↑", for: .normal)
            self.rightBtn.setTitleColor(.black, for: .normal)
            self.rightBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
            self.rightBtn.layer.borderWidth = 0.5
            self.rightBtn.layer.borderColor = UIColor.red.cgColor
            
            self.centerLbl.text = String(value)
            self.centerLbl.font = .systemFont(ofSize: 20)
            self.centerLbl.textAlignment = .center
            self.centerLbl.backgroundColor = .cyan
            self.centerLbl.layer.borderWidth = 0.5
            self.centerLbl.layer.borderColor = UIColor.blue.cgColor
             
            self.addSubview(self.leftBtn)
            self.addSubview(self.rightBtn)
            self.addSubview(self.centerLbl)
            
            self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
            self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        }
        
        @objc func valueChange(_ sender: UIButton) {
            self.value += sender.tag
        }

}
