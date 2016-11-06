import Foundation

class WordBank {
    
    func randomWord() -> String {
        let min = 0
        let max = words.count
        let randomNumber = Int(arc4random_uniform(UInt32(max - min)) + UInt32(min))
        return words[randomNumber]
    }
    
    func randomWords() -> Data {
        let randomWords = [randomWord(), randomWord(), randomWord(), randomWord(), randomWord()]
        return NSKeyedArchiver.archivedData(withRootObject: randomWords)
    }
    
    private let words=["accepting",
                       "accord",
                       "acoustic",
                       "adrenaline",
                       "ageless",
                       "almost",
                       "ambitious",
                       "apology",
                       "aroma",
                       "atmosphere",
                       "attitude",
                       "awakening",
                       "balance",
                       "becoming",
                       "beginning",
                       "beyond",
                       "blend",
                       "bloom",
                       "boundary",
                       "caress",
                       "clever",
                       "coincidence",
                       "comfortable",
                       "complete",
                       "conclusion",
                       "constant",
                       "contrast",
                       "cultural",
                       "decadence",
                       "diversion",
                       "drift",
                       "dynamic",
                       "elsewhere",
                       "endless",
                       "enlighten",
                       "ephemeral",
                       "flicker",
                       "happiness",
                       "home",
                       "intimate",
                       "liberating",
                       "magic",
                       "memory",
                       "momentary",
                       "mysterious",
                       "nomadic",
                       "ornamental",
                       "paradise",
                       "philosophy",
                       "poetic",
                       "potential",
                       "profound",
                       "promise",
                       "prophetic",
                       "purpose",
                       "release",
                       "riddle",
                       "scenic",
                       "serenity",
                       "soft",
                       "solid",
                       "solitary",
                       "soul",
                       "spirit",
                       "timeless",
                       "vision",
                       "warmth",
                       "whisper",
                       "wisdom",
                       "world"];

}
