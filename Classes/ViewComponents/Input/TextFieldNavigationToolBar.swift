//    The MIT License (MIT)
//
//    Copyright (c) 2016 Inácio Ferrarini
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

import UIKit

open class TextFieldNavigationToolBar: NSObject {


    // MARK: - Properties

    open var previousButtonLabel: String? {
        didSet {
            guard let previousButton = self.previousButton else { return }
            previousButton.title = previousButtonLabel
        }
    }
    open var nextButtonLabel: String? {
        didSet {
            guard let nextButton = self.previousButton else { return }
            nextButton.title = nextButtonLabel
        }
    }
    open var doneButtonLabel: String? {
        didSet {
            guard let doneButton = self.previousButton else { return }
            doneButton.title = doneButtonLabel
        }
    }
    open var toolbar: UIToolbar?
    open var textFields: [UITextField]? {
        didSet {
            self.updateAccessoryViews()
            self.updateToolbar()
        }
    }
    open var relatedFields: [UITextField : AnyObject]?
    open var selectedTextField: UITextField? {
        didSet {
            self.updateToolbar()
        }
    }

    fileprivate var previousButton: UIBarButtonItem?
    fileprivate var nextButton: UIBarButtonItem?
    fileprivate var doneButton: UIBarButtonItem?


    // MARK: - Initialization

    public required init(withTextFields textFields: [UITextField]?, usingRelatedFields relatedFields: [UITextField : AnyObject]?) {
        self.textFields = textFields
        self.relatedFields = relatedFields
        super.init()
        self.createToolbar()
    }


    // MARK: - Helper Methods

    func createToolbar() {
        if nil == self.toolbar {
            let toolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.sizeToFit()
            self.toolbar = toolbar
        }

        guard let toolbar = self.toolbar else { return }

        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let previousButtonImage = UIImage(named: "LeftArrow", in: self.getBundle(), compatibleWith: nil)
        let previousButton = UIBarButtonItem(image: previousButtonImage, style: .plain, target: self, action: #selector(previousButtonClicked))
        self.previousButton = previousButton

        let buttonSpacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        buttonSpacing.width = 12
        
        let nextButtonImage = UIImage(named: "RightArrow", in: self.getBundle(), compatibleWith: nil)
        let nextButton = UIBarButtonItem(image: nextButtonImage, style: .plain, target: self, action: #selector(nextButtonClicked))
        self.nextButton = nextButton

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        self.doneButton = doneButton

        toolbar.items = [previousButton, buttonSpacing, nextButton, flexibleSpaceLeft, doneButton]

        self.updateAccessoryViews()
        self.updateToolbar()
    }

    func updateAccessoryViews() {
        if let textFields = self.textFields {
            for textField in textFields {
                textField.inputAccessoryView = self.toolbar
            }
            // self.selectedTextField = textFields.first
        }
    }

    func getBundle() -> Bundle {
        return Bundle(for: TextFieldNavigationToolBar.self)
    }

    func indexOfSelectedTextField() -> NSInteger {
        guard let selectedTextField = self.selectedTextField else { return 0 }
        guard let textFields = self.textFields else { return 0 }
        guard let selectedIndex = textFields.index(where: {$0 == selectedTextField}) else { return 0 }
        return selectedIndex
    }

    func updateToolbar() {
        guard let previousButton = self.previousButton else { return }
        guard let nextButton = self.nextButton else { return }
        guard let textFields = self.textFields else { return }

        let selectedIndex = self.indexOfSelectedTextField()
        previousButton.isEnabled = textFields.count > 0 && selectedIndex > 0
        nextButton.isEnabled = textFields.count > 0 && selectedIndex < textFields.count - 1
    }

    func previousButtonClicked() {
        guard let textFields = self.textFields else { return }
        let selectedIndex = self.indexOfSelectedTextField()
        if selectedIndex > 0 {
            let selectedTextField = textFields[selectedIndex - 1]
            self.selectedTextField = selectedTextField
            selectedTextField.becomeFirstResponder()
        }
    }

    func nextButtonClicked() {
        guard let textFields = self.textFields else { return }
        let selectedIndex = self.indexOfSelectedTextField()
        if selectedIndex < textFields.count - 1 {
            let selectedTextField = textFields[selectedIndex + 1]
            self.selectedTextField = selectedTextField
            selectedTextField.becomeFirstResponder()
        }
    }

    func doneButtonClicked() {
        guard let selectedTextField = self.selectedTextField else { return }
        selectedTextField.resignFirstResponder()
    }

}
