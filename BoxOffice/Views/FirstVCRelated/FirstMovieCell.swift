//
//  FirstMovieCell.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import UIKit

class FirstMovieCell: UITableViewCell {
    
    //input
    
    //output
    
    //properties
    lazy var cellView: MovieCellView = MovieCellView()

    var viewModel: FirstMovieCellModel = FirstMovieCellModel() {
        didSet {
            cellView.didReceiveViewModel(viewModel)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewHierarchy()
        configureView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(viewModel: FirstMovieCellModel) {
        cellView.didReceiveViewModel(viewModel)
    }

}

extension FirstMovieCell: Presentable {
    func initViewHierarchy() {
        self.contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: [NSLayoutConstraint] = []
        defer { NSLayoutConstraint.activate(constraint) }
        
        constraint += [
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }
    
    func configureView() {
        
    }
    
    func bind() {
        
    }
    
    
}
