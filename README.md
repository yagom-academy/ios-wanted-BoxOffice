## [루키](https://github.com/chaeyoon1101), [송만이](https://github.com/seunghui5247), [도도](https://github.com/dddowon)

## 앱 설명
- `Model-View-Controller 패턴` 
- `BoxOfficeModel` : 영화진흥위원회의 일별박스오피스 API 서비스을 통신하기 위한 모델들입니다. <br>
- `FilmDetailModel` : 영화진흥위원회의 영화 상세정보 API 서비스을 통신하기 위한 모델들입니다. <br>
- `PosterModel` : OMDB API를 이용하여 이미지를 가져오기 위한 모델들입니다. <br>
- `DatabaseModel` : Firebase의 데이터를 가져오기 위한 모델들입니다. <br>
- `Manager`
  - `NetworkManager` : 여러 URL을 사용하기 위한 제네릭한 URLSession 통신 함수를 구현했습니다.
  - `DateManager` : 날짜를 관리하는 함수를 구현했습니다.
  - `ImageManager` : 이미지 URL을 받아와 이미지로 바꿔주는 함수를 구현했습니다.
- `BoxOfficeController` : 일별 박스오피스 앱의 메인화면입니다.

<img src="https://user-images.githubusercontent.com/84975077/211028493-f5a0c415-847f-499f-aa44-b044c8f0aee8.png" width="25%">

- `CellViewController` : 메인화면의 컬렉션 뷰의 셀의 화면입니다.
<img src="https://user-images.githubusercontent.com/84975077/211029435-47d0f7db-2057-4693-b62d-fe6da5f95ef4.png" width="25%">

- `ReviewViewController` : 리뷰를 작성하기 위한 화면입니다.
<img src="https://user-images.githubusercontent.com/84975077/211029657-a7ee50bc-6815-4d9d-8d6c-a6c251f3bf43.png" width="25%">

## 아쉬웠던 점 && 구현 못한 점
- 두번째 사진의 리뷰 테이블뷰에 평점과 맞지 않게 별의 갯수가 채워져있는데 평점이 하나씩 밀려서 값이 저장이 되는 문제를 해결하지 못하였던게 아쉬웠습니다.
- 리뷰 작성시 사진 넣는 것을 구현하지 못하였던게 아쉬웠습니다.
- SMS 공유하기를 구현하지 못하였던게 아쉬웠습니다.
