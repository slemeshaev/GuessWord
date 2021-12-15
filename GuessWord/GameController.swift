//
//  GameController.swift
//  GuessWord
//
//  Created by Stanislav Lemeshaev on 05.12.2021.
//  Copyright © 2021 slemeshaev. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var treeImageView: UIImageView!
    @IBOutlet private var letterButtons: [UIButton]!
    @IBOutlet private weak var correctWordLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private let incorrectMovesAllowed = 7
    private var listOfWords: [String] = []
    private var totalWins = 0
    private var totalLosses = 0
    private var currentGame: MGame!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    // MARK: - Private
    @IBAction private func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        if let letter = sender.titleLabel?.text {
            currentGame.playerGuessed(letter: Character(letter))
        }
        
        updateUI()
    }
    
    private func setupGame() {
        listOfWords = createRelativesList()
        let hiddenWord = listOfWords.removeFirst()
        currentGame = MGame(hiddenWord: hiddenWord, wrongMovesRemainder: incorrectMovesAllowed)
        updateUI()
    }
    
    private func updateCorrectWord() {
        var displayedWord = [String]()
        
        for letter in currentGame.guessedWord {
            displayedWord.append(String(letter))
        }
        
        correctWordLabel.text = displayedWord.joined(separator: " ")
    }
    
    private func updateUI() {
        let movesRemainder = currentGame.wrongMovesRemainder
        let imageNumber = (movesRemainder + 64) % 8
        let image = "Tree\(imageNumber)"
        
        treeImageView.image = UIImage(named: image)
        updateCorrectWord()
        scoreLabel.text = "Winning streak: \(totalWins), losses: \(totalLosses)"
    }
}

// MARK: - GameController
extension GameController {
    
    private func createRelativesList() -> [String] {
        return ["aunt", "brother", "cousin", "daughter", "father", "grandmother", "grandfather",
                "mother", "newphew", "niece", "sister", "son", "uncle", "wife"]
    }
}

