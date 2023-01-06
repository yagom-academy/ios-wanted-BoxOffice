//
//  ListCollectionViewCell.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    let simpleMovieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let rankAndAuddienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankInTenLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankInTenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        label.textColor = .systemYellow
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
    }
    
    private func setup() {
        self.addSubview(posterImageView)
        self.addSubview(simpleMovieInfoStackView)
        
        self.posterImageView.addSubview(statusLabel)
        self.posterImageView.addSubview(rankLabel)
        
        self.rankAndAuddienceStackView.addArrangedSubview(rankInTenImageView)
        self.rankAndAuddienceStackView.addArrangedSubview(rankInTenLabel)
        self.rankAndAuddienceStackView.addArrangedSubview(spacingView)
        self.rankAndAuddienceStackView.addArrangedSubview(audienceCountLabel)
        
        self.simpleMovieInfoStackView.addArrangedSubview(titleLabel)
        self.simpleMovieInfoStackView.addArrangedSubview(openDateLabel)
        self.simpleMovieInfoStackView.addArrangedSubview(rankAndAuddienceStackView)
        
        NSLayoutConstraint.activate([
            self.posterImageView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 5
            ),
            self.posterImageView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor
            ),
            self.posterImageView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor
            ),
            self.posterImageView.heightAnchor.constraint(
                equalTo: self.heightAnchor
            ),
            self.posterImageView.widthAnchor.constraint(
                equalTo: self.posterImageView.heightAnchor,
                multiplier: 0.675
            ),
            
            self.spacingView.widthAnchor.constraint(equalToConstant: 15),
            
            self.statusLabel.trailingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: -5),
            self.statusLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor, constant: 5),
            self.rankLabel.leadingAnchor.constraint(equalTo: self.posterImageView.leadingAnchor, constant: 5),
            self.rankLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.simpleMovieInfoStackView.heightAnchor.constraint(
                equalTo: self.posterImageView.heightAnchor,
                multiplier: 0.8
            ),
            self.simpleMovieInfoStackView.leadingAnchor.constraint(
                equalTo: self.posterImageView.trailingAnchor,
                constant: 15
            ),
            self.simpleMovieInfoStackView.centerYAnchor.constraint(
                equalTo: self.contentView.centerYAnchor
            )
        ])
    }
    
    func setupPoster(url: String?, rank: String, status: String) {
        if url == nil {
            posterImageView.image = UIImage(systemName: "play")
        } else {
            posterImageView.fetch(url: url) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        self.rankLabel.text = rank
        self.statusLabel.text = status
        
        let attributes: [NSAttributedString.Key: Any] = [.obliqueness: 0.2]
        statusLabel.attributedText = NSAttributedString(string: statusLabel.text!, attributes: attributes)
        rankLabel.attributedText = NSAttributedString(string: rankLabel.text!, attributes: attributes)
        
        if status == "NEW" {
            statusLabel.textColor = .systemYellow
        } else if status == "OLD" {
            statusLabel.textColor = .systemRed
        }
    }
    
    func setupLabelText(title: String, opendDt: String, audiAcc: String) {
        self.titleLabel.text = title
        self.openDateLabel.text = opendDt
        self.audienceCountLabel.text = audiAcc
    }
    
    func setupRankInTen(rankInTen: String, imageName: String?) {
        guard let name = imageName else {
            return
        }
        
        self.rankInTenLabel.text = rankInTen
        self.rankInTenImageView.image = UIImage(systemName: name)
        
        if name == "chevron.down" {
            rankInTenLabel.textColor = .systemBlue
            rankInTenImageView.tintColor = .systemBlue
        } else if name == "chevron.up" {
            rankInTenLabel.textColor = .systemRed
            rankInTenImageView.tintColor = .systemRed
        } else {
            rankInTenLabel.textColor = .systemGray
            rankInTenImageView.tintColor = .systemGray
        }
    }
}
