//
//  MatchesListView.swift
//  RandomPhoto
//
//  Created by ENB on 21/10/22.
//

import UIKit
import Alamofire

class DotaMatchesViewController: UIViewController, UITableViewDataSource {
    
    //  MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!

    //  MARK: - Private Properties
    
    var tableData = [Match]()
    
    private let refreshControl = UIRefreshControl()
    
    let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .systemBlue
        let image = UIImage(systemName: "arrow.clockwise",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        // Corner Radius
        button.layer.cornerRadius = 30
        
        return button
    }()
    
    func reloadButton() {
        let button = floatingButton
        button.addTarget(self, action: #selector(fetchMatchesData), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func getButton() {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("Get Matches", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(fetchMatchesData), for: .touchUpInside)

        self.view.addSubview(button)
    } 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 70,
            y: view.frame.size.height - 160,
            width: 60,
            height: 60)
    }

    //  MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTableView()
        setupActivityIndicatorView()
        
        getButton()
        reloadButton()
    }
    
    private func updateView() {
        let hasData = tableData.count > 0
        tableView.isHidden = !hasData
        
        if hasData {
            tableView.reloadData()
        }
    }
    
    //  MARK:  -
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
//        view.addSubview(activityIndicatorView)
        
        tableView.isHidden = true
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MatchCell")
        
        tableView.dataSource = self
        
        
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshMatchesData), for: .valueChanged)
    }
    
    private func setupActivityIndicatorView() {
//        activityIndicatorView.startAnimating()
    }
    
    //    MARK: - Actions

    @objc private func refreshMatchesData() {
        fetchMatchesData()
    }
    
    //    MARK: - Helper Methods

    @objc private func fetchMatchesData() {
        APIHandler.sharedInstance.fetchMatches(steamId: "144103932") { apiData in
        
            self.tableData = apiData
            
            self.updateView()
            self.refreshControl.endRefreshing()
//            self.activityIndicatorView.stopAnimating()
        }
    }
    

}

extension DotaMatchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell")! as UITableViewCell
        // Fetch Data
        cell.textLabel?.text = String(tableData[indexPath.row].match_id)
        
        return cell
    }
}
