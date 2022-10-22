# ios-wanted-BoxOffce

<img src= "https://user-images.githubusercontent.com/101572946/197328436-9c3295ee-af37-4cca-9d34-19ea79105b45.jpeg" width="150" height="150"/>

Hyun(박호현)


## BoxOffice.app 구현

#화면구성

- 첫번째화면

 Navigation bar 적용
 API를 통한 호출
 UILabel구현 (박스오피스 순위, 영화명, 개봉일, 관객수. 전일대비 순위의 증감분, 랭킹 신규 진입여부)

- 두번째화면

API를 통한 호출
UILabel구현 (박스오피스 순위, 영화명, 개봉일, 관객수. 전일대비 순위의 증감분, 랭킹 신규 진입여부, 제작연도,
개봉연도, 상영시간, 장르, 감독명, 배우명, 관람등급 명칭)

-보완할 점

첫번째화면 코드에서 tableView didselectRowAt에서 model를 초기화하는것에 실패하여
두번째화면에서 API를 받아오는데 성공했으나 사용하지 못하였다. (시뮬레이터 두번째화면에서 Label 값들이 nil로 표현)

-API
 BoxOfficeAPI(일가 영화 순위리스트)
 
 <img width="398" alt="스크린샷 2022-10-22 오후 4 56 04" src="https://user-images.githubusercontent.com/101572946/197328179-7e5f3d86-504e-4975-8008-d6f1f41f0438.png">
