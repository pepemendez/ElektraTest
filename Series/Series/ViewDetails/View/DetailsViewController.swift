//
//  DetailsViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var itemId: Int!
    var type: ItemType!
    var viewModel = ViewModelDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        bind()
        
    }

    private func configureView(){
        self.title = "Ejercicio técnico"
        viewModel.retreiveData(type: type, itemId: itemId)
        self.close.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        routeToBack()
    }
    
    @objc func buttonVideoAction(sender: UIButton!) {
        routeToVideos(type: type, id: viewModel.data!.id)
    }
    
    @objc func buttonSeasonsAction(sender: UIButton!) {
        routeToSeasons(type: type, id: viewModel.data!.id)
    }
    
    
    private func bind(){
        viewModel.refreshData = {
            [weak self] () in
            DispatchQueue.main.async {
                
                if let p = self, let data = p.viewModel.data {
                    let backdrop = data.backdrop_path ?? ""
                    let url = backdrop.isEmpty ? data.poster_path : backdrop
                    self?.image.imageFromUrl(urlString: Endpoints.images + url )
                    
                    self?.tableView.setContentOffset(.zero, animated: true)
                    self?.tableView.reloadData()
                    
                    for video in p.viewModel.videos {
                        if (video.site.lowercased() == "youtube"){
                            print("https://www.youtube.com/watch?v=\(video.key)")
                        }
                    }

                }
            }
        }
    }

}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    enum DetailCellType {
        case Details
        case Watch
        case Seasons
        case Overview
    }
    
    func cellTypeForIndexPath(indexPath:IndexPath) -> DetailCellType{
        switch indexPath.row {
            case 0:
                return .Details
            case 1:
                return .Watch
            case 2:
                return (type == .MoviePlaying || type == .MoviePopular) ? .Overview : .Seasons
            default:
                return .Overview
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (type == .MoviePlaying || type == .MoviePopular) ?  3 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let object = viewModel.data else { return UITableViewCell()}
        let type = cellTypeForIndexPath(indexPath: indexPath)
        switch type {
        case .Details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCellDetails

            if let title = object.original_title, !title.isEmpty{
                cell.title?.text = title
            }
            if let title = object.name, !title.isEmpty{
                cell.title?.text = title
            }
            
            if let date = object.first_air_date, !date.isEmpty{
                cell.date?.text = "\(date.prefix(4))"
            }
            if let date = object.release_date, !date.isEmpty{
                cell.date?.text = "\(date.prefix(4))"
            }
            if let lenght = object.runtime, lenght > 0{
                cell.lenght?.text = "\(lenght/60)h \(lenght%60)min"
            }
            else if let seasons = object.number_of_seasons, seasons > 0{
                cell.lenght?.text = "\(seasons) seasons"
            }
            else{
                cell.lenght?.text = " "
            }
            
            
            let rate = "\(object.vote_average*10)"
            cell.rate.text = "\(rate.prefix(2))%"
            return cell

        case .Watch:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videosCell")!

            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            button.addTarget(self, action: #selector(buttonVideoAction), for: .touchUpInside)
            button.backgroundColor = .black
            button.imageView!.contentMode = .scaleAspectFit
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 8
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            button.setTitle("  Watch", for: .normal)
            button.setImage(#imageLiteral(resourceName: "play-circle-outline"), for: .normal)
            button.imageView?.tintColor = .white
            button.setTitleColor(.gray, for: .disabled)
            
            button.isEnabled = self.viewModel.videos.count > 1
            cell.contentView.addSubview(button)
            
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0).isActive = true
            button.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0).isActive = true
            button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 7).isActive = true
            button.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -7).isActive = true

            return cell
        case .Seasons:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videosCell")!

            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            button.addTarget(self, action: #selector(buttonSeasonsAction), for: .touchUpInside)
            button.backgroundColor = .black
            button.imageView!.contentMode = .scaleAspectFit
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 8
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            button.setTitle("  Seasons", for: .normal)
            button.setImage(#imageLiteral(resourceName: "television"), for: .normal)
            button.imageView?.tintColor = .white
            
            cell.contentView.addSubview(button)
            
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
            button.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0).isActive = true
            button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 7).isActive = true
            button.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -7).isActive = true

            return cell
        case .Overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell")!

            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = object.overview
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell")!
            cell.textLabel?.text = "ERROR"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

