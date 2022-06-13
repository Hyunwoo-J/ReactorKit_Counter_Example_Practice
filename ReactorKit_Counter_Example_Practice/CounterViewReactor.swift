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
  
  enum Mutation {
    
  }
  
  /// 상태
  struct State {
    var value: Int = 0 // 현재값을 전달
  }
  
  let initialState: State = State()
}
