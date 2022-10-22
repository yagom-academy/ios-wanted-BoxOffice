//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class BoxOfficeViewController: UIViewController {
    
    var boxOfficeHelper = BoxOfficeHelper()
    var boxOfficeDataList = [DailyBoxOfficeList]()
    var movieDetailDataList = [MovieInfo]()
    var moviePosterData = [String]()
    
    let posterBaseURL = "https://image.tmdb.org/t/p/original"

    let boxOfficeView: BoxOfficeView = {
        let view = BoxOfficeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "박스오피스 순위"

        fetchData()
        addSubView()
        configure()
        setupTableView()
    }
    
    func fetchData() {
        Task {
            do {
                let movieResponse = try await BoxOfficeService().getBoxOfficeData(date: boxOfficeHelper.yesterdayDate())
                boxOfficeDataList.append(contentsOf: movieResponse.boxOfficeResult.dailyBoxOfficeList)
                print(movieResponse)
                boxOfficeView.boxOfficeTableView.reloadData()
                for index in 0..<boxOfficeDataList.count {
                    let movieCode = boxOfficeDataList[index].movieCd
                    let movieDetailResponse = try await BoxOfficeService().getMovieDetailData(movieCode: movieCode).movieInfoResult.movieInfo
                    movieDetailDataList.append(movieDetailResponse)
//                    let movieName = movieDetailResponse.movieNmEn
                    let movieName = boxOfficeHelper.movieNameHelper(boxOfficeDataList[index].movieNm)
                    print(movieName)
                    do {
                        let posterResponse = try await BoxOfficeService().getMoviePosterData(movieName: movieName)
                        if posterResponse.results.count == 0 {
                            moviePosterData.append(posterBaseURL)
                            print("포스터가 없어잉")
                        } else {
                            moviePosterData.append(posterResponse.results[0].poster_path ?? "")
                            print(posterResponse.results[0].poster_path ?? posterBaseURL)
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
//                    print(moviePosterData)
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            boxOfficeView.boxOfficeTableView.reloadData()
        }
    }
    
    func setupTableView() {
        boxOfficeView.boxOfficeTableView.delegate = self
        boxOfficeView.boxOfficeTableView.dataSource = self
        boxOfficeView.boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func addSubView() {
        view.addSubview(boxOfficeView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            
            boxOfficeView.topAnchor.constraint(equalTo: view.topAnchor),
            boxOfficeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boxOfficeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boxOfficeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BoxOfficeTableViewCell
        let data = self.boxOfficeDataList[indexPath.row]

        cell.movieName.text = data.movieNm
        cell.openDate.text = data.openDt
        cell.boxOfficeRank.text = "\(data.rank)(\(data.rankOldAndNew))"
        cell.rankInten.text = boxOfficeHelper.rankIntenCal(data.rankInten)
        cell.audiAcc.text = boxOfficeHelper.audiAccCal(data.audiAcc)

        DispatchQueue.main.async {
            if self.moviePosterData.count != 10 {
                cell.posterImageView.setImageUrl(url: self.posterBaseURL, movieName: "noMovie")
                
            }else {
                cell.posterImageView.setImageUrl(url: "\(self.posterBaseURL)"+"\(self.moviePosterData[indexPath.row])", movieName: data.movieNm)
                
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = BoxOfficeDetailsViewController()
        let data = self.boxOfficeDataList[indexPath.row]
        let posterURL = self.moviePosterData[indexPath.row]
        
        nextVC.boxOfficeDataList = boxOfficeDataList
        nextVC.movieDetailDataList = movieDetailDataList
        nextVC.index = indexPath.row
        
        if posterURL == posterBaseURL {
            nextVC.boxOfficeDetailsView.posterImageView.setImageUrl(url: posterBaseURL, movieName: "noMovie")
        } else {
            nextVC.boxOfficeDetailsView.posterImageView.setImageUrl(url: "\(posterBaseURL)"+"\(posterURL)", movieName: data.movieNm)
        }
    
        self.show(nextVC, sender: self)
    }
    
}

//
//    func fetchData() {
//        BoxOfficeService().getBoxOfficeData(date: boxOfficeHelper.yesterdayDate()) { result in
//            switch result {
//            case .success(let boxOfficeData):
//                self.boxOfficeDataList.append(contentsOf: boxOfficeData.boxOfficeResult.dailyBoxOfficeList)
//                for i in 0..<self.boxOfficeDataList.count {
//                    if self.boxOfficeDataList[i].movieNm == "공조2: 인터내셔날" {
//                        self.fetchPosterData("공조 2: 인터내셔날")
//                    } else {
//                        self.fetchPosterData(self.boxOfficeDataList[i].movieNm)
//                    }
//                    print(self.boxOfficeDataList[i].movieNm)
//                }
//            case .failure(_):
//                print("error")
//            }
//            DispatchQueue.main.async {
//                self.boxOfficeView.boxOfficeTableView.reloadData()
//            }
//        }
//    }
    
//
//    func fetchPosterData(_ movieNm: String) {
//        BoxOfficeService().getMoviePosterData(movieNm: movieNm) { result in
//            switch result {
//            case .success(let posterData):
////                print("포스터 : \(posterData)")
//                self.moviePosterData.append(posterData.results[0])
//            case .failure(_):
//                print(result)
//            }
////            DispatchQueue.main.async {
////                self.boxOfficeView.boxOfficeTableView.reloadData()
////            }
//            print("arr: \(self.moviePosterData)")
//        }
//    }
