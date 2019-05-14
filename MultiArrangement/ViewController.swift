//
//  ViewController.swift
//  MultiArrangement
//
//  Created by Budding Minds Admin on 2019-01-10.
//  Copyright © 2019 Budding Minds Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stimuliControls: UISegmentedControl!
    @IBOutlet weak var subjectField: UITextField!
    var stimuliType = 0
    var stimuli = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startBtn.layer.cornerRadius = 5
        startBtn.layer.borderWidth = 1
        startBtn.layer.borderColor = UIColor.blue.cgColor
        
    }
    
    @IBAction func stimuliChanged(_ sender: Any) {
        stimuliType = stimuliControls.selectedSegmentIndex
    }
    
    @IBAction func startExperiment(_ sender: Any) {
        let choice = stimuliControls.selectedSegmentIndex
        switch choice {
        case 0:
            print("case 0")
            performSegue(withIdentifier: "DefaultSegue", sender: self)
            
        case 1:
            performSegue(withIdentifier: "CustomSegue", sender: self)
        case 2:
            performSegue(withIdentifier: "SlideshowSegue", sender: self)
        default:
            print("error at start button")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DefaultSegue" {
            print("line 53")
            let controller = segue.destination as! CircularArenaController
            //need to load controller.stimuli right away
            controller.stimuli = load_data(fileName: "meadows_stimuli", fileType: "csv")
            controller.subjectID = subjectField.text!
            
        } else if segue.identifier == "CustomSegue" {
            let controller = segue.destination as! CustomStimuliController
            controller.subjectID = subjectField.text!
        } else if segue.identifier == "SlideshowSegue" {
            let controller = segue.destination as! SlideshowController
            controller.subjectID = subjectField.text!
        }
        
    }
    
    func load_data(fileName: String, fileType: String) -> [String]! {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            let data = contents.components(separatedBy: "\r")
            return data
        } catch {
            return nil
        }
    }

}

