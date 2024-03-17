import UIKit

class ViewController: UIViewController {
    
    
    var quizProgress = 0
    var quizData: [Question]?
    
    
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    @IBAction func options(_ sender: UIButton) {
        clearButtonBackground()
        if(quizProgress < quizData!.count) {
            let question = quizData![quizProgress]
            if question.isCorrect(answer: sender.titleLabel!.text!) {
                sender.backgroundColor = UIColor.green
                quizProgress += 1
                renderQuestion()
            } else {
                sender.backgroundColor = UIColor.red
               // Update the UI to show the incorrect answer feedback
            }
        }
    }
    
    func clearButtonBackground() {
        option1.backgroundColor = UIColor.clear
        option2.backgroundColor = UIColor.clear
        option3.backgroundColor = UIColor.clear
        option4.backgroundColor = UIColor.clear
    }
    
    @IBOutlet weak var QuestionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                quizData = try await getQuestions()
                renderQuestion()
            } catch {
                print("Error fetching questions: \(error)")
                }
        }
        
    }
    
    func renderQuestion() {
        let quiz : Question = quizData![quizProgress]
        QuestionText.text = quiz.question
        option1!.setTitle(quiz.option1, for: .normal)
        option2!.setTitle(quiz.option2, for: .normal)
        option3!.setTitle(quiz.option3, for: .normal)
        option4!.setTitle(quiz.option4, for: .normal)
    }
    
    func getQuestions() async throws -> [Question] {
        let url = URL(string: "https://" + (Bundle.main.infoDictionary?["APIEndpoint"] as? String)!)
        let (data, _) = try await URLSession.shared.data(from: url!)
        return try JSONDecoder().decode([Question].self, from: data)
    }
}
