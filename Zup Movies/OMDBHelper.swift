//
//  OMDBHelper.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 13/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit
import Alamofire

class OMDBHelper: NSObject {

    static let OMDB_URI = "http://www.omdbapi.com"
    
    static func searchMovie(text: String, completionBlock:@escaping ((_ movies: [Movie]?) -> ())) {
        let searchUri = OMDB_URI + "/?s=\(text)&plot=short&r=json"
        let uriUTF8 = searchUri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        var movies = [Movie]()
        
        Alamofire.request(uriUTF8!).responseJSON { (response) in
            if let JSON = response.result.value as? NSDictionary {
                if let moviesJSON = JSON.value(forKey: "Search") as? NSArray {
                    for movieJSON in moviesJSON {
                        let movie = Movie()
                        if let movieDictionary = movieJSON as? NSDictionary {
                            if let posterAux = movieDictionary.value(forKey: "Poster") as? String {
                                movie.poster = posterAux
                            }
                            if let titleAux = movieDictionary.value(forKey: "Title") as? String {
                                movie.title = titleAux
                            }
                            if let yearAux = movieDictionary.value(forKey: "Year") as? String {
                                movie.year = Int(yearAux)
                            }
                            if let idAux = movieDictionary.value(forKey: "imdbID") as? String {
                                movie.id = idAux
                            }
                        }
                        movies.append(movie)
                    }
                    completionBlock(movies)
                } else { completionBlock(nil) }
            } else { completionBlock(nil) }
        }
    }
    
    static func getMovie(id: String, completionBlock: ((_ movie: Movie) -> ())) {

    }
    
}
