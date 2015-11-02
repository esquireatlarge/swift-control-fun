//
//  ViewController.swift
//  Control Fun
//
//  Created by Matt Sguerri on 10/28/15.
//  Copyright (c) 2015 EsquireAtLarge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Weak references aren't counted by the ARC, so the object isn't kept in memory.
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var doSomethingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sliderLabel.text = "50";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textFieldDoneEditing(sender: UITextField)
    {
        sender.resignFirstResponder();
    }

    @IBAction func backgroundTap(sender: UIControl)
    {
        nameField.resignFirstResponder();
        numberField.resignFirstResponder();
    }
    
    //Looking at updating a label as a slider is moved
    @IBAction func sliderChanged(sender: UISlider) {
        let progress = lroundf(sender.value);
        sliderLabel.text = "\(progress)";
    }
    
    //Playing with switches.  The animations are cool.
    //This isn't that different in design style from a C# app.
    @IBAction func switchChanged(sender: UISwitch)
    {
        let setting = sender.on;
        leftSwitch.setOn(setting, animated: true);
        rightSwitch.setOn(setting, animated: true);
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        let controller = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .ActionSheet);
        
        let yesAction = UIAlertAction(title: "Yes, I'm sure!", style: .Destructive, handler: {
            action in let msg = self.nameField.text.isEmpty ? "You can breathe easy, it's all ok." :
            "You can breathe easy, \(self.nameField.text)," + " everything went OK.";
            let controller2 = UIAlertController(title: "Something Was Done", message: msg, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Phew!", style: .Cancel, handler: nil)
            controller2.addAction(cancelAction)
            self.presentViewController(controller2, animated: true, completion: nil)
        })
        
        let noAction = UIAlertAction(title: "No way!", style: .Cancel, handler: nil);
        
        controller.addAction(yesAction);
        controller.addAction(noAction);
        
        if let ppc = controller.popoverPresentationController
        {
            ppc.sourceView = sender;
            ppc.sourceRect = sender.bounds;
            ppc.permittedArrowDirections = UIPopoverArrowDirection.Down;
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    //So semicolons aren't necessary, but I'm so used to them it's hard to break the habit!
    @IBAction func toggleControls(sender: UISegmentedControl)
    {
        //Very C++ way of Swifting!
        if (sender.selectedSegmentIndex == 0)
        {
            leftSwitch.hidden = false;
            rightSwitch.hidden = false;
            doSomethingButton.hidden = true;
        }
        else
        {
            leftSwitch.hidden = true;
            rightSwitch.hidden = true;
            doSomethingButton.hidden = false;
        }
    }
}

