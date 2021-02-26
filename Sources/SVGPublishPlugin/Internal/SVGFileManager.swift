/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/

import struct Publish.Path
import Plot
import Foundation
import StrongTypedCSSPublishPlugin

final class SVGFileManager {
	static let shared = SVGFileManager()

	private var cache = [String: String]()

	/// Returns .selfClosedElement Node with svg content inside
	/// - Parameters:
	///   - file: name of svg file without extension
	///   - parameters: attributes for adding to svg content
	/// - Returns: Node`<Context>`
	func svg<Context>(_ fileName: String, parameters: [SVGAttribute]) -> Node<Context> {
		guard let svgContent = self.cache[fileName] else {
			fatalError("🔴 There is no content for \(fileName)")
		}
		return .selfClosedElement(named: self.setParameters(parameters, in: svgContent))
	}

	/// In memory cache for better performance
	/// - Parameters:
	///   - fileName: name of the file wihout extension
	///   - content: file's content
	func cache(fileName: String, with content: String) {
		self.cache[fileName] = content
	}

	private init() {}
}

private extension SVGFileManager {
	func setParameters(_ parameters: [SVGAttribute], in content: String) -> String {
		let separator = " "
		var components = content.components(separatedBy: separator)

		for param in parameters {
			if param.isNeedToReplace,
			   let index = components.firstIndex(where: { $0.hasPrefix(param.attributeName + "=") }) {
				components.remove(at: index)
			}

			switch param {
			case let .width(value):
				components.insert("\(param.attributeName)=\"\(value)\"", at: 1)
			case let .height(value):
				components.insert("\(param.attributeName)=\"\(value)\"", at: 1)
			case let .classes(cssClasses):
				let string = cssClasses.map { $0.rawValue }.joined(separator: " ")
				components.insert("\(param.attributeName)=\"\(string)\"", at: 1)
			case let .classString(string):
				components.insert("\(param.attributeName)=\"\(string)\"", at: 1)
			case let .class(value):
				components.insert("\(param.attributeName)=\"\(value.rawValue)\"", at: 1)
			}
		}

		var output = components.joined(separator: separator)

		// Removing brackets for .selfClosedElement using
		let firstBracketIndex = output.firstIndex(of: "<")!
		output.remove(at: firstBracketIndex)

		let lastBracketIndex = output.lastIndex(of: ">")!
		output.remove(at: lastBracketIndex)

		return output
	}
}
