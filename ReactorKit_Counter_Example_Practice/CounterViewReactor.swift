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
    case setLoading(Bool) // 상태가 추가됐기 때문에 이 상태를 변화시키기 위핸 Mutation도 하나 추가한다.
    // => Bool 타입을 associated value로 가지는 setLoading이라는 Mutation
    // 로딩이 어떻게 시작하는지 view는 몰라도 되기 때문에 Action은 건들지 않는다.
  }
  
  /// 상태
  struct State {
    var value: Int = 0 // 현재값을 전달
    var isLoading: Bool = false // 로딩중이라는 상태를 나타내기 위해 isLoading이라는 Bool 속성 추가
  }
  
  let initialState: State = State()
  
  
  /// Action을 받아서 mutation의 옵저버블을 반환하는 함수
  /// - Parameter action: 액션
  /// - Returns: mutation의 옵저버블
  func mutate(action: Action) -> Observable<Mutation> {
    // Action은 enum으로 정의했기 때문에 switch case로 분기 처리가 가능하다.
    switch action {
    case .increase: // 만약, increase라는 action이 들어왔을 때는 decreaseValue라는 Mutation을 반환시키기 위해서
      // 3가지 Mutation을 직렬로 반환
      // concat이라는 메소드에 배열로 넘어가게 되면 하나가 끝나고 다음 것이 실행되고 그게 끝나야 또 다음 것이 실행된다. -> 순차적 실행
      return Observable.concat([
        Observable.just(Mutation.setLoading(true)),
        Observable.just(Mutation.increaseValue)
          .delay(.seconds(1), scheduler: MainScheduler.instance), // 1초 딜레이 발생
        Observable.just(Mutation.setLoading(false))
      ])
      /*:
       * just: 옵저버블을 만드는 연산자
        1. 파라미터로 전달된 값 하나를 방출한다.
        2. 하나의 요소를 방출하고 끝내고 싶을 때 사용한다.
       */
    case .decrease:
      return Observable.concat([
        Observable.just(Mutation.setLoading(true)),
        Observable.just(Mutation.decreaseValue)
          .delay(.seconds(1), scheduler: MainScheduler.instance), // 1초 딜레이 발생
        Observable.just(Mutation.setLoading(false))
      ])
    }
  }
  
  
  /// 이전 상태를 하나 받고 mutation을 하나 받는다. 그 후, 다음 상태를 반환한다.
  /// - Parameters:
  ///   - state: 이전 상태
  ///   - mutation: mutation
  /// - Returns: 다음 상태
  func reduce(state: State, mutation: Mutation) -> State {
    // Mutation 또한 enum으로 정의했기 때문에 switch case로 분기 처리가 가능하다.
    var newState = state // 새로운 상태를 만들기 위해서 newState로 복사한다.
    switch mutation {
    case .increaseValue:
      newState.value += 1
      
    case .decreaseValue:
      newState.value -= 1
    }
    
    return newState // 새 상태를 반환
  }
}
