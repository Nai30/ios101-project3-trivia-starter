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
    
    var currentQuestionIndex = 0 //what question the user is at
    var currentCategory: String = ""//current category
    var currentQuestion: Question? // Update this to be a Question object
    var correctAnswerCount=0//how many correct answers the user got
    var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNewQuestions()
        
        
            self.loadQuestion()
        
    }
    
    
    
    // Load the questions
    func loadQuestion() {
        
        guard let currentQuestion = getQuestion() else { return }
        var numberOfQuestions=currentQuestion.choices.count
        var count=4
        questionLabel.text = currentQuestion.text
        categoryLabel.text = currentQuestion.category.description
        if numberOfQuestions != count {
            firstOption.setTitle(currentQuestion.choices[0], for: .normal)
            secOption.setTitle(currentQuestion.choices[1], for: .normal)
            thirdOption.isHidden=true
            fourthOption.isHidden=true
            
            return
        }
        firstOption.setTitle(currentQuestion.choices[0], for: .normal)
        secOption.setTitle(currentQuestion.choices[1], for: .normal)
        thirdOption.setTitle(currentQuestion.choices[2], for: .normal)
        fourthOption.setTitle(currentQuestion.choices[3], for: .normal)
    }
    
    func checkAnswer(selectedOption: String) {
        let correctAnswerOfCurrentQuestion = questions[currentQuestionIndex].correctAnswer
        let isCorrect = selectedOption == correctAnswerOfCurrentQuestion
        let message = isCorrect ? "Correct" : "Incorrect"
        if message=="Correct"{
            correctAnswerCount += 1
        }
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default) { _ in
            self.nextQuestion()
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        guard currentQuestionIndex <= questions.count-1 else {
            let alert = UIAlertController(title: "Game Over", message:"You got \(correctAnswerCount) / \(questions.count) correct", preferredStyle: .alert)
            let action = UIAlertAction(title: "Restart", style: .destructive){ (action)
                in
                self.resetGame()
                print ("Restart")
                
                
            }
            
            alert.addAction(action)
            self.present(alert, animated: true , completion: nil)
            return
        }
        loadQuestion() // Load next question
    }
    //
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
    func getQuestion() -> Question? {
        //Filter the questions by category and return the first match
        guard !questions.isEmpty, currentQuestionIndex<questions.count else{
            return nil
        }
        return questions[currentQuestionIndex]
        
    }
    func loadNewQuestions(){
        TriviaService.fetchTriviaElements{ newQuestions in
            self.questions.append(contentsOf: newQuestions)
            print ("Loaded \(newQuestions.count) new questions")
        }
    }
    func resetGame(){
        correctAnswerCount=0
        currentQuestionIndex=0
        loadNewQuestions()
        loadQuestion()
        self.viewDidLoad()
        
        
    }
}
