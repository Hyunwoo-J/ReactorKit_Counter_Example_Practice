//
//  CounterViewController.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/06/13.
//

import Then
import SnapKit
import UIKit
import ReactorKit
import RxCocoa
import RxSwift


final class CounterViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = CounterViewReactor
  
  var disposeBag: DisposeBag = .init()
  
  private let contentView = CounterView()
  
  private let counterViewReactor = CounterViewReactor()
  
  
  override func loadView() {
    super.loadView()
    self.view = self.contentView
  }
  
  
  // 필수 구현
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  
  // 필수 구현
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
  }
  
  /// Action Binding과 State Binding을 작성한다.
  /// CounterViewController와 대응되는 CounterViewReactor를 함수 파라미터로 받도록 정의
  /// - Parameter reator: 해당 vc와 대응되는 reator
  func bind(reactor: Reactor) {
    self.bindIncreaseButton(reactor: reactor)
    self.bindDecreaseButton(reactor: reactor)
    self.bindValueLabel(reactor: reactor)
    self.bindLoading(reactor: reactor)
  }
  
  // MARK: Bind Action
  
  private func bindIncreaseButton(reactor: Reactor) {
    self.contentView.increaseButton.rx.tap // increaseButton이 눌렸을 때, (tap이라는 사용자 interaction이 들어왔을 때)
      .map { Reactor.Action.increase } // -> Reactor.Action에 정의된 increase라는 액션으로 바꾸고
      .bind(to: reactor.action) // -> 그것을 다시 reactor의 action이라는 곳에 바인딩한다.
      .disposed(by: disposeBag)
  }
  
  private func bindDecreaseButton(reactor: Reactor) {
    self.contentView.decreaseButton.rx.tap // decreaseButton이 눌렸을 때, (tap이라는 사용자 interaction이 들어왔을 때)
      .map { Reactor.Action.decrease } // -> Reactor.Action에 정의된 decrease라는 액션으로 바꾸고
      .bind(to: reactor.action) // -> 그것을 다시 reactor의 action이라는 곳에 바인딩한다.
      .disposed(by: disposeBag)
  }
  
  // 이렇게 하면 increaseButton과 decreaseButton이 눌렸을 때 각각 increase 또는 decrease라는 action이 reactor에 전달이 되게 된다.
  // 그러면 CounterViewReactor에서 작성했던 mutate가 먼저 실행이 되고 그리고 다시 reduce가 실행이 되고
  // 새로운 상태가 다시 뷰로 전달이 된다. ===> State Binding 작성
  
  // MARK: Bind State
  // 그 상태(뷰에 전달된 새로운 상태)를 view에 렌더링하기 위해 바인딩을 한다.
  
  private func bindValueLabel(reactor: Reactor) {
    reactor.state.map { $0.value } // reactor에 state라는 옵저버블이 있는데 여기서 value라는 속성을 받아오는 코드를 작성
      .distinctUntilChanged() // 값이 바뀌는 경우에만 label을 업데이트하기 위해 distinctUntilChanged 연산자 사용
      .map { "\($0)" } // int라 label의 필요한 문자열로 만들어준다.
      .bind(to: self.contentView.valueLabel.rx.text) // valueLabel.rx.text에 바인딩한다.
      .disposed(by: disposeBag)
  }
  
  private func bindLoading(reactor: Reactor) {
    reactor.state.map { $0.isLoading }
      .distinctUntilChanged() // 값이 바뀌는 경우에만 UI를 업데이트하기 위해 사용
      .bind(to: self.contentView.activityIndicator.rx.isAnimating) // activity Indicator의 isAnimating 속성을 isLoading과 동일한 속성으로 만든다.
      .disposed(by: disposeBag)
  }
}
