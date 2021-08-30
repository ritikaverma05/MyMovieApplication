//
//  SavedViewController.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 14/08/21.
//

import UIKit

class SavedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var savedMovieTableView: UITableView!
    
    var savedMovies = [SavedMovies]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("testing")
        savedMovieTableView.delegate = self
        savedMovieTableView.dataSource = self
        savedMovieTableView.register(UINib(nibName: Constants.SavedTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.SavedTableViewCell)
        savedMovies = DatabaseHelper.sharedInstance.getMovies()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedMovies = DatabaseHelper.sharedInstance.getMovies()
        self.savedMovieTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = savedMovieTableView.dequeueReusableCell(withIdentifier: Constants.SavedTableViewCell, for: indexPath) as! SavedTableViewCell
        cell.savedMovies = savedMovies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            savedMovies = DatabaseHelper.sharedInstance.deleteMovie(index: indexPath.row)
            self.savedMovieTableView.deleteRows(at: [indexPath], with: .automatic
            )

        }
    }

}
