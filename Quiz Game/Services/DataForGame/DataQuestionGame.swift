//
//  DataQuestionGame.swift
//  Quiz Game
//
//  Created by USER on 14.08.2022.
//

import UIKit

final class DataQuestionGame {
    
    let quiestionForOsnovi : [ModelQuestion] = [
        ModelQuestion(textQuestion: "Каким ключевым словом можно предотвратить переопределение метода, свойства или индекса?", answerCorrect: "final", answer: ["private", "static", "end", "final"], help: "Ассоциация. такие связи между психическими явлениями, при которых появление одного из них в сознании человека влечет практически одновременное появление других.\nОпциональный тип. Swift также включает опиональные типы, которые позволяют работать с отсутствующими значениями. Опциональные значения говорят либо здесь есть значение, и оно равно Х, либо здесь нет значения вообще. Опциональные типы пододны использованию nil  с указателями в Objective-C, но они работают со всеми типами, не только с классами."),
        
        ModelQuestion(textQuestion: "С отсутсвующими значениями можно работать с помощью этого типа", answerCorrect: "Опциональный тип", answer: ["Тип кортеж", "Опциональный тип", "Тип коллекции", "Опциональный тип"], help: "Опциональный тип. Swift также включает опиональные типы, которые позволяют работать с отсутствующими значениями. Опциональные значения говорят либо здесь есть значение, и оно равно Х, либо здесь нет значения вообще. Опциональные типы пододны использованию nil  с указателями в Objective-C, но они работают со всеми типами, не только с классами. ", photoQuestion: UIImage(named: "2")),
        
        ModelQuestion(textQuestion: "Как называется именованный участок в памяти, в котором хранится некоторое значение?", answerCorrect: "Переменная или константа", answer: ["Библиотека", "Строка", "Переменная или константа", "Структура"], help: "Переменная или константа. Для хранения данных в Swift, как и в других языках программирования, используются переменные и константы. Переменная или константа представляет собой именованный участок в памяти, в котором хранится некоторое значение."),
        
        ModelQuestion(textQuestion: "Объекты доступные в любой точке программы?", answerCorrect: "Глобальные объекты", answer: ["Глобальные объекты", "Локальные объекты"], help: "Глобальные объекты. Каждый созданный объект может использоваться только по определенным правилам, одно из которых называется областью видимости. Область видимости определяет, где именно в коде можно использовать тот или иной объект. По принадлежности к области видимости объекты делятся на локальные и глобальные.", photoQuestion: UIImage(named: "3")),
        
        ModelQuestion(textQuestion: "Как называется объявление переменной или константы с присваиванием ей значени?", answerCorrect: "Инициализация", answer: ["Инициализация", "Возведение", "Объявление"], help: "Инициализация. Инициализация - это подготовительный процесс экземпляра класса, структуры или перечисления для дальнейшего использования. Этот процесс включает в себя установку начальных значений для каждого свойства хранения этого экземпляра и проведение любых настроек или инициализации, которые нужны до того, как экземпляр будет использоваться.", photoQuestion: UIImage(named: "1")),
        
        ModelQuestion(textQuestion: "Все базовые типы (Int, String, Double, Bool) в Swift являются хешируемыми, так ли это?", answerCorrect: "Да", answer: ["Все, кроме Bool", "Да", "Все, кроме String", "Нет"], help: "Все базовые типы (Int, String, Double, Bool) в Swift являются хешируемыми типами по умолчанию и могут быть использованы в качестве типов значений множетсва или в качестве типов ключей словаря.", photoQuestion: UIImage(named: "1"))]
    
    
    let quiestionForBazovieOperatori : [ModelQuestion] = [
        ModelQuestion(textQuestion: "Эти операторы применяются к двум величинам", answerCorrect: "Бинарные", answer: ["Тернарные", "Бинарные", "Унарные"], help: "Бинарные. Бинарные операторы применяются к двум величинам (например 2 + 3) и являются инфиксными, так как ставятся между этими величинами."),
        
        ModelQuestion(textQuestion: "Эта минимальная автономная единица способна выполнить команду", answerCorrect: "Оператор", answer: ["Тип кортеж", "Тип коллекции", "Оператор", "Опциональный тип"], help: "Оператор. Оператор - минимальная автономная единица, выполняющая команду. Операторы могут быть простыми (унарными, бинарными) и структурными.", photoQuestion: UIImage(named: "2")),
        
        ModelQuestion(textQuestion: "При использовании операторов сравнения какой мы получим результат?", answerCorrect: "Bool", answer: ["Bool", "Double", "nil", "Int"], help: "Bool. Каждый оператор сравнения возвращает значение типа Bool, указывающее, является ли выражение истиной или нет."),
        
        ModelQuestion(textQuestion: "Какой результат будет в выражении 9 % -4?", answerCorrect: "1", answer: ["2", "8", "4", "1"], help: "1. Если b отрицательно, его знак отбрасывается. Это означает, что выражения a % b и  a % -b  всегда будут давать одинаковый результат.", photoQuestion: UIImage(named: "3")),
        
        ModelQuestion(textQuestion: "Унарные операторы которые ставятся сразу за величиной", answerCorrect: "Постфиксные", answer: ["Постфиксные", "Инфиксные", "Префиксные"], help: "Постфиксные. Унарные постфиксные операторы ставятся сразу за величиной (например, с!)", photoQuestion: UIImage(named: "1")),
        
        ModelQuestion(textQuestion: "Сколько операторов сравнения поддерживает Swift", answerCorrect: "6: ==, !=, >, <, >=, <=", answer: ["3: ===, !==, -=", "4: ==, !=, >=, <=", "6: ==, !=, >, <, >=, <=", "5: ==, !=, >, ||, *="], help: "6: ==, !=, >, <, >=, <=. Язык  Swift поддерживает все стандартные операторы сравнения из С. Всего их шесть.", photoQuestion: UIImage(named: "1"))]
    
    let quiestionForInit : [ModelQuestion] = [
        ModelQuestion(textQuestion: "Вы можете установитьзначение по умолчанию, как часть определения свойства хранения, так ли это?", answerCorrect: "Да", answer: ["Да", "Нет"], help: "Да. Вы можете установить начальное значение свойства внутри инициализатора или присвоить ему значение по умолчанию, как часть определения свойства"),
        
        ModelQuestion(textQuestion: "Когда мы устанавливаем исходное значение для свойтсва хранения в инициализаторе, будет вызываться наблюдатель?", answerCorrect: "Нет", answer: ["Да", "Нет"], help: "Нет. Когда вы присваиваете значение по умолчанию свойству хранения или устанавливаете исходное значение в инициализаторе, то значение устанавливается напрямую, без вызова наблюдателей.", photoQuestion: UIImage(named: "2")),
    ]
    
    let quiestionForVCLifecycle : [ModelQuestion] = [
        ModelQuestion(textQuestion: "Какой метод отработает при смене ориентации экрана, помимо viewWillLayoutSubviews?", answerCorrect: "viewWillTransition", answer: ["updateViewConstraints", "viewDidDisappear", "viewWillTransition"], help: "viewWillTransition. При смене ориентации экрана первым отрабатывает метод viewWillTransition, следом за ним отрабатывают оба метода, ответственные за корректировку визуальных элементов экрана, viewWillLayoutSubviews и viewDidLayoutSubviews."),
        
        ModelQuestion(textQuestion: "В каком из этих методов мы не обращаемся к суперклассу?", answerCorrect: "viewDidLayoutSubviews", answer: ["viewWillAppear", "viewDidAppear", "viewDidLayoutSubviews", "viewDidLoad"], help: "viewDidLayoutSubviews. Во всех основных методах, кроме viewWillLayuotSubviews и viewDidLayoutSubviews мы должны будем обращаться к суперклассу наших методов через .super", photoQuestion: UIImage(named: "2")),
        
        ModelQuestion(textQuestion: "Можем ли мы без последующих проблем работать с размерами экрана и элементов внутри viewDidLoad", answerCorrect: "Нет", answer: ["Да", "Нет"], help: "Нет. Метод viewDidLoad() вызывается до того, как просчитываются все размеры на экране, и до того, как выполняется установка ориентации экрана, поэтомуочень рисковано работать в нем с размерами ваших вью."),
        
        ModelQuestion(textQuestion: "После какого свойства у нас начнут устанавливаться свойства и аутлеты нашего контроллера?", answerCorrect: "awakeFromNib()", answer: ["После viewDidLoad()", "После loadView()", "awakeFromNib()"], help: "awakeFromNib(). Все свойства и аутлеты устанавливаются после awakeFromNib() и перед loadView().", photoQuestion: UIImage(named: "3")),
        
        ModelQuestion(textQuestion: "Унарные операторы которые ставятся сразу за величиной", answerCorrect: "Постфиксные", answer: ["Постфиксные", "Инфиксные", "Префиксные"], help: "Постфиксные. Унарные постфиксные операторы ставятся сразу за величиной (например, с!)", photoQuestion: UIImage(named: "1")),
        
        ModelQuestion(textQuestion: "Сколько операторов сравнения поддерживает Swift", answerCorrect: "6: ==, !=, >, <, >=, <=", answer: ["3: ===, !==, -=", "4: ==, !=, >=, <=", "6: ==, !=, >, <, >=, <=", "5: ==, !=, >, ||, *="], help: "6: ==, !=, >, <, >=, <=. Язык  Swift поддерживает все стандартные операторы сравнения из С. Всего их шесть.", photoQuestion: UIImage(named: "1"))]
    
    let quiestionForUIView : [ModelQuestion] = [
        ModelQuestion(textQuestion: "Внутри какого метода мы можем написать свою реализацию установки фреймов для всех или части ваших вью?", answerCorrect: "layoutSubviews()", answer: ["setNeedLayout()", "layoutSubviews()", "layoutIfNeeded()"], help: "layoutSubviews(). Подклассы могут переопределять этот метод для более точной отрисовки интерфейса. Вы должны переопределять этот метод только в том случае, если Auto Layout и Constraints из коробки не предлагают желаемого поведения."),
        
        ModelQuestion(textQuestion: "Этот метод записывает запрос на обновление вью и сразу же возвращается,не вызывая немедленное обновление", answerCorrect: "setNeedsLayout()", answer: ["setNeedsLayout()", "layoutIfNeeded()", "loadView()"], help: "setNeedsLayout(). Метод setNeedsLayout() записывает запрос на обновление вью и сразу же возвращается, не вызывая немедленное обновление.", photoQuestion: UIImage(named: "2")),
        
        ModelQuestion(textQuestion: "Метод setNeedsLayout() выполняется сразу же, не ожидая следующего цикла обновления. Правда ли это?", answerCorrect: "Нет", answer: ["Да", "Нет"], help: "Нет. Метод setNeedsLayout() для UIView сообщает системе, что вы хотите, чтобы произошла перерисовка вью и всех его сабвью, когда наступит следующий цикл обновления. Он вызывается в основном потоке приложения"),
        
        ModelQuestion(textQuestion: "Какой из этих методов работает асинхронно?", answerCorrect: "setNeedsLayout()", answer: ["setNeedsLayout()", "loadView()", "layoutIfNeeded()"], help: "setNeedsLayout(). Это асинхронный метод. Он завершается и немедленно возвращается (хотя мы и не видим его эффект сразу же).", photoQuestion: UIImage(named: "3")),
        
        ModelQuestion(textQuestion: "Какой из этих нативных методов UIView может быть переопределен?", answerCorrect: "layoutSubviews()", answer: ["layoutSubviews()", "layoutIfNeeded()", "setNeedsLayout()"], help: "layoutSubviews(). Из этих представленных методов, переопределяемым является только метод layoutSubviews. При его его переопределении вы также должны обращаться к его суперклассу.", photoQuestion: UIImage(named: "1")),
        
        ModelQuestion(textQuestion: "Сколько операторов сравнения поддерживает Swift", answerCorrect: "6: ==, !=, >, <, >=, <=", answer: ["3: ===, !==, -=", "4: ==, !=, >=, <=", "6: ==, !=, >, <, >=, <=", "5: ==, !=, >, ||, *="], help: "6: ==, !=, >, <, >=, <=. Язык  Swift поддерживает все стандартные операторы сравнения из С. Всего их шесть.", photoQuestion: UIImage(named: "1"))]
    
    
    lazy var typeCategoryOsnoviSwift: ModelCategoryType = ModelCategoryType(name: "Основы", question: quiestionForOsnovi, isSelected: true)
    
    
    lazy var typeCategoryBazovieOperatori: ModelCategoryType = ModelCategoryType(name: "Базовые операторы", question: quiestionForBazovieOperatori, isSelected: false)
    
    
    lazy var typeCategoryInit: ModelCategoryType = ModelCategoryType(name: "Инициализаторы", question: quiestionForInit, isSelected: false)
    
    lazy var typeCategoryVCLifecycle: ModelCategoryType = ModelCategoryType(name: "ViewController Lifecycle", question: quiestionForVCLifecycle, isSelected: false)
    
    lazy var typeCategoryUIView: ModelCategoryType = ModelCategoryType(name: "UIView", question: quiestionForUIView, isSelected: false)

    lazy var category: [ModelCategory] = [
        ModelCategory(name: "Основы Swift", categoryType: [typeCategoryOsnoviSwift, typeCategoryBazovieOperatori, typeCategoryInit]),

        ModelCategory(name: "UIKit", categoryType: [typeCategoryVCLifecycle, typeCategoryUIView])
    ]
}
