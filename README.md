# ios-wanted-BoxOffice

## 👩🏻‍💻제작

### Mango(강민교)
<img src="https://user-images.githubusercontent.com/61138164/194685598-2fb5ef98-a001-44d2-b020-50554b1cf939.png" width="200" height="200"/></img>

## 💻 기능구현방식
### 첫번째화면_박스오피스 순위
#### TableView를 이용해 박스오피스 순위를 보여줍니다.
1. Poster Image
2. 영화 제목
3. 개봉일
4. 박스오피스 순위 & 랭킹에 신규 진입 여부
5. 전일대비 순위의 증감분
6. 누적 관객수


#### URLSession을 이용해 BoxOfficeService에서 Networking 합니다.
 1. 박스오피스 순위를 불러와 영화코드를 얻습니다.
 2. 영화코드를 이용해 영화 상세정보를 얻습니다.
 3. 영화이름을 이용해 영화 포스터 이미지를 얻습니다.


#### NSCache를 이용해 Poster Image를 캐싱합니다.


### 두번째화면_영화 상세정보 
#### 영화의 상세정보를 보여줍니다.
1. Poster Image
2. 관람등급
3. 영화 제목
4. 영화 제목 (영문)
5. 장르
6. 상영시간
7. 개봉일
8. 제작일
9. 박스오피스 순위 & 랭킹에 신규 진입 여부
10. 전일대비 순위의 증감분
11. 누적 관객수
12. 감독
13. 출연진(배우)


## 📱구현화면
### 첫번째화면_박스오피스 순위
<p>
<img width="290" alt="스크린샷 2022-10-22 오후 4 19 56" src="https://user-images.githubusercontent.com/98341623/197326199-6a6b4fa9-ecaa-48bc-bff8-762d9abe22ab.png">
<img width="288" alt="스크린샷 2022-10-22 오후 4 25 42" src="https://user-images.githubusercontent.com/98341623/197326394-2fac4f6d-101b-4dae-b06b-0223db5a6ede.png">
</p>

### 두번째화면_영화 상세정보 
<img width="288" alt="스크린샷 2022-10-22 오후 4 20 13" src="https://user-images.githubusercontent.com/98341623/197326195-fd01758f-9ae3-459d-88a4-cb1ea2afcc38.png">

## 🎥실행영상
https://user-images.githubusercontent.com/98341623/197327632-cfcd19b4-24cb-440e-86fb-c439854dc932.mov
