import Foundation

struct TriviaElements {
    let triviaCode: TriviaCode
}

enum TriviaCode {
    case politics
    case TV
    case science

    // Use this for the title of each category
    var description: String {
        switch self {
        case .politics:
            return "Politics"
        case .TV:
            return "TV Show"
        case .science:
            return "Science"
        }
    }
}

struct Question {
    let text: String
    let choices: [String]
    let correctAnswer: String
    let category: TriviaCode
}

let questions: [Question] = [
    Question(
        text: "Which president endorsed the New Deal Act?",
        choices: ["Benjamin Franklin", "Barack Obama", "Franklin D. Roosevelt", "Harry S. Truman"],
        correctAnswer: "Franklin D. Roosevelt",
        category: .politics
    ),
    Question(
        text: "Who is the host of the show 'What Would You Do?'",
        choices: ["Chris Hansen", "John Quinones", "Anderson Cooper", "Ellen Degeneres"],
        correctAnswer: "John Quinones",
        category: .TV
    ),
    Question(
        text: "What is the chemical symbol for gold",
        choices: ["Ag", "Au", "Cu", "Pb"],
        correctAnswer: "Au",
        category: .science
    )
]
