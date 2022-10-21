//
//  RankView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

protocol RankViewProtocol{
    func presentDetailView(movie:Movie)
}

class RankView : UIView {
    
    var movie : [Movie] = []
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped) //plain으로 하면 헤더가 사라지지 않음
        
    var range : String?
    
    var delegate : RankViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        tableViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func tableViewConfiguration(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.id)
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: CustomHeader.id)
        let height = UIScreen.main.bounds.size.height / 3
        tableView.rowHeight = height
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
    }
    
}


extension RankView : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.presentDetailView(movie:movie[indexPath.row])
    }
    //시각적인 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }
    //텍스트만 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.id) as? CustomHeader else { return UITableViewHeaderFooterView() }
        header.dateLabel.text = range
        return header
    }
}

extension RankView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell else { return UITableViewCell()}
        let movie = movie[indexPath.row]
        cell.infoGroupView.setInfo(posterImage:movie.poster ,title: movie.boxOfficeInfo.movieNm, releaseDate: movie.boxOfficeInfo.openDt, numOfAudience: movie.boxOfficeInfo.audiAcc, rank: movie.boxOfficeInfo.rank, upAndDown: movie.boxOfficeInfo.rankInten, isNew: movie.boxOfficeInfo.rankOldAndNew)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
}
