//
//  CoreDataStack.swift
//  EkoChallenge
//
//  Created by Azis Senoaji Prasetyotomo on 05/10/17.
//  Copyright © 2017 Azis Senoaji Prasetyotomo. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataStack {
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private static func getContext () -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }

    static func isFavoritedUser(with id: String) -> Bool {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "userId==\(id)")
        do {
            let results = try getContext().fetch(fetchRequest)
            return results.count > 0
            
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    static func favoriteUser(with id: String) {
        let favorite = Favorite(context: getContext())
        favorite.userId = id
        appDelegate.saveContext()
    }
    
    static func removeFavoritedUser(with id: String) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "userId==\(id)")
        do {
            let results = try getContext().fetch(fetchRequest)
            for result in results {
                getContext().delete(result)
            }
            appDelegate.saveContext()

        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }

    }

}
