//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Sema Topcu on 1/27/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "turkey", "uk", "us"]
       /* instead this code:
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("turkey")
        countries.append("uk")
        countries.append("us") */
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        /*
         our border will be 1 pixel on non-retina devices, 2 pixels on retina devices, and 3 on retina HD devices.
         By default, the border of CALayer is black, but you can change that if you want by using the UIColor data type.
         */
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        /*
         If lightGray doesn't interest you, you can create your own color like this:
         UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
         You need to specify four values: red, green, blue and alpha, each of which should range from 0 (none of that color) to 1.0 (all of that color). The code above generates an orange color, then converts it to a CGColor so it can be assigned to a CALayer's borderColor property.
         */
        
        askQuestion(action: nil)
    }


    func askQuestion(action: UIAlertAction!){
        countries.shuffle() // shuffle() for in-place shuffling, shuffled() to return a new, shuffled array
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        /*
            button.setImage() assigns a UIImage to the button. if askQuestion() is called, it this will change it.
         for: .normal The setImage() method takes a second parameter that describes which state of the button should be changed. We're specifying .normal, which means "the standard state of the button."
         That .normal parameter looks like an enum, but it’s actually a static property of a struct called UIControlState.  if you want to be technically correct it’s not a true enum in Swift.
         */
        
        title = countries[correctAnswer].uppercased()
 
}
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
        /*
         The first line uses .alert, which pops up a message box over the center of the screen, and .actionSheet, which slides options up from the bottom. They are similar, but Apple recommends you use .alert when telling users about a situation change, and .actionSheet when asking them to choose from a set of options.
         The second line uses the UIAlertAction data type to add a button to the alert that says "Continue", and gives it the style “default". There are three possible styles: .default, .cancel, and .destructive. The handler parameter is looking for a closure, which is some code that it can execute when the button is tapped. You can write custom code in there if you want, but in our case we want the game to continue when the button is tapped, so we pass in askQuestion so that iOS will call our askQuestion() method.
         The final line calls present(), which takes two parameters: a view controller to present and whether to animate the presentation. It has an optional third parameter that is another closure that should be executed when the presentation animation has finished, but we don’t need it here. We send our UIAlertController for the first parameter, and true for the second because animation is always nice.


         */
    }
    
}

