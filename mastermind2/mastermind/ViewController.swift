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
let maxNumberOfGames = 10
var blackBlobandWhiteBlob : [UIImage] = []
var cpuPrediction = [String] ()
var bcount = 0
var wcount = 0
var reset = false
var userWins = 0
var cpuWins = 0

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: TableView and tableview cell contents
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
    
    @IBOutlet weak var labelGameOver: UILabel!
    
    @IBOutlet weak var labelGameWon: UILabel!
    
    @IBOutlet weak var cpuLbl: UILabel!
    
    @IBOutlet weak var resetHide: UIButton!
    
    @IBOutlet weak var userLbl: UILabel!
    
    
    @IBOutlet weak var okHide: UIButton!
    
    //reference as outlet here hidden button
    
    //MARK: OK Button Pressed
    @IBAction func OKbtn(_ sender: Any) {
         resetHide.isHidden = false
        if userGuess.count == 4  {
            
            
            if NumberOfPredictions == 0 {
                
                //create a random array of elements from the predefined array imageArrayColours
                cpuPrediction = [imageArrayColours.randomElement()!,imageArrayColours.randomElement()!,imageArrayColours.randomElement()!,imageArrayColours.randomElement()!]
                
            }
            if NumberOfPredictions < maxNumberOfGames {
                
                //increment number of predictions
                NumberOfPredictions += 1
                
                //store the imageArrayColours from cpu in this variable so we can increment it later on
                var storedComputerGuess = cpuPrediction
                
                
                //prints the random computer guess and the user guess from array
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
                
                
//                if bcount == 4 && NumberOfPredictions < maxNumberOfGames {
//
//                    labelGameOver.text = "You've won,click reset to start the game"
//
//                    userWins += 1
//                    UserDefaults.standard.set(userWins, forKey: "userWins")
//                    userLbl.text = "user wins: \(userWins)"
//
//                    //okHidden.isHidden = true
//
//                }
                if (bcount == 4 && NumberOfPredictions == maxNumberOfGames) || (bcount == 4 && NumberOfPredictions < maxNumberOfGames ) {
                    userWins += 1
                    UserDefaults.standard.set(userWins, forKey: "userWins")
                    userLbl.text = "user wins: \(userWins)"
                    labelGameWon.text = "You've won"
                  
                        okHide.isHidden = true
                }
                
                if wcount == 4 && maxNumberOfGames == NumberOfPredictions{
                    
                    labelGameOver.text = "GameOver,click reset to start the game"
                    cpuWins += 1
                    UserDefaults.standard.set(cpuWins, forKey: "cpuWins")
                    cpuLbl.text = "cpu: \(cpuWins)"
                }
                
                if NumberOfPredictions == maxNumberOfGames && wcount <= 4 {
                    
                    labelGameOver.text = "GameOver,click reset to start the game"
                    cpuWins += 1
                    UserDefaults.standard.set(cpuWins, forKey: "cpuWins")
                    cpuLbl.text = "cpu: \(cpuWins)"
                }
                
                
                if bcount != 4 && NumberOfPredictions == maxNumberOfGames {
                    
                    labelGameOver.text = "GameOver, code-maker wins the game"
                    cpuWins += 1
                    UserDefaults.standard.set(cpuWins, forKey: "cpuWins")
                    cpuLbl.text = "cpu: \(cpuWins)"
                }
                
                
                
                //reset table view and start from the beginning again
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
                
                //empty the array so resets, ready for next input
                userGuess = []
                pegImages = []
                blackBlobandWhiteBlob = []
                
            }
        }
        else {
            //executed if use user enters less than 4 choices
            CPUlbl.text = "please enter 4 choices to continue"
        }
        
        
    }
    
    
    //MARK: reset button
    @IBAction func resetBtn(_ sender: Any) {
        
        
        print ("game started")
        for _ in 1 ... NumberOfPredictions {
            
            NumberOfPredictions -= 1
            
            let iPath = IndexPath(item:0, section :0)
            Table.deleteRows(at: [iPath], with: .fade)
            
        }
        
        firstSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
        secondSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
        thirdSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
        fourthSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
        
        bcount = 0
        wcount = 0
        userGuess = []
        pegImages = []
        blackBlobandWhiteBlob = []
        
        labelGameOver.isHidden = true
        greaterthan4.isHidden = true
        CPUlbl.isHidden = true
        //okHide.isHidden = false
       
        
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
            
            
            //remove last element of array from user guess
            userGuess.removeLast()
            
            //when delete button is pressed: the array element position selection reset back to white blob state. So the user can choose again.
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
            
            
            //var userGuessStore = userGuess.count
            //            switch userGuess.count {
            //            case userGuess.count == 0:
            //                firstSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            //                case let userGuessStore where userGuessStore == 1:
            //                      secondSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            //                       case let userGuessStore where userGuessStore == 2:
            //                             thirdSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            //                              case let userGuessStore where userGuessStore == 3:
            //                               fourthSelectColour.image = UIImage(imageLiteralResourceName:"white blob.png")
            //                default:
            //                print("default")
            //
            //            }
            
            
        } else {
            
            print ("game is not active, please start the game again")
        }
    }
    //MARK: outlets to show user guess
    @IBOutlet weak var firstSelectColour: UIImageView!
    
    @IBOutlet weak var secondSelectColour: UIImageView!
    
    @IBOutlet weak var thirdSelectColour: UIImageView!
    
    @IBOutlet weak var fourthSelectColour: UIImageView!
    
    
    
    //function of checking for four more colours
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
        
        userWins = UserDefaults.standard.integer(forKey: "userWins")
        cpuWins = UserDefaults.standard.integer(forKey: "cpuWins")
        
        userLbl.text = "user wins: \(userWins)"
        cpuLbl.text = "cpuwins: \(cpuWins)"
        
        resetHide.isHidden = true
              
    }
    // if let playerWins  = UserDefaults.standard.integer(forKey: "UserWins") as? Int {
    //}
    // Do any additional setup after loading the view.
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
