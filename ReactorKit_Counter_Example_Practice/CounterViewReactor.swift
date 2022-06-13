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
}
