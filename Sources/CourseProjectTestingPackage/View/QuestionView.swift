//
//  QuestionView.swift
//  CourseProject2.0Testing
//
//  Created by Anastasia on 29.04.2022.
//

import UIKit

public final class QuestionView : UIView {
    public var userAnswers : [String] = []
    
    private var answer = UITextView()
    private var question = UIView()
    private var button = UIButton(type: .system)
    
    private var currentQuestion = 0
    private var questionsEnded = false
    private var questionsModel: QuestionsModel?
    
    public init(model: QuestionsModel) {
        super.init(frame: .zero)
        
        questionsModel = model
        
        setWidth(to: model.width)
        setHeight(to: model.height)
        
        if (model.color != nil) {
            backgroundColor = model.color
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                model.gradient?.colorTop ?? UIColor.clear,
                model.gradient?.colorBottom ?? UIColor.clear
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: model.width,
                height: model.height
            )
            
            layer.insertSublayer(gradientLayer, at:0)
        }
        
        configureQuestionView(model: model.questionViewModels[0])
        configureAnswerView(model: model.answerViewModels[0])
        configureButton(model: model.buttonModels[0])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureQuestionView(model: QuestionModel.QuestionViewModel) {
        addSubview(question)
        question.pinTop(to: self.topAnchor, model.viewModel.topIndent)
        
        let questionText = UILabel()
        questionText.text = model.question
        questionText.setHeight(to: model.viewModel.height)
        questionText.setWidth(to: model.viewModel.width)
        questionText.numberOfLines = model.numberOfLines
        questionText.textColor = model.textColor
        questionText.lineBreakMode = .byWordWrapping
        questionText.textAlignment = .center
        
        question.addSubview(questionText)
        questionText.pinBottom(to: question.bottomAnchor, 20)
        
        configureView(model: model.viewModel, view: question)
        
        if (model.viewModel.image != nil) {
            let imageView = UIImageView()
            imageView.image = model.viewModel.image
            
            guard let height = model.viewModel.imageHeight else { return }
            guard let width = model.viewModel.imageWidth else { return }
            
            imageView.setHeight(to: height)
            imageView.setWidth(to: width)
            
            question.addSubview(imageView)
            imageView.pinTop(to: questionText.topAnchor, model.viewModel.topIndent)
            imageView.pinLeft(to: question.leadingAnchor, model.viewModel.width / 2 - width / 2)
        }
    }
    
    private func configureAnswerView(model: QuestionModel.AnswerTextViewModel) {
        addSubview(answer)
        answer.pinTop(to: question.bottomAnchor, model.viewModel.topIndent)
        
        configureView(model: model.viewModel, view: answer)
        
        if (model.textContainerInset != nil) {
            guard let insets = model.textContainerInset else { return }
            answer.textContainerInset = insets
        }
        
        answer.inputView = model.inputView
    }
    
    private func configureButton(model: QuestionModel.NextButtonModel) {
        addSubview(button)
        button.pinTop(to: answer.bottomAnchor, model.viewModel.topIndent)
        
        button.setTitle(model.content, for: .normal)
        button.setTitleColor(model.textColor, for: .normal)
        
        configureView(model: model.viewModel, view: button)
        
        if (model.viewModel.image != nil) {
            button.setImage(model.viewModel.image, for: .normal)
        }
        
        button.addTarget(
            self,
            action: #selector(nextButtonWasPressed),
            for: .touchUpInside
        )
    }
    
    @objc
    private func nextButtonWasPressed(_ sender: UIButton) {
        userAnswers.append(answer.text ?? "")
        
        currentQuestion += 1
        if (currentQuestion >= questionsModel?.questionViewModels.count ?? 0) {
            questionsEnded = true
        } else {
            question = UIView()
            answer = UITextView()
            button = UIButton(type: .system)
            
            question.removeFromSuperview()
            answer.removeFromSuperview()
            button.removeFromSuperview()
            
            configureNewQuestion()
        }
    }
    
    private func configureNewQuestion() {
        guard let questionViewModel = questionsModel?.questionViewModels[currentQuestion] else { return }
        guard let answerViewModel = questionsModel?.answerViewModels[currentQuestion] else { return }
        guard let buttonModel = questionsModel?.buttonModels[currentQuestion] else { return }
        
        configureQuestionView(model: questionViewModel)
        configureAnswerView(model: answerViewModel)
        configureButton(model: buttonModel)
    }
    
    private func configureView(model: QuestionModel.ViewModel, view: UIView) {
        view.setHeight(to: model.height)
        view.setWidth(to: model.width)
        
        view.pinLeft(to: self, (questionsModel?.width ?? 0) / 2 - model.width / 2)
        
        view.layer.borderWidth = model.borderWidth ?? 0
        view.layer.borderColor = model.borderColor ?? UIColor.clear.cgColor
        
        if (model.color != nil) {
            view.backgroundColor = model.color
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                model.gradient?.colorTop ?? UIColor.clear,
                model.gradient?.colorBottom ?? UIColor.clear
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: model.width,
                height: model.height
            )
            
            view.layer.insertSublayer(gradientLayer, at:0)
        }
        
        view.layer.cornerRadius = model.cornerRadius ?? 0
        view.clipsToBounds = true
        
        if (model.shadowColor != nil) {
            configureShadow(
                shadowColor: model.shadowColor,
                shadowOffset: model.shadowOffset,
                shadowOpacity: model.shadowOpacity,
                view: view
            )
        }
    }
    
    private func configureShadow(
        shadowColor: CGColor?,
        shadowOffset: CGSize?,
        shadowOpacity: Float?,
        view: UIView
    ) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = shadowOffset ?? CGSize()
        view.layer.shadowOpacity = shadowOpacity ?? 0
        view.layer.shadowRadius = 0.0
        view.layer.masksToBounds = false
    }
}
