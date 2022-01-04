//
//  AppDelegate.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        preLoadJsonIntoCoreData()
        
        return true
    }
    
    private func preLoadJsonIntoCoreData(){
        //get reference to user default, which is the local storage
        let defaultUser = UserDefaults.standard
        //get reference to the core data context
        let context = persistentContainer.viewContext
        
        //check if this is the first lanuch
        //if it is the first lauch, the key doesn't exist at all. Hence, by default, it will return false
        if defaultUser.bool(forKey: Constants.PRELOAD) == false {
            //if so, parse the json file into core data
            let path = Bundle.main.path(forResource: "PreloadedData", ofType: "json")
            guard path != nil else {
                return
            }
            //get the url
            let url = URL(fileURLWithPath: path!)
            //get the data for the file
            let data = try! Data(contentsOf: url)
            
            //this one won't work for core data cuz core data cannot from decoable protocol
            //let decoder = JSONDecoder()
            //let dictionaries = try! decoder.decode([[String:Any]].self, from: data)
            
            //so, we instead turn the data into an json object
            let dicts = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
            
            //then loop through the json object which is an array of dictionaries/namely the place object
            for dic in dicts{
                
                //create a place object under the context and populate the properties
                let p = Place(context: context)
                //the property of the entity of core data is conditional by default
                p.name = dic["name"] as? String
                p.address = dic["address"] as? String
                p.imageName = dic["imagename"] as? String
                p.summary = dic["summary"] as? String
                p.latitude = dic["lat"] as! Double
                p.longitude = dic["long"] as! Double
                
            }
            //save all the datas by saving the context
            self.saveContext()
            
            //change the value of flag
            defaultUser.set(true, forKey: Constants.PRELOAD)
        }
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Guidebook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

