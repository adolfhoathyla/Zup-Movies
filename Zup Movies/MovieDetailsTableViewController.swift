//
//  MovieDetailsTableViewController.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 14/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    var movie = Movie()
    
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieWriter: UILabel!
    @IBOutlet var movieRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDetails()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureViewDetails() {
        
        movieTitle.adjustsFontSizeToFitWidth = true
        movieWriter.adjustsFontSizeToFitWidth = true
        
        OMDBHelper.getMovie(id: movie.id!) { (movie) in
            self.movie = movie
            
            self.poster.image = movie.poster
            self.movieTitle.text = movie.title
            self.movieWriter.text = movie.writer
            self.movieRating.text = String(format: "IMDb rating: %.1f", movie.rating!)
        }
        

        

    }

}
