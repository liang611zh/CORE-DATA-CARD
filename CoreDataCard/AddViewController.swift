//
//  AddViewController.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-09.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var textedit: UITextField!
    
    
    @IBAction func saveCategory(_ sender: Any) {
        //check if the text is nil
        if let categoryinput = textedit.text{
            
            //check if the text field is empty
            if categoryinput.count != 0 {
                
                //check if db already had the same name(duplicate)
                //call db create func
                
                if Category.CreateCategory(CategoryName: categoryinput, in: context ) != nil {
                    do {
                        //remember to save
                        try context.save()
                        print( "save")
                        //back to previous page
                        self.navigationController?.popViewController(animated: true)
                    } catch {
                        print(error)
                        fatalError("fail to add category.")
                    }
                }
            }
            
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
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
