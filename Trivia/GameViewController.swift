//import UIKit

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    var currentQuestionIndex = 0
    var currentCategory: TriviaCode = .politics
    var currentQuestion: Question? // Update this to be a Question object

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion() // Load the first question
    }

    // Load the first question
    func loadQuestion() {
        guard let currentQuestion = getQuestion(for: currentCategory) else { return }

        questionLabel.text = currentQuestion.text
        categoryLabel.text = currentQuestion.category.description
        firstOption.setTitle(currentQuestion.choices[0], for: .normal)
        secOption.setTitle(currentQuestion.choices[1], for: .normal)
        thirdOption.setTitle(currentQuestion.choices[2], for: .normal)
        fourthOption.setTitle(currentQuestion.choices[3], for: .normal)
    }

    func checkAnswer(selectedOption: String) {
        guard let currentQuestion = currentQuestion else { return }
        let isCorrect = selectedOption == currentQuestion.correctAnswer
        let message = isCorrect ? "Correct" : "Incorrect"
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default) { _ in
            self.nextQuestion()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func nextQuestion() {
        currentQuestionIndex += 1
        loadQuestion() // Load next question
    }

    @IBAction func firstOption(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle ?? "")
    }
    @IBAction func secOption(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle ?? "")
    }
    @IBAction func thirdOption(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle ?? "")
    }
    @IBAction func fourthOption(_ sender: UIButton) {
        checkAnswer(selectedOption: sender.currentTitle ?? "")
    }

    // Get the question for the specified category
    func getQuestion(for category: TriviaCode) -> Question? {
        // Filter the questions by category and return the first match
        let filteredQuestions = questions.filter { $0.category == category }
        return filteredQuestions.isEmpty ? nil : filteredQuestions[currentQuestionIndex % filteredQuestions.count]
    }
}

