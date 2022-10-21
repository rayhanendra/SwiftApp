//
//  MatchesListView.swift
//  RandomPhoto
//
//  Created by ENB on 21/10/22.
//

import UIKit
import Alamofire

struct Matches: Codable {
    let matchId: String
    let heroId: String
}


class MatchesListView: UIViewController {
    
    var tableView: UITableView!
    var tableData = [{}]
    let animalNames = ["Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats","Dogs", "Cats"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        setupTableView()
        
        fetchButton()
    
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MatchCell")
        
        tableView.dataSource = self

    }
    
    func fetchButton(){
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setTitle("Get Matches", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
    @objc func didTapButton() {
        getMatchesList(steamId: "144103932")
    }
    
    func getMatchesList(steamId: String) {
        let urlString = "https://api.opendota.com/api/players/\(steamId)/recentMatches"
        
        AF.request(urlString, method: .get)
            .responseData { (response) in
                switch response.result {
                    case .success(let data):
                        debugPrint(response)
                        let decoder = JSONDecoder()
                    let result = try! decoder.decode([Matches].self, from: data)
                    print("ini result", result)
                    case .failure(let error):
                        print(error)
                }
            }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MatchesListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell")! as UITableViewCell
        cell.textLabel?.text = animalNames[indexPath.row]
        return cell
    }
}
