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

public class TextFieldNavigationToolBar: NSObject {


    // MARK: - Properties

    public var previousButtonLabel: String? {
        didSet {
            guard let previousButton = self.previousButton else { return }
            previousButton.title = previousButtonLabel
        }
    }
    public var nextButtonLabel: String? {
        didSet {
            guard let nextButton = self.previousButton else { return }
            nextButton.title = nextButtonLabel
        }
    }
    public var doneButtonLabel: String? {
        didSet {
            guard let doneButton = self.previousButton else { return }
            doneButton.title = doneButtonLabel
        }
    }
    public var toolbar: UIToolbar?
    public var textFields: [UITextField]?
    public var relatedFields: [UITextField : AnyObject]?
    public var selectedTextField: UITextField? {
        didSet {
            self.updateToolbar()
        }
    }

    private var previousButton: UIBarButtonItem?
    private var nextButton: UIBarButtonItem?
    private var doneButton: UIBarButtonItem?


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
            toolbar.barStyle = .Default
            toolbar.sizeToFit()
            self.toolbar = toolbar
        }

        guard let toolbar = self.toolbar else { return }

        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

        let previousButtonImage = UIImage(named: "LeftArrow", inBundle: self.getBundle(), compatibleWithTraitCollection: nil)
        let previousButton = UIBarButtonItem(image: previousButtonImage, style: .Plain, target: self, action: #selector(previousButtonClicked))
        self.previousButton = previousButton

        let buttonSpacing = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        buttonSpacing.width = 12
        
        let nextButtonImage = UIImage(named: "RightArrow", inBundle: self.getBundle(), compatibleWithTraitCollection: nil)
        let nextButton = UIBarButtonItem(image: nextButtonImage, style: .Plain, target: self, action: #selector(nextButtonClicked))
        self.nextButton = nextButton

        let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(doneButtonClicked))
        self.doneButton = doneButton

        toolbar.items = [previousButton, buttonSpacing, nextButton, flexibleSpaceLeft, doneButton]

        if let textFields = self.textFields {
            for textField in textFields {
                textField.inputAccessoryView = self.toolbar
            }
            self.selectedTextField = textFields.first
        }
        self.updateToolbar()
    }

    func getBundle() -> NSBundle {
        return NSBundle(forClass: TextFieldNavigationToolBar.self)
    }

    func indexOfSelectedTextField() -> NSInteger {
        guard let selectedTextField = self.selectedTextField else { return 0 }
        guard let textFields = self.textFields else { return 0 }
        guard let selectedIndex = textFields.indexOf({$0 == selectedTextField}) else { return 0 }
        return selectedIndex
    }

    func updateToolbar() {
        guard let previousButton = self.previousButton else { return }
        guard let nextButton = self.nextButton else { return }
        guard let textFields = self.textFields else { return }

        let selectedIndex = self.indexOfSelectedTextField()
        previousButton.enabled = textFields.count > 0 && selectedIndex > 0
        nextButton.enabled = textFields.count > 0 && selectedIndex < textFields.count - 1
    }

    func previousButtonClicked() {
        guard let textFields = self.textFields else { return }
        let selectedIndex = self.indexOfSelectedTextField()
        if selectedIndex > 0 {
            let selectedTextField = textFields[selectedIndex - 1]
            self.selectedTextField = selectedTextField
            selectedTextField.becomeFirstResponder()
        }
        self.updateToolbar()
    }

    func nextButtonClicked() {
        guard let textFields = self.textFields else { return }
        let selectedIndex = self.indexOfSelectedTextField()
        if selectedIndex < textFields.count - 1 {
            let selectedTextField = textFields[selectedIndex + 1]
            self.selectedTextField = selectedTextField
            selectedTextField.becomeFirstResponder()
        }
        self.updateToolbar()
    }

    func doneButtonClicked() {
        guard let selectedTextField = self.selectedTextField else { return }
        selectedTextField.resignFirstResponder()
        self.updateToolbar()
    }

}
