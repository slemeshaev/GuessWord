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
    @IBOutlet private weak var treeImageView: UIImageView!
    @IBOutlet private var letterButtons: [UIButton]!
    @IBOutlet private weak var correctWordLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private let incorrectMovesAllowed = 7
    private var listOfWords: [String] = []
    private var currentGame: Game!
    
    private var totalWins = 0 {
        didSet {
            setupGame()
        }
    }
    
    private var totalLosses = 0 {
        didSet {
            setupGame()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfWords = loadWordList(from: "Family")
        setupGame()
    }
    
    // MARK: - Private
    @IBAction private func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        if let letter = sender.titleLabel?.text {
            currentGame.playerGuessed(letter: Character(letter))
        }
        
        updateState()
    }
    
    private func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    private func setupGame() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        
        let hiddenWord = listOfWords.removeFirst()
        currentGame = Game(hiddenWord: hiddenWord, wrongMovesRemainder: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    private func updateCorrectWord() {
        var displayedWord = [String]()
        
        for letter in currentGame.guessedWord {
            displayedWord.append(String(letter))
        }
        
        correctWordLabel.text = displayedWord.joined(separator: " ")
    }
    
    private func updateState() {
        if currentGame.wrongMovesRemainder < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.hiddenWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    private func updateUI() {
        let movesRemainder = currentGame.wrongMovesRemainder
        let imageNumber = (movesRemainder + 64) % 8
        let image = "Tree\(imageNumber)"
        
        treeImageView.image = UIImage(named: image)
        updateCorrectWord()
        scoreLabel.text = "Winning streak: \(totalWins), losses: \(totalLosses)"
    }
    
    private func loadWordList(from list: String) -> [String] {
        let plistURL = Bundle.main.url(forResource: list, withExtension: "plist")
        
        guard let plistURL = plistURL else {
            return []
        }
        
        let plistData = try? Data(contentsOf: plistURL)
        
        guard let plistData = plistData else {
            return []
        }
        
        let listWords = try? PropertyListSerialization.propertyList(from: plistData, format: nil)
        
        guard let listWords = listWords as? [String] else {
            return []
        }
        
        return listWords.shuffled()
    }
}
