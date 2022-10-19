//
//  MovieListViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

protocol DefaultViewSetupProtocol {
    func setupView()
    func setConstraints()
    func configureView()
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var movieListTableView: UITableView!
    
    let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.hidesWhenStopped = true
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var boxOffice = [BoxOfficeModel]()
    
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = true // 마지막 페이지 인지 체크 하는 flag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TEST dummy data 박스오피스 순위
        Dummy().create { [weak self] dummy in
            guard let self = self else { return }
            self.boxOffice = dummy
            DispatchQueue.main.async {
                self.updateItems()
            }
        }
        setupView()
        setConstraints()
        configureView()
        
        // FIXME: 적용 안됨.
        segment.layer.cornerRadius = 30
        segment.layer.masksToBounds = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension MovieListViewController: DefaultViewSetupProtocol {
    
    func setupView() {
        
    }
    
    func setConstraints() {
        movieListTableView.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configureView() {
        movieListTableView.backgroundColor = UIColor(named: "backgroundColorAsset")
        movieListTableView.separatorInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10)
    }
}

extension MovieListViewController {
    func updateItems() {
        movieListTableView.reloadData()
        loadingIndicator.stopAnimating()
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Section을 2개 설정하는 이유는 페이징 로딩 시 로딩 셀을 표시해주기 위해서입니다.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return boxOffice.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieListViewCell") as! MovieListViewCell
            let movie = boxOffice[indexPath.row]
            cell.fill(viewModel: movie)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingCell else {
                return UITableViewCell()
            }
            cell.start()
            
            return cell
        }
    }
    
    func changeDateStringFormat(_ string: String) -> String {
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy-MM-dd"
        toDateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        let date = toDateFormatter.date(from: string)
        let toStringFormatter = DateFormatter()
        toStringFormatter.dateFormat = "yy.MM.dd"
        let result = toStringFormatter.string(from: date!)
        return result
    }
    
    func changeToDecimal(_ string: String) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: UInt(string)!))
        guard let result = result else {
            return "-"
        }
        return result
    }
}

extension MovieListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let offsetY = scrollView.contentOffset.y
       let contentHeight = scrollView.contentSize.height
       let height = scrollView.frame.height
        
       // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
       if offsetY > (contentHeight - height) {
           
           if isPaging == false && hasNextPage {
//               print("begin paging")
//               beginPaging()
           }
       }
    }
    
    func beginPaging() {
        isPaging = true
        
        // Section 1을 reload하여 로딩 셀을 보여줌 (페이징 진행 중인 것을 확인할 수 있도록)
        DispatchQueue.main.async {
            self.movieListTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
        // 페이징 메소드 호출
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.paging()
        }
    }
    
    func paging() {
        print("paging!!")
        let count = boxOffice.count
        DispatchQueue.main.async {
//            self.boxOffice.append(contentsOf: self.boxOffice)
            self.hasNextPage = self.boxOffice.count > count ? true : false
            self.isPaging = false // 페이징이 종료 되었음을 표시
            self.updateItems()
        }
        
    }
}

