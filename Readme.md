# BoxOffice

## 기능

#### 1. 박스 오피스 리스트
<span>
<img src="https://user-images.githubusercontent.com/113331061/197326641-918c6170-1559-480c-ac1a-c0cab5d9fd37.png" width="200"></img>
<img src="https://user-images.githubusercontent.com/113331061/197326294-99cca1fc-5a2f-4f2f-9403-0ab0bb83f0e2.png" width="200"></img>
</span>

현재 일자를 기준으로 각 필터에 맞는 박스 오피스 순위 리스트를 보여주는 화면입니다.

상단 버튼들을 통해 필터의 전환이 가능합니다.

리스트에서 영화를 선택시, 영화 상세 페이지로 이동합니다.

<br/>

#### 2. 영화 상세 페이지
<span>
<img src="https://user-images.githubusercontent.com/113331061/197326370-951f2169-b9d7-4040-b429-df92673b74fb.png" width="200"></img>
<img src="https://user-images.githubusercontent.com/113331061/197326373-dfac7e2d-55e8-4ef6-98ee-9d441af29de2.png" width="200"></img>
</span>

선택한 영화의 상세 정보를 보여주는 페이지입니다.

하단의 리뷰 작성 버튼을 통해 리뷰 작성 페이지로 이동 가능합니다.

삭제 버튼을 클릭하면, 비밀번호를 입력 가능한 알림 창이 표시되고, 적절한 비밀번호를 입력 시 해당 리뷰를 삭제합니다.

상단 공유 버튼을 통해, 영화의 상세정보를 텍스트 형태로 공유할 수 있습니다.

<br/>

#### 3. 리뷰 작성 페이지
<img src="https://user-images.githubusercontent.com/113331061/197326463-250df6a1-b8e9-474b-870d-85baa04a905c.png" width="200"></img>

영화에 리뷰를 작성할 수 있는 페이지입니다.

별점 UI에 대한 Tap 또는 Pan Gesture를 통해 별점을 입력할 수 있습니다.

1점 이상의 평점과 1글자 이상의 별명과 내용, 형식에 맞는 비밀번호를 입력하면 하단 작성 완료 버튼이 활성화됩니다.

입력 가능한 UI 외 다른 곳을 터치하면 Keyboard가 Dismiss됩니다.

작성 완료 버튼 클릭 시, 영화에 해당 리뷰를 추가합니다.

<br/>

<hr/>

## Combine 도입의 이유
#### 연쇄적인 비동기 요청
우선 제가 원하는 구현을 위해서는 영화진흥위원회 API 요청 > OMDb 포스터 정보 요청 > 포스터 이미지 요청처럼 연쇄적인 비동기 요청이 필요한 경우가 많았습니다.

이런 비동기 처리의 흐름을 Third Party 프레임워크인 Rx 대신, 애플이 제공하는 Combine을 통해 비동기 처리를 구현했습니다.

#### ViewModel 바인딩
기존에는 MVVM 패턴의 구현 과정에서, ViewModel과 View의 의존성을 없애기 위해, didSet과 클로저를 통해서 구현했었습니다.

하지만 이 방식을 사용하며 크게 두가지 단점을 느낄 수 있었습니다.
 - ViewModel의 초기 상태를 View에 바인딩하기 불편하다.
 - ViewModel의 Property를 여러 객체가 참조하는 경우, 객체의 수만큼 didSet 클로저 안에서 호출이 필요합니다.

이러한 문제들을 해결하기 위해, ViewModel의 Property들을 Publisher 형태로 여러 객체들에서 관찰한다면 위 두가지 문제를 해결할 수 있을 것이라 생각하였습니다.

<br/>

<hr/>

## URLCache 도입
이번 프로젝트에서 사용하는 API들은 주로 캐싱 처리가 가능한 API들이라고 생각하고, 

UX를 개선하기 위해, 영화 진흥위원회와 OMDb API관련 요청들을 URLCache를 활용해 캐싱처리 하였습니다.

<br/>

<hr/>

## 영화 포스터
대부분의 박스 오피스 정보를 제공하는 앱들이 영화 포스터 정보도 함께 제공하고 있었기 때문에, 영화 포스터도 함께 보여줄 수 있는 UI를 구성했습니다.

이를 위해 
1. 박스 오피스 리스트 요청
2. 리스트에 있는 각 영화에 대한 영화 상세 정보 요청
3. 영화 상세 정보에 담긴 해당 영화의 영어이름으로 OMDb에 영화 상세 정보 요청
4. OMDb의 영화 상세 정보에 담긴 PosterURL을 통해 UIImage 생성
위의 4단계를 거쳐야 했습니다.

처음 유저가 필터를 선택하고 위 4가지 과정을 모두 거친 뒤에 UI를 표시하면, 유저 입장에서 기다리는 시간이 길어질 것이라고 생각했습니다.

포스터 정보는 박스 오피스 순위를 보는 유저의 입장에서는 필수적인 정보가 아니라고 생각했기 때문에,

박스 오피스 List를 요청하는 작업이 BoxOfficeListViewModel 안에서 끝나면,

받아온 영화 정보들을 바탕으로 BoxOfficeListCollectionViewCellModel들을 생성하고, BoxOfficeList는 CollectionView의 reloadData를 호출합니다.

우선 1단계를 거친 정보를 바탕으로 Cell들을 생성하고, 각 Cell의 ViewModel들이 비동기적으로 나머지 3단계를 거쳐 포스터를 가져오고, 자신의 Cell ContentView에 반영하도록 구현하였습니다.

<br/>

<hr/>

## 리뷰 기능
닉네임, 암호화된 비밀번호, 내용, 사진 데이터를 Data 형태로 Encoding하여, MovieCode를 이름으로 Firebase Storage에 저장하였습니다.

영화에 대한 리뷰들을 받아올 때, 패스워드 정보까지 모두 받아오므로, Client 사이드에서는 다른 사람의 비밀번호를 알 수 없도록, 암호화하여 Firebase에 저장하였습니다.
