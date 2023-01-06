# 🎬 BoxOffice 프로젝트
<img src="https://i.imgur.com/o0VMIM2.jpg" width="270"/> <img src="https://i.imgur.com/DwW1csc.jpg" width="270"/>

<br>

## 프로젝트 및 개발자 소개
> **소개** : 박스오피스 순위를 소개하는 앱입니다.<br>
> **프로젝트 기간** : 2022.01.02 ~ 2022.01.06<br>

| **[엘렌](https://github.com/jcrescent61)** | **[우롱차](https://github.com/dnwhd0112)** |
|:---:|:---:|
|<img src="https://i.imgur.com/s7IBwC1.jpg" width="270"/>|<img src="https://avatars.githubusercontent.com/u/43274246?v=4" width="200">||

<br>

### 엘렌(Ellen)
- API 관리 및 네트워킹 객체 구현
- MVVM 구조 설계
- 메인 화면 구현
- 영화 상세 화면 구현

### 우롱차
- Firebase 구현
- 리뷰 작성 화면 구현
- 리뷰 리스트 화면 구현

<br>

## Gyro Data 프로젝트 로고
![](https://i.imgur.com/Zp1yIH5.png)

<br>

## 📱 구현 화면

|**메인 화면** | **상세 화면** | **리뷰 화면** |
| -------- | -------- | -------- |
|![](https://i.imgur.com/CJHO0u7.gif)|![](https://i.imgur.com/lKykuht.gif)| ![](https://i.imgur.com/jAuGBbB.gif) |
	
<br>

## 폴더 구조
- **Entry**: AppDelegate과 SceneDelegate이 있습니다.
- **Model**: 네트워킹, 파이어베이스에 사용되는 모델입니다.
- **Network**: API, REST, FierBase의 CRUD 로직을 포함합니다.
- **Domain**: 화면 별 구현사항을 포함합니다.
- **Extension**: 커스텀한 Extension의 집합입니다.
- **SupportFile**: Assets, plist파일 등이 있습니다.

<br>

## 구현 내용
[![swift](https://img.shields.io/badge/swift-5-orange)]() [![xcode](https://img.shields.io/badge/Xcode-14.0-blue)]() [![img](https://img.shields.io/badge/Firebase-orange)]()

### 뷰 컨셉 - 메가박스
<img src="https://i.imgur.com/isYN7N9.jpg" width="300"/>

### 단방향 MVVM
내부 로직이 혼잡해지는 것을 방지하고자 로직의 흐름을 input과 output 처럼 **단방향**으로 제한했습니다. 이러한 형태를 ViewModelInterface로 추상화하였습니다. ViewController에서 추상화 된 ViewModelInterface와 ViewModel의 Newtork객체 모두 **의존성주입** 형태로 초기화하며 이러한 구조는 **테스트 코드 작성에도 용이**합니다.

### 네트워킹 객체 & 3중 네트워킹
비동기 로직을 Combine을 사용하여 구현하였습니다. 하나의 API만이 아닌 여러 API에도 사용가능하게 구현하였습니다. 셀의 갯수 당 세번씩 request를 해야하는데 이 점을 **Combine의 Sequence**를 사용해 구현하였습니다.

### FireStore 와 FireStorage
요구사항에는 FireStorage를 사용하라고 명시되어있으나 사용에 참고하라는 링크는 FireStore 여서 혼동을 많이했습니다. 원래 계획은 FireStore에 정보를 저장하고 이미지와 같은 큰 크기의 파일만 파이어Storage에 저장할 생각이였으나 FireStore에만 사용해야된다는 조건으로 큰크기의 이미지파일의 크기를 줄이고 인코딩하여 String으로 저장하였습니다.



<br>

