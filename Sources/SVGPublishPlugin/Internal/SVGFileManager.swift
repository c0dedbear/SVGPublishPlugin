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
		return .raw(self.setParameters(parameters, in: svgContent))
	}

	func svg<Context>(_ content: String, params: [SVGAttribute]) -> Node<Context> {
		return .raw(self.setParameters(params, in: content))
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

		guard let beginOfSvg = components.first(where: { $0.contains("<svg")}),
			  let beginIndex = components.firstIndex(of: beginOfSvg)
			  else { fatalError("🔴 There is SVG tag found") }

		let insertIndex = components.index(after: beginIndex)

		for param in parameters {
			if param.isNeedToReplace,
			   let index = components.firstIndex(where: { $0.hasPrefix(param.attributeName + "=") }) {
				components.remove(at: index)
			}

			switch param {
			case let .width(value):
				components.insert("\(param.attributeName)=\"\(value)\"", at: insertIndex)
			case let .height(value):
				components.insert("\(param.attributeName)=\"\(value)\"", at: insertIndex)
			case let .classes(cssClasses):
				let string = cssClasses.map { $0.rawValue }.joined(separator: " ")
				components.insert("\(param.attributeName)=\"\(string)\"", at: insertIndex)
			case let .classString(string):
				components.insert("\(param.attributeName)=\"\(string)\"", at: insertIndex)
			case let .class(value):
				components.insert("\(param.attributeName)=\"\(value.rawValue)\"", at: insertIndex)
			}
		}

		return components.joined(separator: separator)
	}
}
