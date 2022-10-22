# BoxOffice

![](https://user-images.githubusercontent.com/73588175/197322403-11bfc2ae-5ac9-451d-84b1-82317cf4c67c.gif) <br>
(동영상 재생을 위해 tmdb api 사용)

# Feature
### 일별 랭킹 페이지
전날을 기준으로 순위별 10위까지의 영화정보 로드<br>
api에 없는 정보(이미지, 동영상, 줄거리)는 No Image Available, Trailer Available, 정보없음 등으로 대체<br>
각 셀을 터치하면 상세정보 페이지로 이동
<br>
<br>

### 상세정보 페이지
영화의 상세정보 로드<br>
공유버튼을 터치하면 공유시트 팝업<br>
<br>
<br>

### 공유페이지
영화 포스터, 순위, 제목, 장르, 감독, 배우같은 중요정보 공유
<br>
<br>
<br>

# 고민할 점
### 첫번째 페이지와 두번째 페이지의 모델관리
1. kobis api에 영화순위와 함께 영화의 메인정보 요청<br>
2. 응답받은 데이터의 영화코드로 상세정보 요청<br>
3. 응답받은 데이터의 영화이름으로 영화 id, poster, backdrop, 줄거리 요청<br>
4. (아직 구현하지 못했지만) id로 트레일러 요청 <br>
의 순으로 데이터를 받는다.<br>
이 때 받은 데이터를 첫번째 페이지(랭킹 페이지)에서 쉽게 쓸 수 있게 가공하는데, <br>
두 번째 페이지에도 거의 모든 정보가 똑같이 쓰인다.<br>
<br>
하지만 섹션을 트레일러섹션, 줄거리섹션, 상세정보섹션으로 나눠서 한 정보로 세 개의 셀을 만들기 떄문에 만약 같은 모델로 사용한다면 sanpshot이 같은 정보를 세 번 업데이트하는 꼴이 된다.<br>
그렇다고 한 모델을 다시 세 개의 모델로 나누는 것은 괜찮은 건가? 라는 생각이 들었다.<br>
아직 diffable data source에 대한 이해가 부족하고 많이 이용해보지 못해 생각보다 까다로웠다.<br>
이제와서 든 생각이지만, <br>
많은 변화가 있는 앱이 아닌 이상 굳이 diffable data source를 쓸 이유가 있을까? 싶다.  
<br>
<br>

### 컬렉션셀의 동적 높이적용
분명 [apple에서 소개하고 있는 예제](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)에서는
```swift
func createLayout() -> UICollectionViewLayout {
    let estimatedHeight = CGFloat(100)
    let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(estimatedHeight))
    let item = NSCollectionLayoutItem(layoutSize: layoutSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                   subitem: item,
                                                   count: 1)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    section.interGroupSpacing = 10
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}
```
이렇게 item과 group에 같은 fractionalWidth로, 같은 estimatedHeight로 동적 높이를 주던데 나는 왜 안됐는지 아직 해결하지 못했다.
오토레이아웃을 좀 더 공부하고 다시 봐야할 것 같다.
