//
//  RankView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

protocol RankViewProtocol{
    func presentDetailView()
}

class RankView : UIView {
    
    let headerView = CustomHeader()
    
    let tableView = UITableView(frame: .zero, style: .grouped) //plain으로 하면 헤더가 사라지지 않음
    
    var boxOfficeResponse : BoxOfficeResponse?
    
    var boxOfficeInfo : [BoxOfficeInfo]?
    
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func setInfo(){
        boxOfficeInfo = boxOfficeResponse?.boxOfficeResult.dailyBoxOfficeList
        range = boxOfficeResponse?.boxOfficeResult.showRange
    }
    
    func urlToImage(url:String) -> UIImage? {
        let url = URL(string: url)
        guard let url = url else { return nil}
        if let data = try? Data(contentsOf:url), let image = UIImage(data: data){
            return image
        }
        return nil
    }
    
}


extension RankView : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.presentDetailView()
        tableView.cellForRow(at: indexPath)?.isSelected = false

    }
    //시각적인 설정
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }
    
    //텍스트만 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.id) as? CustomHeader else { return UITableViewHeaderFooterView() }
        header.dateLabel.text = range
        return header
        
//        if section == 0{
//            return header
//        }else{
//            return nil
//        }
    }

}

extension RankView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell, let boxOfficeInfo = boxOfficeInfo?[indexPath.row] else { return UITableViewCell()}
        let isNew = boxOfficeInfo.rankOldAndNew == "NEW" ? true : false
        cell.rankGroupView.setInfo(isNew: isNew, rank: boxOfficeInfo.rank, upAndDown: boxOfficeInfo.rankInten)
        cell.infoGroupView.setInfo(posterImage: UIImage(named:"James"), title: boxOfficeInfo.movieNm, releaseDate: boxOfficeInfo.openDt, numOfAudience: boxOfficeInfo.audiAcc)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
}
