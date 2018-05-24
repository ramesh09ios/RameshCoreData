//
//  ViewController.swift
//  SwiftCoreDataPratice
//
//  Created by BlazeDream on 23/05/18.
//  Copyright © 2018 BlazeDream. All rights reserved.
//

import UIKit
import  CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var userTableView : UITableView!
    
    static var ageIncrement = 20;
    var userDataArr = NSMutableArray();
    var userDataModelObjectArr = NSMutableArray();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userCell = tableView.dequeueReusableCell(withIdentifier: "UserTableCellID", for: indexPath) as! UserTableCell;
        let userObject = userDataArr.object(at: indexPath.row) as!  UsersRoles;
        userCell.assignUserData(user: userObject);
        return userCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gotoAddUserDataVC(indexPath: indexPath);
    }
    
    func  gotoAddUserDataVC(indexPath : IndexPath) {
        
        let userVC = self.storyboard?.instantiateViewController(withIdentifier: "AddUserControllerID")as! AddUserController;
        userVC.managedObject = userDataModelObjectArr.object(at: indexPath.row) as! NSManagedObject;
        self.navigationController?.pushViewController(userVC, animated: true);
    }
    
    
    @IBAction func assignUserDataAction(_ sender : UIButton)
    {
        ViewController.ageIncrement += 1;
        let userModel = UserDataModel(controller: self)
        let userObject = UsersRoles(name: "Ramesh", password: "123456", age: ViewController.ageIncrement);
        userModel.saveNewUserData(role: userObject);
        
        //== getUserData
        let userData = userModel.getAllUserData(entityName: "Users");
        userDataArr = userData.0 
        userDataModelObjectArr = (userData.1 as! NSArray).mutableCopy() as! NSMutableArray;
        userTableView.reloadData();
    }

}

