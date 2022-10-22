# ios-wanted-BoxOffice

## 소개

| Kuerong(유영훈) |
| --- |
| <img src="https://avatars.githubusercontent.com/u/33388081?v=4" width="200" height="200"/> |
| Github |

## 개발 기간

2022.10.17 ~ 10.22

## 구조 및 기능

## 첫 번째 페이지

| <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328209-8538ead5-1969-4939-83f0-0e7367910d9f.png"> | <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328169-63f6715f-f032-4a91-8056-d1c3d3acfd47.png"> |

- `영화진흥위원회` API를 이용하여 일별, 주간, 주말 박스오피스 순위 10 리스트를 가져옴.
- TableView로 구현됨.


## 두 번째 페이지

| <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328279-807b0f53-5399-4a2f-bceb-d539912aed43.png"> | <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328285-b44a4acd-745a-4760-857d-f6c19af1c793.png"> |

- 영화의 세부 내용을 보여주는 페이지 Scroll View 로 구현됨.
- 리뷰 작성기능은 UI적 부분만 구현되어있으며 기능적으로 미완.


## 세 번째 페이지

| <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328319-b70725d3-609a-4b39-a354-72942a9ad469.png"> | <img width="400" alt="11" src="https://user-images.githubusercontent.com/33388081/197328321-14bea438-7a1e-4027-adc1-999af807bbf7.png"> |

- `SwiftUI`로 리뷰작성 뷰, 리뷰 리스트 뷰를 작성.
- UIHostingViewController를 이용하여 SwiftUI 뷰 불러옴.

```
 @IBAction func showAllCommentListView(_ sender: Any) {
      let vc = UIHostingController(rootView: CommentListView(commentManager: CommentManager.shared))
      self.navigationController?.navigationBar.backgroundColor = .clear
      self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
      navigationController?.pushViewController(vc, animated: true)
  }

  @IBAction func showCommentWriteView(_ sender: Any) {
      let vc = UIHostingController(rootView: CommentWriteView(commentManager: CommentManager.shared))
      self.navigationController?.navigationBar.backgroundColor = .clear
      self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
      navigationController?.pushViewController(vc, animated: true)
  }
```
