//
//  SeasonViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

class SeasonViewController: UIViewControllerExpandable {
    
    @IBOutlet weak var close: UIButton!

    var itemId: Int!
    var type: ItemType!
    var viewModel = ViewModelSeason()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
        bind()
        
    }

    private func configureView(){
        self.title = Messages.TITLE.localized
        viewModel.retreiveData(type: type, itemId: itemId)
        self.close.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        routeToBack()
    }
    
    private func bind(){
        viewModel.refreshData = {
            [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.setContentOffset(.zero, animated: true)
                self?.tableView.reloadData()
            }
        }
    }
}



extension SeasonViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let object = viewModel.data[indexPath.row]
        
        cell.textLabel?.text = object.name
        let date = object.air_date ?? ""
        let prefix = date.count > 1 ? "\(date.prefix(4)) - " : ""
        let episodes = object.episode_count > 0 ?
            Messages.EPISODES.localized.localize(with: "\(object.episode_count)") : Messages.INFO_NOT_AVAILABLE.localized
        cell.detailTextLabel?.text = "\(prefix)\(episodes)"
  
        return cell
    }
    
    
}

