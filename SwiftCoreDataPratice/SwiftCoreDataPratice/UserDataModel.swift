//
//  UserDataModel.swift
//  SwiftCoreDataPratice
//
//  Created by BlazeDream on 23/05/18.
//  Copyright © 2018 BlazeDream. All rights reserved.
//

import UIKit
import CoreData

class UserDataModel: NSObject {

    let appDelegate = UIApplication.shared.delegate! as! AppDelegate;
    let context : NSManagedObjectContext!;
    let currentController : UIViewController!
    
    init( controller : UIViewController ) {
        currentController = controller;
        context = appDelegate.getContext();
    }
    
    func getEntityByName(entityName : String) -> NSEntityDescription?
    {
        guard (context) != nil else{
            print("Managed Object Context not Created");
            return nil;
        }
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        return entity!;
    }
    
    func createNewManagedObject(entityName : String) -> NSManagedObject?
    {
        guard (context) != nil else{
            print("Managed Object Context not Created");
            return nil;
        }
        let entity = self.getEntityByName(entityName: entityName);
        if  let userEntity = entity {
            let managedObject = NSManagedObject(entity: userEntity, insertInto: context);
            return managedObject
        }
        return nil;
    }
    
    //==FetchExistingUserData
    func getFetchRequest(entityName : String)-> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        return fetchRequest
    }
    
    //== UpDate(EDIT)
    func updateManagedObject(managedObject : NSManagedObject , entityName : String) {
        do{
            try managedObject.managedObjectContext?.save() //context.save()
        }catch{
            print("Not saved");
        }
    }
    
    //== DeleteObject
    func deleteManagedObject(managedObject : NSManagedObject , entityName : String) {
        context.delete(managedObject);
        do{
            try context.save()
        }catch{
            print("Not Deleted record")
        }
    }
    
    //MARK:- USERMODULE COREDATA
    
    //==SaveNewUserData
    func saveNewUserData(role : UsersRoles)
    {
        if let newManagedObject = self.createNewManagedObject(entityName: "Users"){
            
            newManagedObject.setValue(role.name, forKey: "name");
            newManagedObject.setValue(role.password, forKey: "password");
            newManagedObject.setValue(role.age, forKey: "age");
            do{
                try context.save()
            }catch{
                print("Unable to Save content");
            }
        }
    }
    
    //== getFetchResults
    func getAllUserData(entityName : String) -> (NSMutableArray,NSArray) {
        let request = self.getFetchRequest(entityName: entityName);
        request.returnsObjectsAsFaults = true;
        let userRoleArr = NSMutableArray();
        var results = [NSManagedObject]()
        do{
            results = try context.fetch(request) as! [NSManagedObject]
            for data in results as! [NSManagedObject]
            {
                
                let userRole = UsersRoles();
                userRole.name = data.value(forKey: "name") as! String;
                userRole.password = data.value(forKey: "password") as! String;
                userRole.age = data.value(forKey: "age") as! Int;
                userRoleArr.add(userRole);
                
            }
        }catch{
            print("User Role Faild");
        }
        return (userRoleArr,results as NSArray);
    }
}

class UsersRoles {
    var name : String! = "";
    var password : String! = "";
    var age = 0
    
    init() {
    }
    
    init(name: String, password:String, age : Int) {
        self.name = name;
        self.password = password;
        self.age = age;
    }
}
