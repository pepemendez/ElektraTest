//
//  ViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isUpdating: Bool = false
    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        bind()
        
    }
    
    private func retreiveAllData(){
        self.isUpdating = true
        
        self.viewModel.retreiveDataList(type: .MoviePlaying)
        self.viewModel.retreiveDataList(type: .MoviePopular)
        self.viewModel.retreiveDataList(type: .SeriePlaying)
        self.viewModel.retreiveDataList(type: .SeriePopular)
    }

    private func configureView(){
        self.title = "Ejercicio técnico"
        
        retreiveAllData()
    }
    
    private func bind(){
        viewModel.refreshData = {
            [weak self] () in
            DispatchQueue.main.async {
                self?.isUpdating = false
                self?.tableView.setContentOffset(.zero, animated: true)
                self?.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UITableViewCellMainListDelegate{
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
        default:
            print("ERROR")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentYoffset = scrollView.contentOffset.y
      
        if contentYoffset < -120 && !isUpdating {
            retreiveAllData()
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
            cell.titleLabel.text = "Series Playing Now"
            cell.data = viewModel.seriePlayingNow
            cell.type = .SeriePlaying
            cell.delegate = self
        case 1:
            cell.titleLabel.text = "Series Most Popular"
            cell.data = viewModel.seriePopular
            cell.type = .SeriePopular
            cell.delegate = self
        case 2:
            cell.titleLabel.text = "Movies Playing Now"
            cell.data = viewModel.moviePlayingNow
            cell.type = .MoviePlaying
            cell.delegate = self
        case 3:
            cell.titleLabel.text = "Movies Most Popular"
            cell.data = viewModel.moviePopular
            cell.type = .MoviePopular
            cell.delegate = self
        default:
            cell.titleLabel.text = "ERROR"
        }
        cell.collectionView.reloadData()
         
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

