[![Swift 5.7](https://img.shields.io/badge/swift-5.7-ED523F.svg?style=flat)](https://swift.org/download/) [![Xcode 14.1](https://img.shields.io/badge/Xcode-14.1-ED523F.svg?style=flat&color=blue)](https://swift.org/download/)

# BoxOffice

> 프로젝트 기간: 2023.01.02 - 2023.01.06 </br>
> 영화진흥위원회 Open API, OMDb API, Firebase-FireStore 활용하여 구현하는 앱

&nbsp;

## API Key

- [영화진흥위원회, OMDb API KEY 다운로드 받기](https://drive.google.com/file/d/1HE1xOj-zn6mJFMaU7IeU-_VLla-BJb0l/view?usp=sharing)
- [GoogleService API KEY 다운로드 받기](https://drive.google.com/file/d/1mVAFxiB2y8jG_q7qikgXcol2hkrxUsQu/view?usp=sharing)

> 아래와 같이 .plist 파일을 프로젝트 경로에 추가해주세요.
![](https://i.imgur.com/jBckMIs.png)


&nbsp;

## 💻 개발자 소개

|예톤|아리|
|:-:|:-:|
|<img src="https://avatars.githubusercontent.com/u/98514397?v=4" width="200">|<img src="https://avatars.githubusercontent.com/u/75905803?v=4" width="200">|
|- FirebaseManager 구현</br>- 영화 상세정보 구현|- 네트워크 동작 구현</br>- 박스오피스 목록 화면 구현</br>- 리뷰작성 화면 구현</br>|

&nbsp;

## 목차

* [파일 디렉토리 구조](#-파일-디렉토리-구조)
* [기술 스택](#-기술-스택)
* [기능 및 UI](#-기능-및-ui)
* [설계 및 구현](#-설계-및-구현)
* [실행 화면](#-실행-화면)
* [기술적 도전](#-기술적-도전)
    * [Combine](#combine)
    * [Coordinator](#coordinator)
    * [Firebase-FireStore](#firebase-firestore)
* [Truoble Shooting](#-truoble-shooting)
    * [PassthroughSubject로 이벤트를 보냈는데, 왜 뷰가 이벤트를 전달받지 못하는 걸까?](#passthroughsubject로-이벤트를-보냈는데-왜-뷰가-이벤트를-전달받지-못하는-걸까)
* [고민했던 점](#-고민했던-점)
    * [화면을 어떻게 구성하면 좋을까?](#-화면을-어떻게-구성하면-좋을까)
    * [뷰와 뷰모델을 어떻게 나눌까?](#-뷰와-뷰모델을-어떻게-나눌까)
    * [셀의 버튼을 눌렀을 때 셀의 위치를 어떻게 알까?](#-셀의-버튼을-눌렀을-때-셀의-위치를-어떻게-알까)

## 🗂 파일 디렉토리 구조

```
 BoxOffice
 ├── Resources
 │   ├── Assets.xcassets
 │   └── Base.lproj
 └── Sources
     ├── App
     ├── Extensions
     │   ├── Combine
     │   └── UI
     ├── Presentation
     │   ├── Coordinator
     │   ├── CreateReview
     │   │   ├── Coordinator
     │   │   ├── ViewController
     │   │   ├── ViewModel
     │   │   └── Views
     │   ├── Detail
     │   │   ├── ViewController
     │   │   ├── ViewModel
     │   │   └── Views
     │   └── List
     │       ├── Coordinator
     │       ├── ViewController
     │       ├── ViewModel
     │       └── Views
     └── Repositories
         ├── Model
         └── Network
             ├── Protocol
             ├── Request
             └── Response
```

&nbsp;

## 🛠 기술 스택

* Swift/UIKit
* Combine

### 아키텍처

* MVVM
    * Input/Output Modeling
* Coordinator

## 📱 기능 및 UI

|기능/UI|설명|
|:-|:-|
|박스오피스 목록|일간, 주간, 주말별로 박스오피스 순위를 보여준다.|
|영화 상세화면|목록화면에서 선택한 영화의 상세한 정보를 보여준다. 공유버튼을 통해 영화의 정보를 공유할 수 있다. 그리고 '리뷰쓰기' 버튼을 통해 영화에 대한 새로운 평가를 작성할 수 있다. 작성되었던 리뷰의 목록도 보여준다.|
|리뷰 쓰기|새로운 리뷰를 작성할 수 있다. 별명, 암호, 리뷰내용, 별점, 프로필 사진 등으로 구성되어있고, 필수 정보를 입력하면 리뷰를 등록할 수 있다.|

&nbsp;

## 💻 설계 및 구현

### MVVM + Coordinator 구조

![](https://i.imgur.com/6o3tI9i.png)

&nbsp;

### 역할 분배

|class/struct|역할|
|:-|:-|
|`AppCoordinator`|앱의 루트. 첫 화면을 준비하기 위한 타입|
|`BoxOfficeListCoordinator`|목록 화면의 화면 전환을 담당하는 타입|
|`BoxOfficeListViewController`|박스오피스 순위를 일간/주간/주말 별로 보여준다.|
|`MovieDetailViewController`|영화의 상세한 정보를 보여준다.|
|`CreateReviewCoordinator`|리뷰 작성 화면의 화면 전환을 담당하는 타입|
|`CreateReviewViewController`|영화에 대한 새로운 리뷰를 작성할 수 있는 화면이다.|

&nbsp;

### Utilities
|class/struct|역할|
|:-|:-|
|`DefaultAPIProvider`|네트워크 요청을 하는 기본 타입이다.|
|`BoxOfficeRepository`|네트워크를 통해 받아온 Response를 뷰에서 사용하기 수월하도록 처리해주는 타입이다.|
|`FirebaseManager`|파이어베이스를 활용하여 리뷰를 등록, 삭제, 불러오기를 할 수 있는 타입이다.|
|`ImageCacheManager`|이미지 캐싱을 담당하는 타입이다.|

&nbsp;


## 👀 실행 화면

> 🎥 박스오피스 랭킹 화면

<img src="https://i.imgur.com/1atUMup.jpg" width="30%"> <img src="https://i.imgur.com/uTbzWfz.png" width="30%">

&nbsp;

> 📺 영화의 상세 정보를 나타내는 화면

<img src="https://i.imgur.com/xVnZ1qW.jpg" width="30%"> <img src="https://i.imgur.com/hSZIKzx.png" width="30%">

&nbsp;

> 📝 리뷰를 작성할 수 있는 화면

<img src="https://i.imgur.com/7eHEf0j.png" width="30%"> <img src="https://i.imgur.com/v0wCPPn.png" width="30%">

&nbsp;

## 💪🏻 기술적 도전

### Combine

연속된 escaping closure를 피하고, 선언형 프로그래밍을 통한 높은 가독성과 오퍼레이터들을 통한 효율적인 비동기 처리를 위해서 Combine을 사용하게 되었습니다.

&nbsp;

### Coordinator

화면 전환에 대한 로직을 ViewController로부터 분리하고 의존성 객체에 대한 주입을 외부에서 처리하도록 하기 위해 코디네이터를 적용했습니다.

&nbsp;

### Firebase-FireStore

하나의 쿼리에 정렬과 필터링 모두 가능하여 복합적인 쿼리가 가능하고, 대용량 데이터가 자주 읽힐 때 사용하기 좋은 FireStore 데이터베이스를 사용하였습니다.

&nbsp;

## 🔥 Trouble Shooting

### PassthroughSubject로 이벤트를 보냈는데, 왜 뷰가 이벤트를 전달받지 못하는 걸까?

* `문제상황` 뷰모델에서 PassthroughSubject 타입으로 Publisher를 구현하고, 뷰에게 전달할 때는 AnyPublisher로 변환하여 구독할 수 있도록 해주었다. 하지만 send를 통해 새로운 값을 전달했음에도 불구하고, 구독하고 있는 뷰에서 전혀 전달받지 못하는 상황이였다.
* `이유` PassthroughSubject의 경우 새로운 값을 전달할 때, 구독하고 있는 Subscriber가 존재하지 않으면 값을 전달하지 않고 삭제하기 때문이였다.
* `해결` 그래서 PassthroughSubject 타입을 CurrentValueSubject로 변경해주어 문제를 해결하게 되었다. CurrentValueSubject는 PassthroughSubject와 달리 가장 최근에 publish된 element의 버퍼를 유지한다.

&nbsp;

## 😵‍💫 고민했던 점

### 👩‍💻 화면을 어떻게 구성하면 좋을까?

프로젝트 요구사항에는 화면을 자유롭게 구성 및 배치하라고 되어있어서 막막했다. 그래서 함께 프로젝트 요구사항을 체크해서 구현해야하는 기능 명세를 정리하고, 타사 앱들을 참고해가며 Figma를 사용해서 어설프지만[?] 최대한 할 수 있는 만큼 실력을 발휘해서 UI 배치를 성공적으로 마무리했다.
고민했던 부분은...

- 별점을 어떤 방식으로 등록하는 것이 편할까?
- 박스오피스 순위를 높은 가독성으로 구성하고 싶다.
- 프로필 사진의 경우, 어떤 동작으로 등록을 할 수 있도록 하면 좋을까?

> [당시 만들었던 프로토타입 바로가기](https://www.figma.com/file/2ciFno4UOd7MXM5XI4mCPA/BoxOffice?node-id=0%3A1&t=yahDndPh0BfFJDNM-1)

&nbsp;

### 👩‍💻 뷰와 뷰모델을 어떻게 나눌까?

고민했던 상황은 작성되어 있는 리뷰를 삭제하는 버튼을 누르면 그 리뷰를 작성한 사람이 비밀번호를 입력하고, 그 비밀번호가 저장되어있던 비밀번호와 일치하면 삭제가 되고, 일치하지 않으면 비밀번호가 일치하지 않는다는 알림이 뜨도록 해야했다. 

맨 처음에 생각한 방식은, 뷰에서 뷰모델로 해당 셀의 index를 전달해주면 뷰모델에서 비밀번호가 일치하는지 확인하여 `UIAlertController`까지 생성하여 뷰로 전달해주도록 하는 방식이었다. 
하지만 뷰모델에서 UIAlertController를 생성하여 전달해주려고 하니 UIKit을 import해야하고, 또 뷰모델의 역할과 맞지 않다는 것을 알게되었다. 따라서 아래와 같은 순서로 뷰와 뷰모델의 역할을 나누어 구현해주었다.

1. `view`: 얼럿을 띄워서 비밀번호를 입력받는다.
2. `view`: 비밀번호 입력 후 사용자가 확인 버튼을 누르면 해당 비밀번호를 viewModel에게 전달해준다.
3. `viewModel`: 전달받은 비밀번호를 검사하고, 비밀번호가 정상이라면 리뷰를 제거하고, 그렇지 않다면 에러메세지를 view에게 전달한다.
4. `view`: 에러메세지를 전달받는다면 에러 얼럿을 띄운다.

#### 실제 코드
```swift
// ViewModel

var _errorMessage = CurrentValueSubject<String?, Never>(nil) 
var errorMessage: AnyPublisher<String?, Never> { return _errorMessage.eraseToAnyPublisher() }

func checkPassword(_ inputPassword: String, index: Int) {
    // 비밀번호가 일치하지 않는 상황
    
    _errorMessage.send("비밀번호가 일치하지 않습니다.") // _errorMessage에 string값 보냄
}
```

```swift
// ViewController

func bind() {
    viewModel.output.errorMessage // 뷰모델의 errorMessage를 구독
        .compactMap { $0 }            
        .sinkOnMainThread(receiveValue: { [weak self] message in
                self?.showAlert(message: message)
        }) 
        .store(in: &cancelable)
}
```
<br>

요약하면, `_errorMessage`에게 비밀번호가 일치하지 않는다는 string값을 `send`하면 **_errorMessage를 AnyPublisher로 바꿔주는** `errorMessage`가 값을 가지고 있게 된다. 따라서 뷰에서는 값을 가지고 있는 `errorMessage`를 `sink`(구독)하여 값이 변경될 때마다 처리해줄 로직을 내부에 작성해두면 되는 것이다.


&nbsp;

### 👩‍💻 셀의 버튼을 눌렀을 때 셀의 위치를 어떻게 알까?

리뷰를 삭제하는 버튼을 눌렀을 때 해당 셀의 위치를 알아야 리뷰를 담고있는 데이터의 위치 또한 알 수 있기 때문에 index를 알아야했다. 
찾아보니 셀의 위치를 알 수 있는 방법으로 UIGestureRecognizer를 사용하거나 delegate를 사용하는 방법 등등 여러 방법이 있었는데 우리는 아래와 같은 방법을 사용했다.


```swift
@objc func deleteButtonDidTap(_ sender: UIButton) {
    let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
    let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
}
```
deleteButtonDidTap 메서드 내부에서 버튼의 위치를 잡고 tableView의 좌표로 변환한 다음 해당 좌표에서 행의 indexPath를 가져올 수 있었다.

