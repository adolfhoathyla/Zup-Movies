//
//  MovieSearchViewController.swift
//  Zup Movies
//
//  Created by Adolfho Athyla on 14/01/17.
//  Copyright © 2017 a7hyla. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var movieTitle: UITextField!
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        indicator.hidesWhenStopped = true
        
        movieTitle.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        indicator.startAnimating()
        textField.resignFirstResponder()
        
        OMDBHelper.searchMovie(text: textField.text!) { (movies) in
            if let _ = movies {
                if (movies?.count)! > 0 {
                    self.performSegue(withIdentifier: "GO_TO_SEARCH_RESULT", sender: movies)
                }
            } else {
                self.present(UtilObjects.alertWithEvent(title: "No results", message: "Your search returned no results", handler: {
                    self.movieTitle.becomeFirstResponder()
                }), animated: true, completion: nil)
            }
            self.indicator.stopAnimating()
        }
        
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let searchResults = segue.destination as? SearchResultTableViewController
        searchResults?.movies = (sender as? [Movie])!
    }
    

}
