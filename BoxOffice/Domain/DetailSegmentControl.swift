//
//  DetailSegment.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit

final class DetailSegmentControl: UISegmentedControl {
  private lazy var underlineView: UIView = {
    let width = self.bounds.size.width / CGFloat(numberOfSegments)
    let height = 5.0
    let xPosition = CGFloat(selectedSegmentIndex * Int(width))
    let yPosition = bounds.size.height - 4.0
    let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
    let view = UIView(frame: frame)
    view.backgroundColor = UIColor(r: 76, g: 52, b: 145)
    addSubview(view)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    removeBackgroundAndDivider()
  }
  override init(items: [Any]?) {
    super.init(items: items)
      backgroundColor = .white
    removeBackgroundAndDivider()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func removeBackgroundAndDivider() {
    let image = UIImage()
    setBackgroundImage(image, for: .normal, barMetrics: .default)
    setBackgroundImage(image, for: .selected, barMetrics: .default)
    setBackgroundImage(image, for: .highlighted, barMetrics: .default)
    
    setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
    UIView.animate(
      withDuration: 0.1,
      animations: { [weak self] in
          guard let self = self else { return }
          self.underlineView.frame.origin.x = underlineFinalXPosition
      }
    )
  }
}
