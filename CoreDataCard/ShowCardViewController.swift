//
//  ShowCardViewController.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-16.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData

class ShowCardViewController: UIViewController {
    var context : NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Card>!
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var frontlable: UILabel!
    @IBOutlet weak var frontview: UIView!
    var flipflag = false
    @IBOutlet weak var backlable: UILabel!
    
    @IBAction func flipback(_ sender: UIButton) {
        flipflag = !flipflag
        let fromview = flipflag ? frontview : backview
        let toview = flipflag ? backview : frontview
        UIView.transition(from: fromview!, to: toview!, duration: 0.5, options: [.transitionFlipFromRight,.showHideTransitionViews])
    }

    
    @IBAction func flipit(_ sender: UIButton) {
        flipflag = !flipflag
        let fromview = flipflag ? frontview : backview
        let toview = flipflag ? backview : frontview
        UIView.transition(from: fromview!, to: toview!, duration: 0.5, options: [.transitionFlipFromRight,.showHideTransitionViews])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
