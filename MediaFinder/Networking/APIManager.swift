//
//  APIManager.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/5/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class APIManager: NSObject {

    class func loadMyMovies(mediaType: String ,criteria: String, completion: @escaping (_ error: Error?, _ movies: [Media]?) -> Void) {
        
        let params = [Paratmeters.media : mediaType , Paratmeters.term : criteria]
        
        Alamofire.request(Urls.media, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: nil).response { response in
                    guard response.error == nil else {
                        print(response.error!)
                        completion(response.error, nil)
                        return
                    }

                    guard let data = response.data else {
                        print("didn't get any data from API")
                        return
                    }
             
                do {
                    let decoder = JSONDecoder()
                    let mediaArray = try decoder.decode(MediaResponce.self, from: data).results
                    completion(nil, mediaArray)
                } catch let error {
                    print(error)
                }
        }
    }
}
