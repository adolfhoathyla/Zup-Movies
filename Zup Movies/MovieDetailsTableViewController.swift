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
    @IBOutlet var movieRuntime: UILabel!
    @IBOutlet var movieActors: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieCountry: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var moviePlot: UITextView!
    
    var saveButton = UIBarButtonItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDetails()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(saveMovie))
        
        navigationItem.rightBarButtonItem = saveButton
        
        updateSaveButton()

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
        return 6
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
    
    private func configureViewDetails() {
        
        movieTitle.adjustsFontSizeToFitWidth = true
        movieWriter.adjustsFontSizeToFitWidth = true
        movieActors.adjustsFontSizeToFitWidth = true
        movieGenre.adjustsFontSizeToFitWidth = true
        movieCountry.adjustsFontSizeToFitWidth = true
        
        OMDBHelper.getMovie(id: movie.id!) { (movie) in
            self.movie = movie
            
            self.poster.image = movie.poster
            self.movieTitle.text = movie.title
            self.movieWriter.text = movie.writer
            if let _ = movie.rating { self.movieRating.text = String(format: "IMDb rating: %.1f", movie.rating!) }
            self.movieRuntime.text = movie.runtime
            self.movieActors.text = movie.actors
            self.movieGenre.text = movie.genre
            self.movieCountry.text = movie.country
            if let year = movie.year { self.movieYear.text = String(describing: year) }
            self.moviePlot.text = movie.plot
        }

    }
    
    func saveMovie() {
        
        var message = ""
        var title = ""
        
        if movie.saveOnCoreData() {
            message = "Movie saved successfully"
            title = "Success"
        } else {
            message = "Movie can't be saved"
            title = "Error"
        }
        
        self.present(UtilObjects.simpleAlert(title: title, message: message), animated: true, completion: nil)
        
        updateSaveButton()
    }
    
    private func updateSaveButton() {
        if let _ = movie.managedObject {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }

}
