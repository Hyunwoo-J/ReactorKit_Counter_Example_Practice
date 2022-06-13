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
  }
}
