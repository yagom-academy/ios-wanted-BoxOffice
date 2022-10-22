# ios-wanted-BoxOffice

<table>
    <tr align="center">
        <td><B>휘양(신동원)<B></td>
    </tr>
    <tr align="center">
        <td width= 170px>
            <img src="https://user-images.githubusercontent.com/33388081/194698936-8386e827-4021-4909-84a5-953e5382ba27.jpeg" width="60%">
        </td>
    </tr>
</table>


## 뷰 구성 정보 및 기능

| 박스오피스                                                   | 영화정보 및 리뷰 <br />(Swipe Action)                                                                 | 리뷰쓰기                                                                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="https://github.com/swc00057/ios-wanted-BoxOffice/blob/main/Simulator%20Screen%20Recording%20-%20iPhone%2013%20Pro%20-%202022-10-22%20at%2017.53.15.gif?raw=true" alt="pagination" width="100"/> | <img src="https://github.com/swc00057/ios-wanted-BoxOffice/blob/main/Simulator%20Screen%20Recording%20-%20iPhone%2013%20Pro%20-%202022-10-22%20at%2017.53.39.gif?raw=true" alt="delete" width="100"/> | <img src="https://github.com/swc00057/ios-wanted-BoxOffice/blob/main/Simulator%20Screen%20Recording%20-%20iPhone%2013%20Pro%20-%202022-10-22%20at%2017.54.15.gif?raw=true" alt="preview" width="100"/> | <img 



## 프로젝트 후기 및 고찰

### 휘양

- mvvm
  - mvvm구조를 지켜가며 구현해보려고 노력해보았다. 끝나고 보니 이게 mvvm이 맞나..? 싶은 엉성한 코드인것 같기도 하고, 끝나고 리팩토링을 좀 더 해봐야 할 것 같다.
- Codable의 한개의 속성, 여러개의 codingkey
  - 이번 선택사항에 주간 박스오피스를 보여주는 것이 있었다. response를 보니 일간과의 차이점은 프로퍼티의 이름뿐이었다. 그래서 기존 일간 박스오피스 모델은 그대로 사용하되 조건에 따라 두개의 codingkey를 사용하게 하였다. 이번에 새롭게 해본 것이라 기억에 많이 남는다.
- firebase storage를 게시판처럼 사용
  - 댓글을 쓰는 기능은 마치 게시판에 글을 쓰는 것과 유사한 기능이었는데, 서버가 없기 때문에 firebase Storage를 사용했다. 근데 사진이 포함된 경우가 막막했는데, 따로 업로드를 해주고 그 주소값을 알아내서 기존 글내용에 포함시켜야 읽어올수 있었기 때문이다. 과정 자체가 매우 험난했었지만 이러한 과정을 해본 것은 좋은 경험이었다.


