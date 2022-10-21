//
//  Dota2ViewViewController.swift
//  RandomPhoto
//
//  Created by ENB on 21/10/22.
//
import SwiftUI
import UIKit
import Alamofire

class Dota2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getDotaProfile(steamId: "144103932")
    }
    
    @IBAction func didTapButtonDota() {
//        let vc = Dota2View()
//        vc.view.backgroundColor = .systemCyan
//        navigationController?.pushViewController(vc, animated: true)
        let hostingController = UIHostingController(rootView: Dota2View())
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    @IBAction func didTapButtonMatches() {
        let MatchesLV = MatchesListView()
        navigationController?.pushViewController(MatchesLV, animated: true)
    }
    
    func getDotaProfile(steamId: String) {
        let urlString = "https://api.opendota.com/api/players/" + (steamId)
        
        AF.request(urlString, method: .get)
            .response { response in
                
                debugPrint(response)
//                if let data = response.result {
//                    print(data)
//                }
                
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
