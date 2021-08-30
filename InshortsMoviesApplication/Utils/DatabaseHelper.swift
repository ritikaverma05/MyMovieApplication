//
//  DatabaseHelper.swift
//  InshortsMoviesApplication
//
//  Created by RITIKA VERMA on 16/08/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saved(object: [String:String]){
        let savedMovies = NSEntityDescription.insertNewObject(forEntityName: "SavedMovies", into: context!) as! SavedMovies
        savedMovies.posterPath = object["posterPath"]
        savedMovies.release_date = object["release_date"]
        savedMovies.title = object["title"] as NSObject?
        
        do{
            try context?.save()
        }catch{
            print("Data is not saved")
        }
        
    }
    
    func getMovies() -> [SavedMovies]{
        var savedMovies = [SavedMovies]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedMovies")
        do{
            savedMovies = try context?.fetch(fetchRequest) as! [SavedMovies]
        }catch{
            print("Data con not be fetched")
        }
        return savedMovies
    }
    
    
    func deleteMovie(index: Int) -> [SavedMovies]{
        
        var savedMovies = getMovies()
        context?.delete(savedMovies[index])
        savedMovies.remove(at: index)
        do{
            try context?.save()
        }catch{
            print("Data is not deleted")
        }
        return savedMovies
    }
    
    func checkMovie(name: String) -> (Bool,Int){
        var savedMovies = [SavedMovies]()
        var flag = 0
        
        savedMovies = DatabaseHelper.sharedInstance.getMovies()
        
        for i in savedMovies{
            if(i.title! as! String == name){
                print("movie found")
                return (true,flag)
            }
            flag+=1
        }
        return (false,0)
    }
    
}
