## 프로젝트명: BoxOffice

**기간: 2023/01/02 ~ 2023/01/06**

**팀원: Neph, Minsson**

| <img src="https://avatars.githubusercontent.com/u/67148595?v=4" alt="img" style="zoom:50%;" /> | <img src="https://avatars.githubusercontent.com/u/96630194?v=4" alt="img" style="zoom:50%;" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|                             Neph                             |                           Minsson                            |

**채택한 아키텍쳐: Clean Architecture**

**서로 담당한 파트**

**Neph**: Movie Detail 화면의 Presentation Layer, 앱의 Data Layer

**Minsson**: Movie List 화면과 Review Writing 화면의 Presentation Layer

**공동 제작**: Domain Layer



## 앱의 구조 설명

### Domain Layer

- Entities
  - MovieOverview: 영화 리스트를 보여줄 화면에서 필요한 Entity입니다.
  - MovieDetail: 영화 상세페이지에서 사용되는 Entity입니다.
  - MovieReview: 영화에 대한 리뷰 정보를 담고있는 Entity입니다.
- UseCases
  - FetchMovieListUseCase: 영화 리스트를 가져오는 Use Case입니다.
  - FetchMovieDetailUseCase: 영화의 상세정보를 가져오는 Use Case입니다.
  - FetchMovieReviewUseCase: 영화의 리뷰를 가져오는 Use Case입니다.
  - DeleteMovieReviewUseCase: 영화의 리뷰를 삭제할 Use Case입니다.
  - FetchReviewImageUseCase: 영화 리뷰 내에 삽입된 이미지를 가져오는 Use Case입니다.
  - UploadReviewUseCase: 리뷰를 업로드하는 Use Case입니다.
  - FetchPosterImageUseCase: 영화 상세정보의 영문 영화명을 검색쿼리로 넣어 포스터 이미지를 가져오는 UseCase입니다.
- RepositoryInterfaces
  - MovieListRepositoryInterface: Movie List 화면에서 사용되는 네트워킹 메서드를 정의해놓은 인터페이스입니다.
  - MovieDetailRepositoryInterface: Movie Detail 화면에서 사용되는 네트워킹 메서드를 정의해놓은 인터페이스입니다.
  - ReviewWritingRepositoryInterface: 리뷰 작성 화면에서 사용되는 네트워킹 메서드를 정의해놓은 인터페이스입니다.

도메인 레이어에서는 앱 내에서 사용될 자료형(Entity)과 앱 내에서 수행되는 동작(UseCase)을 정의합니다.

Data Layer에서 구현될 Repository의 경우, Domain Layer가 Data Layer에 의존성을 가지지 않도록 하기위해 Interface를 protocol을 통해 제작하여 사용합니다.

<br/> 

### Presentation Layer

- MovieList
- MovieDetail
- ReviewWriting

Presentation Layer는 화면에 대한 요소들을 담고 있습니다.

각 화면에는 ViewController와 ViewModel이 존재하며, ViewModel에서는 View로부터 이벤트를 전달받아, 알맞은 UseCase를 호출합니다.

<br/> 

### Data Layer

- DTOs
  - MovieOverviewDTO: MovieOverview를 가져오기 위해 Decodable을 채택한 DTO입니다.
  - MovieDetailDTO: MovieDetail을 가져오기 위해 Decodable을 채택한 DTO입니다.
  - MovieReviewDTO: Firebase Store로부터 MovieReview를 가져오기 위한 로직과 자료구조가 담겨있는 DTO입니다.
  - PosterDTO: Poster 이미지를 가져오기 위해 Decodable을 채택한 DTO입니다.
- Repositories
  - MovieListRepository: Movie List 화면에서 사용되는 네트워킹 메서드들의 구현부입니다.
  - MovieDetailRepository: Movie Detail 화면에서 사용되는 네트워킹 메서드들의 구현부입니다.
  - ReviewWritingRepository: 리뷰 작성 화면에서 사용되는 네트워킹 메서드들의 구현부입니다.
- Services
  - NetworkService: URLRequest에 대한 task를 수행하는 계층입니다.
  - FirebaseService: Firebase에 접근하여 수행하는 task를 관리하는 계층입니다.

Data Layer에는 Repository의 구현부와 이때 사용되는 DTO들, 그리고 내부에서 네트워킹 통신을 진행하는 Service 계층이 존재합니다.

DTO에서 Entity로의 변환, Entity에서 DTO로의 변환 또한 Data Layer에서 이루어지게 됩니다.



### 기타 요소들

- Cancellable: 네트워킹 task를 cancel할 수 있도록 해주는 protocol입니다. 이번 프로젝트에서는 Firebase에서 사용하는 StorageDownloadTask에 Cancellable을 채택하여 추상화된 값을 전달하고 이를 상황에 맞게 cancel할 수 있도록 하였습니다.
- ColorAsset: 앱 내에서 사용될 color들의 정보를 담고있는 저장소입니다.

<br/> 

## 화면 설명

### Movie List
![image](https://user-images.githubusercontent.com/96630194/211037502-9ef75503-314c-4356-8f44-bc87402952d9.png)





### Movie Detail

**화면구조**

- 가장 염두에 두고 작업한 것은 "스크롤을 내릴때만 상단에 붙어있는 TabBar" 입니다.
- 상단에는 포스터 이미지와 영화의 정보가 노출되며 하단에는 추가적인 영화정보를 볼 수 있는 영화정보 탭, 리뷰를 확인할 수 있는 리뷰 탭이 존재합니다.

| <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230104111210.png" alt="image-20230104111210634" style="zoom:50%;" /> | <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230104111224.png" alt="image-20230104111224697" style="zoom:50%;" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|                    영화정보 탭에서의 화면                    |                      리뷰 탭에서의 화면                      |


### Movie Review
![image](https://user-images.githubusercontent.com/96630194/211033684-66114677-4862-424a-b2da-3cc3cf0506c8.png)



## 기능 설명

### ShareButton 액션

앱에서 무언가를 Share 한다면 어떤 것을 공유할지 고민한 결과

앱의 화면 자체를 공유할 수 있으면 좋겠다고 생각되어 이를 제작하였습니다.

### Delete Review

비밀번호를 alert의 textField를 통해 입력받고 비밀번호가 틀린 경우에는 다시 alert으로 알려줍니다.

비밀번호가 맞은 경우에는 삭제 후 변경된 dataSource를 apply합니다.



## 동작화면들

| <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230106233709.gif" alt="전체적인 동작" style="zoom:50%;" /> | <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230106233727.gif" alt="등록 및 삭제" style="zoom:50%;" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|                        전체적인 동작                         |                      리뷰 등록 및 삭제                       |
| <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230106233746.gif" alt="share버튼" style="zoom:50%;" /> | <img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230104112524.gif" alt="Tab전환 및 스크롤" style="zoom: 25%;" /> |
|                         Share action                         |                          Tab Change                          |
