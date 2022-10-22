# ios-wanted-BoxOffice

## 👨🏻‍💻 만든 사람

|                                                                Eddy(권준상)                                                                 |
| :-----------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/31722496/192504266-ff50f0da-68f1-488d-82a5-765cc5a249be.png" width="200" height="200"/> |

## 📁 폴더 구조

<img width="176" alt="스크린샷 2022-10-21 오후 8 58 06" src="https://user-images.githubusercontent.com/61138164/197190601-939beaf7-f3b8-4d90-aec7-e36150a97676.png">

### Application

- AppDelegate, SceneDelegate, Info.plist등

### Resource

- **Asset**

### Source

- **Scene**: 기능 구현에 사용되는 파일들
  - MovieRank : 첫번째 화면, 박스오피스 순위 정보 화면
  - DetailInfo : 두번째 화면, 영화의 세부 정보 화면
- **Network**: 서버 통신을 위한 파일들
  - Manager : 서버 통신이 진행되는 곳
  - Entity : 앱 내에서 사용되는 데이터 모델
  - DTO : 서버 통신 시 사용되는 데이터 모델
- **Extension**: Extension들 모음

<br>

## 📱 구현 화면

### 첫 번째 화면 (일간, 주말 박스오피스 순위 화면)

<div>
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197199611-bd5de3ef-3bb7-4ed5-9436-8deaf50bbc66.png">
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197198764-1d1a927b-73e4-40e8-8e6f-c149f5302f0b.png">
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197199626-fc903333-98e2-482b-8c94-dffcc1dcc26a.png">
</div>

### 두 번째 화면 (영화의 세부 정보)

<div>
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197198848-5384e71e-d236-40c4-8d24-ca4b21b32bd2.png">
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197198840-39d8a917-efeb-42ab-80cc-6155637825d0.png">
<img width="250" height="550" src="https://user-images.githubusercontent.com/61138164/197198819-66a3f6e5-f096-4940-936e-7506144c6e04.png">
</div>

## 🛠 기능 구현 방식

**Compositional Layout**

- Compositional Layout을 사용하여 레이아웃을 구현하였습니다.
- 첫 번째 화면은 각 Section에서 보여주는 데이터가 비슷하여 Diffable DataSource를 사용하였습니다.
- 두 번째 화면은 각 Section에서 보여주는 데이터가 많이 달라서 기존의 방식을 사용하여 구현하였습니다.
- 일별 박스오피스와, 주말 박스오피스를 한번에 보이게 하는 레이아웃으로 구현하였습니다.

**Networking**

- URLSession을 이용하여 NetworkService에서 네트워킹을 합니다.
- 영화의 포스터 이미지를 얻기 위해서는 상당히 복잡한 절차가 필요했습니다.
  1. 일일 박스 오피스 순위 API에서 해당 영화의 코드 번호를 얻음
  2. 코드 번호를 통해 영화 세부 정보 API를 호출, 영화의 영어 이름을 얻음
  3. 영어 이름을 통해 Ombd API를 호출, 포스터 이미지 URL을 얻음
  4. 이미지 URL을 이미지로 변환하여 얻음
- async, await 방식으로 동시성을 관리하였습니다.

**Cache**

- URLCache를 사용합니다.
- 영화 코드를 통해 세부정보 API 호출하는 URLRequest를 캐싱하였습니다.
- 영어 이름을 통한 Ombd API 호출하는 URLRequest를 캐싱하였습니다.
- 이미지 URLRequest를 캐싱하였습니다.

**Share**

- 공유하기 버튼 클릭 시, 메시지로 전달 가능합니다. (시뮬레이터 X, 실 기기에서만)

<br>

## 🕷 발생했던 문제

**처음 화면이 로드될 때 너무 오래 걸림**

- 위에서 설명했듯, 영화의 포스터 이미지를 얻기 위해서 굉장히 많은 API 호출이 필요합니다.
- <일별 박스 오피스 순위 화면 보여주기 위해서 일어나는 일>
  - 일별 박스 오피스 순위 API를 호출합니다. 10가지의 영화가 배열에 담겨서 옵니다. (1번 호출)
  - 각각의 영화의 코드 번호를 통해서 영화 세부 정보 API를 호출하여 영화의 영어 이름을 얻습니다. (10번 호출)
  - 영어 이름을 통해서 Ombd API를 호출하여 해당 영화의 포스터 URL을 얻습니다. (10번 호출)
  - URL을 이미지로 변환하여 각 Cell에 뿌립니다. (10번 호출)
- 저는 일별 박스 오피스, 주말 박스 오피스를 한번에 구현하였기 때문에 총 62번의 API 호출이 일어나서, 화면이 보여지는데에 40초 정도가 걸렸습니다.
- 이를 해결하기 위해서 두 가지 해결책을 생각하였습니다.
  1. 영화의 한글 이름을 Key, 영화의 영어 이름을 Value로 하는 Dictionary를 미리 구현해놓아서 10번의 호출을 줄이기
  2. URLCache를 통해서 시간을 단축하기
- 첫 번쨰 방식은 임시 방편이고, 순위는 매번 달라지기 때문에 의미가 없다고 생각하였습니다.
- 두 번째 방식은 첫 빌드는 오래 걸리지만, 그 이후부터는 빠르게 로드되기 때문에 두 번째 방식을 사용하였습니다.
- 매번 값이 달라지는 순위를 호출하는 API를 제외한, 영화의 세부 정보 호출 API, Ombd API, URL을 이미지로 변환하는 작업을 URLCache를 사용하여 캐싱하였습니다.
- 그 결과, 첫 번째 빌드할 때도 일별과 주말 순위에 겹치는 부분은 빠르게 로드되어서 어느 정도 로드 시간이 단축되었습니다. (그래도 첫 빌드는 느리긴 합니다.)

<br>

## 실행 영상

https://user-images.githubusercontent.com/61138164/197200146-d3e816db-38bb-4806-8063-3021a4ee02ae.mov
