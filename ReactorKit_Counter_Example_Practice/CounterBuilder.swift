//
//  CounterBuilder.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/08/12.
//

import UIKit


final class CounterBuilder {
  public class func build() -> UIViewController {
    let viewController = CounterViewController()
    let reactor = CounterViewReactor()
    viewController.reactor = reactor // 의존성 주입(inject reactor)
    // CounterViewController의 bind라는 메소드는 CounterViewController에 있는 reactor라는 속성에 새로운 값이 들어왔을 때만 호출되기 때문에
    // 생성한 counterViewReactor를 CounterViewController에 있는 reactor라는 속성에다가 assign만 해주게 되면 아까 작성한 bind라는 메소드가 실행이 된다.
    // 그렇게 되면 RxSwift에 따라서 Action과 State 바인딩이 발생을 하고 실제로 + 버튼을 누를 때 1이 올라가고 - 버튼을 누를 때 1이 내려간다.
    
    return viewController
  }
}
