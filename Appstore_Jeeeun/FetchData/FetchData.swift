//
//  FetchData.swift
//  Appstore_Jeeeun
//
//  Created by Jeeeun Lim on 2020/08/20.
//  Copyright © 2020 Jeeeun Lim. All rights reserved.
//

import Foundation

class FetchData {

    static let shared = FetchData() // singleton
       
       func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
           print("Fetching apps result with searchTerm ")
        guard let urlwithPercentEscapes = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
           let urlString = "https://itunes.apple.com/search?term=\(urlwithPercentEscapes)&entity=software&country=KR&lang=ko_kr"
           
           fetchJSONData(urlString: urlString, completion: completion)
       }

       func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
           
           guard let url = URL(string: urlString) else { return }
           URLSession.shared.dataTask(with: url) { (data, resp, err) in
               if let err = err {
                   completion(nil, err)
                   return
               }
               do {
                   let objects = try JSONDecoder().decode(T.self, from: data!)
                   // success
                   completion(objects, nil)
               } catch {
                   completion(nil, error)
               }
               }.resume()
       }

}
