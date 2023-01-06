# BoxOffice 🍿
> <프로젝트 기간>

2023-01-02 ~ 2023-01-07 

## 소개 📑
> 일일 박스오피스 순위를 확인할 수 있는 `Application`입니다.
 
<br>

## 팀원 🤼‍♂️
> 안녕하세요 ! BoxOffice 프로젝트를 함께하는 **`Hugh`** 와 **`Hyeon2`**  입니다 ! 🙋🏻‍♂️ 🙋🏻‍♀️
> 
|Hugh| seohyeon2|
|:-------:|:--------:|
| <img src="https://i.imgur.com/IHXuadr.jpg" width="350" height="350"/> |  <img src="https://avatars.githubusercontent.com/u/50102522?v=4?s=100" width="350" height="350"/>    |
|[@Hugh](https://github.com/Hugh-github)|[@seohyeon2]("https://github.com/seohyeon2")| 


## 구현 화면 📱

| BoxOfficeListView | MovieDetailView |
|:-------:|:--------:|
| <img src="https://i.imgur.com/IEifMGo.png" width="200" height="400"/>| <img src="https://i.imgur.com/ieojuv7.png" width="200" height="400"/> |

| LoginViewController(성공 사진) | LoginViewController(실패 사진) |
|:-------:|:--------:|
|<img src="https://i.imgur.com/xIaxfq3.png" width="200" height="400"/> |<img src= "https://i.imgur.com/seChoOO.png" width="200" height="400"/>|


| 리뷰 삭제 기능(성공) | 리뷰 삭제 기능(실패)|
|:-------:|:--------:|
| <img src="https://i.imgur.com/EMMahzH.png" width="200" height="400"/>|<img src="https://i.imgur.com/EENEaLl.png" width="200" height="400"/>|

|실행 영상|
|:-----:|
|<img src="https://i.imgur.com/D3WbVus.gif" width="200" height="400"/>|


## 구현 내용 🧑‍💻
#### Networking Layer
+ 필요한 프로퍼티와 기능을 추상화(APIRequest)
+ 추상화한 프로토콜을 채택한 EndPoint 타입을 통해 http 통신에 필요한 URLRequest 생성 
+ 원하는 EndPoint를 편리하게 생성할 수 있는 EndPoints 타입 구현

#### Database & Caching
+ FirebaseStore를 이용한 CRUD 기능 구현
+ NSCache를 이용한 이미지 캐싱 기능 구현

#### BoxOfficeListView
+ CollectionView를 사용해 list 형태의 일일 박스오피스 순위 구현
+ NumberFormatter, DateFormatter를 활용해 text 설정

#### MovieDetailView
+ 영화 포스터 비율에 맞는 크기 조절, 포스터 위 관람등급 표시 구현
+ scrollView를 사용해 가로 스크롤 구현
+ 영화 상세 정보를 공유할 수 있는 기능 구현
+ tableView를 이용해 list 형태의 리뷰 구현 
+ 리뷰 삭제 기능 구현

#### LoginViewController
+ button을 이용한 별점 기능 구현
+ firestore에 데이터 저장 기능 구현


<br>

## 핵심 경험 💡
- [x] URLSession
- [x] Firebase
- [x] UICollectionView
- [x] Cache

