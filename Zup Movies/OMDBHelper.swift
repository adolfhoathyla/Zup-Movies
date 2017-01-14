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
                                movie.posterURI = posterAux
                                let data = NSData(contentsOf: NSURL(string: posterAux) as! URL)
                                movie.poster = UIImage(data: data as! Data)
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
    
    static func getMovie(id: String, completionBlock: @escaping ((_ movie: Movie) -> ())) {
        let uri = OMDB_URI + "/?i=\(id)&plot=full&r=json"
        
        let movie = Movie()
        
        Alamofire.request(uri).responseJSON { (response) in
            if let JSON = response.result.value as? NSDictionary {
                if let posterAux = JSON.value(forKey: "Poster") as? String {
                    movie.posterURI = posterAux
                    let data = NSData(contentsOf: NSURL(string: posterAux) as! URL)
                    movie.poster = UIImage(data: data as! Data)
                }
                if let titleAux = JSON.value(forKey: "Title") as? String {
                    movie.title = titleAux
                }
                if let yearAux = JSON.value(forKey: "Year") as? String {
                    movie.year = Int(yearAux)
                }
                if let idAux = JSON.value(forKey: "imdbID") as? String {
                    movie.id = idAux
                }
                if let runtimeAux = JSON.value(forKey: "Runtime") as? String {
                    movie.runtime = runtimeAux
                }
                if let genreAux = JSON.value(forKey: "Genre") as? String {
                    movie.genre = genreAux
                }
                if let writerAux = JSON.value(forKey: "Writer") as? String {
                    movie.writer = writerAux
                }
                if let actorsAux = JSON.value(forKey: "Actors") as? String {
                    movie.actors = actorsAux
                }
                if let plotAux = JSON.value(forKey: "Plot") as? String {
                    movie.plot = plotAux
                }
                if let countryAux = JSON.value(forKey: "Country") as? String {
                    movie.country = countryAux
                }
                if let ratingAux = JSON.value(forKey: "imdbRating") as? String {
                    movie.rating = Float(ratingAux)
                }
                completionBlock(movie)
            }
        }
    }
    
}
