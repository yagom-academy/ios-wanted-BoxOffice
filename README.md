# BoxOffice
> 프로젝트 기간: 2022-01-02 ~ 2022-01-07</br>
> 팀원: [백곰](https://github.com/Baek-Gom-95), [aCafela coffee](https://github.com/aCafela-coffee)</br>

## 📑 목차
- [개발자 소개](#개발자-소개)
- [프로젝트 소개](#프로젝트-소개)
- [기능설명](#기능설명)
## 개발자 소개
|[aCafela coffee](https://github.com/aCafela-coffee)|[백곰](https://github.com/Baek-Gom-95)|
|:---:|:---:|
| <img src = "https://avatars.githubusercontent.com/u/70484506?v=4" width="250" height="250">| <img src = "https://i.imgur.com/5uwUyDt.jpg" width="250" height="250"> |

## 프로젝트 소개
- 영화진흥위원회 Open API, OMDb API 활용하여 구현하는 앱입니다.

## 기능설명

### MovieDetailView
- BoxOfficeList에서 선택한 영화상세보기 뷰 입니다.

### MovieDetailViewController
- BoxOfficeList에서 선택 한 영화상세보기 컨트롤러입니다.

### MovieDetailInfo
- BoxOfficeDetailAPI에서 받아올 데이터의 모델입니다.

### MoviePosterInfo
- MoviePosterAPI에서 받아올 데이터의 모델입니다.

### BoxOfficeDetailAPI
- 영화진흥위원회 Open API를 통해 영화의 상세정보 데이터를 받아올 Manager역할을 합니다.

### MoviePosterAPI
- OMDB Open API를 통해 영화 Poster를 받아올 Manager역할을 합니다.

### BoxOfficeListViewController
- 영화 목록을 보여줍니다.
- `1일, 1주, 주말, 주중`의 목록을 선택할 수 있습니다.
- `UICollectionViewDiffableDataSource` 사용
    - Cell추가, 수정으로 인한 실수를 줄일 수 있습니다.

### BoxOfficeListRequester
- `requestDailyList`, `requestWeeklyList` 함수를 사용하면 `KobisResult`를 돌려줍니다.
- `BoxOffice`의 프로퍼티에 주석을 달았습니다.
