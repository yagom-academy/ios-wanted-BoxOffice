# 🎦 BoxOffice 프로젝트

## 📘 목차
- [👩‍💻 프로젝트 및 개발자 소개👨‍💻](#-프로젝트-및-개발자-소개)
- [⚙️ 개발환경 및 라이브러리](#-개발환경-및-라이브러리)
- [❇️ 핵심 키워드](#-키워드)
- [📱 구현 화면](#-구현-화면)
- [⚡️ 트러블 슈팅](#%EF%B8%8F-트러블-슈팅)
- [🔗 참고 링크](#-참고-링크)

<br>

## 프로젝트 및 개발자 소개
> **소개** : 박스오피스 순위를 소개 앱입니다.
.<br>**프로젝트 기간** : 2023.01.02 ~ 2023.01.06<br>

| **[언체인(Unchain)](https://github.com/unchain123)** | **[바드(Bard)](https://github.com/bar-d)** |
|:---:|:---:|
|<img src="https://i.imgur.com/I4RtOVg.png" width="270" height="250"/>|<img src="https://avatars.githubusercontent.com/u/92622931?v=4" width="270" height="250"/>|

### 언체인(unchain)
- 메인뷰, 상세뷰, 리뷰 포스트뷰
- 데이터 바인딩

### 바드(Bard)
- 네트워크 모듈화
- 네트워킹 모델 구축



<br>

## 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5-orange)]() [![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]()

<br>

## 💡 키워드
- **`SwiftUI`**
- **`MVVM`**
- **`DataFormatting`**
- **`URLSession`**
- **`RestAPI`**

<br>

## 📱 구현 화면

|**메인 화면** | **측정 화면** | 
| -------- | -------- |
|<img src="https://i.imgur.com/4eMi5zN.jpg" width="270" height="250"/>| <img src="https://i.imgur.com/B8R3dmi.jpg" width="270" height="250"/>|

<br>

| 공유 화면 | 리뷰 화면 | 
| -------- | -------- |
| <img src="https://i.imgur.com/oMetFZh.gif" width="270" height="250"/> | <img src="https://i.imgur.com/O6ylInX.gif" width="270" height="250"/> |

### 1. SwiftUI MVVM
- 뷰를 구성하는 방법은 SwiftUI를 선택했습니다.
- mvvm구조를 채택하여 뷰모델을 observableObject로 만들어서 뷰를 다시 그릴 수 있게 연결하여 줬습니다.

### 2. 네트워킹 객체와 omdb네트워킹
- omdb에서 포스터 이미지를 가져오기 위해서는 4번에 걸쳐서 네트워크 요청을 해줘야 했습니다. 이것을 해결하기 위해 컴플리션 핸들러를 통해 연쇄적으로 네트워킹 할 수 있도록 만들어 줬으며 네트워킹은 각각 객체화 하여 필요한 Request를 만들어서 사용할 수 있도록 했습니다.
 
### 3. 기획 명세서 맞추기
- 일일 박스오피스를 요청할 때 당일로 하면 응답을 받을 수 없기 때문에 하루전날을 기준으로 했습니다. 
- 서울로만 지역제한을 해야했기 때문에 서울의 지역코드를 찾아서 쿼리 아이템으로 넣어 주었습니다.
- 포스터 이미지를 요청하는 과정에서 영화의 영어이름과 개봉연도 밖에 api를 통해서 넣어 줄 수 있는게 없었기 때문에 둘 다 입력하여 최대한 포스터 이미지가 현재 나오는 영화의 포스터와 맞도록 맞춰 주었습니다.

