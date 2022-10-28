//
//  APIHandler.swift
//  RandomPhoto
//
//  Created by ENB on 27/10/22.
//

import Foundation
import Alamofire

class APIHandler {
    static let sharedInstance = APIHandler()

    func fetchMatches(steamId: String, handler: @escaping (_ apiData: [Match])->(Void)) {
        let url = "https://api.opendota.com/api/players/\(steamId)/recentMatches"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
                case .success(let data):
                    do {
                        let jsondata = try JSONDecoder().decode([Match].self, from: data!)
                        print("inii jsondata ",jsondata)
//                       closure calling
                        handler(jsondata)
                    }
                    catch{
                        print(String(describing: error)) // <- ✅ Use this for debuging!
                   }
            case .failure(let error):
                print(String(describing: error)) // <- ✅ Use this for debuging!
            }
        }
    }
}

//struct Match: Codable {
//    let match_id: Int
//    let duration: Int
////    let players: [Player]
////    let hero_id: String?
////    let kills: String?
////    let deaths: String?
////
////    private enum CodingKeys: String, CodingKey {
////        case match_id = "match_id", hero_id = "hero_id", kills = "kills", deaths = "deaths"
////    }
//}
//
////struct Player: Codable {
////    let hero_id: Int
////    let kills: Int
////    let deaths: Int
////    let assists: Int
////}
