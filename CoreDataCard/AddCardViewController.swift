//
//  AddCardViewController.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-16.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData
class AddCardViewController: UIViewController {
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var keywordlable: UITextField!
    @IBOutlet weak var cardbacklable: UITextField!
    @IBOutlet weak var cardfrontlable: UITextField!
    
    @IBAction func savecard(_ sender: Any) {
        let keywordinput = keywordlable.text
        let cardbackinput = cardbacklable.text
        let cardfrontinput = cardfrontlable.text
        
        
        
        //check if the text field is empty
        if (keywordinput?.count != 0 && cardbackinput?.count != 0 && cardfrontinput?.count != 0 ) {
            
            //check if db already had the same name(duplicate)
            //call db create func
            
            if Card.CreateCard(KeyWord: keywordinput!, CardFront: cardfrontinput!, CardBack: cardbackinput!, in: context) != nil {
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
extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
