<img src="https://capsule-render.vercel.app/api?type=waving&color=BDBDC8&height=150&section=header&text=RxSwift" />

Observable VS Observer
- Observable : 일을 전달 하는것
  * 예) 계산기 어플에서 숫자 3을 입력 
- Observer : 일을 전달 받아 일을 처리하는 것
  * 예) 계산기 어플에서 3 + 3 입력받으면 6이라고 처리

subscribe vs dispose
- subscribe : 구독하여 일을 전달하여 처리하는 과정을 연결 시켜주는 것 (Observable Streams)
  * 예) Youtube에서 구독하는 것 -> 구독하면 알림을 받음
- disepose : 과정을 없애서 이전에 받아온 처리를 못받게 하는 것
  * 예) Youtube에서 구독취소 -> 구독하면 알림을 못받음

next vs completed vs error
- 전달이벤트의 종류로 next, completed, error가 있음
  * next : 데이터 전달
  * completed : 데이터 전달 완료
  * error : 오류발생 ( 상태오류, 네트워크오류 등등...)

subject
- Observable, Observer는 단방향으로 일을 전달하거나 일을 받아 처리
- subject는 양방향으로 일을 전달(Observable), 처리(Observer는)를 둘 다 할 수 있음

publishSubject vs behaviorSubject  
- subject에서 사용 되는 이벤트로 behaviorSubject는 초기값이 필요하고, publishSubject는 초기값이 필요없다.

  
<img src="https://capsule-render.vercel.app/api?type=waving&color=BDBDC8&height=150&section=footer" />
