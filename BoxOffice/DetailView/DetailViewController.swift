//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit
import FirebaseStorage
import Firebase

class DetailViewController : UIViewController{
    
    let detailView = DetailView()
            
    var movie : Movie?
    
    var contents : [String] = []
    
    let storage = Storage.storage()
    
    lazy var storageRef = storage.reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let documentPath : URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryPath: URL = documentPath.appendingPathComponent(movie?.detailInfo.movieNmEn.makeItFitToURL() ?? "movie")
        do{
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false)
        }catch{
            print(error.localizedDescription)
        }
        do{
            contents = try fileManager.contentsOfDirectory(atPath: directoryPath.path)
        }catch{
            print(error.localizedDescription)
        }
        loadReviews()
        setInfo()
        addSubViews()
        setConstraints()
        detailView.delegate = self
    }
 
    func loadReviews(){
            for content in contents{
                let filePath = "gs://boxoffice-18825.appspot.com/" + content
                let storageReference = storage.reference(forURL: filePath)
                let megaByte = Int64(1 * 1024 * 1024)
                storageReference.getData(maxSize: megaByte) { data, error in
                    do{
                        guard let data = data else { return }
                        let reviewData = try JSONDecoder().decode(ReviewModel.self, from: data)
                        self.detailView.reviews.append(reviewData)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
                let imagefilePath = "gs://boxoffice-18825.appspot.com/" + content + "Image"
                let imagestorageReference = storage.reference(forURL: imagefilePath)
                imagestorageReference.getData(maxSize: megaByte) { data, error in
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    self.detailView.profiles.append(image ?? UIImage(named: "Profile")!)
                    self.detailView.tableView.reloadData()
                }
            }
    }

    
    func setInfo(){
        detailView.setInfo(movie: movie!)
    }
    
    func addSubViews(){
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension DetailViewController : DetailViewProtocol{
    func presentReviewWriteView() {
        let vc = ReviewWriteViewController()
        vc.movieTitle = movie?.detailInfo.movieNmEn
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
