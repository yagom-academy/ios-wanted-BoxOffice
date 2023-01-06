//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    enum BoxOfficeRank: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
    }
    
    let networkManager = NetworkManager()
    private var movieModels = [BoxOfficeRank: MovieModel]() {
        didSet {
            if self.movieModels.count == 10 {
                DispatchQueue.main.async {
                    self.listView.boxOfficeCollectionView.reloadData()
                }
            }
        }
    }
    
    let listView = BoxOfficeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultSetting()
        configureDailyBoxOffice()
    }

    override func viewDidAppear(_ animated: Bool) {
        listView.layer.addBorder([.top], color: .black, width: 1)
    }
    
    private func configureDefaultSetting() {
        self.view.backgroundColor = .white
        self.view.addSubview(listView)
        self.navigationItem.title = "BoxOffice"
        self.configureUI()
        
        self.listView.boxOfficeCollectionView.dataSource = self
        self.listView.boxOfficeCollectionView.delegate = self
        self.listView.boxOfficeCollectionView.register(
            ListCollectionViewCell.self,
            forCellWithReuseIdentifier: "ListCollectionViewCell"
        )
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureDailyBoxOffice() {
        let api = EndPoints.makeBoxOfficeApi(
            key: APIKey.movieInfo.rawValue,
            date: DateFormatterManager.shared.convertToDateKey()
        )
        
        networkManager.dataTask(api: api) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let dailyBoxOfficeData: BoxOfficeResult = JSONManager.shared.decodeToInfo(
                        from: data
                      ) else { return }
               
                dailyBoxOfficeData.boxOfficeResult.dailyBoxOfficeList.forEach { info in
                    self.configureDetailInfo(info: info)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureDetailInfo(info: BoxOfficeInfo) {
        let api = EndPoints.makeDetailMovieApi(
            key: APIKey.movieInfo.rawValue,
            code: info.movieCd
        )
        
        networkManager.dataTask(api: api) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let detailMovieInfo: MovieInfoResult = JSONManager.shared.decodeToInfo(
                        from: data
                      ) else { return }
                self.configurePosterURL(from: info, detailMovieInfo.movieInfoResult.movieInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configurePosterURL(from info: BoxOfficeInfo, _ detailInfo: DetailInfo) {
        let api = EndPoints.makeOMDBFullDataApi(
            key: APIKey.omdb.rawValue,
            title: detailInfo.movieNmEn
        )
        
        guard detailInfo.nations.first?.nationNm != "한국" else {
            self.configureMovieModel(from: info, detailInfo, nil)
            return
        }
        
        networkManager.dataTask(api: api) { result in
            switch result {
            case .success(let data):
                guard let data = data,
                      let moviePoster: MoviePoster = JSONManager.shared.decodeToInfo(
                        from: data
                      ) else { return }
                self.configureMovieModel(from: info, detailInfo, moviePoster.poster)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureMovieModel(from info: BoxOfficeInfo, _ detailInfo: DetailInfo, _ posterURL: String?) {
        let movieModel = MovieModel(boxOfficeInfo: info, movieInfo: detailInfo, posterURL: posterURL)
        
        guard let rank = BoxOfficeRank(rawValue: info.rank) else {
            return
        }
        
        self.movieModels.updateValue(movieModel, forKey: rank)
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ListCollectionViewCell",
            for: indexPath
        ) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let rank = indexPath.row + 1
        guard let key = BoxOfficeRank(rawValue: String(rank)),
              let viewData = movieModels[key] else {
            return UICollectionViewCell()
        }
        
        cell.setupPoster(
            url: viewData.posterURL,
            rank: viewData.boxOfficeInfo.rank,
            status: viewData.boxOfficeInfo.rankOldAndNew
        )
        
        cell.setupLabelText(
            title: viewData.boxOfficeInfo.movieNm,
            opendDt: "\(viewData.boxOfficeInfo.openDt) 개봉",
            audiAcc: "누적관객 \(NumberFormatterManager.shared.getAudience(from: viewData.boxOfficeInfo.audiAcc)!)"
        )
        
        cell.setupRankInTen(
            rankInTen: viewData.boxOfficeInfo.rankInten,
            imageName: checkRankInTen(from: viewData.boxOfficeInfo.rankInten)
        )
        
        return cell
    }
    
    //TODO: View에 들어갈 데이터 처리하는 메서드 구현
    private func checkRankInTen(from rankInTen: String) -> String? {
        guard let number = Int(rankInTen) else {
            return nil
        }
        
        if number == 0 {
            return "minus"
        } else if number > 0 {
            return "arrow.up"
        } else {
            return "arrow.down"
        }
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.listView.boxOfficeCollectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailViewController = MovieDetailViewController()
        weak var sendDataDelegate: (SendDataDelegate)? = movieDetailViewController
        
        guard let key = BoxOfficeRank(rawValue: String(indexPath.row+1)) else {
            return
        }
        sendDataDelegate?.sendData(movieModels[key])

        navigationController?.pushViewController(
            movieDetailViewController,
            animated: true
        )
    }
}
//TODO: 폴더 분리 필요
extension UIImageView {
    func fetch(url: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            return
        }
        
        // TODO: 여기에만 추가시키면 되려나?
        if let cachedImage = ImageCacheManager.shared.getCachedImage(url: NSString(string: urlString)) {
            completion(.success(cachedImage))
            return
        }

        let request = URLRequest(url: url)
        
        // TODO: 변경 여부 확인
        let urlSession = URLSession(configuration: .ephemeral)
        urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(error!))
                return
            }
            
            ImageCacheManager.shared.saveCache(image: image, url: urlString)
            completion(.success(image))
        }.resume()
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

class NumberFormatterManager {
    static let shared = NumberFormatterManager()
    private let formatter = NumberFormatter()
    
    var audienceNumberFormatter: NumberFormatter {
        self.formatter.numberStyle = .decimal
        self.formatter.roundingMode = .ceiling
        self.formatter.maximumFractionDigits = 0
        return formatter
    }
    
    private init() { }
    
    func getAudience(from number: String) -> String? {
        guard let number = Int(number) else {
            return nil
        }
        
        if number / 10000 == 0 {
            return audienceNumberFormatter.string(for: number)
        } else {
            let newNumber = Double(number) / Double(10000)
            return audienceNumberFormatter.string(for: newNumber)! + "만"
        }
    }
}
