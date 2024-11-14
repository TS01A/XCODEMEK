//
//  QuizViewController.swift
//  withyou
//
//  Created by Abdullah on 12/05/1446 AH.
//

import UIKit

struct QuizQuestion{
    let question: String
    let options: [String]
    let correctAnswer: Int
    
}

class QuizViewController: UIViewController {

  
    
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    
    let allQuestions: [QuizQuestion] = [
            QuizQuestion(
                question: "ما هو القلق؟",
                options: ["الشعور المستمر بالتوتر وعدم الراحة", "زيادة السعادة بشكل مفاجئ", "الرغبة في النوم المستمر", "عدم الشعور بأي عاطفة"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "أي من العوامل التالية قد يزيد من الشعور بالقلق؟",
                options: ["ممارسة الرياضة بانتظام", "السهر المستمر وقلة النوم", "تناول الطعام الصحي", "التنفس بعمق"],
                correctAnswer: 1
            ),
            QuizQuestion(
                question: "ما هو التعريف الصحيح للاكتئاب؟",
                options: ["شعور مستمر بالحزن وفقدان الاهتمام", "زيادة مفاجئة في النشاط", "الشعور بالسعادة لفترات طويلة", "التفكير الإيجابي المستمر"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو تأثير ممارسة التأمل على الصحة النفسية؟",
                options: ["تقليل التوتر وتحسين التركيز", "زيادة القلق", "زيادة الغضب", "التسبب في الأرق"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو اضطراب الهلع؟",
                options: ["نوبات مفاجئة من الخوف الشديد", "الحزن المستمر", "الرغبة في العزلة", "النشاط المفرط"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "أي من الأعراض التالية يرتبط باضطراب ما بعد الصدمة؟",
                options: ["استرجاع الأحداث المؤلمة بشكل متكرر", "زيادة الشهية", "النوم الطويل", "الشعور بالسعادة المستمر"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "كيف يمكن التغلب على الأرق؟",
                options: ["اتباع جدول نوم منتظم", "تناول الطعام الثقيل قبل النوم", "شرب القهوة قبل النوم", "الاستمرار في استخدام الهاتف في السرير"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو تأثير الرياضة على الصحة النفسية؟",
                options: ["تحسين المزاج وتقليل التوتر", "زيادة الغضب", "التسبب في الأرق", "زيادة القلق"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو أفضل وقت لممارسة تمارين الاسترخاء؟",
                options: ["قبل النوم", "خلال ساعات العمل", "بعد تناول الطعام", "عند الشعور بالسعادة"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو اضطراب الوسواس القهري؟",
                options: ["أفكار وسلوكيات متكررة وغير مرغوبة", "الابتعاد عن الآخرين", "النوم المستمر", "الشعور المستمر بالبهجة"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "كيف يمكن تقليل التوتر في الحياة اليومية؟",
                options: ["ممارسة تمارين التنفس العميق", "زيادة العمل دون راحة", "تناول كميات كبيرة من الكافيين", "تجاهل التمارين الرياضية"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو تعريف الصحة النفسية الجيدة؟",
                options: ["الشعور بالراحة والتوازن العقلي", "العمل طوال اليوم بدون راحة", "التوتر المستمر", "الشعور بالإحباط بشكل مستمر"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هي فوائد التواصل الاجتماعي للصحة النفسية؟",
                options: ["الدعم العاطفي وتقليل العزلة", "زيادة التوتر", "الإرهاق المستمر", "الشعور بالقلق"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو تأثير قلة النوم على الصحة النفسية؟",
                options: ["زيادة التوتر والاكتئاب", "تحسين المزاج", "زيادة الطاقة", "تقليل الإجهاد"],
                correctAnswer: 0
            ),
            QuizQuestion(
                question: "ما هو العلاج السلوكي المعرفي؟",
                options: ["علاج يركز على تغيير الأفكار والسلوكيات السلبية", "استخدام الأدوية فقط", "ممارسة الرياضة بشكل مكثف", "الابتعاد عن الناس"],
                correctAnswer: 0
            )
        ]
    var selectedQuestions: [QuizQuestion] = []
        var currentQuestionIndex = 0
        var score = 0
        var selectedAnswerIndex: Int?

        override func viewDidLoad() {
            super.viewDidLoad()
            // اختيار 6 أسئلة عشوائيًا من القائمة الكاملة
            selectedQuestions = Array(allQuestions.shuffled().prefix(6))
            loadQuestion()
        }
    func loadQuestion() {
            let question = selectedQuestions[currentQuestionIndex]
            questionLabel.text = question.question
            optionButton1.setTitle(question.options[0], for: .normal)
            optionButton2.setTitle(question.options[1], for: .normal)
            optionButton3.setTitle(question.options[2], for: .normal)
            optionButton4.setTitle(question.options[3], for: .normal)
            selectedAnswerIndex = nil
        }
    @IBAction func optionSelected(_ sender: UIButton) {
            selectedAnswerIndex = sender.tag
            checkAnswer()
        }


   
    @IBAction func nextQuestion(_ sender: Any) {
        if currentQuestionIndex < selectedQuestions.count - 1 {
                    currentQuestionIndex += 1
                    loadQuestion()
                } else {
                    showResult()
                }
    }
    func checkAnswer() {
           if selectedAnswerIndex == selectedQuestions[currentQuestionIndex].correctAnswer {
               score += 1
           }
       }
    func showResult() {
            let alert = UIAlertController(title: "النتيجة", message: "لقد أجبت بشكل صحيح على \(score) من \(selectedQuestions.count) سؤال", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "إعادة المحاولة", style: .default, handler: { _ in
                self.resetQuiz()
            }))
            present(alert, animated: true, completion: nil)
        }

        func resetQuiz() {
            currentQuestionIndex = 0
            score = 0
            selectedQuestions = Array(allQuestions.shuffled().prefix(6))
            loadQuestion()
        }
    }
    

