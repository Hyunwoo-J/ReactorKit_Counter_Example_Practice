//
//  CounterViewController.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/06/13.
//

import Then
import SnapKit
import UIKit


final class CounterViewController: UIViewController {
  
  private let counterView = CounterView()
  
  private let counterViewReactor = CounterViewReactor()
  
  
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
    
    self.view.addSubview(counterView)
    
    self.counterView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    // CounterView의 bind라는 메소드는 CounterView에 있는 reactor라는 속성에 새로운 값이 들어왔을 때만 호출되기 때문에
    self.counterView.reactor = counterViewReactor // 의존성 주입(inject reactor)
    // 생성한 counterViewReactor를 counterView에 있는 reactor라는 속성에다가 assign만 해주게 되면 아까 작성한 bind라는 메소드가 실행이 된다.
    // 그렇게 되면 RxSwift에 따라서 Action과 State 바인딩이 발생을 하고 실제로 + 버튼을 누를 때 1이 올라가고 - 버튼을 누를 때 1이 내려간다.
  }
}
