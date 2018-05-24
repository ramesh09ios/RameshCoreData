//
//  AddUserController.swift
//  SwiftCoreDataPratice
//
//  Created by BlazeDream on 23/05/18.
//  Copyright © 2018 BlazeDream. All rights reserved.
//

import UIKit
import CoreData

class AddUserController: UIViewController {

    @IBOutlet var nameTxt : UITextField!;
    @IBOutlet var passwordTxt : UITextField!;
    @IBOutlet var ageTxt : UITextField!;
    @IBOutlet var submitBtn : UIButton!;

    var managedObject : NSManagedObject!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignAddUserAction();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assignAddUserAction() {
        nameTxt.text = managedObject.value(forKey: "name") as? String;
        passwordTxt.text = managedObject.value(forKey: "password") as? String;
        ageTxt.text =  String(describing: managedObject.value(forKey: "age")!);
    }
    
    
    @IBAction func submitAction(_ sender : UIButton)
    {
         let userModel = UserDataModel(controller: self);
        
        if sender.tag == 1 {
            //== submit
            managedObject.setValue(nameTxt.text, forKey: "name");
            managedObject.setValue(passwordTxt.text, forKey: "password");
            managedObject.setValue(Int(ageTxt.text!), forKey: "age");
            userModel.updateManagedObject(managedObject: managedObject, entityName: "Users");
            
        }else{
            //== Delete
            userModel.deleteManagedObject(managedObject: managedObject, entityName: "Users")
        }
        
        self.navigationController?.popViewController(animated: true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
