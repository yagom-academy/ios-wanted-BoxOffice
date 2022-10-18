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
    
    var movieInfo : [RankInfo] = []
    
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
        header.dateLabel.text = "2022년 10월 22일 기준"
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
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.id, for: indexPath) as? CustomCell else { return UITableViewCell()}
        if indexPath.row % 2 == 0{
            cell.rankGroupView.setInfo(isNew: false, rank: "1", isUp: true, rankDiff: "4")
            cell.infoGroupView.setInfo(posterImage: UIImage(named:"James") ,title: "아이언맨", releaseDate: "2012", numOfAudience: "123")
        }else{
            cell.rankGroupView.setInfo(isNew: true, rank: "2", isUp: false, rankDiff: "2")
            cell.infoGroupView.setInfo(posterImage: UIImage(named:"James") ,title: "아이언맨", releaseDate: "2012", numOfAudience: "123")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
}
