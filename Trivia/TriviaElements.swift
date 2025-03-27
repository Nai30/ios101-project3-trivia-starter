import Foundation

struct TriviaAPIResponse: Decodable{
    let results:[Question]
}

struct Question: Decodable {
    let text: String
    let choices: [String]
    let correctAnswer: String
    let category: String
    let type: String
    let difficulty: String
    
    private enum CodingKeys: String, CodingKey {
        case text="question"
        case incorrectAnswers="incorrect_answers"
        case correctAnswer="correct_answer"
        case category
        case type
        case difficulty
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        let incorrectAnswers = try container.decode([String].self, forKey:.incorrectAnswers)
        correctAnswer = try container.decode(String.self,forKey: .correctAnswer)
        category = try container.decode(String.self, forKey: .category)
        type = try container.decode(String.self, forKey: .type)
        difficulty = try container.decode(String.self, forKey: .difficulty)
        choices = (incorrectAnswers + [correctAnswer]).shuffled()
        
    }
}



