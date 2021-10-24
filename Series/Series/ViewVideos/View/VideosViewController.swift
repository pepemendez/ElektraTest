//
//  VideosViewController.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit
import WebKit

class VideosViewController: UIViewControllerExpandable {
    
    @IBOutlet weak var close: UIButton!

    var itemId: Int!
    var type: ItemType!
    var viewModel = ViewModelVideos()
    
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


class VideosViewControllerViewCell: UITableViewCell, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let wView = self.contentView.viewWithTag(1){
            wView.isHidden = false
        }
        else{
            print("ERROR")
        }
    }
}

extension VideosViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! VideosViewControllerViewCell
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let object = viewModel.data

        //cell.textLabel?.text = object[indexPath.row].key
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = object[indexPath.row].name
        cell.contentView.addSubview(label)
        
        //We add this view because while loading webview shows only a blank screen, and give us an odd feeling
        let view = UIView(frame: CGRect(x:0, y:0, width: 100, height: 100))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        cell.contentView.addSubview(view)
        
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
 
        view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 7).isActive = true
        view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -7).isActive = true
        
        
        let webView = WKWebView(frame: CGRect(x:0, y:0, width: 100, height: 100))
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.inputView?.backgroundColor = .black
        webView.tag = 1
        cell.contentView.addSubview(webView)
            
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        label.heightAnchor.constraint(equalToConstant: 25).isActive = true

        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 7).isActive = true
        label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -7).isActive = true
        
        
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(object[indexPath.row].key)")!))
        
        webView.isHidden = true
        webView.navigationDelegate = cell

        
        return cell
    }
    
    
}
