//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import UIKit
import os.log
class MealTableViewController: UITableViewController {

    var meals=[Meal]();
    private func loadSampleMeal(){
        let img1=UIImage(named: "Image_test")
        guard let meal1=Meal(name: "bird", rating: 3, photo: img1) else {
            fatalError("unable to init")
        }
        meals+=[meal1]
    }
    private func loadMeal()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.archiveUrl.path) as? [Meal]
    }
    private func saveMeals(){
//        for m in meals{
//            m.rate=1;
//        }
        let isSuccessfulSave=NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.archiveUrl.path)
        if isSuccessfulSave{
            os_log("Meals saved", log:OSLog.default ,type: .debug)
        }
        
        //print(meals)
    }
    @IBAction func unwindToMealList(sender:UIStoryboardSegue){
        if let sourceViewController = sender.source as? ViewController, let meal=sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                meals[selectedIndexPath.row]=meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)                
            }else{
                let newIndexPath=IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveMeals();

            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem=editButtonItem
        //loadSampleMeal();
        if let saveMeals=loadMeal(){
            meals+=saveMeals;
        }else{
            loadSampleMeal();
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier="MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("the error in meal table view cell");
        }
        let meal=meals[indexPath.row];
        cell.Name_view.text=meal.name
        cell.Image_view.image=meal.photo
        cell.Rating_control.rating=meal.rating
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? ""{
        case "AddItem":
            os_log("Add a new Item.", log:OSLog.default,type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController=segue.destination as? ViewController else{
                fatalError("Unexpected destination:\(segue.destination)")
            }
            guard let selectedMealCell=sender as? MealTableViewCell else{
                fatalError("Unexpected sender:\(String(describing: sender))")
            }
            guard let indexPath=tableView.indexPath(for: selectedMealCell) else{
                fatalError("the selected is disapper")
            }
            let selectedMeal=meals[indexPath.row]
            mealDetailViewController.meal=selectedMeal;
        default:
            fatalError("Unexpected Segue Identifier \(String(describing: segue.identifier))");
        }
        
    }
    

}
