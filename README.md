###### tags: `README`

# Box Office

## 🙋🏻‍♂️ 프로젝트 소개
원티드 프리온 보딩 `BoxOffice` 앱 프로젝트 입니다.

> 프로젝트 기간: 2023-01-02 ~ 2023-01-07 (5일)
> 팀원: [브래드](https://github.com/bradheo65), [보리사랑](https://github.com/yusw10)

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [🔑 핵심기술](#-핵심기술)
- [📱 실행화면](#-실행화면)
- [⚙️ 적용한 기술](#-적용한-기술)
- [🛠 아쉬운 점](#-아쉬운-점)


## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[브래드](https://github.com/bradheo65)|[보리사랑]()|
|:---:|:---:|
|<image src = "https://i.imgur.com/35bM0jV.png" width="250" height="250">|<image src = "https://i.imgur.com/ClIWluz.jpg" width="250" height="250">|
|`UI, Model`|`URLSession, Firebase`|  


## 🔑 핵심기술
- **`MVVM 패턴`**
    - SwiftUI 구조의 특성으로 MVVM 패턴을 구현해 보았습니다.
- **`디자인패턴`**
    - 빌더 패턴
        - 오픈API 사용을 위한 `URLRequest`를 생성했습니다.
- **`UI 구현`**
    - Swift UI
- **`파일 저장 형식`**
    - FireBaseStore
- **`비동기처리`**
    - @escaping closer

## 📱 실행화면

|||
|:---:|:---:|
|<image src = "https://i.imgur.com/S8zR5qO.gif">|<image src = "https://i.imgur.com/ha17cAx.gif">|
|`Prview와 상세 화면`|`리뷰 등록 및 리뷰 확인`|

## 🔭 프로젝트 구조

### - File Tree
    
```
.
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   ├── Contents.json
│   └── NoImageNotFound.imageset
│       ├── Contents.json
│       └── 내 프로젝트.png
├── BoxOfficeApp.swift
├── Extension
│   ├── Date+Extension.swift
│   └── String+Extension.swift
├── Info.plist
├── Manager
│   ├── BoxOffice
│   │   ├── BoxOfficeAPIDirector.swift
│   │   ├── Constants
│   │   │   ├── BoxOfficeURL.swift
│   │   │   └── OMDbUrl.swift
│   │   ├── OMDbAPIDirector.swift
│   │   └── Protocol
│   │       └── APIRequest.swift
│   ├── BoxOfficeFireBaseManager.swift
│   ├── JsonDecoderManager
│   │   └── JsonDecoder.swift
│   ├── NetworkManager.swift
│   └── NetworkService.swift
├── Model
│   ├── DailyMovieBoxOfficeModel.swift
│   ├── MovieDetailModel.swift
│   ├── MovieInfoPageModel.swift
│   ├── MoviePosterModel.swift
│   └── ReviewModel.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── ViewModel
│   ├── BoxOfficeMainViewModel.swift
│   ├── BoxOfficeReviewModel.swift
│   └── MovieDetailViewModel.swift
└── View
    ├── BoxOfficeDetailView.swift
    ├── BoxOfficeListView.swift
    ├── BoxOfficeMainView.swift
    ├── BoxOfficeReviewView.swift
    └── ImagePicker.swift
```
    
## ⚙️ 적용한 기술
    
### ✅ SwiftUI
    
- SwiftUI로 View 기능 구현
- 이미지를 받아오지 못할 경우 Default이미지 설정
- Binding 키워드를 통해 View 업데이트
    
### ✅ URLSession 

- URLSession을 활용하여 선형으로 데이터 요청
    - 일간 박스오피스 리스트 요청 -(영화 코드 추출)
-> 영화 상세정보 요청 -(영화 영문명 추출)
-> 영화 포스터 URL 요청 -(영화 포스터 이미지 배열 추출) 
-> 이미지화 
    
### ✅ FireBaseStore

- FireBase Store
    - FireBaseStore를 활용하여 리뷰 데이터 관리
    - 리뷰 목록 및 리뷰 작성 메서드 구현

## 🛠 아쉬운 점
    
- 리뷰를 보여주는 List에서 순서대로 가져오지 못했다. FireStore에 저장 시 uuid로 판단해서 문제가 생긴 것 같다. 추후에 업로드 시간으로 구별해도 좋을 것 같습니다.
    
- FireStore에 UIImage를 저장하고자 했으나 용량 문제로 업로드 되지 않았다. 다만 이미지 자체의 Data가 아니라 이미지 URL을 저장하는 방식으로 변경했다면 리뷰에 등록하는 이미지를 저장할 수 있었으리라고 생각된다.
    
- 영화진흥회의 API와 OMDb의 API에서 다루는 영화 코드 체계가 달라 영문명으로만 영화 포스터의 이미지를 가져올 수 밖에 없었다. 따라서 간단한 영화명의 경우 여러 이미지를 받아오게 되어 기본 이미지로 대체하였다. 

