# ios-wanted-BoxOffice  
## 팀원  소개  
|Channy(김승찬)|
|:---:|
|<img src="https://user-images.githubusercontent.com/31722496/194575712-36002fac-9426-40cb-8adf-c5898be1114d.png" width="200" height="200"/>|
|[Github](https://github.com/seungchann)|

## 개발 기간  
2022.10.17 ~ 10.22

## 앱 소개  
### 첫 번째 페이지  
<img width="300" alt="1" src="https://user-images.githubusercontent.com/63276842/197329827-80e7ffb0-18fd-4cca-a312-b157891db6e2.png">  

* [영화진흥위원회](https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do) 의 일별 박스오피스 API 를 활용하여 영화 순위를 표현  
* 랭킹에 신규로 진입했을 경우 `NEW` 표시를 추가  
* 서버에서 데이터 로딩 시 `ActivityIndicator` 를 사용하여 로딩중임을 표현  

### 두 번째 페이지  

<img width="200" alt="2" src="https://user-images.githubusercontent.com/63276842/197327002-2cf5f14d-eef5-4f48-8939-7d7bcf96972d.jpeg"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img width="200" alt="2" src="https://user-images.githubusercontent.com/63276842/197326904-b9589b60-f415-4cb0-90af-996ce0e415e3.jpeg"> 

* 첫번째 페이지에서 클릭된 영화의 상세정보, 감독 및 출연배우를 표현  
* 공유하기 버튼을 사용하여 영화 정보를 담은 메시지 전송 구현  
* 서버에서 데이터 로딩 시 `ActivityIndicator` 를 사용하여 로딩중임을 표현  

## 구조 및 기능  
![Diagram 001](https://user-images.githubusercontent.com/63276842/197329637-8134500b-17ad-41d4-bd48-828b489ee66d.jpeg)  

* MVVM (Model-View-ViewModel) 패턴, Repository 패턴 사용  
* Repository 와 Domain 사이에 DTO (Data Transfer Object)를 사용하여 데이터 처리  
* 모든 UI 를 코드로 구현  
* TableView 내부 Cell 생성 시, `OOTableViewCellContentView` 형태로 내부 contentView 를 분리하여 구현  
***

## 파일 구조  
```bash
.
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Data
│   ├── Network
│   │   └── DataMapping
│   │       ├── MoviesDetailResponseKofic+Mapping.swift
│   │       └── MoviesResponseKofic+Mapping.swift
│   └── Repositories
│       └── DefaultMoviesRepository.swift
├── Domain
│   ├── Entity
│   │   ├── Movie.swift
│   │   └── MovieDetail.swift
│   └── Interface
│       └── Repositories
│           └── MoviesRepository.swift
├── Infrastructure
│   └── Network
│       └── NetworkService.swift
├── Presentation
│   └── MoviesScene
│       ├── MoviesDetail
│       │   ├── View
│       │   └── ViewModel
│       ├── MoviesList
│       │   ├── View
│       │   └── ViewModel
│       └── Utils
│           └── Observable.swift
└── Resources
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   └── Contents.json
    │   └── Contents.json
    ├── Base.lproj
    │   └── LaunchScreen.storyboard
    └── Info.plist
``` 

