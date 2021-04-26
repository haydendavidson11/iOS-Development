//
//  ViewController.swift
//  Project2
//
//  Created by Hayden Davidson on 2/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Button1: UIButton!
    
    @IBOutlet var Button2: UIButton!
    
    @IBOutlet var Button3: UIButton!
    
    @IBOutlet var QuestionLabel: UILabel!
    
    @IBOutlet var ScoreLabel: UILabel!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(scoreTapped))
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        Button1.layer.borderWidth = 1
        Button2.layer.borderWidth = 1
        Button3.layer.borderWidth = 1
        
        Button1.layer.borderColor = UIColor.lightGray.cgColor
        Button2.layer.borderColor = UIColor.lightGray.cgColor
        Button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func scoreTapped(){
        let ac = UIAlertController(title: "Your score is" , message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        Button1.setImage(UIImage(named: countries[0]), for: .normal)
        Button2.setImage(UIImage(named: countries[1]), for: .normal)
        Button3.setImage(UIImage(named: countries[2]), for: .normal)
        QuestionLabel.text = "Question \(questionsAsked) of 10"
        ScoreLabel.text = "Your Score is \(score)"
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        
    }
    
    func resetGame(action: UIAlertAction! = nil){
        score = 0
        questionsAsked = 0
        askQuestion()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            questionsAsked += 1
        }else{
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
            questionsAsked += 1
        }
//        create gameover alert
        let gameOver = UIAlertController(title: "Game Over", message: "Your final score was \(score)", preferredStyle: .alert)
        gameOver.addAction(UIAlertAction(title: "Play Again", style: .default, handler: resetGame))
        
//        create score alert
        let ac = UIAlertController(title: title , message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

//       present right alert
        if questionsAsked == 11 {
            present(gameOver, animated: true)
        }else{
            present(ac, animated: true)
        }
    }
    
}

