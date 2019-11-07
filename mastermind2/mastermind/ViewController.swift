//
//  ViewController.swift
//  mastermind
//
//  Created by Noel Mathew on 31/10/2019.
//  Copyright © 2019 Noel Mathew. All rights reserved.
//

import UIKit

//MARK: Declrations of Arrays and Variables
var imageArrayColours = ["blue", "green", "red", "yellow", "grey", "orange"]
var userGuess = [String]()
var pegImages: [UIImage] = []
var NumberOfPredictions = 0
var blackBlobandWhiteBlob : [UIImage] = []
var cpuPrediction = [String] ()
var bcount = 0
var wcount = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    
  //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NumberOfPredictions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! cellClass
        
        cell.label1.text = "Guess\(NumberOfPredictions)"
    
        if pegImages.count > 0 {
            
            cell.imageDisplay1.image=pegImages[0]
            
            cell.imageDisplay2.image=pegImages[1]
            
            cell.imageDisplay3.image=pegImages[2]
            
            cell.imageDisplay4.image=pegImages[3]
            
        }
        if blackBlobandWhiteBlob.count > 0 {
            
            cell.clue1.image=blackBlobandWhiteBlob[0]
    
        }
        
        if blackBlobandWhiteBlob.count > 1 {
            
            cell.clue2.image=blackBlobandWhiteBlob[1]
        }
        
        if blackBlobandWhiteBlob.count > 2 {
                  
                  cell.clue3.image=blackBlobandWhiteBlob[2]
              }
        if blackBlobandWhiteBlob.count > 3 {
                  
                  cell.clue4.image=blackBlobandWhiteBlob[3]
              }
        return cell
    }
    
    
    @IBOutlet weak var CPUlbl: UILabel!
    
    @IBOutlet weak var Table: UITableView!
    
    @IBOutlet weak var greaterthan4: UILabel!
    
    //MARK: OK Button Pressed
    @IBAction func OKbtn(_ sender: Any) {
        
        if userGuess.count == 4  {
            
            CPUlbl.text = ""
            
            if NumberOfPredictions == 0 {
                
                //create a random array of elements from the predefined array imageArrayColours
                cpuPrediction = [imageArrayColours.randomElement()!,imageArrayColours.randomElement()!,imageArrayColours.randomElement()!,imageArrayColours.randomElement()!]
            }
            
            NumberOfPredictions += 1
            
            var storedComputerGuess = cpuPrediction
    
            
            //prints the random computer guess and the user guess of arrays
            print ("The computer guess is: \(cpuPrediction). The UserGuess is : \(userGuess)")
            
            //check correct peg colour and correct position which is black count defintion
            //MARK: logic of computer guess comparison to user guess and pegs
            for c in 0...3 {
                if cpuPrediction[c] == userGuess[c]{
                    bcount += 1
                    blackBlobandWhiteBlob.append(UIImage(imageLiteralResourceName: "black blob.png"))
                    print ("\(cpuPrediction) matched with \(userGuess[c])---> black")
                    storedComputerGuess[c] = "++"
                    userGuess[c]="--"
                    print ("\(cpuPrediction) black")
                }
            }
            
            //check for peg in the cpu generated guess - white count
            for c in 0...3{
                for j in 0...3{
                    let currentPeg = cpuPrediction[j]
                    if currentPeg == userGuess[c] {
                        wcount += 1
                        blackBlobandWhiteBlob.append(UIImage(imageLiteralResourceName: "white blob.png"))
                        storedComputerGuess[j] = "++"
                        print ("\(cpuPrediction) --> white")
                    }
                }
            }
            
            self.Table.beginUpdates()
            self.Table.insertRows(at: [IndexPath.init (row:0, section:0 )], with: .automatic)
            self.Table.endUpdates()
            
            
            //reloading the colour selection back to default after user presses ok
            firstSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            secondSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            thirdSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            fourthSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            
            
            //reset the black and white counts
            bcount = 0
            wcount = 0
            
            //empty the array so resets
            userGuess = []
            pegImages = []
            blackBlobandWhiteBlob = []
        }
            
        else {
            //executed if use user enters less than 4 choices
            CPUlbl.text = "please enter 4 choices to continue"
        }
        
        
    }
    //MARK: Button Selections Outlets
    @IBAction func blueBtn(_ sender: Any) {
        checkFourMoreColours(n:"blue",image: UIImage(imageLiteralResourceName:"blue.png"))
        
        
    }
    
    @IBAction func yellowBtn(_ sender: Any) {
        
        checkFourMoreColours(n:"yellow",image: UIImage(imageLiteralResourceName:"yellow.png"))
        
    }
    
    @IBAction func redBtn(_ sender: Any) {
        
        checkFourMoreColours(n:"red",image: UIImage(imageLiteralResourceName:"red.png"))
        
    }
    @IBAction func orangeBtn(_ sender: Any) {
        checkFourMoreColours(n:"orange",image: UIImage(imageLiteralResourceName:"orange.png"))
        
    }
    
    @IBAction func greyBtn(_ sender: Any) {
        checkFourMoreColours(n:"grey",image: UIImage(imageLiteralResourceName:"grey.png"))
    }
    
    @IBAction func greenBtn(_ sender: Any) {
        checkFourMoreColours(n:"green",image: UIImage(imageLiteralResourceName:"green.png"))
        print(userGuess)
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    //MARK: delete button
    @IBAction func deleteBtn(_ sender: Any) {
        if userGuess.count > 0 {
            
            
            userGuess.removeLast()
            
            //remove last element of array from user guess
            
            if userGuess.count == 0 {
                firstSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
                
            }
            if userGuess.count == 1 {
                secondSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
                
            }
            if userGuess.count == 2 {
                thirdSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
                
            }
            if userGuess.count == 3 {
                fourthSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
                
            }
            
            
        } else {
            
            print ("game is not active, please start the game again")
        }
    }
    //MARK: outlets to show user guess
    @IBOutlet weak var firstSelectColour: UIImageView!
    
    @IBOutlet weak var secondSelectColour: UIImageView!
    
    @IBOutlet weak var thirdSelectColour: UIImageView!
    
    @IBOutlet weak var fourthSelectColour: UIImageView!
    
    
    
    //function of checking four more colours
    func checkFourMoreColours(n: String, image: UIImage) {
        
        if userGuess.count < 4 {
            userGuess.append(n)
            
            //allGuesses.append(image)
            if userGuess.count == 1 {
                firstSelectColour.image = image
                pegImages.append(firstSelectColour.image!)
            }
            if userGuess.count == 2 {
                secondSelectColour.image = image
                pegImages.append(secondSelectColour.image!)
                
            }
            if userGuess.count == 3 {
                thirdSelectColour.image = image
                pegImages.append(thirdSelectColour.image!)
            }
            if userGuess.count == 4 {
                fourthSelectColour.image = image
                pegImages.append(fourthSelectColour.image!)
            }
            
            
            
        } else {
            greaterthan4.text = "please only enter 4 guesses and click ok"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: TableViewCell content outlets
class cellClass : UITableViewCell {
    
    @IBOutlet weak var imageDisplay1: UIImageView!
    
    @IBOutlet weak var imageDisplay2: UIImageView!
    
    @IBOutlet weak var imageDisplay3: UIImageView!
    
    @IBOutlet weak var imageDisplay4: UIImageView!
    
    @IBOutlet weak var clue1: UIImageView!
    
    @IBOutlet weak var clue2: UIImageView!
    
    @IBOutlet weak var clue3: UIImageView!
    
    @IBOutlet weak var clue4: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
}
