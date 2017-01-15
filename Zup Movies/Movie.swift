//
//  Movie.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 13/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit
import CoreData

class Movie: NSObject {
    var id: String?
    var title: String?
    var year: Int?
    var runtime: String?
    var genre: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var country: String?
    var rating: Float?
    var posterURI: String?
    var poster: UIImage?
    
    var managedObject: NSManagedObject?
    
    override init() { }
    
    init(managedObject: NSManagedObject) {
        super.init()
        
        id = managedObject.value(forKey: "id") as? String
        title = managedObject.value(forKey: "title") as? String
        year = managedObject.value(forKey: "year") as? Int
        runtime = managedObject.value(forKey: "runtime") as? String
        genre = managedObject.value(forKey: "genre") as? String
        writer = managedObject.value(forKey: "writer") as? String
        actors = managedObject.value(forKey: "actors") as? String
        plot = managedObject.value(forKey: "plot") as? String
        country = managedObject.value(forKey: "country") as? String
        rating = managedObject.value(forKey: "rating") as? Float
        posterURI = managedObject.value(forKey: "posterUri") as? String
        if let data = managedObject.value(forKey: "poster") as? Data { poster = UIImage(data: data) }
        
        self.managedObject = managedObject
        
    }
    
    // MARK: - CoreData methods
    func saveOnCoreData() -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext!)
        managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject?.setValue(id , forKey: "id")
        managedObject?.setValue(title, forKey: "title")
        managedObject?.setValue(year, forKey: "year")
        managedObject?.setValue(runtime, forKey: "runtime")
        managedObject?.setValue(genre, forKey: "genre")
        managedObject?.setValue(writer, forKey: "writer")
        managedObject?.setValue(actors, forKey: "actors")
        managedObject?.setValue(plot, forKey: "plot")
        managedObject?.setValue(country, forKey: "country")
        managedObject?.setValue(rating, forKey: "rating")
        managedObject?.setValue(posterURI, forKey: "posterUri")
        if let poster = poster {
            managedObject?.setValue(UIImagePNGRepresentation(poster), forKey: "poster")
        }
        
        do {
            try managedContext?.save()
            return true
        } catch let error as NSError {
            print("Error: save movie \(error)")
            return false
        }
    }
    
    static func getAllMovies() -> [Movie]? {
        var movies = [Movie]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let results = try managedContext?.fetch(fetchRequest)
            
            if let results = results {
                if results.count < 1 { return nil }
                
                for result in results as! [NSManagedObject] {
                    movies.append(Movie(managedObject: result))
                }
                
            } else {
                return nil
            }
            
        } catch let error as NSError {
            print("Error: get all movies \(error)")
        }
        
        return movies
    }
}
