# Error_Clean_Architecture

## 통합 에러 처리 구조 설계

### 배경과 문제의식
- 기존의 에러 처리 방식은 Manager, Repository, ViewModel, ViewController에 이르기까지 각 계층마다 다양한 에러 타입을 전달하고 처리하는 구조였다.
- 이로 인해 각 Rx 스트림마다 onError를 따로 구독하고 Alert을 띄우는 코드가 반복되어 코드 중복이 심하고,
- 에러가 발생할 경우 Rx 스트림이 끊겨 UI 이벤트가 무시되거나 앱의 흐름이 비정상적으로 종료되는 문제가 있었다.

 
### 개선 방향
- 에러를 하나의 상태로 관리하는 방향으로 구조로 개편
- ViewModel 내부에서 에러를 Observable<AppError>로 상태 관리하고, 각 Task 내부에서 catch 처리 후 _error.onNext(...) 형태로 이벤트를 방출
- 에러는 공통 Enum인 AppError로 통합되며, ViewController에서는 이 하나의 스트림만 구독하여 Alert을 띄우고, 로그를 출력하는 방식으로 단순화

 
### 구현 방식 요약
- LocalizedError 프로코톨을 채택한 AppErrorProtocol을 정의해 errorDescription, debugDescription을 공통 인터페이스로 설계.
  - [LocalizedError에 관한 설명 블로그](https://soo-hyn.tistory.com/147)
- NetworkError, CoreDataError 등 각 도메인 에러는 이 프로토콜을 채택해 구성.
- 모든 에러는 Domain 계층(레포지토리)에서 AppError로 Wrapping되어 전달됨.
- ViewModel에서는 catch 블록에서 AppError로 변환 후 상태로 방출.
- ViewController는 ViewModel의 state.error를 통해 Alert 출력과 로그 디버깅을 통합적으로 처리.


### 기존 구조
![기존 에러 구조](https://github.com/user-attachments/assets/51640495-f664-4c66-9d22-fed865bb2ab3)

### 개선 구조
![개선 에러 구조](https://github.com/user-attachments/assets/1ccb7eb1-5b35-4114-94b2-33e7d67aff63)

### 개선 효과
- 에러 흐름이 단순해지고 명확해져 코드 가독성과 디버깅 효율이 크게 향상
- Rx 스트림의 중단 없이 에러를 비동기 상태로 처리할 수 있어, UX 흐름이 안정화
- ViewController에서 Alert 띄우는 로직이 중앙화되어 중복 제거가 가능했고, 새로운 화면을 추가할 때도 일관된 방식으로 대응할 수 있게 됨

### 한계
- ViewController에서 동일한 에러 처리 (Alert Present)가 아닌 각각 다른 처리를 필요로 한다면, 개선된 구조가 유연성이 떨어질 수 있다.    
  (output.error를 구독하는 부분에서 전달받은 AppError 타입을 switch-case로 나누어 분기한다면 극복할 수 있을 것 같다)
 
### 느낀 점
- 이번 구조 개선을 통해 비즈니스 로직과 에러 처리 로직의 분리, Rx 스트림의 일관된 흐름 유지, 에러의 목적별 메시지 분리(사용자용 vs 디버깅용) 등의 설계적 중요성을 체감했다
- 특히 “에러는 이벤트로 처리하고, 상태로 전달한다”는 원칙을 직접 설계 및 구현하며, Clean Architecture에 있어 에러 처리 또한 명확한 책임 분리가 필요한 영역임을 깊이 이해하게 되었다.

### 블로그 정리
- [Clean Architecture - Error 설계에 대한 고찰](https://soo-hyn.tistory.com/153)
