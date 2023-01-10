# BoxOffice

## 🙋🏻‍♂️ 프로젝트 소개
원티드 프리온 보딩 `BoxOffice` 앱 프로젝트 입니다.

> 프로젝트 기간: 2023-01-02 ~ 2022-01-06 (5일)
> 팀원: [Judy](https://github.com/Judy-999), [웡빙](https://github.com/wongbingg)

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [🔑 핵심기술](#-핵심기술)
- [📱 실행화면](#-실행화면)
- [🔭 프로젝트 구조](#-프로젝트-구조)
- [⚙️ 적용한 기술](#%EF%B8%8F-적용한-기술)
- [🛠 개선할 점](#-개선할-점)

<br>

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[Judy](https://github.com/Judy-999)|[웡빙](https://github.com/wongbingg)|
|:---:|:---:|
|<image src = "https://i.imgur.com/n304TQO.jpg" width="250" height="250"> | <image src = "https://i.imgur.com/fQDo8rV.jpg" width="250" height="250">|
|`Firestore`,`리뷰화면`, `상세화면`|`async-await`, `API`, `홈화면`| 

<br>
	
## 🔑 핵심기술
- **`APIKey 암호화`**
    - API key가 공개 Repository에 노출되지 않도록 plist로 관리하였습니다.
    ![](https://i.imgur.com/iaFN2g0.png)
    - omdb_API_KEY : 112af520
    - kobis_API_KEY : 6f25ceb4b995518d987d1f003e84fae7
    - <span style="background-color:pink">**위 사진처럼 MovieInfo 파일에 두개의 키를 기입 해주셔야 API가 동작합니다**</span>

- **`MVVM`**
    - 데이터 관련 로직은 **ViewModel**, 뷰의 상태 관리는 **ViewContoller**, 뷰의 로직은 View로 MVVM 패턴을 사용해 이번 프로젝트를 진행해 보았습니다.
- **`디자인패턴`**
    - 옵저버블 패턴
        - MVVM 구현시 데이터 바인딩을 위해 옵저버블 패턴으로 구현을 해보았습니다.
	- 싱글톤 패턴
		- 데이터베이스로 사용하는 FirestoreManager 구현 시 하나의 인스턴스를 유지하기 위해 싱글톤 패턴을 적용했습니다.
- **`UI 구현`**
     - 코드 베이스 UI
    - 오토레이아웃
    - 피그마 프로토타입
    <img width="500" alt="스크린샷 2023-01-06 오후 10 26 35" src="https://user-images.githubusercontent.com/95671495/211021565-f15fbc77-67d6-4618-b177-8d1b36bb22be.png">
    
- **`데이터베이스`**
    - Firestore
- **`비동기처리`**
    - async - await
<br>
	
## 📱 실행화면
    
### 홈화면
|일별 박스오피스 화면|주간/주말 박스오피스 화면|날짜 선택|
|:---:|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/95671495/211020054-eb9e980e-9108-4890-96d8-d030de264c79.gif" width="200">|<img src="https://user-images.githubusercontent.com/95671495/211020560-63bd6278-68a3-4c70-89af-82eafbdc4f03.gif" width="200">|<img src="https://user-images.githubusercontent.com/95671495/211021219-698d76f8-bf8f-4d1f-a9fe-2ac5ec3aa919.gif" width="200">|

    
### 상세화면 + 리뷰화면 
|상세화면 + 출연진 더보기| 리뷰 쓰기 |리뷰보기 및 삭제|
|:---:|:---:|:---:|
|<img src="https://user-images.githubusercontent.com/95671495/211034206-f80b71a3-7ea4-464b-b566-309c251eb7f1.gif" width="200">|<image src = "https://i.imgur.com/1Oy8rqp.gif" width="200">|<img src="https://user-images.githubusercontent.com/95671495/211033515-da18ca14-c0d0-4fb5-9aef-220598436619.gif" width="200">|

	

<br>
	
## 🔭 프로젝트 구조
```swift
.
├── APIs
│	├── SearchDailyBoxOfficeListAPI.swift
│	├── SearchMovieInfoAPI.swift
│	├── SearchMoviePosterAPI.swift
│	└── SearchWeeklyBoxOfficeListAPI.swift
├── Application
│	├── AppDelegate.swift
│	└── SceneDelegate.swift
├── Domain
│	├── Entities
│	│	├── MovieData.swift
│	│	└── Review.swift
│	└── UseCase
│		├── MovieAPIUseCase.swift
│		└── ReviewFirebaseUseCase.swift
├── GoogleService-Info.plist
├── Info.plist
├── MovieInfo.plist
├── Resource
│	├── Assets.xcassets
│	│	├── AccentColor.colorset
│	│	│	└── Contents.json
│	│	├── AppIcon.appiconset
│	│	│	└── Contents.json
│	│	└── Contents.json
│	└── Base.lproj
│		└── LaunchScreen.storyboard
├── Scene
│	├── HomeScene
│	│	├── CalendarModalView
│	│	│	├── CalendarPresentationController.swift
│	│	│	├── CalendarTransitioningDelegate.swift
│	│	│	└── CalendarViewController.swift
│	│	├── HomeViewController.swift
│	│	├── HomeViewModel.swift
│	│	├── ModeSelectModalView
│	│	│	├── ModeSelectCell.swift
│	│	│	├── ModeSelectPresentationController.swift
│	│	│	├── ModeSelectTransitioningDelegate.swift
│	│	│	└── ModeSelectViewController.swift
│	│	└── SubViews
│	│	 	├── GridCell.swift
│	│	 	├── HeaderView.swift
│	│	 	├── HomeCollectionView.swift
│	│	 	└── ListCell.swift
│	├── MovieDetailScene
│	│	├── ActorListModalView
│	│	│	├── ActorListPresentationController.swift
│	│	│	├── ActorListTransitioningDelegate.swift
│	│	│	└── ActorListViewController.swift
│	│	├── MovieDetailViewController.swift
│	│	├── SubViews
│	│	│	├── MovieButton.swift
│	│	│	├── MovieLabel.swift
│	│	│	├── MovieMainInfoView.swift
│	│	│	├── MovieReviewView.swift
│	│	│	├── MovieSubInfoView.swift
│	│	│	└── ReviewTableViewCell.swift
│	│	└── UIViewController+.swift
│	└── ReviewScene
│	    ├── MovieReviewViewModel.swift
│	    ├── ReviewListViewController.swift
│	    └── WriteReviewViewController.swift
├── Service
│	├── Firebase
│	│	├── FirebaseError.swift
│	│	├── FirestoreManager.swift
│	│	└── StorageManager.swift
│	└── Network
│	 	├── API.swift
│	 	├── APIClient.swift
│	 	├── APIConfiguration.swift
│	 	├── APIError.swift
│	 	└── Extension
│	 	    ├── Bundle+Extension.swift
│	 	    ├── Date+Extension.swift
│	 	    └── Dictionary+Extension.swift
└── Utility
	├── ImageCache
	│	└── ImageCacheManager.swift
 	├── Observable
 	│	└── Observable.swift
 	└── StarRating
 	 	├── StarRatingView.swift
 	 	└── SubViews
 			├── StarImageView.swift
 			└── StarRatingUISlider.swift

```

<br>
	
## ⚙️ 적용한 기술

### ✅ CollectionView Compositional Layout
    섹션별로 데이터를 유연하게 처리하기 위해 Compositional Layout을 사용하였습니다. 
    
### ✅ Custom Modal View
    `보기모드 변경 버튼(상단 버튼)`, `캘린더 버튼`, `출연진 더보기 버튼` 을 Custom Modal 형식으로
    구현을 했습니다.  
### ✅ Async - Await
    API 요청이 3번 연속되어 @escaping 클로저로 처리하게 될 시 복잡한 코드로 인해 가독성이 떨어지고
    협업하는 팀원 또한 코드를 이해하기 어려운 상황이 있었습니다. async-await 처리로 인해 들여쓰기 문법을
    최대한 배제하고, 가독성을 올려 팀원과 협업하기 좋은 코드로 변경 하였습니다. 
### ✅ Firestore
	리뷰를 저장하기 위해 Firebase의 Firestore를 사용했습니다. 리뷰 간의 독립성을 위해 영화 별로
	`닉네임+암호`를 파일 이름으로 저장했습니다. Firestore의 사용을 돕는 `FirestoreManager`객체가 있고, 
	해당 객체를 `Review`로 직접 사용하는 `ReviewFiresoterUseCase` 객체로 계층을 분리했습니다

<br>
	
## 🛠 개선할 점

### 리뷰 테이블 뷰 셀 동적 크기 조절
- 현재 리뷰에 긴 글을 적었을 경우 나머지 글자가 `...`로 잘리고 있습니다. 리뷰 리스트를 보여주는 화면에서 셀의 크기를 다이나믹하게 조절하는 기능을 아직 넣지 못했습니다.

### 리뷰 이미지
- 현재 리뷰 이미지를 선택할 순 있지만 저장하지 않고 기본 이미지만 띄우고 있습니다. FireStorage를 사용하려 구현까지 해놨지만, Firestore만 사용하는 요구사항에 따라 `UIImage`를 `base64`로 `String`으로 전환한 후 배열 형태로 Firestore에 저장하면 될 것 같습니다. 
