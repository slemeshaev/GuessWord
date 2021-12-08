//
//  GameViewController.swift
//  GuessWord
//
//  Created by Stanislav Lemeshaev on 05.12.2021.
//  Copyright © 2021 slemeshaev. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private let incorrectMovesAllowed = 7
    private var listOfWords: [String] = []
    private var totalWins = 0
    private var totalLosses = 0
    private var currentGame: Game!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    // MARK: - Interface
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    // MARK: - Private
    private func setupGame() {
        listOfWords = createRelativesList()
        let newWord = listOfWords.removeFirst()
        currentGame = Game(hiddenWord: newWord, wrongMovesRemainder: incorrectMovesAllowed)
        updateUI()
    }
    
    private func updateUI() {
        let movesRemainder = currentGame.wrongMovesRemainder
        let image = "Tree\(movesRemainder < 8 ? movesRemainder : 7)"
        treeImageView.image = UIImage(named: image)
        scoreLabel.text = "Winning streak: \(totalWins), losses: \(totalLosses)"
    }
}

// MARK: - GameViewController
extension GameViewController {
    
    private func createRelativesList() -> [String] {
        return ["aunt", "brother", "cousin", "daughter", "father", "grandmother", "grandfather",
                "mother", "newphew", "niece", "sister", "son", "uncle", "wife"]
    }
}

