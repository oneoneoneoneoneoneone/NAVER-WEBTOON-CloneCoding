//
//  RectCollectionViewCell.swift
//  StickyMenuApp
//
//  Created by hana on 2022/09/21.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell{
    
    //static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: MainCollectionViewModel? { didSet { bind() } }

    //let imageView = UIImageView()
    lazy var contentsView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground

        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .label
        label.text = "월"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            contentsView.backgroundColor = isSelected ? .green : .systemBackground
            titleLabel.textColor = isSelected ? .green : .label
            titleLabel.font = isSelected ? .systemFont(ofSize: 14, weight: .semibold) : .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    private func configure() {
        
        addSubview(contentsView)
        addSubview(titleLabel)

        contentsView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(2)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    private func bind() {
          titleLabel.text = model?.title ?? ""
      }
}
