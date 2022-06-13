//
//  CounterViewReactor.swift
//  ReactorKit_Counter_Example_Practice
//
//  Created by Hyunwoo Jang on 2022/06/13.
//

import Foundation

import ReactorKit
import RxSwift


final class CounterViewReactor: Reactor {
  
  /// 사용자가 + 버튼을 눌렀을 때 어떤 형식으로 Reactor에 전달할지 정의한다.
  enum Action {
    case increase // +버튼을 눌렀을 때는 Reactor에 increase 액션을 전달
    case decrease // -버튼을 눌렀을 때는 Reactor에 decrease 액션을 전달
  }
  
  /// Action과 State만 있다고 해서 State가 바로 바뀌지 않는다.
  /// State를 바꾸는 가장 작은 단위가 바로 Mutation이다.
  enum Mutation {
    case increaseValue // increase라는 액션이 들어왔을 때는 value를 1 증가시키기 위해 increaseValue라는 mutation을 만듬
    case decreaseValue // decrease라는 액션이 들어왔을 때는 value를 1 감소시키기 위해 decreaseValue라는 mutation을 만듬
  }
  
  /// 상태
  struct State {
    var value: Int = 0 // 현재값을 전달
  }
  
  let initialState: State = State()
  
  
  /// Action을 받아서 mutation의 옵저버블을 반환하는 함수
  /// - Parameter action: 액션
  /// - Returns: mutation의 옵저버블
  func mutate(action: Action) -> Observable<Mutation> {
    // Action은 enum으로 정의했기 때문에 switch case로 분기 처리가 가능하다.
    switch action {
    case .increase: // 만약, increase라는 action이 들어왔을 때는 decreaseValue라는 Mutation을 반환시키기 위해서
      return Observable.just(Mutation.increaseValue)
      /*:
       * just: 옵저버블을 만드는 연산자
        1. 파라미터로 전달된 값 하나를 방출한다.
        2. 하나의 요소를 방출하고 끝내고 싶을 때 사용한다.
       */
    case .decrease:
      return Observable.just(Mutation.decreaseValue)
    }
  }
}
