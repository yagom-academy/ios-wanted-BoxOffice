# BoxOffice

## Feature

### 영화순위 및 상세정보 조회

|                     영화순위 조회 (일별)                     |                  영화순위 조회 (주간/주말)                   |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/36187265/197319153-aacaa4cc-dfde-42c7-bab4-027718a00834.png" alt="daily" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319147-8e37e533-5e2a-4784-9d95-f56aae3941b4.png" alt="weekly" style="zoom:25%;" /> |

-   [영화진흥위원회 Open API](http://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do)를 활용하여 일별/주간/주말 박스오피스 목록을 조회
<br>
<br>



|                        영화상세 조회                         |                           공유하기                           |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/36187265/197319143-4f06c9c5-4ad3-4a7d-8c99-0cc8b9573cd1.png" alt="detail" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319115-8f549188-bb9c-48cc-83dd-8073c184717d.png" alt="share" style="zoom:25%;" /> |

-   영화 클릭시 상세정보 조회
-   공유 버튼클릭시 상세정보를 텍스트로 공유
<br>
<br>


### 리뷰 추가/삭제/조회

|                          리뷰 작성                           |                      유효하지 않은 경우                      |                         유효한 경우                          |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/36187265/197319138-23b6a980-67cd-4879-ba1e-7e0a470db3d6.png" alt="review-add" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319133-d1cc1582-b7be-47f8-ba20-f0a2caed1904.png" alt="invalid-password" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319128-8ab39f21-dbf9-4f66-bc2b-f7556033e45f.png" alt="valid-password" style="zoom:25%;" /> |

- 작성버튼 클릭시 리뷰작성화면으로 이동
- [Firebase-FireStore](https://firebase.google.com/docs/firestore)를 활용하여 리뷰 추가, 삭제, 조회
- [Firebase-FireStorage](https://firebase.google.com/docs/storage)를 활용하여 프로필 이미지 업로드


- 유효성을 검증하여 버튼 활성화/비활성화 

    - 닉네임과 비밀번호는 필수사항
    - 암호는 6자리 이상, 20자리 이하
    - 암호는 알파벳 소문자, 숫자, 특수문자(!, @, #, $) 중 반드시 한 가지 이상을 포함
<br>
<br>


|                        리뷰 삭제 (전)                        |                        삭제 완료 (후)                        |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| <img src="https://user-images.githubusercontent.com/36187265/197319122-031cd520-f4a6-481d-b76e-ef8d6ea012d4.png" alt="review-delete-swipe" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319118-7a361c98-c097-4fc7-b6bc-80c90c7f2782.png" alt="review-deleted" style="zoom:25%;" /> |

-   저장버튼 클릭시 영화상세화면으로 이동 및 작성된 리뷰 조회 가능 
-   리뷰 스와이프시 리뷰삭제버튼
<br>
<br>

| 삭제시 비밀번호 검증                                         | 검증 재시도                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="https://user-images.githubusercontent.com/36187265/197319121-c3df0890-7a62-4539-b5f5-5e36fbfc7707.png" alt="review-password" style="zoom:25%;" /> | <img src="https://user-images.githubusercontent.com/36187265/197319119-b193430d-dc62-4040-915d-eb4f3864c260.png" alt="review-password-incorrect" style="zoom:25%;" /> |

- 리뷰 삭제버튼 클릭시 비밀번호가 일치하는지 확인한 후 리뷰삭제
- 일치하지 않는다면 재입력 요청
<br>

# Development Tool

-   Frameworks: UIKit 
-   Tools: Xcode 16
-   Language: Swift 5
<br>

# Contributors

[![betterhee](https://github.com/betterhee.png?size=100)](https://github.com/betterhee)

-   dahee (홍다희)

