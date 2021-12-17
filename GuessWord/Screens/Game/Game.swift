//
//  Game.swift
//  GuessWord
//
//  Created by Stanislav Lemeshaev on 07.12.2021.
//  Copyright © 2021 slemeshaev. All rights reserved.
//

struct Game {
    
    // MARK: - Init
    init(hiddenWord: String, wrongMovesRemainder: Int) {
        self.hiddenWord = hiddenWord
        self.wrongMovesRemainder = wrongMovesRemainder
    }
    
    // MARK: - Properties
    var hiddenWord: String
    var wrongMovesRemainder: Int
    
    private var guessedLetters = [Character]()
    
    var guessedWord: String {
        var wordToShow = String()
        
        for letter in hiddenWord {
            if guessedLetters.contains(Character(letter.lowercased())) || letter == "-" || letter == " " {
                wordToShow += String(letter)
            } else {
                wordToShow += "_"
            }
        }
        
        return wordToShow
    }
    
    // MARK: - Interface
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        
        if !hiddenWord.lowercased().contains(lowercasedLetter) {
            wrongMovesRemainder -= 1
        }
    }
}
