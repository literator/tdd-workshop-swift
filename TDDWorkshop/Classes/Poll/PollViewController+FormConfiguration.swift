//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import Eureka

typealias Emoji = String
let 🎉 = "🎉", 👍 = "👍", 😎 = "😎", 👎 = "👎", 😡 = "😡"
let symbols = [🎉: 5, 👍: 4, 😎: 3, 👎: 2, 😡: 1]

extension PollViewController {
	func configureGeneralSection() {
		form +++
		Section("General")
		<<< NameRow("name") {
			$0.title = "Name*"
			$0.placeholder = "John Smith?"
		}.onCellHighlightChanged { _, row in
			if !row.isHighlighted {
				self.showValidationDialogIfNeeded(for: row.value, isValid: self.validate(text:))
			}
		}
		<<< EmailRow("username") {
			$0.title = "E-mail*"
			$0.placeholder = "you@example.com"
		}.onCellHighlightChanged { _, row in
			if !row.isHighlighted {
				self.showValidationDialogIfNeeded(for: row.value, isValid: self.validate(email:))
			}
		}
		<<< TextAreaRow("feedback") {
			$0.title = "General feedback"
			$0.placeholder = "Write general feedback..."
		}.onCellHighlightChanged { _, row in
			if !row.isHighlighted {
				self.showValidationDialogIfNeeded(for: row.value, isValid: self.validate(comment:))
			}
		}
	}

	func configureAgendaSections() {
		for (i, section) in sections.enumerated() {
			form +++
			Section(section)
			<<< SegmentedRow<Emoji>("rate\(i)") {
				$0.title = "What's your rate?"
				$0.options = [🎉, 👍, 😎, 👎, 😡]
				$0.value = 🎉
			}
			<<< TextAreaRow("comment\(i)") {
				$0.title = "Comments"
				$0.placeholder = "Write your comments here..."
			}
		}
	}

	func configureSentGeneralSection() {
		form.removeAll()
		form +++ Section("General") <<< LabelRow("main") {
			$0.title = "Poll has been sent."
		}
		tableView.reloadData()
	}

	// MARK: Dialogs

	private func showValidationDialogIfNeeded(for value: String?, isValid: (String?) -> Bool) {
		if !isValid(value) {
			showInvalidValueAlert(value)
		}
	}

	private func showInvalidValueAlert(_ value: String?) {
		if let printableValue = value {
			let message = "Value you entered is invalid: \"\(printableValue)\""
			let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
			present(alert, animated: true, completion: nil)
		}
	}
}
