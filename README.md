# ios-wanted-BoxOffice

## 구현화면

| 리스트   | 리뷰작성 | 리뷰삭제 |
|---|--| --|
| ![Simulator Screen Recording - iPhone 14 Pro - 2022-10-22 at 17 06 14](https://user-images.githubusercontent.com/37897873/197328394-ae1816d3-ea05-4363-97d6-45709917f793.gif) |  ![Simulator Screen Recording - iPhone 14 Pro - 2022-10-22 at 17 07 06](https://user-images.githubusercontent.com/37897873/197328408-93fca27a-7445-4f24-a11c-7acd84134fbd.gif) |  ![Simulator Screen Recording - iPhone 14 Pro - 2022-10-22 at 17 07 26](https://user-images.githubusercontent.com/37897873/197328586-56846910-0992-4759-9fa5-4b796ec9df91.gif)

## 프로젝트 구조
|폴더구조|설명|
|--|--|
<img width="204" alt="스크린샷 2022-10-22 오후 5 17 07" src="https://user-images.githubusercontent.com/37897873/197328695-49094696-d3f1-4b0f-87e8-996056868f3b.png"> | <img width="400" alt="스크린샷 2022-10-22 오후 5 29 31" src="https://user-images.githubusercontent.com/37897873/197329604-52a71fdd-d506-4880-9bbd-350d84734338.png"> 

### 패턴
- MVVM 패턴과 Clean Architecture를 일부 도입하여 구현하였습니다.


| Architecture | 설명 | 
| -- | --- |
| <img width="300" alt="스크린샷 2022-10-22 오후 5 17 07" src="https://user-images.githubusercontent.com/37897873/197329728-ca24391e-3bd8-43dc-ac7c-6f62e953daed.png"> | <img width="400" alt="스크린샷 2022-10-22 오후 5 17 07" src="https://user-images.githubusercontent.com/37897873/197330024-97090472-d7fe-4946-9533-aa66a55aca6e.png"> |


## 구현과정
### 파일간 의존성 제거를 위해
- 이전 프로젝트를 여러번 MVC로 구현하니 모든 것이 ViewController 종속되어 있는 것 같이 느껴졌다. 만약 실제 프로젝트라면 새로운 기능이 추가될때마다 그와 연결된 ViewController의 모든 걸 수정해야 한다는 번거로움이 있을 것이다.
- Model은 Formatting만 하고 Viewmodel은 정보를 뿌려주기만 하므로써 ViewController의 역할을 덜었다.
### 리뷰를 로컬에 저장
- 영화별 리스트의 리뷰를 각각 로컬에 저장하는 과정속에서 시간이 꽤 소요되었다. 
- 어떤 영화의 리뷰인지 구분하기 위해 처음엔 영화 제목을 기준으로 필터링하였으나 한글을 넣으면 깨지는 문제가 발생하여 영화의 고유값을 기준으로 필터링하여 각 영화에 맞게 리뷰를 저장하였다.
### 회고
- 이유있는 코드를 작성하기 위해 노력한 프로젝트이다! 프로젝트의 구조와 아키텍쳐 관점에서도 생각하려 노력했다.
- 이번 프로젝트는 코드의 품질을 높이려고 노력하다보니 선택 기능을 모두 구현하지 못한 아쉬움이 있었다.
- 그전 프로젝트때도 학교다니면서 하기 바빴는데 엎친데 덮친격 시험기간이 겹쳐버리니 너무 시간이 부족했다 🥹
