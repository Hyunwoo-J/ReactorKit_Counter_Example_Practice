//
//  CounterView.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/06/12.
//

import BonMot
import Foundation
import Then
import SnapKit


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct NoticeView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      CounterView()
        .showPreview()
    }
  }
}
#endif



public class CounterView: UIView {
  
  private lazy var valueLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "0".styled(
      with: StringStyle([
        .font(.preferredFont(forTextStyle: .title1)),
        .color(.label),
        .alignment(.center)
      ])
    )
  }
  
  private lazy var decreaseButton = UIButton(type: .system).then {
    $0.setTitle("-", for: .normal)
    $0.titleLabel?.font = .preferredFont(forTextStyle: .title1)
  }
  
  private lazy var increaseButton = UIButton(type: .system).then {
    $0.setTitle("+", for: .normal)
    $0.titleLabel?.font = .preferredFont(forTextStyle: .title1)
  }
  
  private lazy var activityIndicator = UIActivityIndicatorView()
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()
  }
  
  
  private func setup() {
    self.do {
      $0.addSubview(valueLabel)
      $0.addSubview(decreaseButton)
      $0.addSubview(increaseButton)
      $0.addSubview(activityIndicator)
    }
    
    valueLabel.snp.makeConstraints {
      $0.centerX.equalTo(self.snp.centerX)
      $0.centerY.equalTo(self.snp.centerY)
    }
    
    self.do { _ in
      decreaseButton.snp.makeConstraints {
        $0.leading.equalTo(30)
        $0.centerY.equalTo(self.snp.centerY)
      }
      
      increaseButton.snp.makeConstraints {
        $0.trailing.equalTo(-30)
        $0.centerY.equalTo(self.snp.centerY)
      }
    }
    
    activityIndicator.snp.makeConstraints {
      $0.centerX.equalTo(self.snp.centerX)
      $0.top.equalTo(valueLabel.snp.top).offset(50)
    }
  }
}
