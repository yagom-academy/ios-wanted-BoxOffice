//
//  MockData.swift
//  BoxOffice
//
//  Created by sole on 2022/10/18.
//

import UIKit

struct Movie: Hashable {
    let main: MainInformation
    var plot: Plot
    let detail: DetailInformation
    let review: Review?
}

struct Banner: Hashable {
    let image: UIImage
}

class MockDataController {
    static let shared = MockDataController()
    private init() {
        generateItems()
    }
    
    private var items = [RankingItem]()
    private func generateItems() {
        items = [
            .banner(.init(image: UIImage(named: "testImage1")!)),
            .banner(.init(image: UIImage(named: "testImage2")!)),
            
            .ranking(.init(
                           main: MainInformation(id: 616670,
                                                posterPath: "/pZG6SMsRij6MHeRa9wjUAxneDei.jpg",
                                                backdropPath: "hS2NJsSNNtmDflANdVuv9jJUm86.jpg",
                                                ranking: 4,
                                                ratioComparedToYesterday: 0,
                                                isIncreased: .same,
                                                isNewEntered: false,
                                                koreanName: "인생은 아름다워",
                                                englishName: "Life is Beautiful",
                                                releasedDate: "2022-09-28",
                                                dailyAttendance: 4454,
                                                totalAttendance: 829737),
                       plot: Plot(content: "무뚝뚝한 남편 진봉과 무심한 아들딸을 위해 헌신하며 살아온 세연은 어느 날 자신에게 시간이 얼마 남지 않았다는 것을 알게 된다. 한치 앞도 알 수 없는 인생에 서글퍼진 세연은 마지막 생일 선물로 문득 떠오른 자신의 첫사랑을 찾아달라는 황당한 요구를 한다. 막무가내로 우기는 아내의 고집에 어쩔 수 없이 여행길에 따라나선 진봉은 아무런 단서도 없이 이름 석자만 가지고 무작정 전국 방방곡곡을 누빈다. 시도 때도 없이 티격태격 다투던 두 사람은 가는 곳곳마다 자신들의 찬란했던 지난날 소중한 기억을 하나 둘 떠올리는데..."),
                       detail: DetailInformation(productionYear: "2020",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 2분",
                                                            genres: ["뮤지컬"],
                                                            directors: ["최국회"],
                                                            actors: ["류승룡", "염정아", "박세완"],
                                                            watchGrade: "12세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: 736820,
                                             posterPath: "/8FPbEnvnjMP7PoU63QQpV7IjMKU.jpg",
                                            backdropPath: "/xov3ufX4ZRyw2pSF3XLNjtvZPw4.jpg",
                                            ranking: 5,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "공조2: 인터내셔날",
                                            englishName: "Confidential Assignment2: International",
                                            releasedDate: "2022-09-27",
                                            dailyAttendance: 11234,
                                            totalAttendance: 6772992),
                       plot: Plot(content: "남한으로 숨어든 글로벌 범죄 조직을 잡기 위해 새로운 공조 수사에 투입된 북한 형사 림철령. 수사 중의 실수로 사이버수사대로 전출됐던 남한 형사 강진태는 광수대 복귀를 위해 모두가 기피하는 철령의 파트너를 자청한다. 이렇게 다시 공조하게 된 철령과 진태! 철령과 재회한 민영의 마음도 불타오르는 가운데, 철령과 진태는 여전히 서로의 속내를 의심하면서도 나름 그럴싸한 공조 수사를 펼친다. 드디어 범죄 조직 리더인 장명준의 은신처를 찾아내려는 찰나, 미국에서 날아온 FBI 소속 잭이 그들 앞에 나타나는데…"),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 8분",
                                                            genres: ["액션", "코미디"],
                                                            directors: ["이석훈"],
                                                            actors: ["현빈", "유해진", "임윤아"],
                                                            watchGrade: "15세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: nil,
                                            posterPath: nil,
                                            backdropPath: nil,
                                            ranking: 9,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교",
                                            englishName: "Crayon Shin-chan: School Mystery! The Splendid Tenkasu Academy",
                                            releasedDate: "2022-09-28",
                                            dailyAttendance: 223111,
                                            totalAttendance: 555009),
                       plot: Plot(content: nil),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "1시간 44분",
                                                            genres: ["애니메이션"],
                                                            directors: ["타카하시 와타루"],
                                                            actors: [],
                                                            watchGrade: "전체관람가"),
                       review: nil)),
            .ranking(.init(
                           main: MainInformation(id: 616670,
                                                 posterPath: "/pZG6SMsRij6MHeRa9wjUAxneDei.jpg",
                                                backdropPath: "hS2NJsSNNtmDflANdVuv9jJUm86.jpg",
                                                ranking: 3,
                                                ratioComparedToYesterday: 0,
                                                isIncreased: .same,
                                                isNewEntered: false,
                                                koreanName: "인생은 아름다워",
                                                englishName: "Life is Beautiful",
                                                releasedDate: "2022-09-28",
                                                dailyAttendance: 9932,
                                                totalAttendance: 829737),
                       plot: Plot(content: "무뚝뚝한 남편 진봉과 무심한 아들딸을 위해 헌신하며 살아온 세연은 어느 날 자신에게 시간이 얼마 남지 않았다는 것을 알게 된다. 한치 앞도 알 수 없는 인생에 서글퍼진 세연은 마지막 생일 선물로 문득 떠오른 자신의 첫사랑을 찾아달라는 황당한 요구를 한다. 막무가내로 우기는 아내의 고집에 어쩔 수 없이 여행길에 따라나선 진봉은 아무런 단서도 없이 이름 석자만 가지고 무작정 전국 방방곡곡을 누빈다. 시도 때도 없이 티격태격 다투던 두 사람은 가는 곳곳마다 자신들의 찬란했던 지난날 소중한 기억을 하나 둘 떠올리는데..."),
                       detail: DetailInformation(productionYear: "2020",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 2분",
                                                            genres: ["뮤지컬"],
                                                            directors: ["최국회"],
                                                            actors: ["류승룡", "염정아", "박세완"],
                                                            watchGrade: "12세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: 736820,
                                             posterPath: "/8FPbEnvnjMP7PoU63QQpV7IjMKU.jpg",
                                            backdropPath: "/xov3ufX4ZRyw2pSF3XLNjtvZPw4.jpg",
                                            ranking: 7,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "공조2: 인터내셔날",
                                            englishName: "Confidential Assignment2: International",
                                            releasedDate: "2022-09-27",
                                            dailyAttendance: 1121,
                                            totalAttendance: 6772992),
                       plot: Plot(content: "남한으로 숨어든 글로벌 범죄 조직을 잡기 위해 새로운 공조 수사에 투입된 북한 형사 림철령. 수사 중의 실수로 사이버수사대로 전출됐던 남한 형사 강진태는 광수대 복귀를 위해 모두가 기피하는 철령의 파트너를 자청한다. 이렇게 다시 공조하게 된 철령과 진태! 철령과 재회한 민영의 마음도 불타오르는 가운데, 철령과 진태는 여전히 서로의 속내를 의심하면서도 나름 그럴싸한 공조 수사를 펼친다. 드디어 범죄 조직 리더인 장명준의 은신처를 찾아내려는 찰나, 미국에서 날아온 FBI 소속 잭이 그들 앞에 나타나는데…"),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 8분",
                                                            genres: ["액션", "코미디"],
                                                            directors: ["이석훈"],
                                                            actors: ["현빈", "유해진", "임윤아"],
                                                            watchGrade: "15세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: nil,
                                             posterPath: nil,
                                            backdropPath: nil,
                                            ranking: 10,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교",
                                            englishName: "Crayon Shin-chan: School Mystery! The Splendid Tenkasu Academy",
                                            releasedDate: "2022-09-28",
                                            dailyAttendance: 2211,
                                            totalAttendance: 555009),
                       plot: Plot(content: nil),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "1시간 44분",
                                                            genres: ["애니메이션"],
                                                            directors: ["타카하시 와타루"],
                                                            actors: [],
                                                            watchGrade: "전체관람가"),
                       review: nil)),
            .ranking(.init(
                           main: MainInformation(id: 616670,
                                                 posterPath: "/pZG6SMsRij6MHeRa9wjUAxneDei.jpg",
                                                backdropPath: "hS2NJsSNNtmDflANdVuv9jJUm86.jpg",
                                                ranking: 2,
                                                ratioComparedToYesterday: 0,
                                                isIncreased: .same,
                                                isNewEntered: false,
                                                koreanName: "인생은 아름다워",
                                                englishName: "Life is Beautiful",
                                                releasedDate: "2022-09-28",
                                                dailyAttendance: 1121,
                                                totalAttendance: 829737),
                       plot: Plot(content: "무뚝뚝한 남편 진봉과 무심한 아들딸을 위해 헌신하며 살아온 세연은 어느 날 자신에게 시간이 얼마 남지 않았다는 것을 알게 된다. 한치 앞도 알 수 없는 인생에 서글퍼진 세연은 마지막 생일 선물로 문득 떠오른 자신의 첫사랑을 찾아달라는 황당한 요구를 한다. 막무가내로 우기는 아내의 고집에 어쩔 수 없이 여행길에 따라나선 진봉은 아무런 단서도 없이 이름 석자만 가지고 무작정 전국 방방곡곡을 누빈다. 시도 때도 없이 티격태격 다투던 두 사람은 가는 곳곳마다 자신들의 찬란했던 지난날 소중한 기억을 하나 둘 떠올리는데..."),
                       detail: DetailInformation(productionYear: "2020",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 2분",
                                                            genres: ["뮤지컬"],
                                                            directors: ["최국회"],
                                                            actors: ["류승룡", "염정아", "박세완"],
                                                            watchGrade: "12세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: 736820,
                                             posterPath: "/8FPbEnvnjMP7PoU63QQpV7IjMKU.jpg",
                                            backdropPath: "/xov3ufX4ZRyw2pSF3XLNjtvZPw4.jpg",
                                            ranking: 6,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "공조2: 인터내셔날",
                                            englishName: "Confidential Assignment2: International",
                                            releasedDate: "2022-09-27",
                                            dailyAttendance: 11123,
                                            totalAttendance: 6772992),
                       plot: Plot(content: "남한으로 숨어든 글로벌 범죄 조직을 잡기 위해 새로운 공조 수사에 투입된 북한 형사 림철령. 수사 중의 실수로 사이버수사대로 전출됐던 남한 형사 강진태는 광수대 복귀를 위해 모두가 기피하는 철령의 파트너를 자청한다. 이렇게 다시 공조하게 된 철령과 진태! 철령과 재회한 민영의 마음도 불타오르는 가운데, 철령과 진태는 여전히 서로의 속내를 의심하면서도 나름 그럴싸한 공조 수사를 펼친다. 드디어 범죄 조직 리더인 장명준의 은신처를 찾아내려는 찰나, 미국에서 날아온 FBI 소속 잭이 그들 앞에 나타나는데…"),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "2시간 8분",
                                                            genres: ["액션", "코미디"],
                                                            directors: ["이석훈"],
                                                            actors: ["현빈", "유해진", "임윤아"],
                                                            watchGrade: "15세이상관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: nil,
                                             posterPath: nil,
                                            backdropPath: nil,
                                            ranking: 8,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교",
                                            englishName: "Crayon Shin-chan: School Mystery! The Splendid Tenkasu Academy",
                                            releasedDate: "2022-09-28",
                                            dailyAttendance: 9932,
                                            totalAttendance: 555009),
                       plot: Plot(content: nil),
                       detail: DetailInformation(productionYear: "2021",
                                                            releasedYear: "2022",
                                                            runningTime: "1시간 44분",
                                                            genres: ["애니메이션"],
                                                            directors: ["타카하시 와타루"],
                                                            actors: [],
                                                            watchGrade: "전체관람가"),
                       review: nil)),
        .ranking(.init(
                       main: MainInformation(id: 616670,
                                             posterPath: "/pZG6SMsRij6MHeRa9wjUAxneDei.jpg",
                                            backdropPath: "hS2NJsSNNtmDflANdVuv9jJUm86.jpg",
                                            ranking: 1,
                                            ratioComparedToYesterday: 0,
                                            isIncreased: .same,
                                            isNewEntered: false,
                                            koreanName: "인생은 아름다워",
                                            englishName: "Life is Beautiful",
                                            releasedDate: "2022-09-28",
                                            dailyAttendance: 2221,
                                            totalAttendance: 829737),
                   plot: Plot(content: "무뚝뚝한 남편 진봉과 무심한 아들딸을 위해 헌신하며 살아온 세연은 어느 날 자신에게 시간이 얼마 남지 않았다는 것을 알게 된다. 한치 앞도 알 수 없는 인생에 서글퍼진 세연은 마지막 생일 선물로 문득 떠오른 자신의 첫사랑을 찾아달라는 황당한 요구를 한다. 막무가내로 우기는 아내의 고집에 어쩔 수 없이 여행길에 따라나선 진봉은 아무런 단서도 없이 이름 석자만 가지고 무작정 전국 방방곡곡을 누빈다. 시도 때도 없이 티격태격 다투던 두 사람은 가는 곳곳마다 자신들의 찬란했던 지난날 소중한 기억을 하나 둘 떠올리는데..."),
                   detail: DetailInformation(productionYear: "2020",
                                                        releasedYear: "2022",
                                                        runningTime: "2시간 2분",
                                                        genres: ["뮤지컬"],
                                                        directors: ["최국회"],
                                                        actors: ["류승룡", "염정아", "박세완"],
                                                        watchGrade: "12세이상관람가"),
                   review: nil))
        ]
    }
    
    func items(for rankingSection: RankingSection) -> [RankingItem] {
        var result = [RankingItem]()
        switch rankingSection {
        case .onboarding:
            let onboardingItems = items.filter { $0.type == "onboarding" }
            result = onboardingItems
        case .ranking:
            let rankingItems = items.filter { $0.type == "ranking" }
            result = rankingItems
        }
        return result
    }
    
    func items(with items: [DetailItem], for detailSection: DetailSection) -> [DetailItem] {
        var result = [DetailItem]()
        switch detailSection {
        case .main:
            let mainItems = items.filter { $0.type == "main" }
            result = mainItems
        case .plot:
            let plot = items.filter { $0.type == "plot" }
            result = plot
        case .detail:
            let detailItems = items.filter { $0.type == "detail" }
            result = detailItems
        }
        return result
    }
}
