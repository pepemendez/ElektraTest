//
//  ViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()

    var isUpdatingMoviePlaying: Bool = false
    var isUpdatingMoviePopular: Bool = false
    var isUpdatingSeriePlaying: Bool = false
    var isUpdatingSeriePopular: Bool = false
    
    var refresh: Bool = true

    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        bind()
        
    }
    
    private func isUpdating() -> Bool{
        return isUpdatingMoviePlaying || isUpdatingMoviePopular || isUpdatingSeriePlaying || isUpdatingSeriePopular
    }
    
    private func retreiveLocalData(){
        refresh = true
        self.viewModel.retreiveLocalDataList(type: ItemType.MoviePlaying)
        self.viewModel.retreiveLocalDataList(type: ItemType.MoviePopular)
        self.viewModel.retreiveLocalDataList(type: ItemType.SeriePlaying)
        self.viewModel.retreiveLocalDataList(type: ItemType.SeriePopular)
    }
    
    private func retreiveAllData(){
        refresh = true
        self.isUpdatingMoviePlaying = true
        self.isUpdatingMoviePopular = true
        self.isUpdatingSeriePlaying = true
        self.isUpdatingSeriePopular = true

        self.viewModel.retreiveDataList(type: ItemType.MoviePlaying)
        self.viewModel.retreiveDataList(type: ItemType.MoviePopular)
        self.viewModel.retreiveDataList(type: ItemType.SeriePlaying)
        self.viewModel.retreiveDataList(type: ItemType.SeriePopular)
    }
    
    private func retreiveMoreData(type: ItemType){
        refresh = false
        switch type {
        case .MoviePlaying:
            self.isUpdatingMoviePlaying = true
        case .MoviePopular:
            self.isUpdatingMoviePopular = true
        case .SeriePlaying:
            self.isUpdatingSeriePlaying = true
        case .SeriePopular:
            self.isUpdatingSeriePopular = true
        }

        self.viewModel.retreiveMoreDataList(type: type)
    }

    private func configureView(){
        self.title = Messages.TITLE.localized
        retreiveLocalData()
        retreiveAllData()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshData()
    {
        refreshControl.endRefreshing()
        retreiveAllData()
    }
    
    private func bind(){
        viewModel.refreshData = {
            [weak self] type in
            DispatchQueue.main.async {
                if #available(iOS 13.0, *) {} else{ UIView.setAnimationsEnabled(false)}
                switch type{
                    case .MoviePlaying:
                        self?.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
                        self?.isUpdatingMoviePlaying = false
                    case .MoviePopular:
                        self?.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
                        self?.isUpdatingMoviePopular = false
                    case .SeriePlaying:
                        self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                        self?.isUpdatingSeriePlaying = false
                    case .SeriePopular:
                        self?.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
                        self?.isUpdatingSeriePopular = false
                }
                if #available(iOS 13.0, *) {} else{ UIView.setAnimationsEnabled(true) }
            }
        }
    }

}

extension UICollectionView {

    func reloadDataWithoutScroll() {
        let offset = contentOffset
        reloadData()
        setContentOffset(CGPoint(x: offset.x + 2000, y: 0), animated: false)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UITableViewCellMainListDelegate{
    func fetchMore(type: ItemType) {
        if(!isUpdating()){
            retreiveMoreData(type: type)
        }
    }
    
    func tapped(type: ItemType, at: IndexPath) {
        switch type {
        case .MoviePlaying:
            routeToDetail(type: type, item: viewModel.moviePlayingNow[at.row])
        case .MoviePopular:
            routeToDetail(type: type, item: viewModel.moviePopular[at.row])
        case .SeriePlaying:
            routeToDetail(type: type, item: viewModel.seriePlayingNow[at.row])
        case .SeriePopular:
            routeToDetail(type: type, item: viewModel.seriePopular[at.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCellMainList
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = Messages.SERIES_PLAYING.localized
            cell.data = viewModel.seriePlayingNow
            cell.type = .SeriePlaying
            cell.delegate = self
        case 1:
            cell.titleLabel.text = Messages.SERIES_POPULAR.localized
            cell.data = viewModel.seriePopular
            cell.type = .SeriePopular
            cell.delegate = self
        case 2:
            cell.titleLabel.text = Messages.MOVIES_PLAYING.localized
            cell.data = viewModel.moviePlayingNow
            cell.type = .MoviePlaying
            cell.delegate = self
        case 3:
            cell.titleLabel.text = Messages.MOVIES_POPULAR.localized
            cell.data = viewModel.moviePopular
            cell.type = .MoviePopular
            cell.delegate = self
        default:
            cell.titleLabel.text = "ERROR"
        }
        
        if(refresh){
            cell.collectionView.reloadData()
            cell.collectionView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
        }
        else{
            cell.collectionView.reloadDataWithoutScroll()
        }
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

