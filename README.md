# BoxOffice 🏃🏻
> <프로젝트 기간>

2023-01-02 ~ 2023-01-06

## 소개 📑
> 매일 업데이트 되는 BoxOffice Api를 이용하여 영화 순위를 나타내는 앱입니다.
 
<br>

## 팀원 🤼‍♂️
> 안녕하세요 ! BoxOffice 프로젝트를 함께하는 **[@apwierk2451]("https://github.com/apwierk2451")** 와 **[@Sooji]("https://github.com/SoKoooool")**  입니다 ! 🙋🏻‍♂️ 🙋🏻‍♀️

### bonf
- 여러개의 API를 호출하고 데이터를 파싱하는 데이터 계층을 구현
- 각 페이지를 구성하는 모든 UI를 구현

### SooJi
- 파싱한 데이터를 모델링하는 도메인 계층을 구현
- 데이터와 도메인 계층의 리팩토링에 집중

## 커밋 컨벤션
- feat : 새로운 기능 추가
- fix : 버그 수정
- docs : 문서 수정
- style : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- refactor : 코드 리팩토링
- test : 테스트 코드, 리팩토링 테스트 코드 추가
- chore : 빌드 업무 수정, 패키지 매니저 수정

## 테크
- MVVM구조를 위해 ViewModel객체를 생성하여 ViewController가 최대한 ViewModel에 의존하는 디자인 패턴을 적용하였습니다
- Observable 객체를 만들어 ViewController와 ViewModel간의 데이터 바인딩을 적극 활용하였습니다
- 
## 구현 화면 📱

|MainView| MeasureView|
|:-------:|:--------:|
|<img src="https://i.imgur.com/zPcdwFj.gif" width="200" height="400"/> |<img src="https://i.imgur.com/YHJavtt.gif" width="200" height="400"/>|

## 구현 내용 🧑‍💻

#### MovieListView 
- TableView 구성
- 전 날의 박스오피스 순위와 지난 주의 박스오피스 순위를 가져오는 기능이다.

#### MovieDetailView
- ListView에서 각 영화를 터치 시 해당 영화의 정보를 보여준다.
- scrollView로 구성

<br>

## 핵심 경험 💡
- [x] Firestore
- [x] Network
- [x] REST-API
- [x] DiffableDataSource

<br>

## 트러블슈팅
- 여러개의 API를 순차적으로 호출하되, 그 결과를 하나로 합쳐야 하는 문제
  - Observable 객체를 활용하여 API를 순차적으로 호출하여 저장하고, zip으로 하나의 모델로 결합하여 해결
