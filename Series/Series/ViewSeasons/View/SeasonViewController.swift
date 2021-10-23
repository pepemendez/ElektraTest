//
//  SeasonViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

class SeasonViewController: UIViewController {
    
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var tableView: UITableView!

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
        self.title = "Ejercicio técnico"
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



extension SeasonViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let object = viewModel.data[indexPath.row]
        
        cell.textLabel?.text = object.name
        let date = object.air_date ?? ""
        let prefix = date.count > 1 ? "\(date.prefix(4)) - " : ""
        let episodes = object.episode_count > 0 ? "\(object.episode_count) episodes" : "Information not available"
        cell.detailTextLabel?.text = "\(prefix)\(episodes)"
  
        return cell
    }
    
    
}

