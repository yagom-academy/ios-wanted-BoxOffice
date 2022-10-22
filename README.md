# ios-wanted-BoxOffice

</br>

#### **Resource/SecretInfo.plist에 API Key 입력 후 실행해주세요.**

</br>

|Beeem(김수빈)|
|:---:|
|<img src="https://user-images.githubusercontent.com/31722496/192567901-5f1ede08-e89e-4adf-b987-2af47ec2d1a3.png" width="200" height="200"/>|
|[Github](https://github.com/skyqnaqna)|

</br>

## **개발 기간**

- 2022-10-17 ~ 2022-10-22

</br>

## **구조 및 기능**

https://user-images.githubusercontent.com/31722496/197324466-1ec12b41-f4e7-4abc-9a97-482194c20e5a.mp4

</br>

### **첫 번째 페이지**


<img src="https://user-images.githubusercontent.com/31722496/197322211-e3d7bc47-67cd-43be-af93-c084da5adfb7.png" width=100%>

- `UITableView`와 `UISegmentedControl`을 사용하여 영화 목록을 표현
- 포스터 이미지는 `NSCache`를 사용하여 캐싱
- 순위 변동과 순위에 새로 진입 여부 구현
- 보완할 점
	- 영화 정보를 불러오는 동안 인디케이터로 로딩 중임을 표시하기
	- 유동적 글자크기를 지원하려고 `preferredFont`를 사용했는데, `UILabel` 위치가 통일되지 않는 현상 고치기
	- 현재 포스터 이미지만 캐싱하고 있는데, 순위 정보를 제외한 영화 상세 정보도 캐싱하면 성능이 향상될 것으로 예상
	- 네트워킹 과정이 연쇄적이라 비효율적이라고 생각한다. 요청 수를 줄일 방법과 동기/비동기 처리를 고민하여 사용성을 개선하자

</br>

#### **Networking 흐름도**

<img src="https://user-images.githubusercontent.com/31722496/197323786-9e397a06-6de2-41ca-a24e-8e9940b9cfe2.png" width=100%>

- 각 `fetchMovie()` 함수에 대한 `performRequest()`, `parseJSON()` 함수가 연쇄적으로 동작

</br>

### **두 번째 페이지**


<img src="https://user-images.githubusercontent.com/31722496/197322215-b37585ac-9875-45f3-bf25-19b1b5e09636.png" width=100%>

- 2개의 Section으로 나누고 리뷰 정보는 FireStorage에서 불러온다
- 보완할 점
	- FireStorage에서 fetch한 데이터를 Delegate를 사용하여 가져오는데 순서가 랜덤함
		- 정렬 기능 적용하기

</br>

<img src="https://user-images.githubusercontent.com/31722496/197322216-6c4580d5-65f3-438c-9d5f-4e57014c341d.png" width=100%>

- `UIActivityViewController`를 사용하여 공유하기 기능 구현
- 보완할 점
	- 리뷰 내용 공유 추가하기
	- 공유 데이터 양식 수정하기

</br>

<img src="https://user-images.githubusercontent.com/31722496/197322217-6a282f1a-83d3-43a0-8e0d-67844d585711.png" width=100%>

- `UIAlertController` 사용
- 입력한 비밀번호가 일치할 경우에 삭제


</br>


### **세 번째 페이지**

<img src="https://user-images.githubusercontent.com/31722496/197322218-f97a9c8c-3abd-4ca4-8e5a-d6130c125cd2.png" width=100%>

<img src="https://user-images.githubusercontent.com/31722496/197324571-4cfbd94e-ef8f-4783-8da7-9ae9c68d80c9.png" width=100%>


- 별명과 비밀번호가 비어있으면 등록 불가능
- 리뷰 등록하면 FireStorage에 JSON 파일로 저장하고 두 번째 페이지로 이동
- 비밀번호 양식
	- 6자리 이상, 20자리 이하
	- 알파벳 소문자와 아라비아 숫자, 특수문자(!, @, #, $의 4가지)만을 입력
	- 반드시 알파벳 소문자, 아라비아 숫자, 특수문자가 각 1개 이상 포함
- 비밀번호 양식 검사는 정규표현식을 사용
```swift
  func checkValidPassword(_ pw: String) -> Bool {
    let pattern = #"^(?=.*[a-z])(?=.*\d)(?=.*[!@#$])[a-z0-9!@#$]{6,20}$"#

    if pw.range(of: pattern, options: .regularExpression) != nil {
      return true
    } else { return false }
  }
```

- 보완할 점
	- 키보드 입력시 커서의 위치와 화면 위치 때문에 시간을 많이 허비했다.
	- 세로모드에서는 괜찮지만 가로모드에서 어떻게 해결할지 더 고민하고 보완해야한다.
	- 사진 첨부 기능 구현하기


</br>

## **후기**

- 주어진 시간이 부족하여 디자인에 크게 신경쓰지 못했다. 후에 디자인과 성능을 보완해야겠다.
- 오토레이아웃과 네트워킹에 대해 더 자세히 학습해야겠다.
- MVVM에 대한 이해도가 부족하여 일단 MVC로 진행했다. MVVM을 학습하면서 리팩토링을 해야겠다.
- 팀원의 소중함을 느꼈다.
