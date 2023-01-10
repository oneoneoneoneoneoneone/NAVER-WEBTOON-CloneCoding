//
//  UnderlineSegmentedControl.swift
//  SegmentedControlMenu
//
//  Created by hana on 2022/09/22.
//

import UIKit

final class UnderlindSegmentedControl: UISegmentedControl{
    
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(numberOfSegments)/3
        let height = 2.0
        //let xPosition = self.bounds.size.width * 2/3
        //let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 2.0
        let frame = CGRect(x: 0, y: 43, width: width, height: height)
        let view = UIView(frame: frame)
        
        view.backgroundColor = .green
        self.addSubview(view)
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 0
                
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        setTitleTextAttributes(titleTextAttributes, for: .selected)
        let font = UIFont.systemFont(ofSize: 14)
        setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        let underlineFinalXPosition = self.bounds.size.width / CGFloat(numberOfSegments) / 3 * (CGFloat(selectedSegmentIndex) * CGFloat(numberOfSegments) + 1)
        
        //이건 멍미
        UIView.animate(withDuration: 0.1, animations: {
            self.underlineView.frame.origin.x = underlineFinalXPosition
        })
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeBackgroundAndDivider(){
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        //Divider - 이게 선인듯..?
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
}
