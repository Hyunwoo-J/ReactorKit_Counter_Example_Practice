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

import ReactorKit
import RxCocoa
import RxSwift


#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct CounterView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      CounterView()
        .showPreview()
    }
  }
}
#endif



class CounterView: UIView, ReactorKit.View {
  
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
  
  typealias Reactor = CounterViewReactor
  
  var disposeBag: DisposeBag = .init()
  
  
  /// Action Binding과 State Binding을 작성한다.
  /// CounterViewController와 대응되는 CounterViewReactor를 함수 파라미터로 받도록 정의
  /// - Parameter reator: 해당 vc와 대응되는 reator
  func bind(reactor: Reactor) {
    // Action
    
    // 1. increaseButton
    increaseButton.rx.tap // increaseButton이 눌렸을 때, (tap이라는 사용자 interaction이 들어왔을 때)
      .map { Reactor.Action.increase } // -> Reactor.Action에 정의된 increase라는 액션으로 바꾸고
      .bind(to: reactor.action) // -> 그것을 다시 reactor의 action이라는 곳에 바인딩한다.
      .disposed(by: disposeBag)
    
    // 2. decreaseButton
    decreaseButton.rx.tap // decreaseButton이 눌렸을 때, (tap이라는 사용자 interaction이 들어왔을 때)
      .map { Reactor.Action.decrease } // -> Reactor.Action에 정의된 decrease라는 액션으로 바꾸고
      .bind(to: reactor.action) // -> 그것을 다시 reactor의 action이라는 곳에 바인딩한다.
      .disposed(by: disposeBag)
    
    // 이렇게 하면 increaseButton과 decreaseButton이 눌렸을 때 각각 increase 또는 decrease라는 action이 reactor에 전달이 되게 된다.
    // 그러면 CounterViewReactor에서 작성했던 mutate가 먼저 실행이 되고 그리고 다시 reduce가 실행이 되고
    // 새로운 상태가 다시 뷰로 전달이 된다. ===> State Binding 작성
    
    
    // State
    // 그 상태(뷰에 전달된 새로운 상태)를 view에 렌더링하기 위해 바인딩을 한다.
    reactor.state.map { $0.value } // reactor에 state라는 옵저버블이 있는데 여기서 value라는 속성을 받아오는 코드를 작성
      .distinctUntilChanged() // 값이 바뀌는 경우에만 label을 업데이트하기 위해 distinctUntilChanged 연산자 사용
      .map { "\($0)" } // int라 label의 필요한 문자열로 만들어준다.
      .bind(to: valueLabel.rx.text) // valueLabel.rx.text에 바인딩한다.
      .disposed(by: disposeBag)
  }
}
